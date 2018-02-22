#tag Module
Protected Module EIPLNumbering
	#tag Method, Flags = &h21
		Private Function CreateEiplNumber(db as sqlitedatabase, EventID as string, EiplType as String) As String
		  dim partType, partBranch, partRevision as String
		  dim retFinal as string
		  
		  partType = DetermineTypeID(EiplType)
		  
		  dim bn as integer = DetermineBranchNumber(db, EventID)
		  If bn <> 0 Then partBranch = str(bn)
		  
		  partRevision = DetermineRevision(db, EventID, bn, EiplType)
		  
		  retFinal = partType + partBranch + "." + partRevision
		  
		  Return retFinal
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CreateTemporary(EiplType as string) As String
		  dim d as New Date
		  dim ars() as string
		  dim s as string
		  
		  ars.Append( d.Month.ToText )
		  ars.Append( d.Day.ToText )
		  ars.Append( d.Hour.ToText )
		  ars.Append( d.Minute.ToText )
		  
		  dim et as string = DetermineTypeID(EiplType)
		  
		  s = ars.Join("")
		  s = "Temp-" + et + s
		  
		  Return s
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DetermineBranchNumber(db as SQLiteDatabase, EventID as String) As Integer
		  dim i as integer
		  
		  // Check if the event specifies a default branch number
		  i = GetEventBranchNumber(db, EventID)
		  If i <> 0 Then Return i
		  
		  // Check for the highest branch number in related eipls
		  i = GetHighestRelatedEIPLBranch(db, EventID)
		  If i <> 0 Then Return i
		  
		  // Check for highest branch number used
		  i = GetHighestBranchNumber(db)
		  UpdateBranchNumberTable(db, i)
		  Return i
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DetermineRevision(db as SQLiteDatabase, EventID as string, BranchNumber as integer, EiplType as String) As String
		  dim i as integer
		  
		  i = GetHighestRevisionNumber(db, EventID, BranchNumber, EiplType)
		  
		  i = i + 1
		  
		  dim s as string
		  
		  s = str( i, "00" )
		  
		  Return s
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DetermineTypeID(EiplType as String) As String
		  Dim arsTypes() as string = ValueRef.EIPLTypes.Split(",")
		  
		  Select Case EiplType
		  Case "Estimate"
		    Return EIPLCodes.Estimate
		  Case "Pro-Forma Invoice"
		    Return EIPLCodes.ProFormaInvoice
		  Case "Invoice"
		    Return EIPLCodes.Invoice
		  Case "Pack List"
		    Return EIPLCodes.PackList
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FindTempEiplNumbers(db as SQLiteDatabase) As Dictionary()
		  dim sql as string
		  dim ard() as Dictionary
		  
		  sql = "Select uuid, eipl_number, eipl_type, fkevents From tbl_eipl Where eipl_number Like 'Temp%';"
		  
		  dim ps as SQLitePreparedStatement = db.Prepare(sql)
		  dim rs as RecordSet = ps.SQLSelect
		  
		  If db.Error Then
		    ErrManage("EIPLNumbering.FindTempEiplNumbers", "Error while finding temporary numbers: " + db.ErrorMessage)
		    Return ard()
		  End If
		  
		  If rs = Nil Then Return ard()
		  
		  While not rs.EOF
		    dim d as new Dictionary
		    d.Value("uuid") = rs.Field("uuid").StringValue
		    d.Value("eipl_number") = rs.Field("eipl_number").StringValue
		    d.Value("eipl_type") = rs.Field("eipl_type").StringValue
		    d.Value("fkevents") = rs.Field("fkevents").StringValue
		    
		    rs.MoveNext
		  Wend
		  
		  Return ard()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetEventBranchNumber(db as SQLiteDatabase, EventId as String) As Integer
		  dim sql as string
		  
		  // Check if we have a db connection
		  If db = Nil Then Return 0
		  
		  // Create sql to grab defualt branch number from the event
		  sql = "Select uuid, branch_number from tbl_events Where uuid = ?;"
		  dim ps as SQLitePreparedStatement
		  ps = db.Prepare(sql)
		  ps.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		  ps.Bind(0, EventId)
		  
		  dim rs as RecordSet = ps.SQLSelect
		  If db.Error Then
		    ErrManage("EIPLNumbering.GetEventBranchNumber", "Could not get default branch number: " + db.ErrorMessage)
		    Return 0
		  End If
		  
		  If rs = Nil Then Return 0
		  
		  dim i as integer = rs.Field("branch_number").IntegerValue
		  
		  Return i
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetHighestBranchNumber(db as SQLiteDatabase) As Integer
		  dim sql as string
		  
		  sql = "Select * From tbl_branchnumbers Order By branch_number Descending Limit 1;"
		  
		  dim ps as SQLitePreparedStatement
		  ps = db.Prepare(sql)
		  
		  dim rs as RecordSet = ps.SQLSelect
		  If db.Error Then
		    ErrManage("EIPLNumbering.FindHighestBranchNumber", "Could not get next branch number: " + db.ErrorMessage)
		    Return 0
		  End If
		  
		  If rs = Nil Then Return 0
		  
		  dim i as integer = rs.Field("branch_number").IntegerValue
		  
		  Return i
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetHighestRelatedEIPLBranch(db as sqlitedatabase, EventID as string) As Integer
		  dim sql as string
		  dim ars() as string
		  
		  sql = "Select uuid, branch_number, eipl_number From tbl_eipl Where fkevents = ? Order By branch_number Descending Limit 1;"
		  
		  dim ps as SQLitePreparedStatement
		  ps = db.Prepare(sql)
		  ps.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		  ps.Bind(0, EventID)
		  
		  dim rs as RecordSet
		  rs = ps.SQLSelect
		  If db.Error Then
		    ErrManage("EIPLNumbering.GetRelatedEIPLNumbers", "Could not get any related eipl numbers: " + db.ErrorMessage)
		    Return 0
		  End If
		  
		  dim i as integer
		  If rs <> Nil Then
		    i = rs.Field("branch_number").IntegerValue
		  End If
		  
		  Return i
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetHighestRevisionNumber(db as SQLiteDatabase, EventID as String, BranchNumber as integer, EiplType as string) As Integer
		  dim sql as string
		  dim i as integer
		  
		  sql = "Select uuid, branch_number, eipl_number, revision_number from tbl_eipl Where fkevents = ? And branch_number = ? And eipl_type = ? Order By revision_number Descending Limit 1;"
		  
		  dim ps as SQLitePreparedStatement
		  ps = db.Prepare(sql)
		  ps.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		  ps.BindType(1, SQLitePreparedStatement.SQLITE_INTEGER)
		  ps.BindType(2, SQLitePreparedStatement.SQLITE_TEXT)
		  ps.Bind(0, EventID)
		  ps.Bind(1, BranchNumber)
		  ps.Bind(2, EiplType)
		  
		  dim rs as RecordSet
		  rs = ps.SQLSelect
		  
		  If rs = Nil Then Return i
		  
		  i = rs.Field("revision_number").IntegerValue
		  
		  Return i
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetNewEiplNumber(EventID as String, EiplType as string) As String
		  dim bCreateNew as Boolean = True
		  dim s as string
		  
		  // Check if we are offline
		  If app.bOffline Then
		    bCreateNew = False
		  End If
		  
		  dim db as SQLiteDatabase
		  db = DataFile.GetDB
		  
		  If db = Nil Then
		    bCreateNew = False
		  End If
		  
		  If bCreateNew Then
		    s = CreateEiplNumber(db, EventID, EiplType)
		  Else
		    s = CreateTemporary(EiplType)
		  End If
		  
		  Return s
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ProcessTemporaryNumbers(db as SQLiteDatabase, ard() as Dictionary)
		  
		  If ard.Ubound = -1 Then Return
		  
		  For Each d as Dictionary In ard()
		    
		    dim EiplId as string = d.Value("uuid")
		    dim EiplType as string = d.Value("eipl_type")
		    dim EventId as string = d.Value("fkevents")
		    
		    dim s as string = CreateEiplNumber(db, EventId, EiplType)
		    
		    If s <> "" Then
		      dim ei as DataFile.tbl_eipl
		      ei = DataFile.tbl_eipl.FindByID(EiplId)
		      
		      If ei <> Nil Then
		        ei.seipl_number = s
		        ei.Save
		      End If
		    End If
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateBranchNumberTable(db as SQLiteDatabase, bn as integer)
		  dim sql as string
		  
		  sql = "Insert Into tbl_branchnumbers(branch_number, uuid) Values(?,?);"
		  
		  dim ps as SQLitePreparedStatement
		  ps = db.Prepare(sql)
		  
		  ps.BindType(0, SQLitePreparedStatement.SQLITE_INTEGER)
		  ps.BindType(1, SQLitePreparedStatement.SQLITE_TEXT)
		  ps.Bind(0, bn)
		  ps.Bind(1, GetNewUUID)
		  
		  ps.SQLExecute
		  If db.Error Then
		    ErrManage("EIPLNumbering.UpdateBranchNumberTable", "Could not update branch number table: " + db.ErrorMessage)
		    Return
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub UpdateTemporaryNumbers(db as SQLiteDatabase)
		  
		  dim ard() as Dictionary = FindTempEiplNumbers(db)
		  
		  ProcessTemporaryNumbers(db, ard)
		End Sub
	#tag EndMethod


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
