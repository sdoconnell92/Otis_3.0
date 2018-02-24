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
		    Return db
		  End If
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CreateLocalChangeJSON(xml as String, UserID as string) As String
		  dim builder() as string
		  
		  builder.Append( "{")
		  builder.Append( """subscriber"":""" + UserID + """, ""content"":""" + xml.JSONify + """, ""version"":""3""" )
		  builder.Append( "}" )
		  
		  Return Join(builder, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CreateLocalChangeXML(SyncDB as SQLiteDatabase) As String
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
		            If s = "" Then s = "Null"
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
		            If s = "" Then s = "Null"
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
		  
		  Return Join(builder, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CreateSQLFromInitialize(js as JSONItem, SyncDb as SQLiteDatabase) As SQLitePreparedStatement()
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
		Private Function CreateSQLFromSync(js as JSONItem, SyncDB as SQLiteDatabase) As SQLitePreparedStatement()
		  dim s as string
		  dim ars() as SQLitePreparedStatement
		  dim db as SQLiteDatabase = SyncDB
		  dim tn as string = js.Value( "TableName" ).StringValue
		  
		  s = "TriggerInsertDrop"
		  dim tests as string = js.Value(s).StringValue
		  If js.Value(s).StringValue <> "" Then ars.Append( db.Prepare( js.Value(s).StringValue ) )
		  
		  s = "TriggerUpdateDrop"
		  tests = js.Value(s).StringValue
		  If js.Value(s).StringValue <> "" Then ars.Append( db.Prepare( js.Value(s).StringValue ) )
		  
		  s = "TriggerDeleteDrop"
		  tests = js.Value(s).StringValue
		  If js.Value(s).StringValue <> "" Then ars.Append( db.Prepare( js.Value(s).StringValue ) )
		  
		  s = js.Value("Records").StringValue
		  If s = "" Then 
		    ReDim ars(-1)
		    Return ars
		  End If
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
		  tests = js.Value(s).StringValue
		  If js.Value(s).StringValue <> "" Then ars.Append( db.Prepare( js.Value(s).StringValue ) )
		  
		  s = "TriggerUpdate"
		  tests = js.Value(s).StringValue
		  If js.Value(s).StringValue <> "" Then ars.Append( db.Prepare( js.Value(s).StringValue ) )
		  
		  s = "TriggerDelete"
		  tests = js.Value(s).StringValue
		  If js.Value(s).StringValue <> "" Then ars.Append( db.Prepare( js.Value(s).StringValue ) )
		  
		  
		  Return ars()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ExecAddTables(sock as HttpSecureSocket, TableNames() as string)
		  // Loop through each TableName and use the single tablename version of this 
		  For Each tn as string In TableNames()
		    ExecAddTables(sock, tn)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ExecAddTables(sock as HttpSecureSocket, TableName as string)
		  
		  // Add the table to the list of tables to sync on server
		  dim s as string = reqAddTable(sock, TableName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ExecInitialize(sock as HttpSecureSocket, UserID as string, SyncDB as SQLiteDatabase) As Boolean
		  dim js as JSONItem = reqInitialize(sock,UserId)
		  If js = Nil then Return False
		  
		  dim ars() as SQLitePreparedStatement = CreateSQLFromInitialize(js, SyncDB)
		  
		  dim ers() as string = ExecuteStatements(ars(), SyncDB)
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
		Protected Sub ExecPushChanges(sock as HttpSecureSocket, SyncDB as SQLiteDatabase, UserID as string, Tables() as string)
		  
		  dim s as string = CreateLocalChangeXML(SyncDB)
		  
		  dim js as String = CreateLocalChangeJSON(s, UserID)
		  
		  reqPostChanges( sock, js )
		  
		  ResetMergeUpdate(SyncDB, Tables())
		  ResetMergeDelete(SyncDB)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ExecSync(sock as HttpSecureSocket, SyncDB as sqlitedatabase, Tables() as String, UserID as string) As Boolean
		  dim errors as New Dictionary
		  
		  For i as integer = 0 To Tables.Ubound
		    dim tn as string  = Tables(i)
		    dim js as JSONItem = reqSync(sock, UserId, tn)
		    
		    dim ars() as SQLitePreparedStatement = CreateSQLFromSync(js, SyncDB)
		    If ars.Ubound = -1 Then Return True
		    
		    dim ers() as string = ExecuteStatements(ars(), SyncDB)
		    If ers.Ubound = -1 Then
		      'success
		      dim syncid as string = js.Value("SyncId").StringValue
		      // Send a commit back to server
		      reqCommitSync(sock, syncid)
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
		Private Function ExecuteStatements(ars() as SQLitePreparedStatement, SyncDB as SQLiteDatabase) As String()
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

	#tag Method, Flags = &h1
		Protected Function GetErrors() As String()
		  Return errors
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LogError(content as string)
		  dim s as string
		  dim d as New date
		  
		  s = "[" + d.SQLDateTime + "] " + content
		  
		  errors.Append(s)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RemoveBegEndBrackets(s as string) As string
		  dim sret as string
		  
		  sret = Mid( s, 3, Len(s) - 4 )
		  
		  Return sret
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function reqAddTable(sock as HttpSecureSocket, Table as string) As String
		  
		  dim rq as string = "http://" + ValueRef.kSyncServerAddress + "/SqliteSync_315/API3/AddTable/" + Table
		  
		  // Grab the data back from the server
		  Dim data As String = SqliteSync.SocketGet(sock,rq,30)
		  
		  Return data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub reqCommitSync(sock as HttpSecureSocket, SyncId as string)
		  
		  // Build request string
		  dim rq as string = "http://" + ValueRef.kSyncServerAddress + "/SqliteSync_315/API3/CommitSync/" + SyncId
		  
		  // Grab the data back from the server
		  Dim data As String = SqliteSync.SocketGet(sock,rq,30)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function reqInitialize(sock as HttpSecureSocket, ClientID as string) As JSONItem
		  
		  // Build request string
		  dim rq as string = "http://" + ValueRef.kSyncServerAddress + "/SqliteSync_315/API3/InitializeSubscriber/" + ClientId
		  
		  // Grab the data back from the server
		  Dim data As String = SqliteSync.SocketGet(sock,rq,30)
		  
		  If data.InStr("Error creating new subscriber") > 0 Then
		    ErrManage( "SqliteSync.reqInitialize", "Could not Initialize Subscriber: data" )
		    Return Nil
		  End If
		  
		  // Convert data to a json object
		  dim js as New JSONItem(data)
		  
		  
		  Return js
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub reqPostChanges(sock as HttpSecureSocket, content as string)
		  
		  dim content_type as string = "application/json"
		  
		  // Build request string
		  dim rq as string = "http://" + ValueRef.kSyncServerAddress + "/SqliteSync_315/API3/Send/"
		  Break
		  sock.SetRequestContent( content, content_type )
		  
		  SqliteSync.SocketPost(sock, rq)
		  // sock.SendRequest("Post", rq)
		  dim s as string = Str(sock.HTTPStatusCode)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function reqRemoveTable(sock as HttpSecureSocket, Table as string) As String
		  
		  dim rq as string = "http://" + ValueRef.kSyncServerAddress + "/SqliteSync_315/API3/RemoveTable/" + Table
		  
		  // Grab the data back from the server
		  Dim data As String = SqliteSync.SocketGet(sock,rq,30)
		  
		  Return data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function reqSync(sock as HttpSecureSocket, ClientId as string, TableName as string) As JSONItem
		  
		  // Build request string
		  dim rq as string = "http://" + ValueRef.kSyncServerAddress + "/SqliteSync_315/API3/Sync/" + ClientId + "/" + TableName
		  
		  // Grab the data back from the server
		  Dim data As String = SqliteSync.SocketGet(sock,rq,30)
		  
		  // Convert data to a json object
		  dim js as New JSONItem( RemoveBegEndBrackets(data) )
		  
		  
		  Return js
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ResetMergeDelete(SyncDB as SQLiteDatabase)
		  dim db as SQLiteDatabase = SyncDB
		  
		  dim s as string = "Delete From MergeDelete;"
		  db.SQLExecute(s)
		  If db.Error Then Break
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ResetMergeUpdate(SyncDB as SQLiteDatabase, Tables() as string)
		  dim db as SQLiteDatabase = SyncDB
		  dim errors as New Dictionary
		  Break
		  For Each tn as String In Tables()
		    dim s as string = "Update " + tn + " set MergeUpdate=0 Where MergeUpdate > 0;"
		    db.SQLExecute(s)
		    If db.Error Then
		      errors.Value(s) = db.ErrorMessage
		    End If
		  Next
		  
		  If errors.Keys.Ubound <> -1 Then Break
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SocketGet(sock as HTTPSecureSocket, request as string, timeout as integer) As String
		  dim s as string
		  
		  SqliteSync.RequestID = GetNewUUID
		  
		  s = sock.Get(request, timeout)
		  
		  Return s
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SocketPost(sock as HTTPSecureSocket, request as string)
		  
		  SqliteSync.RequestID = GetNewUUID
		  
		  sock.Post( request )
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private errors() As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected RequestID As string
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
