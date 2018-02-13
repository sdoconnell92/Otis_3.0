#tag Class
Protected Class ActiveRecordBase
Inherits DataFile.Base
	#tag Event
		Sub AfterDelete()
		  
		  
		  PostDelete
		End Sub
	#tag EndEvent

	#tag Event
		Sub AfterSave()
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub BeforeCreate()
		  
		  
		  // Add a uuid
		  dim sNewUUID as String = GetNewUUID
		  dim oRandomizer as New Random
		  me.suuid = sNewUUID
		  me.ipkid = oRandomizer.LessThan(999999999)
		  
		  // Fill in Create and Modified Dates
		  dim dCurrentDate as New Date
		  me.srow_created = dCurrentDate.SQLDateTime
		  me.srow_modified = dCurrentDate.SQLDateTime
		  
		  // Fill in Username
		  me.srow_username = UserInfo.Username
		  
		  // Trigger Pre Insert Event
		  PreInsert
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub BeforeDelete()
		  PreDelete
		End Sub
	#tag EndEvent

	#tag Event
		Sub BeforeUpdate()
		  // Modify some values
		  me.srow_username = UserInfo.Username
		  dim d1 as New date
		  me.srow_modified = d1.SQLDateTime
		  
		End Sub
	#tag EndEvent


	#tag Hook, Flags = &h0
		Event PostDelete()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PostInsert()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PostUpdate()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PreDelete()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PreInsert()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PreUpdate()
	#tag EndHook


	#tag Property, Flags = &h0
		ipkid As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		srow_created As String
	#tag EndProperty

	#tag Property, Flags = &h0
		srow_modified As String
	#tag EndProperty

	#tag Property, Flags = &h0
		srow_username As String
	#tag EndProperty

	#tag Property, Flags = &h0
		suuid As String
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
			Name="ipkid"
			Group="Behavior"
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
			Name="name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="srow_created"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="srow_modified"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="srow_username"
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
			Name="suuid"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
