#tag Class
Protected Class BaseStoryObject
	#tag Method, Flags = &h0
		Sub Draw(g as Graphics)
		  
		  For Each oObject as InnerObjectBase In aroInnerObjects()
		    
		    oObject.Draw(g)
		    
		  Next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		aroInnerObjects() As InnerObjectBase
	#tag EndProperty

	#tag Property, Flags = &h0
		Height As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0
		Width As Integer = -1
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Height"
			Group="Behavior"
			InitialValue="-1"
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
		#tag ViewProperty
			Name="Width"
			Group="Behavior"
			InitialValue="-1"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
