#tag Module
Protected Module Contracts
	#tag Method, Flags = &h1
		Protected Function CreateContract(oEIPL as RecordStorageClass) As DataFile.ActiveRecordBase
		  dim oEvent as RecordStorageClass 
		  dim oEventRecord as DataFile.tbl_events
		  dim oEIPLRecord as DataFile.tbl_eipl = oEIPL.GetTableRecordVariant
		  
		  If oEIPLRecord.sfkevents <> "" Then 
		    oEventRecord = DataFile.tbl_events.FindByID(oEIPLRecord.sfkevents)
		    oEvent = DataFile.StorifyRecords(oEventRecord)
		  Else
		    Return Nil
		  End If
		  
		  
		End Function
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
