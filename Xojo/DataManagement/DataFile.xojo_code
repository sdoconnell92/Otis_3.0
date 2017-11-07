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
		  dim rd as New ResourceDirectories
		  dim db as New SQLiteDatabase
		  db.DatabaseFile = rd.otis_data_file.FilePath
		  
		  If db.Connect THen
		    Return db
		  End If
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Copy(Extends arsSource() as String) As String()
		  dim retS() as string
		  For Each s as string In arsSource()
		    retS.Append(s)
		  Next
		  Return retS()
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
		Protected Sub GetChildren(oStor as RecordStorageClass)
		  
		  If oStor.oTableRecord = Nil Then
		    Return
		  End If
		  
		  // Start by pulling the table record from the storage class
		  dim oRecord as DataFile.ActiveRecordBase = oStor.oTableRecord
		  dim sTableName as String = oRecord.GetTableName
		  
		  dim aroLinkRecords() as DataFile.tbl_internal_linking = DataFile.tbl_internal_linking.List("fk_parent = '" + oRecord.suuid + "' And fk_table_name = '" + sTableName + "'")
		  If aroLinkRecords.Ubound <> -1 Then
		    oStor.isFolder = True
		  End If
		  
		  // Loop through each link record
		  dim oParentStor as RecordStorageClass = oStor
		  For iLinkIndex as Integer = 0 To aroLinkRecords.Ubound
		    dim oLinkRecord as DataFile.tbl_internal_linking = aroLinkRecords(iLinkIndex)
		    
		    // Check if the link record actually relates to a child
		    If oLinkRecord.sfk_child <> "" Then
		      
		      // Check if this child has a link type to the parent
		      If oLinkRecord.slink_type <> "" Then
		        
		        // Check if there is already a link stor for this link type
		        dim x1 as integer = oStor.aroChildren.IndexOfFolderName(oLinkRecord.slink_type)
		        If x1 <> -1 Then
		          ' a link stor already exists
		          oParentStor = oStor.aroChildren(x1)
		        Else
		          ' a link stor does not exist
		          // Create a Stor class for the link type
		          dim oLinkStor as New RecordStorageClass
		          oLinkStor.isChild = True
		          oLinkStor.isFolder = True
		          oLinkStor.isLinker = True
		          oLinkStor.isRecord = False
		          oLinkStor.sFolderName = oLinkRecord.slink_type
		          oLinkStor.oParentStor = oParentStor
		          
		          oParentStor = oLinkStor
		        End If
		      Else
		        oParentStor = oStor
		      End If
		      
		      // Get all of the methods from the mothertable
		      dim ariMi() as Xojo.Introspection.MethodInfo = Xojo.Introspection.GetType(oRecord).Methods
		      // Loop through each method we found
		      For Each mi as Xojo.Introspection.MethodInfo In ariMi()
		        
		        // Check if this method is findByID
		        If mi.Name = "FindByID" Then
		          // Set up the parameter
		          dim aUUID as Auto = oLinkRecord.sfk_child
		          // Grab the actual child record from mothertable
		          dim aChildRecord as Auto = mi.Invoke(oRecord, Array(aUUID))
		          
		          If aChildRecord <> Nil Then
		            // Create a new stor class
		            dim oNewStor as New RecordStorageClass
		            dim oChildRecord as DataFile.ActiveRecordBase
		            oChildRecord = aChildRecord
		            
		            oNewStor.oTableRecord = oChildRecord
		            oNewStor.oLinkRecord = oLinkRecord
		            oNewStor.isChild = True
		            oNewStor.isRecord = True
		            oNewStor.oParentStor = oParentStor
		            oNewStor.sUUID = oNewStor.oTableRecord.suuid
		            
		            // Get the children of this child record
		            GetChildren(oNewStor)
		            
		            // Add this storage class to the child array
		            oParentStor.aroChildren.Append(oNewStor) 
		          End If
		        End If
		      Next
		    End If
		  Next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetDB() As SQLiteDatabase
		  Return app.db
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetNewUUID() As String
		  Dim crypt As New Chilkat.Crypt2
		  
		  Dim uuid As String
		  uuid = crypt.GenerateUuid()
		  
		  Return uuid
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetNextEIPLNumber(EIPLUUID as String) As Integer
		  dim db1 as PostgreSQLDatabase = app.RegDB
		  dim EIPLNumber as integer
		  
		  
		  If db1 <> Nil And App.bOnline Then
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

	#tag Method, Flags = &h1
		Protected Function GroupRecords(aroStors() as RecordStorageClass, sGroupBy as String) As RecordStorageClass()
		  dim oMaster() as RecordStorageClass
		  
		  // Check if there is a specified field to group by
		  If sGroupBy = "" Then
		    // Exit the method since we have nothing to group by
		    Return Nil
		  End If
		  
		  dim arsGroupFields() as String = sGroupBy.Split(",")
		  For Each oRecordStor as RecordStorageClass In aroStors()
		    
		    dim iLev as integer
		    
		    // Get the fields and values out of the record
		    dim jsFieldValues as JSONItem = oRecordStor.oTableRecord.GetMyFieldValues(True)
		    dim arsGroupStructure() as String
		    
		    dim aroCurrent() as RecordStorageClass = oMaster()
		    dim arsGroupStIndexofAdded as integer = - 1
		    // Loop through the list of fields we are grouping by
		    For i1 as integer = 0 To arsGroupFields.Ubound
		      dim bLastField as Boolean
		      If i1 = arsGroupFields.Ubound Then bLastField = True
		      dim sFieldName as String = arsGroupFields(i1)
		      
		      // Check to make sure this field exists in the record
		      If jsFieldValues.Names.IndexOf(sFieldName) = -1 Then
		        // The field you are looking for does not exist
		        
		        // Add a field of this name to the json items with a <none> Tag
		        jsFieldValues.Value(sFieldName) = "<none>"
		      End If
		      
		      dim sFieldValue as String = jsFieldValues.Value(sFieldName).StringValue
		      
		      If i1 <> arsGroupStIndexofAdded Then
		        // Add this group to the group structure
		        arsGroupStructure.Append(sFieldValue)
		        arsGroupStIndexofAdded = i1
		      End If
		      
		      
		      // Check if any of the Storage classes have the same value as the current record
		      dim iMatchIndex as Integer = aroCurrent.IndexOfFolderName(sFieldValue)
		      If iMatchIndex <> -1 Then
		        // There is a match for this field value 
		        
		        // Check if we are on the last grouping field or if we need to go deeper
		        If bLastField Then
		          ' we are on the last field
		          // Add the current record to the children of this category
		          oRecordStor.oParentStor = aroCurrent(iMatchIndex)
		          oRecordStor.arsGroupStructure = arsGroupStructure.Copy
		          oRecordStor.iLevel = iLev
		          aroCurrent(iMatchIndex).aroChildren.Append(oRecordStor)
		          Exit
		          
		        Else
		          ' we are not on last field 
		          
		          // Set aroCurrent to the child array of this storage class
		          aroCurrent() = aroCurrent(iMatchIndex).aroChildren
		          iLev = iLev + 1
		          Continue
		        End If
		        
		      Else
		        // There is no match for this field value
		        
		        // Create a New stor class for this field value
		        dim oNewStor as New RecordStorageClass
		        oNewStor.sFolderName = sFieldValue
		        oNewStor.arsGroupStructure = arsGroupStructure.Copy
		        oNewStor.isFolder = True
		        oNewStor.iLevel = iLev
		        aroCurrent.Append(oNewStor)
		        
		        // Reset the group field index back one so we can match the field value to this new class in the next loop
		        i1 = i1 - 1
		        Continue
		      End If
		      
		    Next
		    
		  Next
		  
		  Return oMaster
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function JoinSQL(extends ars() as string) As String
		  Return join(ars, " ")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub PopulateListWithChildren(aroStor() as RecordStorageClass)
		  
		  // Loop through all of the storage records in the array
		  For Each oStor as RecordStorageClass In aroStor()
		    GetChildren(oStor)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function StorifyRecords(oRecords() as DataFile.ActiveRecordBase) As RecordStorageClass()
		  dim aroStors() as RecordStorageClass
		  
		  For Each oRecord as DataFile.ActiveRecordBase In oRecords
		    
		    dim oStor as New RecordStorageClass
		    oStor.oTableRecord = oRecord
		    oStor.isChild = False
		    oStor.isRecord = True
		    oStor.sUUID = oRecord.suuid
		    
		    aroStors.Append(oStor)
		    
		  Next
		  
		  Return aroStors()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StorifyRecords(oRecord as DataFile.ActiveRecordBase) As RecordStorageClass
		  dim aro() as DataFile.ActiveRecordBase
		  aro.Append( oRecord )
		  dim aroStor() as RecordStorageClass = StorifyRecords(aro)
		  Return aroStor(0)
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
