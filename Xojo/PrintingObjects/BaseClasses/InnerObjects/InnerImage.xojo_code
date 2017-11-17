#tag Class
Protected Class InnerImage
Inherits InnerObjectBase
	#tag Event
		Sub evdefDraw(g as Graphics)
		  
		  HandleDraw(g)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(ParentDocument as BaseDocument)
		  ObjectBorder = New BorderClass
		  Parent = ParentDocument
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DetermineImageSize(g as Graphics) As Integer()
		  dim iWidth, iHeight as integer
		  
		  // Determine the height of image
		  If Height = 0 And Width = 0 Then
		    'Height will be determined by height of graphic clip
		    'Width will be determined either by scaling or by width of clip
		    iHeight = g.Height
		    If Scaled Then
		      dim iRatio as double = iHeight / Content.Height
		      iWidth = Floor( Content.Width * iRatio )
		    Else
		      iWidth = g.Width
		    End If
		  ElseIf Height = 0 And Width <> 0 Then
		    'Width is specified
		    iWidth = Width
		    If Scaled Then
		      dim iRatio as double = iWidth / Content.Width
		      iHeight = Floor( Content.Height * iRatio )
		    Else
		      iHeight = g.Height
		    End If
		  ElseIf Height <> 0 And Width = 0 Then
		    'Height is specified
		    iHeight = Height
		    If Scaled Then
		      dim iRatio as Double = iHeight / Content.Height
		      iWidth = Floor( Content.Width * iRatio )
		    Else
		      iWidth = g.Width
		    End If
		  ElseIf Height <> 0 And Width <> 0 Then
		    'Both width and height are specified
		    iHeight = Height
		    iWidth = Width
		  End If
		  
		  Return Array( iWidth, iHeight )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DetermineLeftTop(iWidth as integer, iHeight as integer) As Integer()
		  dim iLeft, iTop as Integer
		  
		  Select Case JustificationHor
		  Case -1
		    iLeft = x
		  Case 0
		    dim iHalfHor as double = Floor( iWidth / 2 )
		    iLeft = x - iHalfHor
		  Case 1
		    iLeft = x - iWidth
		  End Select
		  
		  Select Case JustificationVert
		  Case -1
		    iTop = y
		  Case 0 
		    dim iHalfVert as double = Floor( iHeight / 2 )
		    iTop = y - iHalfVert
		  Case 1
		    iTop = y - iHeight
		  End Select
		  
		  Return Array( iLeft, iTop )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleDraw(gdog as Graphics)
		  dim iWidth,iHeight, iLeft, iTop as integer
		  
		  
		  // Determine the image size
		  dim iRet() as Integer = DetermineImageSize(gdog)
		  iWidth = iRet(0)
		  iHeight = iRet(1)
		  
		  iRet = DetermineLeftTop(iWidth,iHeight)
		  iLeft = iRet(0)
		  iTop = iRet(1)
		  
		  //gdog.DrawString("jsojeondfonsodksdnfokansdofineoinslkdnflinslinselinflksnlienlskndlinsflinslinelknslkndlineflinsef", 0, gdog.TextAscent)
		  //gdog.DrawPicture(EIPLHeaderLogo_Print_v20,5,5, iWidth, iHeight, 0,0,EIPLHeaderLogo_Print_v20.Width, EIPLHeaderLogo_Print_v20.Height) 
		  gdog.DrawPicture( EIPL_HeaderLogo, 0, 0 )
		  // g.DrawPicture( Content, _
		  // iLeft, iTop, iWidth, iHeight, _
		  // 0, 0, Content.Width, Content.Height )
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Content As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		Scaled As Boolean = True
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Content"
			Group="Behavior"
			Type="Picture"
		#tag EndViewProperty
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
			Name="Scaled"
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
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
