#tag Class
Protected Class lbRowTag
	#tag Method, Flags = &h0
		Function IsItem() As Boolean
		  
		  If vtblRecord <> Nil Then
		    Return True
		  Else
		    Return False
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		aroChildren() As lbRowTag
	#tag EndProperty

	#tag Property, Flags = &h0
		iCellTypes() As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		iFolderLevel As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		isFolder As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		pkid As Int64
	#tag EndProperty

	#tag Property, Flags = &h0
		sFieldNames() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sGroupDataStructure As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			GroupFolder
			GrandParent
			LinkingTypeFolder
			LinkedItem
		#tag EndNote
		sRowType As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sSubRowType As String
	#tag EndProperty

	#tag Property, Flags = &h0
		uuid As string
	#tag EndProperty

	#tag Property, Flags = &h0
		vColumnValues() As Variant
	#tag EndProperty

	#tag Property, Flags = &h0
		vGroupingData As Variant
	#tag EndProperty

	#tag Property, Flags = &h0
		vLinkTable As Variant
	#tag EndProperty

	#tag Property, Flags = &h0
		vtblRecord As Variant
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="iFolderLevel"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isFolder"
			Group="Behavior"
			Type="Boolean"
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
			Name="pkid"
			Group="Behavior"
			Type="Int64"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sGroupDataStructure"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sRowType"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sSubRowType"
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
		#tag ViewProperty
			Name="uuid"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
