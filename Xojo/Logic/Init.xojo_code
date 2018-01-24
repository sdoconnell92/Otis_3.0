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
		  Quit
		End Sub
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
		  
		  win.Display
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Go()
		  
		  AddHandler tmSplashDisplay, AddressOf Init.HandleSpashDisplayTimerAction
		  
		  AddHandler oThread.Run, AddressOf Init.HandleThreadRun
		  oThread.Run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleSpashDisplayTimerAction(sender as Timer)
		  
		  If bDisplaySplash Then 
		    ' splash requested
		    If winSpl = Nil Then
		      ' splash does not exist
		      dim w as New winSplash
		      winSpl = w
		      winSpl.Display
		    Else
		      ' splash exists
		    End If
		  else
		    ' splash not wanted
		    If winSpl = Nil Then
		      ' splash does not exist
		    else
		      'splash exists
		      winSpl.Close
		      winSpl = Nil
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleThreadRun(sender as Thread)
		  dim bOfflineReady as Boolean
		  
		  If Not InitDirectories Then
		    ErrManage("Init.InitDirectories", "Could not initialize file system directory. Must Close App")
		    MsgBox("Could not initialize file system directory. Must Close App")
		    CloseApp
		  End If
		  
		  bDisplaySplash = True
		  
		  // Start the updater, then wait for it to complete
		  RunUpdater
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
		      If CreateOfflinePrompt Then
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
		  
		  If Not app.bOffline Then
		    ' we are online
		    init.UpdateTempEiplNumbers
		  End If
		  
		  Init.DisplayMainWindow
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleUpdateWaiterTimerAction(sender as timer)
		  If app.UpdateInitiater = Nil And Updater.Checker.UpdateWindowIsOpen = False Then
		    
		    me.Mode = Timer.ModeOff
		    Init.UpdateDone = True
		    
		  Else
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function InitDirectories() As Boolean
		  
		  Return Directory.Init
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function InitLocalDb() As Boolean
		  dim sqcl as SqliteSync.SqlSyncClass
		  dim rd as New ResourceDirectories
		  
		  // Run class Init which will create the databse if neccesary and connect to it
		  sqcl = SqliteSync.SqlSyncClass.Init(ValueRef.kSyncServerAddress, rd.otis_data_file, rd.SyncDets, ValueRef.kSyncTables )
		  
		  If sqcl = Nil Then
		    Return False
		  Else
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunUpdater()
		  Updater.Run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ToggleOffline(bool as Boolean)
		  App.bOffline = bool
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
		Private bDisplaySplash As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private oThread As Thread
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected sStatus1 As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected sStatus2 As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private tmSplashDisplay As Timer
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
