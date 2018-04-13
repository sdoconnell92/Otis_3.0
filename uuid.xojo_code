#tag Module
Protected Module uuid
	#tag Method, Flags = &h1
		Protected Function uuid4() As String
		  Dim crypt As New Chilkat.Crypt2
		  
		  Dim uuid As String
		  uuid = crypt.GenerateUuid()
		  
		  Return uuid
		End Function
	#tag EndMethod


End Module
#tag EndModule
