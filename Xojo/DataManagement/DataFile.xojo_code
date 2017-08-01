#tag Module
Protected Module DataFile
	#tag Method, Flags = &h1
		Protected Sub AddEIPLtoNumberGetList(EIPLUUID as String)
		  dim FileContents as string
		  
		  dim rd1 as New ResourceDirectories
		  dim f1 as FolderItem = rd1.eipl_numbers_to_get_file.FilePath
		  
		  If f1 <> Nil Then
		    If f1.Exists Then
		      
		      dim tis1 as TextInputStream
		      Try
		        tis1 = TextInputStream.Open(f1)
		        FileContents = tis1.ReadAll
		      Catch e as IOException
		        dim s as string
		      End Try
		      
		    End If
		  End If
		  
		  dim NumberArray() as string = FileContents.Split(",")
		  
		  NumberArray.Append(EIPLUUID)
		  FileContents = Join( NumberArray, "," )
		  
		  If f1 <> Nil Then
		    Try
		      Dim tos1 as TextOutputStream = TextOutputStream.Create(f1)
		      tos1.Write( FileContents )
		      tos1 = Nil
		    Catch e as IOException
		      dim s as string
		    End Try
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConnectDB() As SQLiteDatabase
		  dim db as New SQLiteDatabase
		  db.DatabaseFile = SpecialFolder.Desktop.Child("testdb.sqlite")
		  
		  If db.Connect THen
		    Return db
		  End If
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CreateNumbersForOfflineEIPLs()
		  dim oEIPLS() as DataFile.tbl_eipl
		  
		  dim FileContents as string
		  
		  dim rd1 as New ResourceDirectories
		  dim f1 as FolderItem = rd1.eipl_numbers_to_get_file.FilePath
		  
		  If f1 <> Nil Then
		    If f1.Exists Then
		      
		      dim tis1 as TextInputStream
		      Try
		        tis1 = TextInputStream.Open(f1)
		        FileContents = tis1.ReadAll
		      Catch e as IOException
		        dim s as string
		      End Try
		      
		    End If
		  End If
		  
		  dim NumberArray() as string = FileContents.Split(",")
		  
		  If NumberArray.Ubound <> -1 Then
		    For Each sUUID as string In NumberArray()
		      
		      dim oEIPL as DataFile.tbl_eipl = DataFile.tbl_eipl.FindByID(sUUID)
		      
		      If oEIPL <> Nil Then
		        dim iNewNumber as Integer = GetNextEIPLNumber("")
		        If iNewNumber <> 0 Then
		          oEIPL.ieipl_number = iNewNumber
		          oEIPL.Save
		        End If
		      End If
		    Next
		    
		    OSM.RunSync
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DB() As SQLiteDatabase
		  Return App.db
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetDB() As SQLiteDatabase
		  Return app.db
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetNewUUID(minLen As Integer = 32, maxLen As Integer = 64, lowerc As Boolean = True, upperc As Boolean = True, numeric As Boolean = True, symbols As Boolean = True) As String
		  _// Select Characters to pick from
		  Dim sGrabBag As String
		  If lowerc Then sGrabBag = sGrabBag + "abcdefghijklmnopqrstuvwxyz"
		  If upperc Then sGrabBag = sGrabBag + "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
		  If numeric Then sGrabBag = sGrabBag + "1234567890"
		  If symbols Then sGrabBag = sGrabBag + "!@#$%^&*()_-+"
		  
		  // How many do we have?
		  Dim iBagChars, iRandChar As Integer
		  iBagChars = Len(sGrabBag)
		  
		  // Init rnd
		  Dim oRand As New Random
		  
		  // Pick Length
		  Dim iLength As Integer
		  oRand.RandomizeSeed
		  iLength = oRand.InRange(minLen, maxLen)
		  
		  // Pick iLength characters
		  Dim sResult, sChar As String
		  For i As Integer = 1 To iLength
		    oRand.RandomizeSeed
		    iRandChar = oRand.InRange(1, iBagChars)
		    sChar = Mid(sGrabBag, iRandChar, 1)
		    sResult = sResult + sChar
		  Next i
		  
		  Return sResult
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetNextEIPLNumber(EIPLUUID as String) As Integer
		  dim db1 as PostgreSQLDatabase = app.RegDB
		  dim EIPLNumber as integer
		  
		  
		  If db1 <> Nil And Login.State = "Online" Then
		    // we are online
		    
		    dim sql1 as string = "Select nextval('utility.seq_eipl_numbers');"
		    dim rs1 as RecordSet = db1.SQLSelect(sql1)
		    If db1.Error Then
		      ErrManage("Methods.GetNextEIPLNumber", "Could not get next eipl_number from server: " + db1.ErrorMessage )
		      If EIPLUUID <> "" Then
		        AddEIPLtoNumberGetList(EIPLUUID)
		        Return 0
		      End If
		    End If
		    
		    If rs1.RecordCount <> 0 Then
		      EIPLNumber = rs1.Field( "nextval" ).IntegerValue
		      Return EIPLNumber
		    End If
		    
		  Else
		    // we are offline
		    
		    If EIPLUUID <> "" Then
		      AddEIPLtoNumberGetList(EIPLUUID)
		      
		      Return 0
		    End If
		    
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function JoinSQL(extends ars() as string) As String
		  Return join(ars, " ")
		End Function
	#tag EndMethod


	#tag Constant, Name = kMaxReturn, Type = Double, Dynamic = False, Default = \"50", Scope = Public
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
