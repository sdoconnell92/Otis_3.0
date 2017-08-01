#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Close()
		  
		  #Pragma BreakOnExceptions Off
		  try
		    db.close
		  catch
		    'do nothing
		  end try
		  #Pragma BreakOnExceptions On
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  
		  // winSplash will call app.initialize before closing
		  dim w as new winSplash
		  w.Display
		End Sub
	#tag EndEvent

	#tag Event
		Function UnhandledException(error As RuntimeException) As Boolean
		  dim ars() as string
		  
		  ars.Append( "Stack:" )
		  ars.Append( Join(error.Stack, EndOfLine) )
		  
		  ErrManage("App.UnhandledException", "Stack: " + Join(error.Stack,"||") )
		  
		  MsgBox( Join(ars, EndOfLine) )
		  
		  Return True
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Initialize()
		  dim rd as New ResourceDirectories
		  
		  // Check Initialized File
		  Dim Initialized as Boolean
		  Dim ReInitializePlease as Boolean
		  Dim GetNewClientIDPlease as Boolean
		  Initialized = InitializationModule.CheckInitializedFile
		  
		  If Initialized Then
		  Else
		    ReInitializePlease = True
		  End If
		  
		  // Check Databases for structural integreity
		  If Not InitializationModule.CheckDatabases Then
		    ReInitializePlease = True
		  End If
		  
		  // Check if we have a client id
		  If Not UserInfo.CheckForClientID Then
		    GetNewClientIDPlease = True
		  End If
		  
		  // Check if we need to ReInitialize
		  If ReInitializePlease Then
		    GetNewClientIDPlease = True
		    // Initialize Database structure
		    InitializationModule.InitialSetup
		  End If
		  
		  // Login
		  If Login.Go Then
		    ' we have successfully logged into the registration server
		    
		    Login.State = "Online"
		    
		    // Now we check if we need a new id
		    If GetNewClientIDPlease Then
		      If UserInfo.GetNewClientIDFromServer <> 0 Then
		        'acquired id successfully
		      Else
		        'Could not get an id
		        Dim err as RuntimeException
		        err.Message = "Could not acquire a client id from server"
		        ErrManage("App.Initialize",err.Message)
		        Raise err
		      End If
		    Else
		      'New client id not needed
		    End If
		    
		    // Now lets check if we need to pull all of the data from the server down
		    'need to do full sync conditions
		    'If we have reinitialized
		    Dim FullSyncPlease as Boolean
		    If ReInitializePlease Then
		      FullSyncPlease = True
		    Else
		      // we must now check if there is any data in the local database
		      If Not InitializationModule.CheckForLocalData Then
		        FullSyncPlease = True
		      End If
		    End If
		    
		    // Push data to server possibly
		    If Not FullSyncPlease Then
		      'we are not pulling down all new information
		      // Run Sync
		      Try
		        OSM.RunSync()
		      Catch err as RuntimeException
		        ErrManage("App.Initialize","Could not Push...:  " + err.Message )
		        break
		      End Try
		      
		    Else
		      ' run a full sync
		      Try
		        osm.RunFullSync
		      Catch err as RuntimeException
		        ErrManage("App.Initialize","Could not do full sync | " + err.Message )
		        break
		        RD.otis_data_file.FilePath.Delete
		        MsgBox("Error while trying to sync data from the server. App must quit")
		        Quit
		      End Try
		      
		    End If
		    
		  Else
		    'Login to reg server not succesful
		    
		    If app.bUserAuthenticationFailed Then Quit
		    
		    // Check if we have a valid client id to work offline with
		    If GetNewClientIDPlease Then
		      'No valid client id
		      MsgBox("Could not connect to server, and no valid client id is present, or there is no local data. We must quit.")
		      Quit
		    Else
		      'valid client id
		      
		      // Check to see if there is any local data
		      If InitializationModule.CheckForLocalData Then
		        // There is local data
		        // Ask the user if they want to work offline
		        Dim msgboxResult as integer
		        msgboxResult = MsgBox( "Could not log into server. Would you like to work offline?",4 )
		        
		        If msgboxResult = 6 Then
		          'Yes
		          Login.State = "Offline"
		        ElseIf msgboxResult = 7 Then
		          'No
		          Quit
		        End If
		        
		      Else
		        // THere is no local data
		        MsgBox("There is no local data present, must quit")
		        Quit
		      End If
		    End If
		    
		  End If
		  
		  // Set Color Scheme
		  UiColors.DefaultScheme
		  
		  // Open the database file
		  db = DataFile.ConnectDB
		  if db = nil then
		    quit
		  end if
		  
		  // Lets check if any eipls need numbers from being created offline
		  DataFile.CreateNumbersForOfflineEIPLs
		  
		  // Open the main window
		  App.MainWindow = New winMain_1TabPanel
		  app.MainWindow.Show
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		bUserAuthenticationFailed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		db As SQLiteDatabase
	#tag EndProperty

	#tag Property, Flags = &h0
		MainWindow As winMain_1TabPanel
	#tag EndProperty

	#tag Property, Flags = &h0
		regDB As PostgreSQLDatabase
	#tag EndProperty


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="bUserAuthenticationFailed"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
