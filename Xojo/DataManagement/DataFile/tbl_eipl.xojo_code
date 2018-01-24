#tag Class
Protected Class tbl_eipl
Inherits DataFile.ActiveRecordBase
	#tag Event
		Function evdefGetRecordName() As String
		  Return seipl_name
		End Function
	#tag EndEvent

	#tag Event
		Sub PreInsert()
		  
		  dim iNewEIPLNumber as integer
		  
		  iNewEIPLNumber = DataFile.GetNextEIPLNumber(me.suuid)
		  me.ieipl_number = iNewEIPLNumber
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Shared Function BaseSQL(bAsCount as Boolean = false) As String
		  dim ars() as string
		  
		  ars.Append "select "
		  if bAsCount = false then
		    ars.Append "*"
		  else
		    ars.Append "count(*) as iCnt"
		  end if
		  
		  ars.Append "From tbl_eipl"
		  
		  Return ars.JoinSQL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeleteOK(Byref sError as string) As Boolean
		  //Add your delete Validation here
		  
		  //Use sError to provide feedback to the user.
		  //Example:
		  //sError = "This Record cannot be deleted because xyz"
		  
		  
		  
		  Return true
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FindByID(id as String) As DataFile.tbl_eipl
		  //Usage:
		  //dim tbl_eipl as DataFile.tbl_eipl = DataFile.tbl_eipl.FindByID( id )
		  if DB.error THen
		  end if
		  
		  if db.Error Then
		  end if
		  
		  dim s as string
		  s = "Select * from tbl_eipl Where uuid = '" + str(id) + "';"
		  
		  dim rs as RecordSet = DB.SQLSelect(s)
		  if DB.error then
		    System.debugLog DB.ErrorMessage
		    return nil
		  end
		  if rs.RecordCount = 0 then return nil
		  
		  dim tbl_eipl as new DataFile.tbl_eipl
		  tbl_eipl.ReadRecord(rs)
		  return tbl_eipl
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindParentEvent() As DataFile.tbl_events
		  dim retEvent as DataFile.tbl_events
		  
		  If sfkevents <> "" Then
		    retEvent = DataFile.tbl_events.FindByID(sfkevents)
		  End If
		  
		  Return retEvent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindPrimaryContact() As DataFile.tbl_contactables
		  dim retContact as New DataFile.tbl_contactables
		  
		  
		  dim oLink as DataFile.tbl_contactable_linking
		  
		  // First try to find a linked contactable that has been designated primary
		  dim sql1 as string = _
		  "Select a.uuid "_
		  + "From tbl_contactable_linking, tbl_contactables as a "_
		  + "Where parent_table = 'tbl_eipl' And fk_parent = ? "_
		  + "And fk_child = a.uuid And a.type = 'Contact' "_
		  + "And primary_contactable = 1 ;"
		  dim ps1 as SQLitePreparedStatement = DB.Prepare(sql1)
		  ps1.BindType(0,SQLitePreparedStatement.SQLITE_TEXT)
		  ps1.Bind(0, suuid)
		  dim rs1 as RecordSet = ps1.SQLSelect()
		  
		  If rs1 <> Nil Then
		    dim Contactuuid as string = rs1.Field("uuid").StringValue
		    retContact = DataFile.tbl_contactables.FindByID(Contactuuid)
		  End If
		  
		  Return retContact
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindPrimaryVenue() As DataFile.tbl_contactables
		  dim retVenue as New DataFile.tbl_contactables
		  
		  
		  dim oLink as DataFile.tbl_contactable_linking
		  
		  // First try to find a linked contactable that has been designated primary
		  dim sql1 as string = _
		  "Select a.uuid "_
		  + "From tbl_contactable_linking, tbl_contactables as a "_
		  + "Where parent_table = 'tbl_eipl' And fk_parent = ? "_
		  + "And fk_child = a.uuid And a.type = 'Venue' "_
		  + "And primary_contactable = 1 ;"
		  dim ps1 as SQLitePreparedStatement = DB.Prepare(sql1)
		  ps1.BindType(0,SQLitePreparedStatement.SQLITE_TEXT)
		  ps1.Bind(0, suuid)
		  dim rs1 as RecordSet = ps1.SQLSelect()
		  
		  If rs1 <> Nil Then
		    dim Contactuuid as string = rs1.Field("uuid").StringValue
		    retVenue = DataFile.tbl_contactables.FindByID(Contactuuid)
		  End If
		  
		  Return retVenue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDiscounts() As String()
		  dim retS() as string
		  dim sDiscountPercent, sDiscountAmount, arsDiscount() as String
		  arsDiscount() = sdiscount.Split(":")
		  
		  For i1 as integer = 0 To arsDiscount.Ubound
		    dim sDiscount as string = arsDiscount(i1)
		    If InStr( sDiscount , "%") > 0 Then
		      ' discount is a percent
		      sDiscountPercent = sDiscount
		    Else
		      sDiscountAmount = str( sDiscount, "\$###,###,###,###.00" )
		    End If
		  Next
		  
		  If val(Methods.StripNonDigitsDecimals(sDiscountPercent)) <> 0 Then
		    retS.Append(sDiscountPercent)
		  Else
		    retS.Append("")
		  End If
		  If val(Methods.StripNonDigitsDecimals(sDiscountAmount)) <> 0 Then
		    retS.Append(sDiscountAmount)
		  Else
		    retS.Append("")
		  End If
		  
		  Return retS
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetNewEiplNumber() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function List(stmt as PreparedSQLStatement) As DataFile.tbl_eipl()
		  //Note: You should use this method if your query contains user entered data. Using this method will help prevent SQL injection attacks
		  dim aro() as DataFile.tbl_eipl
		  
		  dim rs as recordset = stmt.SQLSelect
		  If DB.error then
		    break
		    System.debugLog DB.ErrorMessage
		    return aro
		  end
		  
		  while rs.eof = false
		    dim oRecord as new DataFile.tbl_eipl
		    oRecord.ReadRecord(rs)
		    aro.Append oRecord
		    rs.MoveNext
		  wend
		  
		  return aro
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function List(sCriteria as string = "", sOrder as string = "", iOffset as Integer = -1) As DataFile.tbl_eipl()
		  //Note: You should not use this method if your query contains user entered data.
		  //Using this method with user entered data could expose you to SQL injection attacks.
		  dim aro() as DataFile.tbl_eipl
		  dim ars() as string
		  
		  if db.Error Then
		  end if
		  
		  ars.append DataFile.tbl_eipl.BaseSQL
		  if sCriteria.Trim <> "" then
		    ars.append "WHERE " + sCriteria
		  end if
		  
		  if sOrder.trim <> "" then
		    ars.append " ORDER BY " + sOrder
		  else
		    'ars.append "<Your Field Here>"
		  end if
		  
		  if iOffset > -1 then
		    ars.append " LIMIT " + str(kMaxReturn) + " Offset " + str(iOffset)
		  end if
		  
		  dim s as string = ars.JoinSQL
		  dim rs as RecordSet = DB.SQLSelect(s)
		  If DB.error then
		    break
		    System.debugLog DB.ErrorMessage
		    return aro
		  end
		  
		  do until rs.EOF
		    dim oRecord as new DataFile.tbl_eipl
		    oRecord.ReadRecord(rs)
		    
		    aro.Append(oRecord)
		    rs.MoveNext
		  loop
		  
		  
		  
		  return aro
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ListCount(stmt as PreparedSQLStatement) As Integer
		  //Note: You should use this method if your query contains user entered data. Using this method will help prevent SQL injection attacks
		  
		  dim rs as Recordset = stmt.SQLSelect
		  
		  If DB.error then
		    break
		    System.debugLog DB.ErrorMessage
		    return 0
		  end
		  return rs.Field("iCnt").IntegerValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ListCount(sCriteria as string = "") As Integer
		  //Note: You should not use this method if your query contains user entered data.
		  //Using this method with user entered data could expose you to SQL injection attacks.
		  dim ars() as string
		  
		  if db.Error Then
		  end if
		  
		  ars.append DataFile.tbl_eipl.BaseSQL(True)
		  if sCriteria<>"" then
		    ars.append "WHERE " + sCriteria
		  end if
		  dim s as string = ars.JoinSQL + ";"
		  dim rs as RecordSet = DB.SQLSelect(s)
		  
		  If DB.error then
		    break
		    System.debugLog DB.ErrorMessage
		    return 0
		  end
		  return rs.Field("iCnt").IntegerValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ListGrouped(sCriteria as string = "", sOrder as string = "", sGroupBy as String = "") As Dictionary
		  dim jsMaster as New Dictionary
		  dim oRecordList() as DataFile.tbl_eipl
		  
		  If sGroupBy = "" Then
		    Return Nil
		  End If
		  
		  // Lets get the complete list of records from the database
		  oRecordList() = DataFile.tbl_eipl.List(sCriteria, sOrder)
		  
		  // now we need to loop through each one of the records and startp putting them in there place
		  dim sGroupByList() as string = sGroupBy.split(", ")
		  dim jsCurrent() as Dictionary
		  dim idx_record as integer
		  For Each oRecord as DataFile.tbl_eipl In oRecordList()
		    
		    jsCurrent.append( jsMaster)
		    
		    dim jsFieldValues as JSONItem = oRecord.GetMyFieldValues(True)
		    
		    
		    For idx1 as integer = 0 To sGroupByList.Ubound
		      
		      dim sGroupField as string = sGroupByList(idx1)
		      dim n3 as integer = jsCurrent.Ubound
		      dim sGroupValue as String =  jsFieldValues.Value(sGroupField)
		      
		      // Check if this record fits into any existing groups
		      dim sArray() as string
		      for Each vKey as Variant In jsCurrent(n3).Keys
		        sArray.Append( str( vKey ) )
		      Next
		      'If jsCurrent(n3).Keys.IndexOf( sGroupValue ) > -1 Then
		      If sArray.IndexOf( sGroupValue ) > -1 THen
		        ' there is a place for this record at this level
		        
		        ' now we check if the value of the current level group is a jsonitem, array, or s"none"
		        If jsCurrent(n3).Value( sGroupValue ) IsA Dictionary Then
		          ' we must dig depper into jsonitems
		          
		          jsCurrent.Append( jsCurrent(n3).Value( sGroupValue ) )
		          Continue
		          
		        Elseif jsCurrent(n3).Value( sGroupValue ) IsA DataFile.tbl_eipl Then
		          ' we can put the record here
		          
		        Else
		          
		          #Pragma BreakOnExceptions Off
		          Try
		            // pull the array of records from the value
		            dim oRecords() as DataFile.tbl_eipl
		            oRecords() = jsCurrent(n3).Value(sGroupValue)
		            oRecords.Append(oRecord)
		            jsCurrent(n3).Value(sGroupValue) = oRecords
		            Continue
		          Exception
		          End Try
		          #Pragma BreakOnExceptions Default
		          
		          'ElseIf jsCurrent(n3).Value( sGroupValue ) IsA String THen
		          If jsCurrent(n3).Value( sGroupValue ) = "none" THen
		            
		            // We need to check if this is the last group by field
		            If idx1 = sGroupByList.Ubound Then
		              // this is the last of the group by fields so we can put an array with this record in the value
		              dim oRecords() as DataFile.tbl_eipl
		              oRecords.Append( oRecord )
		              jsCurrent(n3).Value( sGroupValue ) = oRecords
		            Else
		              // We still need to group by deeper
		              // we will continue on the loop so as to advance the level of deepness by one group creating field
		              jsCurrent(n3).Value( sGroupValue ) = New Dictionary
		              jsCurrent.Append( jsCurrent(n3).Value( sGroupValue ) )
		              Continue
		            End If
		          End If
		          
		        End If
		        
		      Else
		        ' There is no place created for this record at this level
		        
		        // we will create a new key for this unique value and mark it as s"none" 
		        jsCurrent(n3).Value( sGroupValue ) = "none"
		        
		        // Now we will continue on with our looping with the index backtracked so we will try to categorize this record with this new key created
		        idx1 = idx1 - 1
		        Continue
		        
		      End If
		    Next
		    
		    ReDim jsCurrent(-1)
		    idx_record = idx_record + 1
		  Next
		  
		  Return jsMaster
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		ibranch_number As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		irevision_number As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		sdiscount As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sdue_date As String
	#tag EndProperty

	#tag Property, Flags = &h0
		seipl_name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		seipl_number As String
	#tag EndProperty

	#tag Property, Flags = &h0
		seipl_tax_rate As String
	#tag EndProperty

	#tag Property, Flags = &h0
		seipl_type As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sfkevents As string
	#tag EndProperty

	#tag Property, Flags = &h0
		sshipping_method As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ipkid"
			Group="Behavior"
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
			Name="sdiscount"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sdue_date"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="seipl_name"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="seipl_number"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="seipl_tax_rate"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="seipl_type"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sfkevents"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="srow_created"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="srow_modified"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="srow_username"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sshipping_method"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="suuid"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
