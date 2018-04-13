#tag Module
Protected Module Auth
	#tag Method, Flags = &h1
		Protected Function Authenticate() As Boolean
		  dim sock as New HTTPSecureSocket
		  sock.ConnectionType = 1
		  sock.Secure = False
		  AddHandler sock.AuthenticationRequired, AddressOf Auth.AuthenticationRouter
		  
		  dim rq as string = ValueRef.kSyncServerAddress + "/SqliteSync_315/API3/"
		  
		  Auth.RequestID = GetNewUUID
		  dim s as string = sock.get(rq, 30)
		  Auth.RequestID = ""
		  
		  If s.InStr("SQLite-Sync.COM is working correctly") <> 0 Then
		    'we connected
		    If Auth.SaveCredsToFile Then
		      Return True
		    End If
		  Else
		    'login failed
		    Return False
		  End If
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function AuthenticationRouter(sender as HTTPSecureSocket, Realm As String, Headers As InternetHeaders, ByRef Name As String, ByRef Password As String) As Boolean
		  
		  Return auth.HandleAuthenticationRequest(Name, Password)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function BuildCredsDb(f as FolderItem) As SQLiteDatabase
		  dim db as new SQLiteDatabase
		  
		  dim sql as string = "Create Table tbl_Users(username Text, password Text);"
		  
		  If f <> Nil Then
		    If f.Exists Then
		      f.Delete
		    End If
		    
		    db.DatabaseFile = f
		    If db.CreateDatabaseFile Then
		      db.SQLExecute(sql)
		      If db.Error Then
		        ErrManage("Auth.BuildCredsDb", "Could not build database: " + db.ErrorMessage)
		        Return Nil
		      End If
		    End If
		  End If
		  
		  Return db
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DisplayLoginWindow(un as string = "", pw as string = "", ErrorCode as integer = 0) As Dictionary
		  dim w as New winLogin
		  dim d as Dictionary
		  
		  w.Left = 20
		  d = w.Display(un,pw,ErrorCode)
		  
		  
		  Return d
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetCreds() As Dictionary
		  dim dictCreds as Dictionary
		  
		  // Check if this is a repeated attempt
		  If RepeatedAttempt Then
		    dictCreds = GetCredsFromUser(Auth.Username, Auth.Password, Auth.LastErrorCode)
		  Else
		    
		    dictCreds = GetCredsFromMemory
		    
		    If dictCreds = Nil Then dictCreds = GetCredsFromFile
		    
		    If dictCreds = Nil Then dictCreds = GetCredsFromUser
		    
		  End If
		  
		  Return dictCreds
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetCredsFromFile() As Dictionary
		  dim f as FolderItem = Directory.UserDatabase
		  
		  If f <> Nil Then
		    If f.Exists Then
		      dim db as New SQLiteDatabase
		      db.DatabaseFile = f
		      If db.Connect Then
		        
		        dim sql as string = "Select * From tbl_users;"
		        dim rs as RecordSet = db.SQLSelect(sql)
		        dim un, pw as string
		        un = rs.Field("Username").StringValue
		        pw = rs.Field("Password").StringValue
		        
		        If un = "" Then 
		          db.Close
		          Return Nil
		        End If
		        If un = "" Then
		          db.Close
		          Return Nil
		        End If
		        
		        dim dictCreds as New Dictionary
		        dictCreds.Value("Username") = un
		        dictCreds.Value("Password") = pw
		        
		        db.Close
		        Return dictCreds
		        
		      Else
		        Return Nil
		      End If
		      
		    Else
		      Return Nil
		    End If
		  End If
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetCredsFromMemory() As Dictionary
		  
		  If Auth.Username = "" Then Return Nil
		  If Auth.Password = "" Then Return Nil
		  
		  dim dictCreds as New Dictionary
		  dictCreds.Value("Username") = Auth.Username
		  dictCreds.Value("Password") = Auth.Password
		  
		  Return dictCreds
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetCredsFromUser(un as string = "", pw as string = "", ErrorCode as integer = 0) As Dictionary
		  dim dictCreds as Dictionary
		  
		  // Enter loop asking user for creds
		  // dont leave until user returns valid info or cancels
		  While dictCreds = Nil
		    dictCreds = InquireLoginCreds(un,pw,auth.LastErrorCode)
		    If dictCreds <> Nil Then
		      dim UserCancel as Boolean
		      If dictCreds.Keys.IndexOf("UserCancelled") <> -1 Then UserCancel = dictCreds.Value("UserCancelled").BooleanValue
		      If UserCancel Then 
		        Auth.UserAbort = UserCancel
		        Return dictCreds
		      End If
		      
		      If dictCreds.Keys.IndexOf("Username") <> -1 Then un = dictCreds.Value("Username").StringValue
		      If dictCreds.Keys.IndexOf("Password")  <> -1 Then pw = dictCreds.Value("Password").StringValue
		      
		      If un = "" Then 
		        LastErrorCode = ErrorCodes.kUsernameCannotBeBlank
		        dictCreds = Nil
		        Continue
		      End If
		      If pw = "" Then
		        LastErrorCode = ErrorCodes.kPasswordCannotBeBlank
		        dictCreds = Nil
		        Continue
		      End If
		    End If
		  Wend
		  
		  LastErrorCode = ErrorCodes.kNoError
		  
		  Return dictCreds
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function HandleAuthenticationRequest(ByRef un As String, ByRef pw As String, ErrorCode as integer = 0) As Boolean
		  
		  // Check if the current RequestID is the same as the last request id 
		  // We check this to see if this is a brand new authentication attempt 
		  // or a continued authentication attempt because of wrong credentials
		  If Auth.RequestID = Auth.LastReqID Then
		    RepeatedAttempt = True
		    
		    // Set the LastErrorCode if a specific error was not passed to us
		    If ErrorCode = 0 Then
		      LastErrorCode = ErrorCodes.kLoginFailed
		    Else
		      LastErrorCode = ErrorCode
		    End If
		  Else
		    RepeatedAttempt = False
		    Auth.LastReqID = Auth.RequestID
		    Auth.UserAbort = False
		    
		    // Set the last error code
		    If ErrorCode = 0 Then
		      LastErrorCode = ErrorCodes.kNoError
		    Else
		      LastErrorCode = ErrorCode
		    End If
		  End If
		  
		  // Get User Credentials
		  dim dictCreds as Dictionary
		  dictCreds = GetCreds
		  
		  If auth.UserAbort Then Return False
		  
		  If dictCreds <> Nil Then
		    If dictCreds.Keys.IndexOf("Username") <> -1 Then un = dictCreds.Value("Username").StringValue
		    If dictCreds.Keys.IndexOf("Password") <> -1 Then pw = dictCreds.Value("Password").StringValue
		    Auth.Username = un
		    Auth.Password = pw
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandletmUIDisplayAction(sender as Timer)
		  
		  If bDisplayLogin Then
		    bDisplayLogin = False
		    dim d as Dictionary = DisplayLoginWindow(inUserName, inPassword, inErrorCode)
		    
		    outDictionary = d
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Init()
		  
		  tmUIDisplay = New Timer
		  AddHandler tmUIDisplay.Action, AddressOf HandletmUIDisplayAction
		  tmUIDisplay.Period = 500
		  tmUIDisplay.Enabled = True
		  tmUIDisplay.Mode = Timer.ModeMultiple
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function InquireLoginCreds(un as string, pw as string, ec as integer) As Dictionary
		  inUserName = un
		  inPassword = pw
		  inErrorCode = ec
		  
		  outDictionary = Nil
		  bDisplayLogin = True
		  
		  While outDictionary = Nil
		    
		    app.SleepCurrentThread(500)
		    
		  Wend
		  
		  
		  If outDictionary <> Nil Then 
		    Return outDictionary
		  Else
		    Return nil
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SaveCredsToFile() As Boolean
		  dim f as FolderItem = Directory.UserDatabase
		  dim db as SQLiteDatabase = Auth.BuildCredsDb(f)
		  
		  If db <> Nil Then
		    dim sql as string = "Insert Into tbl_users(username, password) Values(?,?);"
		    dim ps as SQLitePreparedStatement = db.Prepare(sql)
		    ps.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		    ps.BindType(1, SQLitePreparedStatement.SQLITE_TEXT)
		    ps.Bind(0, Auth.Username)
		    ps.Bind(1, Auth.Password)
		    
		    ps.SQLExecute
		    If db.Error Then
		      ErrManage("Auth.SaveCredsToFile", "Could not save credentials to file: " + db.ErrorMessage)
		      Return False
		    End If
		    Return True
		  End If
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SaveCredsToMemory(un as string, pw as String)
		  Auth.Username = un
		  Auth.Password = pw
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private bDisplayLogin As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private inErrorCode As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private inPassword As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private inUserName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private LastErrorCode As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private LastReqID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private outDictionary As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Password As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private RepeatedAttempt As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private RequestID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private tmUIDisplay As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private UserAbort As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Username As String
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
