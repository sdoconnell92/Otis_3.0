#tag Class
Protected Class printData
	#tag Method, Flags = &h0
		Sub Draw(g as Graphics, iLeftOffset as integer)
		  
		  dim runningX as integer
		  For iColIndex as integer = 0 To arsColumnValues.Ubound
		    
		    dim sColVal as String = arsColumnValues(iColIndex)
		    dim iClipWidth as integer = oParentStory.ariTrueWidths(iColIndex)
		    if iColIndex = 0 Then iClipWidth = iClipWidth - iLeftOffset
		    dim iClipHeight as integer = g.Height
		    dim iClipX as integer = runningX
		    if iColIndex = 0 then iClipX = iClipX + iLeftOffset
		    dim iClipY as integer = 0
		    
		    dim gClip as Graphics = g.Clip(iClipX, iClipY, iClipWidth, iClipHeight)
		    gClip.DrawString( sColVal, 0, g.TextAscent, gClip.Width )
		    
		    runningX = iClipX + iClipWidth
		  Next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		arsColumnValues() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		arsColWidths() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		arsFieldNames() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		oParent As RecordStorageClass
	#tag EndProperty

	#tag Property, Flags = &h0
		oParentStory As LineItemStory
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
			Name="oParent"
			Group="Behavior"
			Type="Integer"
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
