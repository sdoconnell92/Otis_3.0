#tag Class
Protected Class lbUIState
	#tag Property, Flags = &h0
		oOpenFolders() As RecordStorageClass
	#tag EndProperty

	#tag Property, Flags = &h0
		oOpenFoldersOld() As lbRowTag
	#tag EndProperty

	#tag Property, Flags = &h0
		oSelectedRows() As RecordStorageClass
	#tag EndProperty

	#tag Property, Flags = &h0
		oSelectedRowsOld() As lbRowTag
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
End Class
#tag EndClass
