#tag Class
Protected Class InnerText
Inherits InnerObjectBase
	#tag Event
		Sub evdefDraw(g as Graphics)
		  HandleDraw(g)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(ParentDocument as BaseDocument)
		  Parent = ParentDocument
		  ObjectBorder = New BorderClass
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(sText() as string, ParentDocument as BaseDocument)
		  Constructor(ParentDocument)
		  ContentAdd(sText())
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(sText as string, ParentDocument as BaseDocument)
		  Constructor(ParentDocument)
		  ContentAdd(sText)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContentAdd(sText() as string)
		  ContentDelete
		  Content = sText()
		  For i1 as integer = 0 To Content.Ubound
		    ContentBorder.Append(New BorderClass)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContentAdd(sText as string)
		  Content.Append(sText)
		  ContentBorder.Append(New BorderClass)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContentDelete()
		  ReDim Content(-1)
		  ReDim ContentBorder(-1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DetermineBold(index as integer) As Boolean
		  
		  Select Case Bold.Ubound
		  Case -1 
		    Return False
		  Case 0 
		    Return Bold(0)
		  Case Is > 0
		    Return Bold(index)
		  End Select
		  
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DetermineFont(index as integer) As String
		  
		  Select Case Font.Ubound
		  Case -1
		    Return "Helvetica"
		  Case 0
		    Return Font(0)
		  Case Is > 0 
		    Return Font(index)
		  End Select
		  
		  Return "Helvetica"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DetermineFontSize(index as integer) As integer
		  Select Case FontSize.Ubound
		  Case -1
		    Return 12
		  Case 0 
		    Return FontSize(0)
		  Case Is > 0 
		    Return FontSize(index)
		  End Select
		  
		  Return 12
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DetermineForeColor(index as integer) As Color
		  dim NewColor as Color
		  Select Case ForeColor.Ubound
		  Case -1 
		    Return NewColor
		  Case 0 
		    Return ForeColor(0)
		  Case Is > 0 
		    Return ForeColor(index)
		  End Select
		  
		  Return NewColor
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DetermineItalic(index as integer) As Boolean
		  
		  Select Case Italic.Ubound
		  Case -1 
		    Return False
		  Case 0
		    Return Italic(0)
		  Case Is > 0 
		    Return Italic(index)
		  End Select
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DetermineTextLeft(g as graphics, sText as String) As Integer
		  dim iWidth as double = g.StringWidth( sText )
		  dim iJust as integer = -2
		  dim iBuffer as integer = 2
		  
		  If aroJustificationHor.Ubound = Content.Ubound Then
		    // Horizontal alignment has been choses per line
		    
		    dim iContentIndex as integer = Content.IndexOf(sText)
		    If aroJustificationHor( iContentIndex ) <> -2 Then
		      iJust = aroJustificationHor( iContentIndex )
		    Else
		      // This line is supposed to use default Justification
		      iJust = JustificationHor
		    End If
		    
		  Else
		    // Horizontal alignment uses default
		    iJust = JustificationHor
		  End If
		  
		  Select Case iJust
		  Case -1
		    Return DetermineObjectLeft + iBuffer
		  Case 0
		    dim iHalf as double = iWidth / 2
		    Return Floor( DetermineObjectCenter - iHalf ) + iBuffer
		  Case 1
		    Return Floor( DetermineObjectCenter - iWidth ) + iBuffer
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawContentBorders(g as Graphics, iTextLeft as integer, iTextTop as integer, sText as String)
		  dim txtIndex as integer = Content.IndexOf(sText)
		  dim iLeft,iRight,iTop,iBottom as integer
		  dim iBuffer as integer = 1
		  dim iTextWidth as double = g.StringWidth(sText)
		  dim iTextHeight as integer = g.StringHeight(sText,iTextWidth + 4)
		  
		  If Width = 0 Then
		    iLeft = iTextLeft - iBuffer
		    iRight = iLeft + iTextWidth + iBuffer
		  Else
		    iLeft = DetermineObjectLeft
		    iRight = DetermineObjectRight - ContentBorder(txtIndex).WidthRight
		  End If
		  
		  iTop = iTextTop - iBuffer
		  iBottom = iTextTop + iTextHeight + iBuffer
		  dim iWidth,iHeight as integer
		  iWidth = iRight - iLeft
		  iHeight = iBottom - iTop
		  
		  // Draw Left
		  If ContentBorder(txtIndex).Left Then
		    If ContentBorder(txtIndex).WidthLeft = 0 Then
		      ContentBorder(txtIndex).WidthLeft = 1
		    End If
		    dim RectX,RectY,RectWidth,RectHeight as integer
		    RectX = iLeft
		    RectY = iTop
		    RectWidth = ContentBorder(txtIndex).WidthLeft
		    RectHeight = iHeight
		    g.ForeColor = ContentBorder(txtIndex).ColorLeft
		    
		    g.FillRect(RectX, RectY, RectWidth, RectHeight)
		  End If
		  
		  // DrawTop
		  If ContentBorder(txtIndex).Top Then
		    If ContentBorder(txtIndex).WidthTop = 0 Then
		      ContentBorder(txtIndex).WidthTop = 1
		    End If
		    dim RectX,RectY,RectWidth,RectHeight as integer
		    RectX = iLeft
		    RectY = iTop
		    RectWidth = iWidth + 1
		    RectHeight = ContentBorder(txtIndex).WidthLeft
		    g.ForeColor = ContentBorder(txtIndex).ColorTop
		    
		    g.FillRect(RectX, RectY, RectWidth, RectHeight)
		  End If
		  
		  // Draw Right
		  If ContentBorder(txtIndex).Right Then
		    If ContentBorder(txtIndex).WidthRight = 0 Then
		      ContentBorder(txtIndex).WidthRight = 1
		    End If
		    dim RectX,RectY,RectWidth,RectHeight as integer
		    RectX = iRight
		    RectY = iTop
		    RectWidth = ContentBorder(txtIndex).WidthRight
		    RectHeight = iHeight
		    g.ForeColor = ContentBorder(txtIndex).ColorRight
		    
		    g.FillRect(RectX, RectY, RectWidth, RectHeight)
		  End If
		  
		  // Draw Bottom
		  If ContentBorder(txtIndex).Bottom Then
		    If ContentBorder(txtIndex).WidthBottom = 0 Then
		      ContentBorder(txtIndex).WidthBottom = 1
		    End If
		    dim RectX,RectY,RectWidth,RectHeight as integer
		    RectX = iLeft
		    RectY = iBottom
		    RectWidth = iWidth + 1
		    RectHeight = ContentBorder(txtIndex).WidthBottom
		    g.ForeColor = ContentBorder(txtIndex).ColorBottom
		    
		    g.FillRect(RectX, RectY, RectWidth, RectHeight)
		  End If
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleDraw(g as Graphics)
		  dim iLeft, iTop as integer
		  
		  iTop = DetermineObjectTop
		  
		  // Draw Lines of text
		  For i1 as integer = 0 To Content.Ubound
		    dim sLine as String = Content(i1)
		    
		    dim iBaseLine as integer
		    
		    g.TextFont = DetermineFont(i1)
		    g.TextSize = DetermineFontSize(i1)
		    g.Bold = DetermineBold(i1)
		    g.Italic = DetermineItalic(i1)
		    g.ForeColor = DetermineForeColor(i1)
		    
		    iLeft = DetermineTextLeft(g,sLine)
		    iBaseLine = iTop + g.StringHeight(sLine, g.StringWidth(sLine) + 4 )
		    
		    g.DrawString( sLine, iLeft, iBaseLine )
		    
		    DrawContentBorders(g, iLeft, iTop, sLine)
		    
		    iTop = iBaseLine + LineBuffer
		  Next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		aroJustificationHor() As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Bold() As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Content() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ContentBorder() As BorderClass
	#tag EndProperty

	#tag Property, Flags = &h0
		Font() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		FontSize() As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		ForeColor() As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		Italic() As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		LineBuffer As Integer = 1
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Height"
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
			Name="JustificationHor"
			Group="Behavior"
			InitialValue="-1"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="JustificationVert"
			Group="Behavior"
			InitialValue="-1"
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
			Name="LineBuffer"
			Group="Behavior"
			InitialValue="1"
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
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="xPosition"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="yPosition"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
