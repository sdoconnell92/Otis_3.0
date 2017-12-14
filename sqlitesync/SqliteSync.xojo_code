#tag Module
Protected Module SqliteSync
	#tag Method, Flags = &h21
		Private Sub BindValues(ps as sqlitePreparedStatement, ars() as String, FieldNames() as string, FieldTypes as Dictionary)
		  
		  
		  For i as integer = 0 To FieldNames.Ubound
		    dim fn as string = FieldNames(i)
		    dim type as integer
		    dim value as Variant
		    
		    Select Case FieldTypes.Value(fn)
		    Case "Integer"
		      type = SQLitePreparedStatement.SQLITE_INTEGER
		      value = val( ars(i) )
		    Case "Text"
		      type = SQLitePreparedStatement.SQLITE_TEXT
		      value = str( ars(i) )
		    Case "Int64"
		      type = SQLitePreparedStatement.SQLITE_INT64
		      value = val( ars(i) )
		    Case "Boolean"
		      type = SQLitePreparedStatement.SQLITE_BOOLEAN
		      value = val( ars(i) )
		    Case "Blob"
		      type = SQLitePreparedStatement.SQLITE_BLOB
		      value = ars(i)
		    Case "Double"
		      type = SQLitePreparedStatement.SQLITE_DOUBLE
		      value = val( ars(i) )
		    Case "Null"
		      type = SQLitePreparedStatement.SQLITE_NULL
		      value = ars(i)
		    End Select
		    
		    ps.BindType( i, type )
		    ps.Bind( i, value )
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ConnectDB(dbFile as FolderItem) As SQLiteDatabase
		  dim db as New SQLiteDatabase
		  db.DatabaseFile = dbFile
		  
		  If db.CreateDatabaseFile Then
		    SyncDB = db
		    Return db
		  End If
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CreateLocalChangeJSON(xml as String) As jsonItem
		  dim js as New JSONItem
		  
		  js.Value("subscriber") = SqliteSync.UserId
		  js.Value("content") = xml
		  js.Value("version") = "3"
		  
		  Return js
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CreateLocalChangeXML() As String
		  dim builder() as String
		  dim tables() as String
		  
		  // Add Headers
		  builder.Append("<?xml version=""1.0"" encoding=""utf-8""?>")
		  builder.Append("<SyncData xmlns=""urn:sync-schema"">")
		  
		  // Get all tablenames
		  dim sql as string = "select tbl_Name from sqlite_master where type='table' and sql like '%RowId%'  and tbl_Name != 'android_metadata' and tbl_Name != 'MergeDelete' and tbl_Name !='MergeIdentity';"
		  dim db as SQLiteDatabase = SyncDB
		  dim rs as RecordSet = db.SQLSelect(sql)
		  If rs = Nil Then Return ""
		  While not rs.EOF
		    tables.Append( rs.Field("tbl_Name") )
		    rs.MoveNext
		  Wend
		  rs.Close
		  
		  // Loop throgh each table
		  For Each tn as string In tables()
		    
		    // Get all of the column names for the table
		    sql = "Pragma table_info(" + tn + ");"
		    dim rs1 as RecordSet = db.SQLSelect(sql)
		    dim cols() as String
		    If rs1 = Nil Then Continue
		    While Not rs1.EOF
		      cols.Append( rs1.Field("name") )
		      rs1.MoveNext
		    Wend
		    
		    // Make sure this table isn't  MergeDelete
		    If tn <> "MergeDelete" Then
		      builder.Append( "<tab n=""" + tn + """>" )
		      builder.Append( "<ins>" )
		      
		      // Get all the rows that need to be inserted
		      sql = "select * from " + tn + " where RowId is null;"
		      rs = db.SQLSelect( sql )
		      If rs <> Nil Then
		        While not rs.EOF
		          builder.Append( "<r>")
		          
		          // Loop through all of the columns in this table
		          For Each col as string in cols
		            If col = "MergeUpdate" Then Continue
		            dim s as string = rs.Field(col).StringValue
		            builder.Append( "<" + col + "><![CDATA[" + s + "]]></" + col + ">" ) 
		          Next
		          
		          builder.Append( "</r>" )
		          
		          rs.MoveNext
		          
		        Wend
		      End If
		      
		      builder.Append( "</ins>" )
		      
		      rs.Close
		      
		      builder.Append( "<upd>" )
		      
		      // Get all the rows that need to be updated
		      sql = "select * from " + tn + " where MergeUpdate > 0 and RowId is not null;"
		      rs = db.SQLSelect( sql )
		      If rs <> Nil Then
		        While not rs.EOF
		          builder.Append( "<r>")
		          
		          // Loop through all of the columns in this table
		          For Each col as string in cols
		            If col = "MergeUpdate" Then Continue
		            dim s as string = rs.Field(col).StringValue
		            builder.Append( "<" + col + "><![CDATA[" + s + "]]></" + col + ">" ) 
		          Next
		          
		          builder.Append( "</r>" )
		          rs.MoveNext
		        Wend
		      End If
		      
		      builder.Append ( "</upd>" )
		      
		      builder.Append( "</tab>" )
		      
		    End If
		    
		  Next
		  
		  builder.Append( "<delete>")
		  
		  sql = "select TableId,RowId from MergeDelete;"
		  dim rs3 as RecordSet = db.SQLSelect(sql)
		  If rs3 <> Nil Then
		    While not rs3.EOF
		      dim tn as string = rs3.Field("TableId").StringValue
		      dim rid as string = rs3.Field("RowId").StringValue
		      builder.Append("<r><tb>" + tn + "</tb><id>" + rid + "</id></r>")
		      rs3.MoveNext
		    Wend
		  End If
		  
		  builder.Append( "</delete>" )
		  
		  builder.Append( "</SyncData>" )
		  
		  Return Join(builder, EndOfLine)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CreateSQLFromInitialize(js as JSONItem) As SQLitePreparedStatement()
		  dim ars() as SQLitePreparedStatement
		  dim db as SQLiteDatabase = SyncDB
		  
		  dim nms() as String = js.Names
		  nms.Sort
		  For i as integer = 0 To nms.Ubound
		    If nms(i) = "00000 SQLiteSync.com version" Then Continue
		    dim s as string = js.Value(nms(i)).StringValue
		    dim ps as SQLitePreparedStatement = db.Prepare(s)
		    ars.Append(ps)
		  Next
		  
		  Return ars()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CreateSQLFromSync(js as JSONItem) As SQLitePreparedStatement()
		  dim s as string
		  dim ars() as SQLitePreparedStatement
		  dim db as SQLiteDatabase = SyncDB
		  dim tn as string = js.Value( "TableName" ).StringValue
		  
		  s = "TriggerInsertDrop"
		  If js.Value(s).StringValue <> "" Then ars.Append( db.Prepare( js.Value(s).StringValue ) )
		  
		  s = "TriggerUpdateDrop"
		  If js.Value(s).StringValue <> "" Then ars.Append( db.Prepare( js.Value(s).StringValue ) )
		  
		  s = "TriggerDeleteDrop"
		  If js.Value(s).StringValue <> "" Then ars.Append( db.Prepare( js.Value(s).StringValue ) )
		  
		  s = js.Value("Records").StringValue
		  dim xml as New XmlDocument(s)
		  
		  // Get the field types from sqlite database
		  s = "Pragma table_info(" + tn + ");"
		  dim rs as RecordSet = db.SQLSelect(s)
		  dim ft as New Dictionary
		  While Not rs.EOF
		    ft.Value( rs.Field("name").StringValue ) = rs.Field("type").StringValue
		    rs.MoveNext
		  Wend
		  
		  // Find the Fields in order for each type of query
		  dim InsertFields(), UpdateFields(), DeleteFields() as string
		  InsertFields = js.Value("QueryInsert").StringValue.SQLExtractFields
		  UpdateFields = js.Value("QueryUpdate").StringValue.SQLExtractFields
		  DeleteFields = js.Value("QueryDelete").StringValue.SQLExtractFields
		  
		  // Loop through Records
		  dim xml_Records as XmlNode = xml.FirstChild
		  For i as integer = 0 To xml_Records.ChildCount - 1
		    dim xml_Record as XmlNode = xml_Records.Child(i)
		    dim arv() as String
		    
		    // Loop through each Value
		    For i1 as integer = 0 To xml_Record.ChildCount - 1
		      dim xmlC as XmlNode = xml_Record.Child(i1)
		      If xmlC.FirstChild = Nil Then
		        arv.Append("")
		      Else
		        arv.Append(xmlC.FirstChild.Value)
		      End If
		    Next
		    
		    // Determine what kind of statement to use
		    dim Action as Integer = Val( xml_Record.GetAttribute("a") )
		    Select Case Action
		    Case 1
		      'insert
		      dim sql as string = js.Value("QueryInsert").StringValue
		      dim ps as SQLitePreparedStatement = db.Prepare(sql)
		      BindValues(ps,arv(),InsertFields, ft )
		      ars.Append(ps)
		    Case 2
		      'update
		      dim sql as string = js.Value("QueryUpdate").StringValue
		      dim ps as SQLitePreparedStatement = db.Prepare(sql)
		      BindValues(ps,arv(),UpdateFields, ft )
		      ars.Append(ps)
		    Case 3
		      'delete
		      dim sql as string = js.Value("QueryDelete").StringValue
		      dim ps as SQLitePreparedStatement = db.Prepare(sql)
		      BindValues(ps,arv(),DeleteFields, ft )
		      ars.Append(ps)
		    End Select
		  Next
		  
		  
		  s = "TriggerInsert"
		  If js.Value(s).StringValue <> "" Then ars.Append( db.Prepare( js.Value(s).StringValue ) )
		  
		  s = "TriggerUpdate"
		  If js.Value(s).StringValue <> "" Then ars.Append( db.Prepare( js.Value(s).StringValue ) )
		  
		  s = "TriggerDelete"
		  If js.Value(s).StringValue <> "" Then ars.Append( db.Prepare( js.Value(s).StringValue ) )
		  
		  
		  Return ars()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ExecAddTables(ExcludeTables as string = "")
		  dim stables() as string
		  dim extn() as string = ExcludeTables.Split(",")
		  
		  dim sql as string = "select tbl_Name from sqlite_master where type='table' and sql like '%RowId%'  and tbl_Name != 'android_metadata' and tbl_Name != 'MergeDelete' and tbl_Name !='MergeIdentity';"
		  
		  dim db as SQLiteDatabase = SyncDB
		  dim rs as RecordSet = db.SQLSelect(sql)
		  While not rs.EOF
		    dim s as string = rs.Field("tbl_Name").StringValue
		    If extn.IndexOf(s) = -1 Then stables.Append(s)
		    rs.MoveNext
		  Wend
		  
		  For i as integer = 0 To stables.Ubound
		    dim tn as string = stables(i)
		    
		    dim s as string = reqAddTable(ServerHost, tn)
		  Next
		  
		  Tables = stables
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ExecInitialize() As Boolean
		  UserId = GetNewUUID
		  
		  dim js as JSONItem = reqInitialize(ServerHost,UserId)
		  
		  dim ars() as SQLitePreparedStatement = CreateSQLFromInitialize(js)
		  
		  dim ers() as string = ExecuteStatements(ars())
		  If ers.Ubound = -1 Then
		    'success
		    Return True
		  Else
		    ' error things have been rolled back
		    Return False
		  End If
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ExecPushChanges()
		  
		  dim s as string = CreateLocalChangeXML
		  
		  dim js as JSONItem = CreateLocalChangeJSON(s)
		  
		  reqPostChanges( ServerHost, js.ToString )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ExecSync() As Boolean
		  dim errors as New Dictionary
		  
		  For i as integer = 0 To Tables.Ubound
		    dim tn as string  = Tables(i)
		    dim js as JSONItem = reqSync(SqliteSync.ServerHost, SqliteSync.UserId, tn)
		    
		    dim ars() as SQLitePreparedStatement = CreateSQLFromSync(js)
		    
		    dim ers() as string = ExecuteStatements(ars())
		    If ers.Ubound = -1 Then
		      'success
		    Else
		      ' error things have been rolled back
		      Break
		      errors.Value(tn) = ers()
		    End If
		    
		    
		  Next
		  
		  If Errors.Keys.Ubound = -1 Then
		    Return True
		  Else
		    Return False
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ExecuteStatements(ars() as SQLitePreparedStatement) As String()
		  dim db as SQLiteDatabase = SyncDB
		  dim errors() as string
		  
		  db.SQLExecute("Begin Transaction")
		  
		  For i as integer = 0 to ars.Ubound
		    
		    dim ps as SQLitePreparedStatement = ars(i)
		    
		    If ps <> Nil Then
		      ps.SQLExecute
		      if db.Error Then
		        errors.Append( i.ToText + ":" + db.ErrorMessage )
		        db.SQLExecute("Rollback")
		        Return errors
		      End If
		      
		    End If
		    
		  Next
		  
		  db.SQLExecute("Commit")
		  Return errors
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ExtractFieldsFromQuery(QueryType as String, sql as String) As String()
		  
		  Select Case QueryType
		  Case "INSERT"
		    
		    // Find the start and end and length of the fields section
		    dim st,en,length as integer
		    st = sql.InStr("(") + 1
		    en = sql.InStr(")") - 1
		    length = en - st + 1
		    
		    // Extract the field section
		    dim fs as string = Mid( sql, st, length )
		    // split the field section into array
		    dim ars() as string = fs.Split(",")
		    Return ars()
		    
		  Case "UPDATE", "DELETE"
		    
		    dim cmpt as Boolean
		    dim srchst as integer
		    dim ars() as string
		    
		    // loop until all fields are found
		    While Not cmpt
		      // find start end length of field name
		      dim equal_loc,st,en,length as integer
		      equal_loc = sql.InStr( srchst, "=" )
		      if equal_loc = -1 Then
		        cmpt = True
		        exit
		      end if
		      en = equal_loc -1
		      st = sql.InStrReverse( equal_loc, " " ) + 1
		      length = en - st + 1
		      
		      // extract
		      dim field as string = Mid( sql, st, length )
		      ars.Append(field)
		      
		      // increase the search string start location to search past this =
		      srchst = equal_loc + 2
		      if Len(sql) - 1 <= srchst then cmpt = True
		    Wend
		    
		    Return ars()
		    
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetNewUUID() As String
		  Dim crypt As New Chilkat.Crypt2
		  
		  Dim uuid As String
		  uuid = crypt.GenerateUuid()
		  
		  Return uuid
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RemoveBegEndBrackets(s as string) As string
		  dim sret as string
		  
		  sret = Mid( s, 3, Len(s) - 4 )
		  
		  Return sret
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function reqAddTable(Host as string, Table as string) As String
		  dim sock as New HTTPSocket
		  
		  dim rq as string = "http://" + Host + "/SqliteSync_315/API3/AddTable/" + Table
		  
		  // Grab the data back from the server
		  Dim data As String = sock.Get(rq, 30)
		  
		  Return data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub reqCommitSync(Host as string, SyncId as string)
		  Dim sock As New HTTPSocket
		  
		  // Build request string
		  dim rq as string = "http://" + Host + "/SqliteSync_315/API3/CommitSync/" + SyncId
		  
		  // Grab the data back from the server
		  Dim data As String = sock.Get(rq, 30)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function reqInitialize(Host as string, ClientID as string) As JSONItem
		  Dim sock As New HTTPSocket
		  
		  // Build request string
		  dim rq as string = "http://" + Host + "/SqliteSync_315/API3/InitializeSubscriber/" + ClientId
		  
		  // Grab the data back from the server
		  Dim data As String = sock.Get(rq, 30)
		  
		  // Convert data to a json object
		  dim js as New JSONItem(data)
		  
		  
		  Return js
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub reqPostChanges(Host as string, content as string)
		  dim sock as New HTTPSocket
		  
		  dim content_type as string = "application/json"
		  
		  // Build request string
		  dim rq as string = "http://" + Host + "/SqliteSync_315/API3/Send/"
		  
		  sock.SetRequestContent( content, content_type )
		  
		  sock.Post( rq )
		  // sock.SendRequest("Post", rq)
		  dim s as string = Str(sock.HTTPStatusCode)
		  Break
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function reqRemoveTable(Host as string, Table as string) As String
		  dim sock as New HTTPSocket
		  
		  dim rq as string = "http://" + Host + "/SqliteSync_315/API3/RemoveTable/" + Table
		  
		  // Grab the data back from the server
		  Dim data As String = sock.Get(rq, 30)
		  
		  Return data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function reqSync(Host as string, ClientId as string, TableName as string) As JSONItem
		  Dim sock As New HTTPSocket
		  
		  // Build request string
		  dim rq as string = "http://" + Host + "/SqliteSync_315/API3/Sync/" + ClientId + "/" + TableName
		  
		  // Grab the data back from the server
		  Dim data As String = sock.Get(rq, 30)
		  
		  // Convert data to a json object
		  dim js as New JSONItem( RemoveBegEndBrackets(data) )
		  
		  
		  Return js
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected ServerHost As String = "207.246.68.7"
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected SyncDB As SQLiteDatabase
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected Tables() As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected UserId As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
