#tag Class
Protected Class SqlSyncClass
	#tag Method, Flags = &h0
		Sub Constructor(ServerAddress as string, db as sqliteDatabase, TablesToSync() as string, ClientID as string = "")
		  
		  ServerHost = ServerAddress
		  SyncDB = db
		  SyncTables = TablesToSync
		  UserID = ClientID
		  SyncSocket = New HTTPSecureSocket
		  SyncSocket.Secure = False
		  SyncSocket.ConnectionType = 1
		  AddHandler SyncSocket.AuthenticationRequired, AddressOf HandleAuthRequired
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteDatabase()
		  Directory.MainDatabase.Delete
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteDets()
		  Directory.SqliteSyncDetails.Delete
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HandleAuthRequired(sock as HTTPSecureSocket, Realm As String, Headers As InternetHeaders, ByRef Name As String, ByRef Password As String) As Boolean
		  Return Auth.HandleAuthenticationRequest(Name, Password)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Init(ServerHost as string, SyncDB as sqlitedatabase, DetailsFile as FolderItem, SyncTables() as string, Offline as Boolean) As SqliteSync.SqlSyncClass
		  // 1.  Try to load from file
		  dim cl as SqliteSync.SqlSyncClass
		  dim NeedInit as Boolean
		  dim NeedNewCl as Boolean
		  
		  // Try to load class from file
		  cl = LoadFromFile(DetailsFile.Parent, DetailsFile.Name)
		  If cl <> Nil Then
		    // Validate the Detais
		    If cl.ValidateDets Then
		      
		      // Validate the database
		      If cl.ValidateDatabase Then
		      Else
		        NeedInit = True
		      End If
		    Else
		      NeedNewCl = True
		    End If
		  Else
		    NeedNewCl = True
		  End If
		  
		  
		  If NeedNewCl Then
		    If Offline Then Return Nil
		    cl = Nil
		    dim suuid as string = GetNewUUID
		    cl = New SqliteSync.SqlSyncClass(ServerHost, SyncDB, SyncTables, suuid)
		    NeedNewCl = False
		    NeedInit = True
		  End If
		  
		  If NeedInit Then
		    cl.InitializeSubscriber
		  End If
		  
		  dim abort as Boolean
		  If Not cl.ValidateDets Then 
		    cl.DeleteDets
		    abort = True
		  End If
		  If Not cl.ValidateDatabase Then 
		    cl.DeleteDatabase
		    abort = True
		  End If
		  
		  If abort Then Return Nil
		  
		  Return cl
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InitializeSubscriber()
		  If SqliteSync.ExecInitialize(Self.SyncSocket, UserID, SyncDB) Then
		    If Self.Sync Then
		      
		    End If
		    Self.SaveToFile( Directory.InfoFolder, Directory.kSqliteSyncDetailsName )
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function LoadFromFile(FilePath as FolderItem, FileName as string) As SqliteSync.SqlSyncClass
		  dim s as string
		  dim t as TextInputStream
		  dim content as string
		  
		  If FilePath.Exists Then 
		    FilePath = FilePath.Child(FileName)
		    If FilePath.Exists Then
		      
		      // Try to read the file
		      Try
		        t = TextInputStream.Open(FilePath)
		        content = t.ReadAll
		      Catch e as IOException
		        ErrManage( "SqliteSync LoadFromFile", e.Message + " | " + "Could not load class info from file." )
		        Return Nil
		      End Try
		      
		      If content = "" Then Return Nil
		      
		    Else
		      Return Nil
		    End If
		  Else
		    Return Nil
		  End If
		  
		  // Convert To JSON
		  dim js as New JSONItem
		  Try
		    js.load(content)
		  Catch e as JSONException
		    ErrManage( "SqliteSync LoadFromFile", e.Message + " | " + "Could not load json from file" )
		    Return Nil
		  End Try
		  
		  // Pull info from json
		  dim sh,sdb,st,uid as String
		  Try
		    sh = js.Value("serverhost")
		    sdb = js.Value("syncdb_filepath")
		    st = js.Value("sync_tables")
		    uid = js.Value("userid")
		  Catch err as JSONException
		    Return Nil
		  End Try
		  
		  If sh = "" Or sdb = "" Or st = "" Or uid = "" Then Return Nil
		  
		  dim fi as New FolderItem(sdb, FolderItem.PathTypeNative)
		  
		  Dim cl as New SqliteSync.SqlSyncClass(sh, datafile.GetDB, Split(st,","), uid)
		  
		  Return cl
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PushChanges()
		  SqliteSync.ExecPushChanges(Self.SyncSocket, SyncDB, UserID, SyncTables)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PushSync() As Boolean
		  PushChanges
		  If Self.Sync Then
		    Return True
		  End If
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveToFile(FilePath as FolderItem, FileName as string)
		  dim js as New JSONItem
		  
		  js.Value("serverhost") = self.ServerHost
		  js.Value("syncdb_filepath") = self.SyncDB.DatabaseFile.NativePath
		  js.Value("sync_tables") = self.SyncTables.Join(",")
		  js.Value("userid") = self.UserID
		  
		  // Create the containing folder if neccesary
		  If Not FilePath.Exists Then FilePath.CreateAsFolder
		  
		  Try
		    dim tos as TextOutputStream = TextOutputStream.Create(FilePath.Child(FileName))
		    tos.Write(js.ToString)
		    tos.Close
		  Catch e as IOException
		    ErrManage("SqlSyncClass SaveToFile", "Could not save sync details to file." + " | " + e.Message )
		    Return
		  End Try
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Sync() As Boolean
		  If SqliteSync.ExecSync(Self.SyncSocket, self.SyncDB, self.SyncTables, self.UserID) Then
		    Return True
		  Else
		    Return False
		  End If
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidateDatabase() As Boolean
		  // Things to do to validate database
		  // 1. Check that all tables in SyncTables exist
		  
		  If SyncDB = Nil Then Return False
		  dim db as SQLiteDatabase = SyncDB
		  
		  // 1
		  // Loop through SyncTables
		  For Each tn as String In SyncTables
		    dim s as string = "Select tbl_name From sqlite_master Where tbl_name = ?;"
		    dim ps as SQLitePreparedStatement = db.Prepare(s)
		    ps.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		    ps.Bind(0, tn)
		    dim rs as RecordSet = ps.SQLSelect
		    If rs = Nil Then Return False
		  Next
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidateDets() As Boolean
		  Break
		  If ServerHost.IsEmpty Then Return False
		  If SyncDB = Nil Then Return False
		  If SyncTables.Ubound = -1 Then Return False
		  If UserID = "" Then Return False
		  
		  Return True
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private ServerHost As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private SyncDB As SQLiteDatabase
	#tag EndProperty

	#tag Property, Flags = &h0
		SyncSocket As HTTPSecureSocket
	#tag EndProperty

	#tag Property, Flags = &h21
		Private SyncTables() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private UserID As String
	#tag EndProperty


	#tag Constant, Name = errCouldNotCreate_sqlitesync_dets, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"Could not create table sqlitesync_dets in util database: "
	#tag EndConstant

	#tag Constant, Name = kCreateTable_sqlitesync_dets, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"Create Table sqlitesync_dets(pkid Integer Primary Key AutoIncrement\x2C serverhost Text\x2C syncdb_filepath Text\x2C sync_tables Text\x2C userid Text);"
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
End Class
#tag EndClass
