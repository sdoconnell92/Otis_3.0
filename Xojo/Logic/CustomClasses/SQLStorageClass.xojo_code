#tag Class
Protected Class SQLStorageClass
	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PrepareStatement()
		  
		  oPS = DataFile.GetDB.Prepare(sSQL)
		  
		  // Bind the Values
		  For i1 as integer = 0 To ariTypes.Ubound
		    oPS.BindType( i1, ariTypes(i1) )
		    oPS.Bind( i1, arvValues(i1) )
		  Next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		ariTypes() As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		arvValues() As Variant
	#tag EndProperty

	#tag Property, Flags = &h0
		oPS As SQLitePreparedStatement
	#tag EndProperty

	#tag Property, Flags = &h0
		sSQL As String
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
			Name="sSQL"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
End Class
#tag EndClass
