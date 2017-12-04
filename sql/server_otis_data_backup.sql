--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.7
-- Dumped by pg_dump version 9.5.5

-- Started on 2017-12-01 16:51:16

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 8 (class 2615 OID 18210)
-- Name: client_reg; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA client_reg;


ALTER SCHEMA client_reg OWNER TO postgres;

--
-- TOC entry 9 (class 2615 OID 18211)
-- Name: utility; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA utility;


ALTER SCHEMA utility OWNER TO postgres;

--
-- TOC entry 2 (class 3079 OID 12395)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2322 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 1 (class 3079 OID 18212)
-- Name: plpythonu; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpythonu WITH SCHEMA pg_catalog;


--
-- TOC entry 2323 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpythonu; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpythonu IS 'PL/PythonU untrusted procedural language';


SET search_path = client_reg, pg_catalog;

--
-- TOC entry 209 (class 1255 OID 18217)
-- Name: fnc_get_id_block(text, integer); Type: FUNCTION; Schema: client_reg; Owner: postgres
--

CREATE FUNCTION fnc_get_id_block(pusername text, block_size integer DEFAULT 100) RETURNS text
    LANGUAGE plpythonu
    AS $_$#fnc_get_id_block
id_list = []

for i1 in range(1,block_size):
	
	sql = "Insert Into client_reg.tbl_id_assignments (row_username) Values($1) Returning pkid;"
	plan = plpy.prepare(sql,["text"])
	rv = plpy.execute(plan,[pusername])

	for oRow in rv:
		id_list.append(str(oRow["pkid"]))

return ",".join(id_list)$_$;


ALTER FUNCTION client_reg.fnc_get_id_block(pusername text, block_size integer) OWNER TO postgres;

--
-- TOC entry 210 (class 1255 OID 18218)
-- Name: fnc_get_new_client_id(); Type: FUNCTION; Schema: client_reg; Owner: postgres
--

CREATE FUNCTION fnc_get_new_client_id() RETURNS integer
    LANGUAGE plpgsql
    AS $$
Declare
clientid integer;
Begin

Insert Into client_reg.tbl_otis_client_reg
  	Default Values
  	Returning client_id Into clientid;

Return clientid;
  
End;

$$;


ALTER FUNCTION client_reg.fnc_get_new_client_id() OWNER TO postgres;

--
-- TOC entry 211 (class 1255 OID 18219)
-- Name: tgfnc_tbl_otis_client_reg_change(); Type: FUNCTION; Schema: client_reg; Owner: postgres
--

CREATE FUNCTION tgfnc_tbl_otis_client_reg_change() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

Declare
Begin

Update tbl_otis_client_reg
	Set 
    	row_modified = clock_timestamp()
    Where pkid = New.pkid;

Return New;
End;

$$;


ALTER FUNCTION client_reg.tgfnc_tbl_otis_client_reg_change() OWNER TO postgres;

--
-- TOC entry 212 (class 1255 OID 18220)
-- Name: tgfnc_tbl_users_change(); Type: FUNCTION; Schema: client_reg; Owner: postgres
--

CREATE FUNCTION tgfnc_tbl_users_change() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

Declare
Begin

Update tbl_users
	Set 
   		row_modified = clock_timestamp()
    Where pkid = New.pkid;

Return New;
End;

$$;


