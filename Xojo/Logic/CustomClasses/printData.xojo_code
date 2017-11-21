#tag Class
Protected Class printData
	#tag Method, Flags = &h0
		Function DetermineLeftOffset() As Integer
		  // Determine the left offset
		  dim iLeftOffset as integer = (oParent.FindDepth - 1) * 10
		  Return iLeftOffset
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Draw(g as Graphics)
		  dim bBold as Boolean
		  dim iFontSize as integer
		  dim iLeftOffset as integer = DetermineLeftOffset
		  
		  Select Case oParent.StorType
		  Case "Header", "GroupFolder"
		    bBold = True
		    iFontSize = oParentStory.FontSize
		  Case "Total", "MasterTotal"
		    
		    dim iCenterBuffer as integer = 4
		    
		    // Get the center x mark of the totals section
		    dim iTC as integer
		    If oParent.oParentStor = Nil Then
		      itc = oParentStory.iTotalCenter(g, True)
		    Else
		      itc = oParentStory.iTotalCenter(g) + DetermineLeftOffset
		    End If
		    
		    For i1 as integer = 0 To 1
		      dim tuple() as string = arsColumnValues
		      
		      // Create Graphics Clip
		      dim bb as Boolean = g.Bold
		      g.Bold = True
		      dim iClipWidth, iClipHeight, X, Y as integer
		      iClipWidth = g.StringWidth(tuple(0) + ":") + iCenterBuffer * 2 + g.StringWidth(tuple(1))
		      iClipHeight = g.Height
		      // X = iTC - oParentStory.iLineBuffer - g.StringWidth(tuple(0) + ":")
		      X = g.Width - iClipWidth
		      If oParent.StorType = "MasterTotal" Then X = X - 80
		      Y = 0
		      
		      dim gClip as Graphics = g.Clip(X,Y,iClipWidth,iClipHeight)
		      
		      // Draw the Title
		      gClip.TextSize = g.TextSize
		      gClip.Bold = True
		      
		      gClip.DrawString( Join(tuple, ": "), 0, gClip.TextAscent )
		      
		      // gClip.DrawString(tuple(0) + ":", 0, gClip.TextAscent)
		      
		      // Draw the content
		      // gClip.DrawString(tuple(1), g.StringWidth(tuple(0) + ":") + iCenterBuffer * 2, gClip.TextAscent)
		      g.Bold = bb
		    Next
		    
		    Return
		    
		  Else
		    bBold = False
		    iFontSize = oParentStory.FontSize
		  End Select
		  
		  dim runningX as integer
		  For iColIndex as integer = 0 To arsColumnValues.Ubound
		    
		    if iColIndex > ariJustification.Ubound Then
		      ariJustification.Append(0)
		    end if
		    
		    dim sColVal as String = arsColumnValues(iColIndex)
		    dim iClipWidth as integer = oParentStory.ariTrueWidths(iColIndex)
		    if iColIndex = 0 Then iClipWidth = iClipWidth - iLeftOffset
		    dim iClipHeight as integer = g.Height
		    dim iClipX as integer = runningX
		    if iColIndex = 0 then iClipX = iClipX + iLeftOffset
		    dim iClipY as integer = 0
		    
		    dim gClip as Graphics = g.Clip(iClipX, iClipY, iClipWidth, iClipHeight)
		    
		    gClip.Bold = bBold
		    gClip.TextSize = iFontSize
		    
		    dim iTextX, iTextWidth, iTextHalf, iJustification, iClipHalf, iClipHalfX as integer
		    iTextWidth = gClip.StringWidth(sColVal) + 1
		    iTextHalf = iTextWidth / 2
		    iClipHalf = iClipWidth / 2
		    iClipHalfX = iClipHalf
		    if ariJustification(iColIndex) = 0 Then
		      iJustification = ValueRef.DefualtPrintColJust
		    Else
		      iJustification = ariJustification(iColIndex)
		    end if
		    
		    Select Case iJustification
		    Case 1
		      iTextX = 0
		    Case 2
		      iTextX = iClipHalfX - iTextHalf
		    Case 3
		      iTextX = iClipWidth - iTextWidth
		    End Select
		    
		    
		    dim www as integer = gClip.StringHeight(sColVal, gClip.Width)
		    gClip.DrawString( sColVal, iTextX, gClip.TextAscent, gClip.Width )
		    
		    runningX = iClipX + iClipWidth
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringLines(ReturnMaxHeight as Boolean = False) As Integer
		  dim bBold as Boolean
		  dim iFontSize as integer
		  dim maxHeight as integer
		  dim isTotal as Boolean = oParent.isTotal
		  
		  Select Case oParent.StorType
		  Case "Header", "GroupFolder"
		    bBold = True
		    iFontSize = oParentStory.FontSize
		  Case "Total"
		    bBold = True
		    iFontSize = oParentStory.FontSize
		    Return 1
		  Else
		    bBold = False
		    iFontSize = oParentStory.FontSize
		  End Select
		  
		  dim p as new Picture(50,50)
		  dim g as Graphics = p.Graphics
		  g.TextSize = iFontSize
		  g.Bold = bBold
		  For iColIndex as integer = 0 To arsColumnValues.Ubound
		    dim iHeight as integer
		    dim iWidth as integer 
		    If iColIndex = 0 Then
		      iWidth = oParentStory.ariTrueWidths(iColIndex) - DetermineLeftOffset
		    Else
		      iWidth = oParentStory.ariTrueWidths(iColIndex)
		    End If
		    iHeight = g.StringHeight(arsColumnValues(iColIndex), iWidth)
		    If iHeight > maxHeight Then maxHeight = iHeight
		    
		  Next
		  
		  dim i1 as double
		  i1 = maxHeight / g.StringHeight("Tg", 50)
		  
		  If ReturnMaxHeight Then
		    Return maxHeight
		  Else
		    Return Floor(i1)
		  End If
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		#tag Note
			0 = Default
			1 = Left
			2 = Center
			3 = Right
		#tag EndNote
		ariJustification() As Integer
	#tag EndProperty

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
