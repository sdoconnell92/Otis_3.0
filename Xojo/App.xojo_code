#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Close()
		  App.UpdateInitiater = Nil
		  
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
		Sub OpenMainWindow()
		  // Launch main windows
		  dim winMain as New winMain_1TabPanel
		  app.MainWindow = winMain
		  app.MainWindow.Show
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		bOffline As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		DbSync As SqliteSync.SqlSyncClass
	#tag EndProperty

	#tag Property, Flags = &h0
		MainWindow As winMain_1TabPanel
	#tag EndProperty

	#tag Property, Flags = &h0
		UpdateInitiater As Kaju.UpdateInitiater
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

	#tag Constant, Name = kUpdateServerPublicRSAKey, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"30820120300D06092A864886F70D01010105000382010D00308201080282010100B969FC7BA4E3AE187D2DF0F4DB95D6146568FCE121CC6B507AE9A92DA214E1BC2B27B190DD95DE2AF472F65C0FC7E88ECAA9840D790987A3A53620A89EFACF0372741A52768019A825187D5472C314B0C44FAA5E22995015D881F7F26B139055F7215226A5A1CF33B542D3818BCC132881D03924B43BF45A2F7064E138E2422C9350C087AC4DAC0AF14325AD2D495B9C45A5F08CB2AB4C4739625066360617E66BDCC5AD72E96C2C262357D5C40D5B7A6ACFBFCA08372B1F528D41F90A00E3C2F85DEC3329A203E2AFCCE54F0CC43E659F58BF25BA2FCB7E96844A6980FD0FA41D34F8C69975DDC917922CC1D497625DC05F5691D14E8C23998CED1B6E04AB7D020111"
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="bOffline"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