ALTER FUNCTION client_reg.tgfnc_tbl_users_change() OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- TOC entry 225 (class 1255 OID 18221)
-- Name: create_full_sync_script(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION create_full_sync_script() RETURNS text
    LANGUAGE plpythonu
    AS $$
#I know we dont need to....
#   but dammit.... I like initializing variables
sql = ""
rs = None
table_names = []
column_names = []
column_values = []
column_data_types = {}
insert_st_list = []
tup_list = None
cursor = None


# Get all the names of tables that contain our data
sql = "Select table_name From information_schema.tables Where table_schema = 'public'"
table_names = plpy.execute(sql)

# loop through each table
for table_dict in table_names:
    # get the current table name
    table = table_dict['table_name']

    # grab the data types for each column in this table
    sql = "Select column_name, data_type From information_schema.columns Where table_name = '" + table + "'"
    rv = plpy.execute(sql)

    # loop through to create a dictionary of data types
    #    now = [ {column_name:pkid,data_type:text},{column_name:time,data_type:date} ]
    #   we want = {pkid:text,time:date}
    for row in rv:
        column_data_types[row["column_name"]] = row["data_type"]

    # set up a cursor and loop through all records in the table
    cursor = plpy.cursor("Select * From " + table )
    while True:

        # grab a row
        row = cursor.fetch(1)

        # check if we actually grabbed any rows
        if not row:
            break

        # pull the column names and values into lists
        tup_list = row[0].items()
        column_names = [x[0] for x in tup_list]
        column_values_tmp = [x[1] for x in tup_list]
        column_values = []
        number_types = ['smallint','integer','bigint','decimal','numeric','real','double precision','serial','bigserial']
        array_types = ['ARRAY','anyarray']
        placeholder_characters = "|PLACEHOLDER|"
        value_placeholders = []

        # prepare the data depending on what its data type is
        for name, value in zip(column_names,column_values_tmp):
            if column_data_types[name] in number_types: #(column_data_types[name] == 'integer') :
                column_values.append(str(value) + "(:)Integer" )
                #if value:
                #    column_values.append(str(value))
                #else:
                #    column_values.append("0")
            elif column_data_types[name] == "boolean":
                #column_values.append(str(value) + "(:)Boolean")
                if value:
                    column_values.append(str(1) + "(:)Boolean")
                else:
                    column_values.append(str(0) + "(:)Boolean")
            #elif column_data_types[name] in array_types:
                #if value:
                #    column_values.append("'" + str(value) + "'")
                #else:
                #    column_values.append("''")
            else:
                column_values.append(str(value) + "(:)Text")
                #if value:
                #    column_values.append("'" + value + "'")
                #else:
                #    column_values.append("''")
            # Add a placeholder
            value_placeholders.append(placeholder_characters)

        # create our insert statment
        insert_statement = "Insert Into " + table + " (" + ','.join(column_names) + ") Values(" + ','.join(value_placeholders) + ");"
        insert_statement = insert_statement + '|EOSTATEMENT|' + '(,)'.join(column_values)
        # append insert statment to or array
        insert_st_list.append(insert_statement)


return '|EOINSERT|'.join(insert_st_list)
$$;


ALTER FUNCTION public.create_full_sync_script() OWNER TO postgres;

--
-- TOC entry 226 (class 1255 OID 18222)
-- Name: get_table_count_modifieddate(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION get_table_count_modifieddate() RETURNS text
    LANGUAGE plpythonu
    AS $$import json
# get_table_count_modifieddate

# Get all the names of tables that contain our data
sql = "Select table_name From information_schema.tables Where table_schema = 'public'"
table_names = plpy.execute(sql)
database_info = {}

# loop through each table
for table_dict in table_names:
	# get the current table name
	table = table_dict['table_name']

	# grab the data for the table
	sql = "Select count(pkid), max(row_modified) From " + table
	rv = plpy.execute(sql)

	for oRow in rv:
		TableCount = oRow["count"]
		ModifiedDate = oRow["max"]

		table_info = {"RecordCount" : TableCount, "ModifiedDate" : ModifiedDate}
		database_info[table] = table_info

return json.dumps(database_info)$$;


ALTER FUNCTION public.get_table_count_modifieddate() OWNER TO postgres;

SET search_path = utility, pg_catalog;

--
-- TOC entry 227 (class 1255 OID 18223)
-- Name: run_sync(text, integer); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION run_sync(ochangedescriptions text, oclientid integer) RETURNS text
    LANGUAGE plpythonu
    AS $$

import sys
sys.path.insert(0,"/home/dev/osm")
import otis_sync_mobile as osm
rv = osm.RunSync(ochangedescriptions,oclientid)
return rv

$$;


ALTER FUNCTION utility.run_sync(ochangedescriptions text, oclientid integer) OWNER TO postgres;

--
-- TOC entry 228 (class 1255 OID 18224)
-- Name: test_func(); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION test_func() RETURNS text
    LANGUAGE plpythonu
    AS $$
import sys
import json
sys.path.insert(0,"/home/dev/osm")
import otis_sync_mobile as osm

jsonstring = '{"Fields":{"pkid":32,"row_created":null,"row_modified":null,"row_username":"","fkconven":"","name_first":"FUCK","name_last":"","job_title":"","contact_company":"","contact_email":"","phone_number":"","address_line1":"","address_line2":"","address_city":"","address_state":"","address_zip":"","address_country":""},"StatementType":"Insert","TableName":"tbl_contacts"}'

jsonlist = []
jsonlist.append(jsonstring)

lol = osm.RunSync(jsonlist,4563)
return lol
$$;


ALTER FUNCTION utility.test_func() OWNER TO postgres;

SET search_path = client_reg, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 184 (class 1259 OID 18225)
-- Name: tbl_id_assignments; Type: TABLE; Schema: client_reg; Owner: postgres
--

CREATE TABLE tbl_id_assignments (
    pkid integer NOT NULL,
    row_created timestamp without time zone DEFAULT clock_timestamp(),
    row_username text
);


ALTER TABLE tbl_id_assignments OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 18232)
-- Name: tbl_id_assignments_pkid_seq; Type: SEQUENCE; Schema: client_reg; Owner: postgres
--

CREATE SEQUENCE tbl_id_assignments_pkid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tbl_id_assignments_pkid_seq OWNER TO postgres;

--
-- TOC entry 2324 (class 0 OID 0)
-- Dependencies: 185
-- Name: tbl_id_assignments_pkid_seq; Type: SEQUENCE OWNED BY; Schema: client_reg; Owner: postgres
--

ALTER SEQUENCE tbl_id_assignments_pkid_seq OWNED BY tbl_id_assignments.pkid;


--
-- TOC entry 186 (class 1259 OID 18234)
-- Name: tbl_otis_client_reg_client_id_seq; Type: SEQUENCE; Schema: client_reg; Owner: postgres
--

CREATE SEQUENCE tbl_otis_client_reg_client_id_seq
    START WITH 23
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tbl_otis_client_reg_client_id_seq OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 18236)
-- Name: tbl_otis_client_reg_pkid_seq; Type: SEQUENCE; Schema: client_reg; Owner: postgres
--

