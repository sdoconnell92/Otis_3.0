#tag Class
Protected Class tbl_inventory
Inherits DataFile.ActiveRecordBase
	#tag Event
		Function evdefGetRecordName() As String
		  Return sitem_name
		End Function
	#tag EndEvent

	#tag Event
		Sub PostDelete()
		  
		  // Grab all the link children of this record from the database
		  dim oLinkChildren() as DataFile.tbl_internal_linking
		  oLinkChildren() = DataFile.tbl_internal_linking.List("fk_parent = '" + self.suuid + "' Or fk_child = '" + self.suuid + "'" )
		  
		  For Each oLinkChild as DataFile.tbl_internal_linking In oLinkChildren
		    
		    oLinkChild.Delete
		    
		  Next
		  
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
		  
		  ars.Append "From tbl_inventory"
		  
		  Return ars.JoinSQL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CopyToLI() As DataFile.tbl_lineitems
		  
		  // Create a new lineitem record for this inventory item
		  dim oNewLI as New DataFile.tbl_lineitems
		  oNewLI.sfkinventory = me.suuid
		  oNewLI.sli_name = me.sitem_name
		  oNewLI.sli_manufacturer = me.sitem_manufacturer
		  oNewLI.sli_model = me.sitem_model
		  oNewLI.sli_department = me.sitem_department
		  oNewLI.sli_category = me.sitem_category
		  oNewLI.sli_subcategory = me.sitem_subcategory
		  oNewLI.sli_description = me.sitem_description
		  oNewLI.sli_type = me.sitem_type
		  oNewLI.sli_price = me.sitem_rental_price
		  
		  oNewLI.sli_quantity = "1"
		  oNewLI.sli_time = "1"
		  oNewLI.sli_rate = "Daily"
		  
		  
		  Return oNewLI
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
		Shared Function FindByID(id as String) As DataFile.tbl_inventory
		  //Usage:
		  //dim tbl_inventory as DataFile.tbl_inventory = DataFile.tbl_inventory.FindByID( id )
		  dim s as string
		  s = "Select * from tbl_inventory Where uuid = '" + str(id) + "'"
		  
		  if db.Error Then
		  end if
		  
		  dim rs as RecordSet = DB.SQLSelect(s)
		  
		  if DB.error then
		    System.debugLog DB.ErrorMessage
		    return nil
		  end
		  if rs.RecordCount = 0 then return nil
		  
		  dim tbl_inventory as new DataFile.tbl_inventory
		  tbl_inventory.ReadRecord(rs)
		  return tbl_inventory
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function List(stmt as PreparedSQLStatement) As DataFile.tbl_inventory()
		  //Note: You should use this method if your query contains user entered data. Using this method will help prevent SQL injection attacks
		  dim aro() as DataFile.tbl_inventory
		  
		  dim rs as recordset = stmt.SQLSelect
		  If DB.error then
		    break
		    System.debugLog DB.ErrorMessage
		    return aro
		  end
		  
		  while rs.eof = false
		    dim oRecord as new DataFile.tbl_inventory
		    oRecord.ReadRecord(rs)
		    aro.Append oRecord
		    rs.MoveNext
		  wend
		  
		  return aro
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function List(sCriteria as string = "", sOrder as string = "", iOffset as Integer = -1) As DataFile.tbl_inventory()
		  //Note: You should not use this method if your query contains user entered data.
		  //Using this method with user entered data could expose you to SQL injection attacks.
		  dim aro() as DataFile.tbl_inventory
		  dim ars() as string
		  
		  if db.Error Then
		  end if
		  
		  ars.append DataFile.tbl_inventory.BaseSQL
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
		    dim oRecord as new DataFile.tbl_inventory
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
		  
		  ars.append DataFile.tbl_inventory.BaseSQL(True)
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

	#tag Method, Flags = &h0
		Shared Function ListGrouped(sCriteria as string = "", sOrder as string = "", sGroupBy as String = "") As Dictionary
		  dim jsMaster as New Dictionary
		  dim oRecordList() as DataFile.tbl_inventory
		  
		  If sGroupBy = "" Then
		    Return Nil
		  End If
		  
		  // Lets get the complete list of records from the database
		  oRecordList() = DataFile.tbl_inventory.List(sCriteria, sOrder)
		  
		  // now we need to loop through each one of the records and startp putting them in there place
		  dim sGroupByList() as string = sGroupBy.split(", ")
		  dim jsCurrent() as Dictionary
		  dim idx_record as integer
		  For Each oRecord as DataFile.tbl_inventory In oRecordList()
		    
		    jsCurrent.append( jsMaster)
		    
		    dim jsFieldValues as JSONItem = oRecord.GetMyFieldValues(True)
		    
		    
		    For idx1 as integer = 0 To sGroupByList.Ubound
		      
		      dim sGroupField as string = sGroupByList(idx1)
		      dim n3 as integer = jsCurrent.Ubound
		      dim sGroupValue as Variant =  jsFieldValues.Value(sGroupField)
		      
		      // Check if this record fits into any existing groups
		      dim sArray() as string
		      for Each vKey as Variant In jsCurrent(n3).Keys
		        sArray.Append( str( vKey ) )
		      Next
		      'If jsCurrent(n3).Keys.IndexOf( sGroupValue ) > -1 Then
		      If sArray.IndexOf( sGroupValue ) > -1 THen
		        ' there is a place for this record at this level
		        
		        ' now we check if the value of the current level group is a jsonitem, array, or s"none"
		        dim vjsonvalue as Variant = jsCurrent(n3).Value( sGroupValue )
		        If jsCurrent(n3).Value( sGroupValue ) IsA Dictionary Then
		          ' we must dig depper into jsonitems
		          
		          jsCurrent.Append( jsCurrent(n3).Value( sGroupValue ) )
		          Continue
		          
		          'Elseif jsCurrent(n3).Value( sGroupValue ) IsA DataFile.ActiveRecordBase Then
		        ElseIf vjsonvalue IsA ActiveRecordBase Then
		          ' we can put the record here
		          
		          
		          
		        Else
		          'ElseIf jsCurrent(n3).Value( sGroupValue ) IsA String THen
		          
		          #Pragma BreakOnExceptions Off
		          Try
		            // pull the array of records from the value
		            dim oRecords() as DataFile.tbl_inventory
		            oRecords() = jsCurrent(n3).Value(sGroupValue)
		            oRecords.Append(oRecord)
		            jsCurrent(n3).Value(sGroupValue) = oRecords
		            Continue
		          Exception
		            
		          End Try
		          #Pragma BreakOnExceptions Default
		          
		          If jsCurrent(n3).Value( sGroupValue ) = "none" THen
		            
		            // We need to check if this is the last group by field
		            If idx1 = sGroupByList.Ubound Then
		              // this is the last of the group by fields so we can put an array with this record in the value
		              dim oRecords() as DataFile.tbl_inventory
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
		Shared Function ListGroupedold(sCriteria as string = "", sOrder as string, iOffset as integer = -1) As Dictionary
		  // Returns a dictionary with keys as group names and values as an array of DataFile.tbl_inventory
		  
		  dim dictReturn as New Dictionary
		  
		  // Load the entire inventory into a varialbe
		  dim oItems() as DataFile.tbl_inventory
		  oItems() = DataFile.tbl_inventory.List(sCriteria, sOrder, iOffset)
		  
		  dim sOrderByFields() as String
		  dim sGroupField as String
		  
		  //Find the field that we are grouping by
		  '          It is the first field of the order by clause
		  sOrderByFields() = sOrder.split(",")
		  sGroupField = sOrderByFields(0)
		  
		  dim sCurrentGroupName as String
		  dim oCurrentGroup() as DataFile.tbl_inventory
		  
		  // Loop through the inventory
		  For each oItem as DataFile.tbl_inventory In oItems
		    dim jsFieldValues as JSONItem
		    
		    // Get the field value pairs as a json item of this item
		    jsFieldValues = oItem.GetMyFieldValues(True)
		    
		    // Check to see if the Current group name is the same as the one in this item
		    If jsFieldValues.Value(sGroupField) <> sCurrentGroupName then
		      ' The current group and the current item differ
		      
		      // Check if there is anything in the current group
		      If oCurrentGroup.Ubound <> -1 Then
		        ' The current group is not empty
		        
		        // Store the current group in the return dict
		        '          We have to make a copy of the Array otherwise we get right fucked
		        dim StupidDamnArrays() as DataFile.tbl_inventory
		        For Each oElement as DataFile.tbl_inventory In oCurrentGroup
		          StupidDamnArrays.Append(oElement)
		        Next
		        dictReturn.Value(sCurrentGroupName) = StupidDamnArrays
		        
		        // Clear the current group 
		        ReDim oCurrentGroup(-1)
		        
		        // update the current group name
		        sCurrentGroupName = jsFieldValues.Value(sGroupField)
		        
		      Else
		        sCurrentGroupName = jsFieldValues.Value(sGroupField)
		      End If
		      
		    End If
		    
		    // Add the current item to the current group array
		    oCurrentGroup.Append(oItem)
		    
		  Next
		  
		  If oCurrentGroup.Ubound <> -1 Then
		    dim StupidDamnArrays() as DataFile.tbl_inventory
		    For Each oElement as DataFile.tbl_inventory In oCurrentGroup
		      StupidDamnArrays.Append(oElement)
		    Next
		    dictReturn.Value(sCurrentGroupName) = oCurrentGroup
		  End If
		  
		  Return dictReturn
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		bhide As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		bitem_taxable As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		bphysical_item As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		sitem_barcode As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sitem_category As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sitem_department As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sitem_depth As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sitem_description As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sitem_height As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sitem_manufacturer As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sitem_model As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sitem_name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sitem_owner As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sitem_purchase_price As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sitem_quantity As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sitem_rental_price As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sitem_rfid_code As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sitem_sale_price As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sitem_serial_code As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sitem_status As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sitem_subcategory As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sitem_type As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sitem_weight As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sitem_width As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="bhide"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="bitem_taxable"
			Group="Behavior"
			Type="Boolean"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="bphysical_item"
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
			Name="sitem_barcode"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sitem_category"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sitem_department"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sitem_depth"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sitem_description"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sitem_height"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sitem_manufacturer"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sitem_model"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sitem_name"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sitem_owner"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sitem_purchase_price"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sitem_quantity"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sitem_rental_price"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sitem_rfid_code"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sitem_sale_price"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sitem_serial_code"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sitem_status"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sitem_subcategory"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sitem_type"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sitem_weight"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sitem_width"
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
