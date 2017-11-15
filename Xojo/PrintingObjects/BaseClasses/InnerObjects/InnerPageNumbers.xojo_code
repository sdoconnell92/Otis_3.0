#tag Class
Protected Class InnerPageNumbers
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
		Sub HandleDraw(g as Graphics)
		  dim iLeft, iTop as integer
		  
		  iTop = DetermineObjectTop
		  g.TextSize = FontSize
		  g.Bold = Bold
		  
		  // Draw Lines of text
		  
		  dim cp, lp as integer
		  cp = me.Parent.iCurrentPage
		  lp = me.Parent.iNumberofPages
		  dim sLine as String = "Page " + str(cp) + " of " + str(lp)
		  
		  dim iBaseLine as integer
		  
		  iBaseLine = iTop + g.StringHeight(sLine, g.StringWidth(sLine) + 4 )
		  
		  g.DrawString( sLine, x, iBaseLine )
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Bold As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		FontSize As Integer
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