CREATE SEQUENCE tbl_otis_client_reg_pkid_seq
    START WITH 23
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tbl_otis_client_reg_pkid_seq OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 18238)
-- Name: tbl_otis_client_reg; Type: TABLE; Schema: client_reg; Owner: postgres
--

CREATE TABLE tbl_otis_client_reg (
    pkid integer DEFAULT nextval('tbl_otis_client_reg_pkid_seq'::regclass) NOT NULL,
    row_created timestamp without time zone DEFAULT clock_timestamp(),
    row_modified timestamp without time zone DEFAULT clock_timestamp(),
    fkusers integer,
    client_id integer DEFAULT nextval('tbl_otis_client_reg_client_id_seq'::regclass) NOT NULL
);


ALTER TABLE tbl_otis_client_reg OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 18245)
-- Name: tbl_users_pkid_seq; Type: SEQUENCE; Schema: client_reg; Owner: postgres
--

CREATE SEQUENCE tbl_users_pkid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tbl_users_pkid_seq OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 18247)
-- Name: tbl_users; Type: TABLE; Schema: client_reg; Owner: postgres
--

CREATE TABLE tbl_users (
    pkid integer DEFAULT nextval('tbl_users_pkid_seq'::regclass) NOT NULL,
    row_created timestamp without time zone DEFAULT clock_timestamp(),
    row_modified timestamp without time zone DEFAULT clock_timestamp(),
    name_first text,
    name_last text
);


ALTER TABLE tbl_users OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- TOC entry 191 (class 1259 OID 18256)
-- Name: tbl_contact_methods; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tbl_contact_methods (
    pkid integer,
    uuid text NOT NULL,
    row_created text,
    row_modified text,
    row_username text,
    fkcontactables text,
    method text,
    method_type text,
    method_location text,
    primary_method boolean,
    hide boolean
);


ALTER TABLE tbl_contact_methods OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 18262)
-- Name: tbl_contactable_linking; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tbl_contactable_linking (
    pkid integer,
    uuid text NOT NULL,
    row_created text,
    row_modified text,
    row_username text,
    fk_parent text,
    fk_child text,
    parent_table text,
    primary_contactable boolean
);


ALTER TABLE tbl_contactable_linking OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 18268)
-- Name: tbl_contactables; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tbl_contactables (
    pkid integer,
    uuid text NOT NULL,
    row_created text,
    row_modified text,
    row_username text,
    indv_bus_ven text,
    type text,
    name_first text,
    name_last text,
    job_title text,
    company text,
    address_line1 text,
    address_line2 text,
    address_city text,
    address_state text,
    address_zip text,
    address_country text,
    hide boolean
);


