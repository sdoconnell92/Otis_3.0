#tag Module
Protected Module BooleanUtils
	#tag Method, Flags = &h0
		Function Invert(extends b as Boolean) As Boolean
		  If b Then
		    Return False
		  ElseIf Not b Then
		    Return True
		  End If
		End Function
	#tag EndMethod


End Module
#tag EndModule
