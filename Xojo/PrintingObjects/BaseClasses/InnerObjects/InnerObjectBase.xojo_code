#tag Class
Protected Class InnerObjectBase
	#tag Method, Flags = &h0
		Sub Constructor(ParentDocument as BaseDocument)
		  ObjectBorder = New BorderClass
		  Parent = ParentDocument
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DetermineObjectBottom() As Integer
		  
		  
		  Select Case JustificationVert
		  Case -1
		    Return Floor( y + Height )
		  Case 0
		    dim iHalf as double = Height / 2
		    Return Floor( y + iHalf )
		  Case 1
		    Return y
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DetermineObjectCenter() As Integer
		  
		  If Width <> 0 Then
		    Select Case JustificationHor
		    Case -1 
		      Return x + Floor(Width/2)
		    Case 0
		      Return x
		    Case 1
		      Return x - Floor(Width/2)
		    End Select
		  End If
		  
		  Return x
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DetermineObjectLeft() As Integer
		  
		  
		  Select Case JustificationHor
		  Case -1
		    Return x
		  Case 0
		    dim iHalf as double = Width / 2
		    Return Floor( x - iHalf )
		  Case 1
		    Return Floor( x - Width )
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DetermineObjectRight() As Integer
		  
		  
		  Select Case JustificationHor
		  Case -1
		    Return Floor( x + Width )
		  Case 0
		    dim iHalf as double = Width / 2
		    Return Floor( x + iHalf )
		  Case 1
		    Return x
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DetermineObjectTop() As Integer
		  
		  
		  Select Case JustificationVert
		  Case -1
		    Return y
		  Case 0
		    dim iHalf as double = Height / 2
		    Return Floor( y - iHalf )
		  Case 1
		    Return Floor( y - Height )
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Draw(g as Graphics)
		  
		  If InStr( xPosition, "%" ) > 0 Then
		    // determine where x is 
		    x = g.Width * val( xPosition.StripNonTenBase )
		    y = g.Height * val( yPosition.StripNonTenBase )
		  Else
		    x = val( xPosition.StripNonTenBase )
		    y = val( yPosition.StripNonTenBase )
		  End If
		  
		  evdefDraw(g)
		  
		  DrawObjectBorders(g)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub DrawObjectBorders(g as Graphics)
		  dim iLeft,iRight,iTop,iBottom as integer
		  dim iBuffer as integer = 0
		  
		  If Width <> 0 And Height <> 0 Then
		    
		    iLeft = DetermineObjectLeft
		    iRight = DetermineObjectRight - ObjectBorder.WidthRight
		    iTop = DetermineObjectTop
		    iBottom = DetermineObjectBottom - ObjectBorder.WidthBottom
		    
		    dim iWidth,iHeight as integer
		    iWidth = iRight - iLeft
		    iHeight = iBottom - iTop
		    
		    // Draw Left
		    If ObjectBorder.Left Then
		      dim RectX,RectY,RectWidth,RectHeight as integer
		      RectX = iLeft
		      RectY = iTop
		      If ObjectBorder.WidthLeft = 0 Then ObjectBorder.WidthLeft = 1
		      RectWidth = ObjectBorder.WidthLeft
		      RectHeight = iHeight
		      g.ForeColor = ObjectBorder.ColorLeft
		      
		      g.FillRect(RectX, RectY, RectWidth, RectHeight)
		    End If
		    
		    // DrawTop
		    If ObjectBorder.Top Then
		      dim RectX,RectY,RectWidth,RectHeight as integer
		      RectX = iLeft
		      RectY = iTop
		      RectWidth = iWidth + 1
		      If ObjectBorder.WidthTop = 0 Then ObjectBorder.WidthTop = 1
		      RectHeight = ObjectBorder.WidthTop
		      g.ForeColor = ObjectBorder.ColorTop
		      
		      g.FillRect(RectX, RectY, RectWidth, RectHeight)
		    End If
		    
		    // Draw Right
		    If ObjectBorder.Right Then
		      dim RectX,RectY,RectWidth,RectHeight as integer
		      RectX = iRight
		      RectY = iTop
		      If ObjectBorder.WidthRight = 0 Then ObjectBorder.WidthRight = 1
		      RectWidth = ObjectBorder.WidthRight
		      RectHeight = iHeight
		      g.ForeColor = ObjectBorder.ColorRight
		      
		      g.FillRect(RectX, RectY, RectWidth, RectHeight)
		    End If
		    
		    // Draw Bottom
		    If ObjectBorder.Bottom Then
		      dim RectX,RectY,RectWidth,RectHeight as integer
		      RectX = iLeft
		      RectY = iBottom
		      RectWidth = iWidth + 1
		      If ObjectBorder.WidthBottom = 0 Then ObjectBorder.WidthBottom = 1
		      RectHeight = ObjectBorder.WidthBottom
		      g.ForeColor = ObjectBorder.ColorBottom
		      
		      g.FillRect(RectX, RectY, RectWidth, RectHeight)
		    End If
		    
		  End If
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event evdefDraw(g as Graphics)
	#tag EndHook


	#tag Property, Flags = &h1
		Protected Center As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Height As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			-1 = Left
			0  = Center
			1  = Right
		#tag EndNote
		JustificationHor As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0
		JustificationVert As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0
		ObjectBorder As BorderClass
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected Parent As BaseDocument
	#tag EndProperty

	#tag Property, Flags = &h0
		Width As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected x As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			As percent or exact
		#tag EndNote
		xPosition As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected y As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			or exact
			
			As Percent
		#tag EndNote
		yPosition As String
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