ALTER TABLE tbl_contactables OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 18408)
-- Name: tbl_contracts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tbl_contracts (
    uuid text NOT NULL,
    row_created text,
    row_modified text,
    row_username text,
    fkeipl text,
    contract_text text,
    contract_state text
);


ALTER TABLE tbl_contracts OWNER TO postgres;

--
-- TOC entry 194 (class 1259 OID 18274)
-- Name: tbl_eipl; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tbl_eipl (
    pkid integer,
    uuid text NOT NULL,
    row_created text,
    row_modified text,
    row_username text,
    fkevents text,
    eipl_number integer,
    eipl_name text,
    due_date text,
    eipl_type text,
    discount text,
    shipping_method text,
    eipl_tax_rate text
);


ALTER TABLE tbl_eipl OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 18280)
-- Name: tbl_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tbl_events (
    pkid integer,
    uuid text NOT NULL,
    row_created text,
    row_modified text,
    row_username text,
    event_name text,
    start_time text,
    end_time text,
    loadin_time text,
    loadout_time text,
    start_date text,
    end_date text,
    loadin_date text,
    loadout_date text,
    event_details text,
    account_manager text,
    event_tags text,
    hide boolean
);


ALTER TABLE tbl_events OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 18286)
-- Name: tbl_firmware; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tbl_firmware (
    pkid integer,
    uuid text NOT NULL,
    row_created text,
    row_modified text,
    row_username text,
    fk_inventory text,
    update_date text,
    firmware_version text,
    update_comments text
);


ALTER TABLE tbl_firmware OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 18292)
-- Name: tbl_group_discounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tbl_group_discounts (
    pkid integer,
    uuid text NOT NULL,
    row_created text,
    row_modified text,
    row_username text,
    fkeipl text,
    group_name text,
    group_discount text
);


ALTER TABLE tbl_group_discounts OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 18298)
-- Name: tbl_internal_linking; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tbl_internal_linking (
    pkid integer,
    uuid text NOT NULL,
    row_created text,
    row_modified text,
    row_username text,
    fk_parent text,
    fk_child text,
    quantity text,
    fk_table_name text,
    link_type text
);


ALTER TABLE tbl_internal_linking OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 18304)
-- Name: tbl_inventory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tbl_inventory (
    pkid integer,
    uuid text NOT NULL,
    row_created text,
    row_modified text,
    row_username text,
    item_name text,
    item_manufacturer text,
    item_model text,
    item_department text,
    item_category text,
    item_subcategory text,
    item_description text,
    item_status text,
    item_quantity text,
    item_purchase_price text,
    item_sale_price text,
    item_rental_price text,
    item_owner text,
    item_taxable boolean,
    item_weight text,
    item_height text,
    item_depth text,
    item_width text,
    item_barcode text,
    item_rfid_code text,
    item_serial_code text,
    item_type text,
    physical_item boolean,
    hide boolean
);


ALTER TABLE tbl_inventory OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 18310)
-- Name: tbl_lineitems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tbl_lineitems (
    pkid integer,
    uuid text NOT NULL,
    row_created text,
    row_modified text,
    row_username text,
    fkeipl text,
    fkinventory text,
    li_name text,
    li_manufacturer text,
    li_model text,
    li_department text,
    li_category text,
    li_subcategory text,
    li_description text,
    li_stage text,
    li_type text,
    li_price text,
    li_rate text,
    li_discount text,
    li_time text,
    li_taxable boolean,
    li_quantity text,
    use_children_total boolean
);


ALTER TABLE tbl_lineitems OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 18316)
-- Name: tbl_maintenance_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tbl_maintenance_logs (
    pkid integer,
    uuid text NOT NULL,
    row_created text,
    row_modified text,
    row_username text,
    fkinventory text,
    entry_date text,
    exit_date text,
    due_date text,
    work_cost text,
    work_summary text,
    work_description text,
    work_comments text,
    work_type text,
    work_done_by text
);


ALTER TABLE tbl_maintenance_logs OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 18322)
-- Name: tbl_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tbl_payments (
    pkid integer,
    uuid text NOT NULL,
    row_created text,
    row_modified text,
    row_username text,
    fkeipl text,
    payment_amount text,
    payment_date text,
    payment_type text,
    payment_memo text
);


ALTER TABLE tbl_payments OWNER TO postgres;

SET search_path = utility, pg_catalog;

