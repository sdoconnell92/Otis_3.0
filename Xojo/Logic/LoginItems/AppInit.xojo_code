#tag Class
Protected Class AppInit
	#tag Method, Flags = &h0
		Sub CheckUIState(sender as timer)
		  If Not bInitDone Then
		    // check if login window is needed
		    If bLaunchLoginWindow Then
		      HandleLoginWindow
		      bLoginAttemptComplete = True
		    End If
		    bLaunchLoginWindow = False
		    
		    // Check if offline prompt is needed
		    If bPromptOfflineMode Then
		      HandleOfflinePrompt
		      bOfflineModePromptComplete = True
		    End If
		    bPromptOfflineMode = False
		  Else
		    
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  tmrUI = New Timer
		  AddHandler tmrUI.Action, AddressOf CheckUIState
		  tmrUI.Mode = Timer.ModeOff
		  
		  thrInit = New Thread
		  AddHandler thrInit.Run, AddressOf mThreadRun
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Go()
		  
		  // Launch the Init thread
		  thrInit.Run
		  
		  'tmrUI.Mode = Timer.ModeMultiple
		  
		  'While Not bInitDone
		  
		  '// check if login window is needed
		  'If bLaunchLoginWindow Then
		  'HandleLoginWindow
		  'bLoginAttemptComplete = True
		  'End If
		  'bLaunchLoginWindow = False
		  '
		  // Check if offline prompt is needed
		  'If bPromptOfflineMode Then
		  'HandleOfflinePrompt
		  'bOfflineModePromptComplete = True
		  'End If
		  'bPromptOfflineMode = False
		  
		  'Wend
		  
		  'If bOpenMainWindow Then
		  // Launch main windows
		  'dim winMain as New winMain_1TabPanel
		  'app.MainWindow = winMain
		  'app.MainWindow.Show
		  'Else
		  'Quit
		  'End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleLoginWindow()
		  
		  // Get login info from background thread
		  dim sUsername as String = dictLoginInfoToUI.Value("Username").StringValue
		  dim sPassword as string = dictLoginInfoToUI.Value("Password").StringValue
		  dim bAuthFailed as Boolean = dictLoginInfoToUI.Value("AuthFailed").BooleanValue
		  dim sHost as string = dictLoginInfoToUI.Value("Host").StringValue
		  dim iPort as integer = dictLoginInfoToUI.Value("Port").IntegerValue
		  dim sDatabaseName as string = dictLoginInfoToUI.Value("DatabaseName").StringValue
		  
		  dim lw as New window_login
		  
		  lw.my_open(sUsername,sPassword,bAuthFailed,sHost,iPort,sDatabaseName)
		  lw.ShowModal
		  
		  dictLoginInfoFromUI = new Dictionary
		  dictLoginInfoFromUI.Value("Username") = lw.username
		  dictLoginInfoFromUI.Value("Password") = lw.password
		  dictLoginInfoFromUI.Value("Abort") = lw.aborted
		  dictLoginInfoFromUI.Value("SaveUsername") = lw.save_username
		  dictLoginInfoFromUI.Value("SavePassword") = lw.save_password
		  dictLoginInfoFromUI.Value("AutoLogin") = lw.auto_login
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleOfflinePrompt()
		  // Ask the user if they want to work offline
		  Dim msgboxResult as integer
		  msgboxResult = MsgBox( "Could not log into server. Would you like to work offline?",4 )
		  
		  If msgboxResult = 6 Then
		    'Yes
		    bUserOfflineModeResponse = True
		  ElseIf msgboxResult = 7 Then
		    'No
		    bUserOfflineModeResponse = False
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function LoginToRemote(sUsername as String, sPassword as string, sHost as String, iPort as integer, sDatabaseName as string) As PostgreSQLDatabase
		  Dim db as New PostgreSQLDatabase
		  
		  db.Host = sHost
		  db.Port = iPort
		  db.DatabaseName = sDatabaseName
		  db.UserName = sUsername
		  db.Password = sPassword
		  
		  If db.Connect Then
		    Return db
		  Else
		    Return Nil
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mThreadRun(sender as Thread)
		  Dim bOfflineCapable, bInitDataPull as Boolean
		  
		  // Check Databases For Structural Integrity
		  Dim bDBIntact as Boolean = InitializationModule.CheckDatabases
		  If Not bDBIntact Then
		    'The local databases are not intact
		    bOfflineCapable = False
		    bInitDataPull = False
		    
		    InitializationModule.InitialSetup
		  Else
		    'The local databases are intact
		    
		    // Check the InitDataPull FIle
		    If InitializationModule.CheckInitDataPull Then
		      'The initial data pull has happened
		      bOfflineCapable = True
		    Else
		      bOfflineCapable = False
		    End If
		  End If
		  
		  // Grab Login Info
		  Dim dictLoginInfo as Dictionary = UserInfo.GetLoginInfo()
		  dim sUsername as string
		  dim sPassword as string
		  dim bAutoLogin as Boolean
		  If dictLoginInfo <> Nil Then
		    sUsername = dictLoginInfo.Value("Username").StringValue
		    sPassword = dictLoginInfo.Value("Password").StringValue
		    bAutoLogin = dictLoginInfo.Value("AutoLogin").BooleanValue
		  End If
		  
		  Dim bOpenLoginWindow as Boolean
		  Dim bAuthFailed as Boolean
		  If bAutoLogin Then
		    If sUsername <> "" And sPassword <> "" Then
		      
		      dim db as PostgreSQLDatabase
		      db = LoginToRemote( sUsername, sPassword, RegDBHost, RegDBPort, RegDBDatabaseName )
		      If db <> Nil Then
		        ' we have connected to remote database
		        app.bOnline = True
		        app.regDB = db
		      Else
		        bAuthFailed = True
		        bOpenLoginWindow = True
		      End If
		    End If
		  Else 
		    bOpenLoginWindow = True
		  End If
		  
		  dim bAbort as Boolean
		  While app.bOnline <> True Or bAbort = True
		    // Prompt user for login info
		    If bOpenLoginWindow Then
		      dictLoginInfoToUI = New Dictionary
		      dictLoginInfoToUI.Value("Username") = sUsername
		      dictLoginInfoToUI.Value("Password") = sPassword
		      dictLoginInfoToUI.Value("AuthFailed") = bAuthFailed
		      dictLoginInfoToUI.Value("Host") = RegDBHost
		      dictLoginInfoToUI.Value("Port") = RegDBPort
		      dictLoginInfoToUI.Value("DatabaseName") = RegDBDatabaseName
		      
		      bLaunchLoginWindow = True
		      
		      tmrUI.Mode = Timer.ModeSingle
		      
		      // Loop while waiting for user to login
		      While Not bLoginAttemptComplete
		        thrInit.Sleep(500)
		      Wend
		      
		      bLoginAttemptComplete = False
		      
		      sUsername = dictLoginInfoFromUI.Value("Username").StringValue
		      sPassword = dictLoginInfoFromUI.Value("Password").StringValue
		      bAbort = dictLoginInfoFromUI.Value("Abort").BooleanValue
		      dim bSaveUN as boolean = dictLoginInfoFromUI.Value("SaveUsername").BooleanValue
		      dim bSavePass as Boolean = dictLoginInfoFromUI.Value("SavePassword").BooleanValue
		      dim bSaveAutoLogin as Boolean = dictLoginInfoFromUI.Value("AutoLogin").BooleanValue
		      
		      If bAbort Then Exit
		      
		      dim db as PostgreSQLDatabase
		      db = LoginToRemote(sUsername,sPassword,RegDBHost,RegDBPort,RegDBDatabaseName)
		      If db <> Nil Then
		        ' connection succsesful
		        app.bOnline = True
		        app.regDB = db
		        
		        dim svUN as string
		        dim svPass as string
		        dim svAL as Boolean
		        
		        If bSaveUN Then svUN = sUsername
		        If bSavePass Then svPass = sPassword
		        If bSaveAutoLogin Then svAL = True
		        
		        If bSaveUN Then UserInfo.SaveLoginInfo(svUN,svPass,svAL)
		        
		      Else
		        bAuthFailed = True
		      End If
		      
		    End If
		  Wend
		  
		  // Check If we are online
		  If app.bOnline Then
		    ' we are online
		    If InitializationModule.CheckInitDataPull Then
		      // Run syncronization of local and remote
		      Try
		        OSM.RunSync()
		      Catch err as RuntimeException
		        ErrManage("App.Initialize","Could not Push...:  " + err.Message )
		        break
		      End Try
		    Else
		      // Run Full data pull from remote to local
		      dim rd as New ResourceDirectories
		      Try
		        osm.RunFullSync
		      Catch err as RuntimeException
		        ErrManage("App.Initialize","Could not do full sync | " + err.Message )
		        break
		        RD.otis_data_file.FilePath.Delete
		        MsgBox("Error while trying to sync data from the server. App must quit")
		        Quit
		      End Try
		      InitializationModule.SetInitDataPull(True)
		    End If
		    bOpenMainWindow = True
		  Else
		    'we are offline
		    If bOfflineCapable Then
		      bPromptOfflineMode = True
		      tmrUI.Mode = Timer.ModeSingle
		      While Not bOfflineModePromptComplete
		        
		      Wend
		      
		      If bUserOfflineModeResponse Then
		        ' user wants to work offline
		        bOpenMainWindow = True
		      Else
		        bOpenMainWindow = False
		      End If
		    Else
		      bOpenMainWindow = False
		    End If
		  End If
		  
		  bInitDone = True
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		bInitDone As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private bLaunchLoginWindow As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private bLoginAttemptComplete As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private bOfflineModePromptComplete As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		bOpenMainWindow As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private bPromptOfflineMode As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private bUserOfflineModeResponse As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private dictLoginInfoFromUI As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private dictLoginInfoToUI As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private thrInit As Thread
	#tag EndProperty

	#tag Property, Flags = &h0
		tmrUI As Timer
	#tag EndProperty


	#tag Constant, Name = RegDBDatabaseName, Type = String, Dynamic = False, Default = \"otis_data", Scope = Private
	#tag EndConstant

	#tag Constant, Name = RegDBHost, Type = String, Dynamic = False, Default = \"45.63.78.70", Scope = Private
	#tag EndConstant

	#tag Constant, Name = RegDBPort, Type = Double, Dynamic = False, Default = \"5432", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="bInitDone"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="bOpenMainWindow"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
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
End Class
#tag EndClass
