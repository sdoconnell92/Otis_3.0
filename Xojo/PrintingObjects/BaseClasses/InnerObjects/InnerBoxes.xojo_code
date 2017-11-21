#tag Class
Protected Class InnerBoxes
Inherits InnerObjectBase
	#tag Event
		Sub evdefDraw(g as Graphics)
		  HandleDraw(g)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddBox(arsContent() as String, Justification as integer = -1)
		  Dim oNewBox as New InnerText(arsContent, me.Parent)
		  
		  oNewBox.Height = me.Height
		  
		  // Check if there are headers on these boxes
		  If Headers Then
		    If oNewBox.Content.Ubound <> -1 Then
		      oNewBox.ContentBorder(0).Top = True
		      oNewBox.ContentBorder(0).Bottom = True
		      oNewBox.ContentBorder(0).Left = True
		      oNewBox.ContentBorder(0).Right = True
		    End If
		  End If
		  
		  oNewBox.ObjectBorder.Top = True
		  oNewBox.ObjectBorder.Bottom = True
		  oNewBox.ObjectBorder.Left = True
		  oNewBox.ObjectBorder.Right = True
		  
		  For i1 as integer = 0 To oNewBox.Content.Ubound
		    oNewBox.aroJustificationHor.Append( Justification )
		  Next
		  
		  BoxContent.Append(oNewBox)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChangeAllBolds(arbBold() as Boolean)
		  For i1 as integer = 0 To BoxContent.Ubound
		    For i as integer = 0 To arbBold.Ubound
		      BoxContent(i1).Bold = arbBold
		    Next
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChangeFontSizes(ariFontSize() as integer)
		  
		  For Each oBox as InnerText In BoxContent()
		    
		    obox.FontSize() = ariFontSize
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ParentDocument as BaseDocument)
		  // Calling the overridden superclass constructor.
		  Super.Constructor(ParentDocument)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DetermineBoxWidths(g as Graphics) As Integer
		  dim i as integer
		  
		  i = Floor( ( g.Width - ( BoxContent.Ubound * BoxSpacing ) - ( BoxMargins * 2 ) ) / (BoxContent.Ubound + 1 ) )
		  
		  Return i
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleDraw(g as Graphics)
		  dim xRunning as integer
		  
		  xRunning = xRunning + BoxMargins
		  dim BoxWidths as integer = DetermineBoxWidths(g)
		  
		  For i1 as integer = 0 To BoxContent.Ubound
		    dim oCurrentBox as InnerText = BoxContent(i1)
		    
		    oCurrentBox.xPosition = xRunning.ToText
		    oCurrentBox.Width = BoxWidths
		    oCurrentBox.Height = g.Height
		    oCurrentBox.Draw(g)
		    
		    xRunning = xRunning + BoxSpacing + BoxWidths 
		    
		  Next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		BoxContent() As InnerText
	#tag EndProperty

	#tag Property, Flags = &h0
		BoxMargins As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		BoxSpacing As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Headers As Boolean = True
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="BoxMargins"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BoxSpacing"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Headers"
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
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
