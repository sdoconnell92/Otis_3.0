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
		Sub UIInit()
		  
		  UiColors.DefaultScheme
		  
		  // Launch main windows
		  app.db = DataFile.ConnectDB
		  dim winMain as New winMain_1TabPanel
		  app.MainWindow = winMain
		  app.MainWindow.Show
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		bOnline As Boolean
	#tag EndProperty

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
			Name="bOnline"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="bUserAuthenticationFailed"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
