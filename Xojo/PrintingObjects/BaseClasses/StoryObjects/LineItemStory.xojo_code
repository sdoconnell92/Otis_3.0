#tag Class
Protected Class LineItemStory
Inherits BaseStoryObject
	#tag Method, Flags = &h0
		Sub Draw(g as Graphics)
		  dim iTextHeight as integer
		  dim iLineBuffer as integer = 1
		  
		  g.TextSize = FontSize
		  iTextHeight = g.TextHeight
		  
		  dim yIndex as integer
		  For Each oLine as InnerObjectBase In aroInnerObjects()
		    
		    dim gClip as Graphics
		    dim iClipWidth, iClipHeight as integer
		    iClipWidth = g.Width
		    iClipHeight = iTextHeight + iLineBuffer + iLineBuffer
		    
		    gClip = g.Clip( 0, yIndex, iClipWidth, iClipHeight )
		    gClip.TextSize = FontSize
		    yIndex = yIndex + iClipHeight
		    
		    oLine.Draw(gClip)
		    
		  Next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		FontSize As Integer = 9
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="FontSize"
			Group="Behavior"
			InitialValue="9"
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
	#tag EndViewBehavior
End Class
#tag EndClass
