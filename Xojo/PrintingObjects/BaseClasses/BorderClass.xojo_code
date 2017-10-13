#tag Class
Protected Class BorderClass
	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Bottom As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		ColorBottom As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		ColorLeft As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		ColorRight As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		ColorTop As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		Left As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Right As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Top As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		WidthBottom As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h0
		WidthLeft As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h0
		WidthRight As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h0
		WidthTop As Integer = 1
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Bottom"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColorBottom"
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColorLeft"
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColorRight"
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColorTop"
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
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
			Name="Left"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Right"
			Group="Behavior"
			Type="Boolean"
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
		#tag ViewProperty
			Name="WidthBottom"
			Group="Behavior"
			InitialValue="1"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="WidthLeft"
			Group="Behavior"
			InitialValue="1"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="WidthRight"
			Group="Behavior"
			InitialValue="1"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="WidthTop"
			Group="Behavior"
			InitialValue="1"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
