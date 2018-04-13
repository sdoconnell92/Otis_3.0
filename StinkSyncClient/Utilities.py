import sqlite3
import json


def connect_database(DatabaseFile):
    db_name = "MainDb"
    db_file = DatabaseFile

    db = None

    try:
        db = sqlite3.connect(db_file, isolation_level=None)
        db.row_factory = __dict_factory
    except sqlite3.Error:
        return None

    return db


def __dict_factory(cursor, row):
    d = {}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d


def get_audit_transactions(db, position=0):

    curs = db.cursor()

    sql = """
            Select 
                rowid,
                time,
                tbl,
                op,
                old,
                new,
                record_id
            From {AuditTable} t1
            Where
                time =(
                Select max(time) from {AuditTable} 
                Where t1.record_id = {AuditTable}.record_id) 
            Order By rowid;
        """.format(
            AuditTable='_audit',
            Position=position,
            )

    curs.execute(sql)
    rows = curs.fetchall()

    return rows


def create_send_string(subscriber_id, database_file):

    db = connect_database(database_file)
    if db is None:
        return "ERROR: Could not connect to database"

    rows = get_audit_transactions(db)

    js = {
            "SubscriberId": subscriber_id,
            "Rows": rows
            }

    s = json.dumps(js)

    return s


def digest_sync_data(database_file, sync_data):

    # Connect to the database
    db = connect_database(database_file)

    # Convert data to json
    data = json.loads(sync_data)

    # Extract values into variables
    subscriber_id = data["SubscriberId"]
    sync_id = data["SyncId"]
    new_position = data["NewPosition"]
    script = data["Script"]

    # Execute the script
    if execute_audit_script(db, script):
        return "True,{SyncId}".format(SyncId=sync_id)
    else:
        return "False,{SyncId}".format(SyncId=sync_id)


def execute_audit_script(db, script):

    curs = db.cursor()
    curs.execute("Begin;")

    # Turn triggers off
    curs.execute("Update _system Set trigger_state = 0;")

    # Start looping through script
    i = 0
    done = False
    while not done:

        i_s = "{0:0=5d}".format(i)
        sql_key = "{Index} Statement".format(Index=i_s)
        values_key = "{Index} Values".format(Index=i_s)
        try:
            sql = script[sql_key]
            vals = script[values_key]
        except KeyError as err:
            done = True

        if done:
            break

        # try:
        curs.execute(sql, vals)
        # except sqlite3.OperationalError as err:
        #     done = True
        #     return False

        i += 1

    # Turn triggers on
    curs.execute("Update _system Set trigger_state = 1;")

    db.commit()
    return True
