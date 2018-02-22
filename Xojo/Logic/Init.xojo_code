#tag Module
Protected Module Init
	#tag Method, Flags = &h21
		Private Function Authenticate() As Boolean
		  If Auth.Authenticate Then
		    Return True
		  Else
		    Return False
		  End If
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CloseApp()
		  Break
		  Quit
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ConnectDatabase() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CreateOfflinePrompt() As Boolean
		  dim d as new MessageDialog
		  dim res as MessageDialogButton
		  
		  d.Title = "Oflline Mode?"
		  d.Message = "Cannot connect to the server.  Would you like to work offline?"
		  d.Icon = MessageDialog.GraphicQuestion
		  
		  d.ActionButton.Caption = "Yes"
		  d.ActionButton.Visible = True
		  
		  d.CancelButton.Caption = "No"
		  d.CancelButton.Visible = True
		  
		  res = d.ShowModal
		  Select Case res
		  Case d.ActionButton
		    Return True
		  Case d.CancelButton
		    Return False
		  End Select
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DisplayMainWindow()
		  App.OpenMainWindow
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DisplaySplash()
		  dim win as New winSplash
		  Init.winSpl = win
		  win.Display
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Go()
		  
		  Auth.Init
		  ErrorManagement.Init
		  
		  tmUpdateWaiter = New Timer
		  AddHandler tmUpdateWaiter.Action, AddressOf Init.HandleUpdateWaiterTimerAction
		  tmUpdateWaiter.Period = 200
		  tmUpdateWaiter.Enabled = True
		  tmUpdateWaiter.Mode = Timer.ModeMultiple
		  
		  tmUIDisplay = New Timer
		  AddHandler tmUIDisplay.Action, AddressOf Init.HandleUIDisplayTimerAction
		  tmUIDisplay.Period = 500
		  tmUIDisplay.Enabled = True
		  tmUIDisplay.Mode = Timer.ModeMultiple
		  
		  oThread = New Thread
		  AddHandler oThread.Run, AddressOf Init.HandleThreadRun
		  
		  If Not InitDirectories Then
		    ErrManage("Init.InitDirectories", "Could not initialize file system directory. Must Close App", True)
		    CloseApp
		  End If
		  
		  DisplaySplash
		  
		  //oThread.Run
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleThreadRun(sender as Thread)
		  dim bOfflineReady as Boolean
		  
		  
		  bDisplaySplash = True
		  
		  // Start the updater, then wait for it to complete
		  bLaunchUpdater = True
		  dim bDone as Boolean
		  While Not bDone
		    sender.Sleep(1000)
		    If UpdateDone Then
		      bDone = True
		      Exit
		    End If
		  Wend
		  
		  bOfflineReady = ValidateSqliteSyncThings
		  
		  If Init.Authenticate Then
		    ' Authentication succeesful
		    Init.ToggleOffline(False)
		  Else
		    ' Authentication unsuccesful
		    If bOfflineReady Then
		      If InquireOffline(sender) Then
		        Init.ToggleOffline(True)
		      Else
		        Init.CloseApp
		        Return
		      End If
		    Else
		      init.CloseApp
		      Return
		    End If
		  End If
		  
		  If Init.InitLocalDb( app.bOffline ) Then
		    // Local db class loaded
		  Else
		    // Local db class loading failed
		    Return
		  End If
		  
		  If Not app.bOffline Then
		    ' we are online
		    init.UpdateTempEiplNumbers
		  End If
		  
		  Init.TriggerMainWindow
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleUIDisplayTimerAction(sender as Timer)
		  
		  'If bDisplaySplash Then 
		  '' splash requested
		  'If winSpl = Nil Then
		  '' splash does not exist
		  'dim w as New winSplash
		  'winSpl = w
		  'winSpl.Display
		  'Else
		  '' splash exists
		  'End If
		  'else
		  '' splash not wanted
		  'If winSpl = Nil Then
		  '' splash does not exist
		  'else
		  ''splash exists
		  'winSpl.Close
		  'winSpl = Nil
		  'End If
		  'End If
		  
		  If bDisplayOfflinePrompt Then
		    bDisplayOfflinePrompt = False
		    dim b as boolean = CreateOfflinePrompt
		    bUserOfflineResponse = str(b)
		  End If
		  
		  If bDisplayMainWindow Then
		    sender.Mode = timer.ModeOff
		    Init.DisplayMainWindow
		    Init.winSpl.Close
		  End If
		  
		  If bLaunchUpdater Then
		    bLaunchUpdater = False
		    RunUpdater
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleUpdateWaiterTimerAction(sender as timer)
		  If Updater.Checker <> Nil Then
		    If Init.bUpdateStarted And app.UpdateInitiater = Nil And Updater.Checker.UpdateWindowIsOpen = False Then
		      
		      tmUpdateWaiter.Mode = Timer.ModeOff
		      Init.UpdateDone = True
		      
		    Else
		      
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function InitDirectories() As Boolean
		  
		  Return Directory.Init
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function InitLocalDb(Offline as Boolean) As Boolean
		  Break
		  dim sqcl as SqliteSync.SqlSyncClass
		  dim db as SQLiteDatabase = SqliteSync.ConnectDB(Directory.MainDatabase)
		  App.db = db
		  
		  // Run class Init which will create the databse if neccesary and connect to it
		  sqcl = SqliteSync.SqlSyncClass.Init(ValueRef.kSyncServerAddress, db, Directory.SqliteSyncDetails, ValueRef.kSyncTables.Split, Offline )
		  
		  If sqcl = Nil Then
		    Return False
		  Else
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function InquireOffline(sender as Thread) As Boolean
		  
		  
		  // Clear any previous answers
		  bUserOfflineResponse = ""
		  
		  // Set flag to launch offline prompt
		  bDisplayOfflinePrompt = True
		  
		  While bUserOfflineResponse = ""
		    
		    sender.Sleep(500)
		    
		  Wend
		  
		  If bUserOfflineResponse = "True" Then
		    Return True
		  Else
		    Return False
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunUpdater()
		  bUpdateStarted = True
		  Updater.Run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ToggleOffline(bool as Boolean)
		  App.bOffline = bool
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerMainWindow()
		  bDisplayMainWindow = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateTempEiplNumbers()
		  dim db as SQLiteDatabase
		  
		  db = DataFile.GetDB
		  
		  EIPLNumbering.UpdateTemporaryNumbers(db)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ValidateSqliteSyncThings() As Boolean
		  If Not Directory.SqliteSyncDetails.Exists Then Return False
		  If Not Directory.MainDatabase.Exists Then Return False
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private bDisplayMainWindow As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private bDisplayOfflinePrompt As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private bDisplaySplash As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private bLaunchUpdater As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private bUpdateStarted As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private bUserOfflineResponse As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected oThread As Thread
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected sStatus1 As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected sStatus2 As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private tmUIDisplay As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private tmUpdateWaiter As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private UpdateDone As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private winSpl As winSplash
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