--
-- TOC entry 203 (class 1259 OID 18328)
-- Name: seq_eipl_numbers; Type: SEQUENCE; Schema: utility; Owner: postgres
--

CREATE SEQUENCE seq_eipl_numbers
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_eipl_numbers OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 18330)
-- Name: tbl_audit; Type: TABLE; Schema: utility; Owner: postgres
--

CREATE TABLE tbl_audit (
    pkid integer NOT NULL,
    change_pushie json,
    local_change_pushie json,
    change_init_client_id integer
);


ALTER TABLE tbl_audit OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 18336)
-- Name: tbl_audit_audit; Type: TABLE; Schema: utility; Owner: postgres
--

CREATE TABLE tbl_audit_audit (
    pkid integer NOT NULL,
    fk_tbl_audit integer,
    client_id integer
);


ALTER TABLE tbl_audit_audit OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 18339)
-- Name: tbl_audit_audit_pkid_seq; Type: SEQUENCE; Schema: utility; Owner: postgres
--

CREATE SEQUENCE tbl_audit_audit_pkid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tbl_audit_audit_pkid_seq OWNER TO postgres;

--
-- TOC entry 2325 (class 0 OID 0)
-- Dependencies: 206
-- Name: tbl_audit_audit_pkid_seq; Type: SEQUENCE OWNED BY; Schema: utility; Owner: postgres
--

ALTER SEQUENCE tbl_audit_audit_pkid_seq OWNED BY tbl_audit_audit.pkid;


--
-- TOC entry 207 (class 1259 OID 18341)
-- Name: tbl_audit_pkid_seq; Type: SEQUENCE; Schema: utility; Owner: postgres
--

CREATE SEQUENCE tbl_audit_pkid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tbl_audit_pkid_seq OWNER TO postgres;

--
-- TOC entry 2326 (class 0 OID 0)
-- Dependencies: 207
-- Name: tbl_audit_pkid_seq; Type: SEQUENCE OWNED BY; Schema: utility; Owner: postgres
--

ALTER SEQUENCE tbl_audit_pkid_seq OWNED BY tbl_audit.pkid;


SET search_path = client_reg, pg_catalog;

--
-- TOC entry 2128 (class 2604 OID 18343)
-- Name: pkid; Type: DEFAULT; Schema: client_reg; Owner: postgres
--

ALTER TABLE ONLY tbl_id_assignments ALTER COLUMN pkid SET DEFAULT nextval('tbl_id_assignments_pkid_seq'::regclass);


SET search_path = utility, pg_catalog;

--
-- TOC entry 2136 (class 2604 OID 18344)
-- Name: pkid; Type: DEFAULT; Schema: utility; Owner: postgres
--

ALTER TABLE ONLY tbl_audit ALTER COLUMN pkid SET DEFAULT nextval('tbl_audit_pkid_seq'::regclass);


--
-- TOC entry 2137 (class 2604 OID 18345)
-- Name: pkid; Type: DEFAULT; Schema: utility; Owner: postgres
--

ALTER TABLE ONLY tbl_audit_audit ALTER COLUMN pkid SET DEFAULT nextval('tbl_audit_audit_pkid_seq'::regclass);


SET search_path = client_reg, pg_catalog;

--
-- TOC entry 2139 (class 2606 OID 18347)
-- Name: tbl_id_assignments_pkey; Type: CONSTRAINT; Schema: client_reg; Owner: postgres
--

ALTER TABLE ONLY tbl_id_assignments
    ADD CONSTRAINT tbl_id_assignments_pkey PRIMARY KEY (pkid);


--
-- TOC entry 2141 (class 2606 OID 18349)
-- Name: tbl_otis_client_reg_pkey; Type: CONSTRAINT; Schema: client_reg; Owner: postgres
--

ALTER TABLE ONLY tbl_otis_client_reg
    ADD CONSTRAINT tbl_otis_client_reg_pkey PRIMARY KEY (pkid);


--
-- TOC entry 2143 (class 2606 OID 18351)
-- Name: tbl_users_pkey; Type: CONSTRAINT; Schema: client_reg; Owner: postgres
--

ALTER TABLE ONLY tbl_users
    ADD CONSTRAINT tbl_users_pkey PRIMARY KEY (pkid);


SET search_path = public, pg_catalog;

--
-- TOC entry 2145 (class 2606 OID 18353)
-- Name: tbl_contact_methods_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tbl_contact_methods
    ADD CONSTRAINT tbl_contact_methods_pkey PRIMARY KEY (uuid);


