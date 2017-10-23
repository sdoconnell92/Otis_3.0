#tag Class
Protected Class ArrayCursorClass
	#tag Method, Flags = &h0
		Sub Constructor()
		  ariCursor.Append(0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CursorRemoved() As Boolean
		  If ariCursor.Ubound = -1 Then
		    Return True
		  Else
		    Return False
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrillIn()
		  ariCursor.Append(0)
		  iCursorIndex = ariCursor.Ubound
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrillOut()
		  ariCursor.Remove(iCursorIndex)
		  iCursorIndex = ariCursor.Ubound
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCurrentIndex() As Integer
		  Return ariCursor(iCursorIndex)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IncreaseCurrentDepth(iAmount as integer = 1)
		  If iCursorIndex = ariCursor.Ubound Then
		    ariCursor(iCursorIndex) = ariCursor(iCursorIndex) + 1
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MoveIn()
		  iCursorIndex = iCursorIndex + 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MoveOut()
		  iCursorIndex = iCursorIndex - 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function onFirst() As Boolean
		  If iCursorIndex = 0 Then
		    Return True
		  Else
		    Return False
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OnLast() As Boolean
		  If iCursorIndex < ariCursor.Ubound Then
		    Return False
		  Else
		    Return True
		  End If
		  Return True
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private ariCursor() As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		iCursorIndex As Integer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="iCursorIndex"
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
