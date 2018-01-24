#tag Module
Protected Module ErrorMessages
	#tag Method, Flags = &h1
		Protected Function GetByErrorCode(i as integer) As String
		  
		  If i = ErrorCodes.kLoginFailed Then Return ErrorMessages.kLoginFailed
		  If i = ErrorCodes.kLoginTimeout Then Return ErrorMessages.kLoginTimeout
		  If i = ErrorCodes.kNoError Then Return ErrorMessages.kNoError
		  If i = ErrorCodes.kPasswordCannotBeBlank Then Return ErrorMessages.kPasswordCannotBeBlank
		  If i = ErrorCodes.kPasswordIncorrect Then Return ErrorMessages.kPasswordIncorrect
		  If i = ErrorCodes.kUsernameCannotBeBlank Then Return ErrorMessages.kUsernameCannotBeBlank
		  If i = ErrorCodes.kUsernameIncorrect Then Return ErrorMessages.kUsernameIncorrect
		  
		  Return ""
		End Function
	#tag EndMethod


	#tag Constant, Name = kCouldNotInitDirectories, Type = String, Dynamic = False, Default = \"", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"Could not initialize file system directories. Otis must close."
	#tag EndConstant

	#tag Constant, Name = kLoginFailed, Type = String, Dynamic = False, Default = \"", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"Login Failed."
	#tag EndConstant

	#tag Constant, Name = kLoginTimeout, Type = String, Dynamic = False, Default = \"", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"Timeout Occurred."
	#tag EndConstant

	#tag Constant, Name = kNoError, Type = String, Dynamic = False, Default = \"", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \""
	#tag EndConstant

	#tag Constant, Name = kPasswordCannotBeBlank, Type = String, Dynamic = False, Default = \"", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"Password field cannot be blank."
	#tag EndConstant

	#tag Constant, Name = kPasswordIncorrect, Type = String, Dynamic = False, Default = \"", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"Password is incorrect."
	#tag EndConstant

	#tag Constant, Name = kUsernameCannotBeBlank, Type = String, Dynamic = False, Default = \"", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"Username field cannot be blank."
	#tag EndConstant

	#tag Constant, Name = kUsernameIncorrect, Type = String, Dynamic = False, Default = \"", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"Username is incorrect."
	#tag EndConstant


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
End Module
#tag EndModule
