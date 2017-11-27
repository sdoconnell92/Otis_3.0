#tag Class
Protected Class tbl_events
Inherits DataFile.ActiveRecordBase
	#tag Event
		Function evdefGetRecordName() As String
		  Return sevent_name
		End Function
	#tag EndEvent

	#tag Event
		Sub PostDelete()
		  
		  // Grab all the link children of this record from the database
		  dim oLinkChildren() as DataFile.tbl_internal_linking
		  oLinkChildren() = DataFile.tbl_internal_linking.List("fk_parent = '" + self.suuid + "' Or fk_child = '" + self.suuid + "'")
		  
		  For Each oLinkChild as DataFile.tbl_internal_linking In oLinkChildren
		    
		    oLinkChild.Delete
		    
		  Next
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function AddEIPL(sEIPLType as String) As DataFile.tbl_eipl
		  '!@! Table Dependent !@!
		  
		  // Create the new eipl
		  dim oNewItem as New DataFile.tbl_eipl
		  oNewItem.Save
		  oNewItem.sfkevents = me.suuid
		  oNewItem.seipl_type = sEIPLType
		  oNewItem.Save
		  
		  
		  // Now we must grab any contactables on the event and link them to the eipl as well
		  dim oLinkRecords() as DataFile.tbl_contactable_linking = DataFile.tbl_contactable_linking.List("fk_parent = '" + me.suuid + "'" )
		  
		  // Loop through all of the link records
		  For Each oRecod as DataFile.tbl_contactable_linking In oLinkRecords()
		    
		    If oRecod.sfk_child <> "" Then
		      
		      dim oChildRecord as DataFile.tbl_contactables = DataFile.tbl_contactables.FindByID( oRecod.sfk_child )
		      If oChildRecord <> Nil Then
		        // the child record exists
		        // chreate a link to the new eipl
		        dim oNewLink as new DataFile.tbl_contactable_linking
		        oNewLink.sfk_parent = oNewItem.suuid
		        oNewLink.sfk_child = oRecod.sfk_child
		        oNewLink.sparent_table = "tbl_eipl"
		        oNewLink.Save
		      End If
		      
		    End If
		    
		  Next
		  
		  Return oNewItem
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function BaseSQL(bAsCount as Boolean = false) As String
		  dim ars() as string
		  
		  ars.Append "select "
		  if bAsCount = false then
		    ars.Append "*"
		  else
		    ars.Append "count(*) as iCnt"
		  end if
		  
		  ars.Append "From tbl_events"
		  
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
		Shared Function FindByID(id as String) As DataFile.tbl_events
		  //Usage:
		  //dim tbl_events as DataFile.tbl_events = DataFile.tbl_events.FindByID( id )
		  if DB.error THen
		  end if
		  
		  if db.Error Then
		  end if
		  
		  dim s as string
		  s = "Select * from tbl_events Where uuid = '" + str(id) + "';"
		  
		  dim rs as RecordSet = DB.SQLSelect(s)
		  
		  if DB.error then
		    System.debugLog DB.ErrorMessage
		    return nil
		  end
		  if rs.RecordCount = 0 then return nil
		  
		  dim tbl_events as new DataFile.tbl_events
		  tbl_events.ReadRecord(rs)
		  return tbl_events
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GroupRecordsOld(oRecordList() as DataFile.tbl_events, sGroupBy as String) As Dictionary
		  dim jsMaster as New Dictionary
		  
		  If sGroupBy = "" Then
		    Return Nil
		  End If
		  
		  // now we need to loop through each one of the records and startp putting them in there place
		  dim sGroupByList() as string = sGroupBy.split(", ")
		  dim jsCurrent() as Dictionary
		  dim idx_record as integer
		  For Each oRecord as DataFile.tbl_events In oRecordList()
		    
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
		          
		        Elseif jsCurrent(n3).Value( sGroupValue ) IsA DataFile.tbl_events Then
		          ' we can put the record here
		          
		        Else
		          'ElseIf jsCurrent(n3).Value( sGroupValue ) IsA String THen
		          
		          #Pragma BreakOnExceptions Off
		          Try
		            // pull the array of records from the value
		            dim oRecords() as DataFile.tbl_events
		            oRecords() = jsCurrent(n3).Value(sGroupValue)
		            oRecords.Append(oRecord)
		            jsCurrent(n3).Value(sGroupValue) = oRecords
		            Continue
		          Exception
		          End Try
		          #Pragma BreakOnExceptions On
		          
		          If jsCurrent(n3).Value( sGroupValue ) = "none" THen
		            
		            // We need to check if this is the last group by field
		            If idx1 = sGroupByList.Ubound Then
		              // this is the last of the group by fields so we can put an array with this record in the value
		              dim oRecords() as DataFile.tbl_events
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

	#tag Method, Flags = &h0
		Shared Function List(stmt as PreparedSQLStatement) As DataFile.tbl_events()
		  //Note: You should use this method if your query contains user entered data. Using this method will help prevent SQL injection attacks
		  dim aro() as DataFile.tbl_events
		  
		  dim rs as recordset = stmt.SQLSelect
		  If DB.error then
		    break
		    System.debugLog DB.ErrorMessage
		    return aro
		  end
		  
		  while rs.eof = false
		    dim oRecord as new DataFile.tbl_events
		    oRecord.ReadRecord(rs)
		    aro.Append oRecord
		    rs.MoveNext
		  wend
		  
		  return aro
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function List(sCriteria as string = "", sOrder as string = "", iOffset as Integer = -1) As DataFile.tbl_events()
		  //Note: You should not use this method if your query contains user entered data.
		  //Using this method with user entered data could expose you to SQL injection attacks.
		  dim aro() as DataFile.tbl_events
		  dim ars() as string
		  
		  if db.Error Then
		  end if
		  
		  ars.append DataFile.tbl_events.BaseSQL
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
		  
		  dim s as string = ars.JoinSQL + ";"
		  dim rs as RecordSet = DB.SQLSelect(s)
		  If DB.error then
		    break
		    System.debugLog DB.ErrorMessage
		    return aro
		  end
		  
		  do until rs.EOF
		    dim oRecord as new DataFile.tbl_events
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
		  
		  ars.append DataFile.tbl_events.BaseSQL(True)
		  if sCriteria<>"" then
		    ars.append "WHERE " + sCriteria
		  end if
		  dim s as string = ars.JoinSQL
		  dim rs as RecordSet = DB.SQLSelect(s)
		  
		  If DB.error then
		    break
		    System.debugLog DB.ErrorMessage
		    return 0
		  end
		  return rs.Field("iCnt").IntegerValue
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		bhide As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		saccount_manager As String
	#tag EndProperty

	#tag Property, Flags = &h0
		send_date As String
	#tag EndProperty

	#tag Property, Flags = &h0
		send_time As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sevent_details As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sevent_name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sevent_tags As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sloadin_date As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sloadin_time As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sloadout_date As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sloadout_time As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sstart_date As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sstart_time As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="bhide"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
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
			Name="saccount_manager"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="send_date"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="send_time"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sevent_details"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sevent_name"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sevent_tags"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sloadin_date"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sloadin_time"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sloadout_date"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sloadout_time"
			Group="Behavior"
			Type="String"
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
			Name="sstart_date"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sstart_time"
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
