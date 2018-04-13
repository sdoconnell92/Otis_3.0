#tag Module
Protected Module Directory
	#tag Method, Flags = &h1
		Protected Sub Init()
		  
		  AppFolder = SpecialFolder.ApplicationData.Child( kAppFolderName )
		  If Not AppFolder.Exists Then AppFolder.CreateAsFolder
		  
		  DatabaseFolder = AppFolder.Child( kDbFolderName )
		  If Not DatabaseFolder.Exists Then DatabaseFolder.CreateAsFolder
		  
		  InfoFolder = AppFolder.Child( kInfoFolderName )
		  If Not InfoFolder.Exists Then InfoFolder.CreateAsFolder
		  
		  KajuFolder = AppFolder.Child( kKajuFolderName )
		  If Not KajuFolder.Exists Then KajuFolder.CreateAsFolder
		  
		  LogFolder = AppFolder.Child( kLogFolderName )
		  If Not LogFolder.Exists Then LogFolder.CreateAsFolder
		  
		  MainDatabase = DatabaseFolder.Child( kMainDbName )
		  
		  PrimaryLogFile = LogFolder.Child( kPrimaryLogFileName )
		  
		  SqliteSyncDetails = InfoFolder.Child( kSqliteSyncDetailsName )
		  
		  UserDatabase = DatabaseFolder.Child( kUserDatabaseName )
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected AppFolder As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected DatabaseFolder As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected InfoFolder As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected KajuFolder As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected LogFolder As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected MainDatabase As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected PrimaryLogFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected SqliteSyncDetails As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected UserDatabase As FolderItem
	#tag EndProperty


	#tag Constant, Name = kAppFolderName, Type = String, Dynamic = False, Default = \"", Scope = Private
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"Otis Business Manager"
	#tag EndConstant

	#tag Constant, Name = kDbFolderName, Type = String, Dynamic = False, Default = \"", Scope = Private
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"db"
	#tag EndConstant

	#tag Constant, Name = kInfoFolderName, Type = String, Dynamic = False, Default = \"", Scope = Private
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"info"
	#tag EndConstant

	#tag Constant, Name = kKajuFolderName, Type = String, Dynamic = False, Default = \"", Scope = Private
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"kaju"
	#tag EndConstant

	#tag Constant, Name = kLogFolderName, Type = String, Dynamic = False, Default = \"", Scope = Private
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"log"
	#tag EndConstant

	#tag Constant, Name = kMainDbName, Type = String, Dynamic = False, Default = \"", Scope = Private
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"main_db.sqlite"
	#tag EndConstant

	#tag Constant, Name = kPrimaryLogFileName, Type = String, Dynamic = False, Default = \"", Scope = Private
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"log_prime"
	#tag EndConstant

	#tag Constant, Name = kSqliteSyncDetailsName, Type = String, Dynamic = False, Default = \"", Scope = Private
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"sqlitesync_details"
	#tag EndConstant

	#tag Constant, Name = kUserDatabaseName, Type = String, Dynamic = False, Default = \"", Scope = Private
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"udf.sqlite"
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
