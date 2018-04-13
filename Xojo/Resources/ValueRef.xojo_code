#tag Module
Protected Module ValueRef
	#tag Constant, Name = DefualtPrintColJust, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = EIPLTypes, Type = String, Dynamic = False, Default = \"", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"Estimate\x2CPro-Forma Invoice\x2CInvoice\x2CPack List"
	#tag EndConstant

	#tag Constant, Name = ItemTypes, Type = String, Dynamic = False, Default = \"", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"Item\x2CPackage\x2CLabor"
	#tag EndConstant

	#tag Constant, Name = Item_Status, Type = String, Dynamic = False, Default = \"", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"Ready\x2CIn Maintenance\x2CSold"
	#tag EndConstant

	#tag Constant, Name = kSyncServerAddress, Type = String, Dynamic = False, Default = \"", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"104.207.139.64:8080"
	#tag EndConstant

	#tag Constant, Name = kSyncTables, Type = String, Dynamic = False, Default = \"", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"tbl_events\x2Ctbl_events_link\x2Ctbl_lineitems\x2Ctbl_inventory\x2Ctbl_firmware\x2Ctbl_maintenance_logs\x2Ctbl_eipl\x2Ctbl_contactables\x2Ctbl_contact_methods\x2Ctbl_internal_linking\x2Ctbl_contactable_linking\x2Ctbl_group_discounts\x2Ctbl_payments\x2Ctbl_contracts\x2Ctbl_branchnumbers"
	#tag EndConstant

	#tag Constant, Name = PaymentTypes, Type = String, Dynamic = False, Default = \"", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"Check\x2CCash\x2CDeposit"
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
