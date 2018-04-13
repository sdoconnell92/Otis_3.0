#tag Module
Protected Module StinkSync
	#tag Method, Flags = &h21
		Private Function ApplySyncToDb(db as SQLiteDatabase, SyncData as string, WorkingDirectory as FolderItem, PythonModules as FolderItem) As String
		  Dim package as Python3Module
		  Dim func as Python3Function
		  Dim params as Python3Parameters
		  Dim result as Python3Result
		  dim tup as String
		  dim f as FolderItem = PythonModules
		  
		  // Add search path where Python can find our module
		  Python3Script.AddSearchPath(f)
		  
		  // We try to load the Python module
		  package = Python3Script.GetModule("Utilities")
		  
		  if package <> nil then
		    
		    // See if we can find function
		    func = package.GetFunction("digest_sync_data")
		    
		    if func <> nil then
		      // Build some parameters to pass to the function
		      params = new Python3Parameters(2)
		      params.stringvalue(0) = db.DatabaseFile.NativePath
		      params.stringvalue(1) = SyncData
		      
		      // run the function
		      result = func.Invoke(params)
		      
		      if result <> nil then
		        tup = result.StringValue
		        Return tup
		      else
		        if Python3Script.ErrorOccurred then
		          dim err as new RuntimeException
		          err.message = Python3Script.GetError()
		          Python3Script.ClearError()
		        end if
		      end if
		    end if
		  else
		    dim err as new RuntimeException
		    err.Message = "Could not load python module"
		    raise err
		  end if 
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CheckClientInit()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ExecuteAuditScript(db as SQLiteDatabase, script as Dictionary)
		  
		  // Start a transaction
		  db.SQLExecute("Begin;")
		  
		  // Loop through all of the statements 
		  dim i as integer = 0
		  dim done as Boolean = False
		  while not done
		    
		    dim i_s as string
		    i_s = Format( i, "00000" )
		    dim sql_key as string = i_s + " Statement"
		    dim values_key as string = i_s + " Values"
		    dim sql as string
		    dim vals() as Variant
		    
		    try
		      sql = script.Value(sql_key)
		      values_key = script.Value(values_key)
		    Catch err as KeyNotFoundException
		      done = True
		      exit
		    end try
		    
		    try
		      
		    end try
		  wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ExecuteInitScript(db as SQLiteDatabase, script as Xojo.Core.Dictionary) As Boolean
		  
		  // Start a transaction
		  db.SQLExecute("Begin;")
		  
		  // Loop through all of the statements 
		  dim i as integer = 1
		  dim done as Boolean = False
		  while not done
		    
		    dim i_s as string
		    i_s = Format( i, "00000" )
		    dim sql_key as string = i_s
		    dim sql as string
		    
		    try
		      sql = script.Value(sql_key)
		    Catch err as KeyNotFoundException
		      done = True
		      exit
		    end try
		    
		    db.SQLExecute(sql)
		    if db.Error then
		      Break
		      db.SQLExecute("Rollback;")
		      done = True
		      Return False
		    end if
		    
		    i = i + 1
		    
		  wend
		  
		  db.SQLExecute("Commit;")
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetAuditTransactions(db as SQLiteDatabase, PythonModules as FolderItem, SubscriberId as string) As String
		  Dim package as Python3Module
		  Dim func as Python3Function
		  Dim params as Python3Parameters
		  Dim result as Python3Result
		  dim js as string
		  dim f as FolderItem = PythonModules
		  
		  // Add search path where Python can find our module
		  Python3Script.AddSearchPath(f)
		  
		  // We try to load the Python module
		  package = Python3Script.GetModule("Utilities")
		  
		  if package <> nil then
		    
		    // See if we can find function
		    func = package.GetFunction("create_send_string")
		    
		    if func <> nil then
		      // Build some parameters to pass to the function
		      params = new Python3Parameters(2)
		      params.stringvalue(0) = SubscriberId
		      params.stringvalue(1) = db.DatabaseFile.NativePath
		      
		      // run the function
		      result = func.Invoke(params)
		      
		      if result <> nil then
		        js = Str(result.StringValue)
		        Return js
		      else
		        if Python3Script.ErrorOccurred then
		          dim err as new RuntimeException
		          err.message = Python3Script.GetError()
		          Python3Script.ClearError()
		        end if
		      end if
		    end if
		  else
		    dim err as new RuntimeException
		    err.Message = "Could not load python module"
		    raise err
		  end if 
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetChanges(db as SQLiteDatabase, WorkingDirectory as FolderItem, PythonModulePath as FolderItem) As Boolean
		  dim tup as String
		  dim SyncId as String
		  Break
		  // Get subscriber id
		  dim SubscriberId as string = ReadSubscriberId(WorkingDirectory)
		  
		  // Get changes from the server
		  dim data as string = reqSync(SubscriberId)
		  
		  // Send changes to python to apply the changes
		  tup = ApplySyncToDb(db, data, WorkingDirectory, PythonModulePath)
		  
		  if tup <> "" then
		    dim bbb as Boolean
		    dim ars() as string = tup.Split(",")
		    if ars(0) = "True" then
		      bbb = True
		    else
		      bbb = False
		    end if
		    SyncId = ars(1)
		    
		    if bbb then
		      // Sync application good
		      // Send commit sync request
		      dim retdata as string = reqCommitSync(SyncId)
		    else
		      dim err as New RuntimeException
		      err.Message = ("Could not apply sync")
		      raise err
		    end if
		  else
		    if Python3Script.ErrorOccurred then
		      dim err as new RuntimeException
		      err.message = Python3Script.GetError()
		      Python3Script.ClearError()
		      raise err
		    end if
		  end if
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub GetColumnsTypes()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function InitClient(db as SQLiteDatabase, WorkingDirectory as FolderItem) As Boolean
		  
		  // Create a new subscriber Id
		  dim SubscriberId as string = uuid.uuid4
		  
		  // Init the database
		  if not InitDatabase(db, SubscriberId) then
		    Break
		    Return False
		  end if
		  
		  // Save the subscriberid
		  if SaveSubscriberId(SubscriberId, WorkingDirectory) then
		    Return True
		  else
		    Break
		    Return False
		  end if
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function InitDatabase(db as SQLiteDatabase, SubscriberId as string) As Boolean
		  
		  // Execute Init request from server
		  dim data as string = reqInitializeSubscriber(SubscriberId)
		  
		  // Convert data into json
		  dim script as Xojo.Core.Dictionary
		  script = Xojo.Data.ParseJSON(data.totext)
		  
		  // Execute init script
		  if ExecuteInitScript(db, script) then
		    Return True
		  else
		    Break
		    Return False
		  end if
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PostChanges(db as SQLiteDatabase, WorkingDirectory as FolderItem, PythonModulePath as FolderItem) As Boolean
		  dim js as string
		  
		  // Get subscriber id
		  dim SubscriberId as string = ReadSubscriberId(WorkingDirectory)
		  
		  // Get changes from database
		  js = GetAuditTransactions( db, PythonModulePath, SubscriberId )
		  
		  MsgBox(js)
		  
		  // Send changes to server
		  if reqSend(SubscriberId, js) then
		    Return True
		  else
		    Return False
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadSubscriberId(FolderPath as FolderItem) As String
		  dim SubscriberId as string
		  
		  dim f as FolderItem = FolderPath.Child(kSubscriberIdFileName)
		  
		  If f <> Nil Then
		    If f.Exists Then
		      Dim t As TextInputStream
		      Try
		        t = TextInputStream.Open(f)
		        SubscriberId = t.ReadAll
		      Catch e As IOException
		        Return SubscriberId
		      End Try
		      t.Close
		    End If
		  End If
		  
		  Return SubscriberId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function reqCommitSync(SyncId as String) As String
		  dim req as string
		  dim sock as new HTTPSecureSocket
		  sock.Secure = False
		  
		  req = kServerAddress + kCommitSync + SyncId + "/"
		  
		  dim data as string = sock.Get(req, 30)
		  
		  data = data.DefineEncoding(Encodings.UTF8)
		  
		  Return data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function reqInitializeSubscriber(SubscriberId as string) As String
		  dim req as string
		  dim sock as new HTTPSecureSocket
		  sock.Secure = False
		  
		  req = kServerAddress + kInitializeSubscriber + SubscriberId + "/"
		  
		  dim data as string = sock.Get(req, 30)
		  
		  data = data.DefineEncoding(Encodings.UTF8)
		  
		  Return data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function reqSend(SubscriberId as string, content as string) As Boolean
		  dim req as string
		  dim sock as new HTTPSecureSocket
		  sock.Secure = False
		  
		  req = kServerAddress + kSend
		  sock.SetRequestContent( content, "application/json" )
		  
		  dim data as string = sock.Post(req, 30)
		  
		  if data = kServerStatusGood then
		    Return True
		  else
		    Return False
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function reqServerCheck() As Boolean
		  dim req as string
		  dim sock as new HTTPSecureSocket
		  sock.Secure = False
		  
		  req = kServerAddress + kRoot
		  
		  dim data as string = sock.Get(req, 30)
		  
		  if data = kServerStatusGood then
		    Return True
		  else
		    Return False
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function reqSync(SubscriberId as string) As String
		  dim req as string
		  dim sock as new HTTPSecureSocket
		  sock.Secure = False
		  
		  req = kServerAddress + kSync + SubscriberId + "/"
		  
		  dim data as string = sock.Get(req, 30)
		  
		  data = data.DefineEncoding(Encodings.UTF8)
		  
		  Return data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SaveSubscriberId(SubscriberId as string, FolderPath as FolderItem) As Boolean
		  
		  If FolderPath <> Nil Then
		    Dim f As FolderItem = FolderPath.Child(kSubscriberIdFileName)
		    If f <> Nil Then
		      Try
		        Dim t As TextOutputStream = TextOutputStream.Create(f)
		        t.Write(SubscriberId)
		        t.Close
		      Catch e As IOException
		        Return False
		      End Try
		    Else
		      Return False
		    End If
		  Else
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ServerCheck() As Boolean
		  Return reqServerCheck
		End Function
	#tag EndMethod


	#tag Constant, Name = kCommitSync, Type = String, Dynamic = False, Default = \"CommitSync/", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"CommitSync/"
	#tag EndConstant

	#tag Constant, Name = kInitializeSubscriber, Type = String, Dynamic = False, Default = \"InitializeSubscriber/", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"InitializeSubscriber/"
	#tag EndConstant

	#tag Constant, Name = kRoot, Type = String, Dynamic = False, Default = \"", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \""
	#tag EndConstant

	#tag Constant, Name = kSend, Type = String, Dynamic = False, Default = \"Send/", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"Send/"
	#tag EndConstant

	#tag Constant, Name = kSendStatusBad, Type = String, Dynamic = False, Default = \"Send Unsuccessful", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"Send Unsuccessful"
	#tag EndConstant

	#tag Constant, Name = kSendStatusGood, Type = String, Dynamic = False, Default = \"Send Successful", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"Send Successful"
	#tag EndConstant

	#tag Constant, Name = kServerAddress, Type = String, Dynamic = False, Default = \"http://192.168.88.155:5000/", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"http://192.168.88.155:5000/"
	#tag EndConstant

	#tag Constant, Name = kServerStatusGood, Type = String, Dynamic = False, Default = \"StinkSync is running. MainDb \x3D True", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"StinkSync is running. MainDb \x3D True"
	#tag EndConstant

	#tag Constant, Name = kSqlGetAuditTransactions, Type = String, Dynamic = False, Default = \"", Scope = Private
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"Select rowid\x2C time\x2C tbl\x2C op\x2C old\x2C new\x2C record_id From _audit t1 Where time \x3D( Select max Where t1.record_id \x3D _audit.record_id) Order By rowid;"
	#tag EndConstant

	#tag Constant, Name = kSubscriberIdFileName, Type = String, Dynamic = False, Default = \"SubscriberId", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kSync, Type = String, Dynamic = False, Default = \"Sync/", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"Sync/"
	#tag EndConstant


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
