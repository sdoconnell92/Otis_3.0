#tag Module
Protected Module EIPLCodes
	#tag Constant, Name = Estimate, Type = String, Dynamic = False, Default = \"Est", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Invoice, Type = String, Dynamic = False, Default = \"Inv", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PackList, Type = String, Dynamic = False, Default = \"PL", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ProFormaInvoice, Type = String, Dynamic = False, Default = \"PF", Scope = Public
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