--
-- TOC entry 2147 (class 2606 OID 18355)
-- Name: tbl_contactable_linking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tbl_contactable_linking
    ADD CONSTRAINT tbl_contactable_linking_pkey PRIMARY KEY (uuid);


--
-- TOC entry 2149 (class 2606 OID 18357)
-- Name: tbl_contactables_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tbl_contactables
    ADD CONSTRAINT tbl_contactables_pkey PRIMARY KEY (uuid);


--
-- TOC entry 2173 (class 2606 OID 18415)
-- Name: tbl_contracts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tbl_contracts
    ADD CONSTRAINT tbl_contracts_pkey PRIMARY KEY (uuid);


--
-- TOC entry 2151 (class 2606 OID 18359)
-- Name: tbl_eipl_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tbl_eipl
    ADD CONSTRAINT tbl_eipl_pkey PRIMARY KEY (uuid);


--
-- TOC entry 2153 (class 2606 OID 18361)
-- Name: tbl_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tbl_events
    ADD CONSTRAINT tbl_events_pkey PRIMARY KEY (uuid);


--
-- TOC entry 2155 (class 2606 OID 18363)
-- Name: tbl_firmware_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tbl_firmware
    ADD CONSTRAINT tbl_firmware_pkey PRIMARY KEY (uuid);


--
-- TOC entry 2157 (class 2606 OID 18365)
-- Name: tbl_group_discounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tbl_group_discounts
    ADD CONSTRAINT tbl_group_discounts_pkey PRIMARY KEY (uuid);


--
-- TOC entry 2159 (class 2606 OID 18367)
-- Name: tbl_internal_linking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tbl_internal_linking
    ADD CONSTRAINT tbl_internal_linking_pkey PRIMARY KEY (uuid);


--
-- TOC entry 2161 (class 2606 OID 18369)
-- Name: tbl_inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tbl_inventory
    ADD CONSTRAINT tbl_inventory_pkey PRIMARY KEY (uuid);


--
-- TOC entry 2163 (class 2606 OID 18371)
-- Name: tbl_lineitems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tbl_lineitems
    ADD CONSTRAINT tbl_lineitems_pkey PRIMARY KEY (uuid);


--
-- TOC entry 2165 (class 2606 OID 18373)
-- Name: tbl_maintenance_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tbl_maintenance_logs
    ADD CONSTRAINT tbl_maintenance_logs_pkey PRIMARY KEY (uuid);


--
-- TOC entry 2167 (class 2606 OID 18375)
-- Name: tbl_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tbl_payments
    ADD CONSTRAINT tbl_payments_pkey PRIMARY KEY (uuid);


SET search_path = utility, pg_catalog;

--
-- TOC entry 2171 (class 2606 OID 18377)
-- Name: tbl_audit_audit_pkey; Type: CONSTRAINT; Schema: utility; Owner: postgres
--

ALTER TABLE ONLY tbl_audit_audit
    ADD CONSTRAINT tbl_audit_audit_pkey PRIMARY KEY (pkid);


--
-- TOC entry 2169 (class 2606 OID 18379)
-- Name: tbl_audit_pkey; Type: CONSTRAINT; Schema: utility; Owner: postgres
--

ALTER TABLE ONLY tbl_audit
    ADD CONSTRAINT tbl_audit_pkey PRIMARY KEY (pkid);


SET search_path = client_reg, pg_catalog;

--
-- TOC entry 2174 (class 2620 OID 18380)
-- Name: tg_tbl_otis_client_reg; Type: TRIGGER; Schema: client_reg; Owner: postgres
--

CREATE TRIGGER tg_tbl_otis_client_reg AFTER UPDATE OF fkusers, client_id ON tbl_otis_client_reg FOR EACH ROW EXECUTE PROCEDURE tgfnc_tbl_otis_client_reg_change();


--
-- TOC entry 2175 (class 2620 OID 18381)
-- Name: tg_tbl_users_change; Type: TRIGGER; Schema: client_reg; Owner: postgres
--

CREATE TRIGGER tg_tbl_users_change AFTER UPDATE OF name_first, name_last ON tbl_users FOR EACH ROW EXECUTE PROCEDURE tgfnc_tbl_users_change();


--
-- TOC entry 2321 (class 0 OID 0)
-- Dependencies: 10
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2017-12-01 16:51:34

--
-- PostgreSQL database dump complete
--

