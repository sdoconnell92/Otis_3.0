#tag Module
Protected Module modUIComunication
	#tag Property, Flags = &h1
		Protected bLaunchLoginWindow As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected bLoginAttemptComplete As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected LoginInfoPull() As Variant
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected LoginInfoPush() As Variant
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
