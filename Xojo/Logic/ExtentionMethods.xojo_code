#tag Module
Protected Module ExtentionMethods
	#tag Method, Flags = &h0
		Function IndexOfFolderName(extends aro() as RecordStorageClass, sValue as string) As integer
		  
		  For i1 as integer = 0 To aro.Ubound
		    dim oStor as RecordStorageClass = aro(i1)
		    If sFolderName = sValue Then
		      Return i1
		    End If
		  Next
		  
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PopulateLbDataList(extends aro() as RecordStorageClass, dictFieldNames as Dictionary, dictCellTypes as Dictionary)
		  
		  For i1 as integer = 0 To aro.Ubound
		    aro(i1).PopulateLbData( dictFieldNames, dictCellTypes )
		    
		    // Check if there are any children
		    If aroChildren.Ubound <> -1 Then aroChildren.PopulateLbDataList( dictFieldNames, dictCellTypes )
		  Next
		End Sub
	#tag EndMethod


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
