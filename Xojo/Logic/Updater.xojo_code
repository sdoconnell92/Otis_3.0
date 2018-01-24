#tag Module
Protected Module Updater
	#tag Method, Flags = &h1
		Protected Sub Run()
		  dim rd as New ResourceDirectories
		  
		  dim updater as new Kaju.UpdateChecker( rd.kaju_folder.FilePath )
		  updater.ServerPublicRSAKey = kPublicKey
		  updater.UpdateURL = kUpdateURL
		  
		  updater.Execute
		  Checker = updater
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected Checker As Kaju.UpdateChecker
	#tag EndProperty


	#tag Constant, Name = kPublicKey, Type = String, Dynamic = False, Default = \"", Scope = Private
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"30820120300D06092A864886F70D01010105000382010D00308201080282010100B969FC7BA4E3AE187D2DF0F4DB95D6146568FCE121CC6B507AE9A92DA214E1BC2B27B190DD95DE2AF472F65C0FC7E88ECAA9840D790987A3A53620A89EFACF0372741A52768019A825187D5472C314B0C44FAA5E22995015D881F7F26B139055F7215226A5A1CF33B542D3818BCC132881D03924B43BF45A2F7064E138E2422C9350C087AC4DAC0AF14325AD2D495B9C45A5F08CB2AB4C4739625066360617E66BDCC5AD72E96C2C262357D5C40D5B7A6ACFBFCA08372B1F528D41F90A00E3C2F85DEC3329A203E2AFCCE54F0CC43E659F58BF25BA2FCB7E96844A6980FD0FA41D34F8C69975DDC917922CC1D497625DC05F5691D14E8C23998CED1B6E04AB7D020111"
	#tag EndConstant

	#tag Constant, Name = kUpdateURL, Type = String, Dynamic = False, Default = \"", Scope = Private
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"http://104.238.132.54/kaju/OtisBusinessManagement/OBM_UpdateInformation.json"
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
