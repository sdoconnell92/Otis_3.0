#tag Class
Protected Class RecordStorageClass
	#tag Method, Flags = &h0
		Sub Constructor()
		  oRowData = New lbData
		  oPrintData = New printData
		  oPrintData.oParent = me
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FolderLevel() As Integer
		  
		  // Check to see if we have a parent
		  If oParentStor <> Nil Then
		    Return oParentStor.FolderLevel + 1
		  Else
		    Return 0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetCellTypes(sRowType as String, dictCellTypes as Dictionary) As Integer()
		  
		  If dictCellTypes .Keys.IndexOf(sRowType) <> -1 Then
		    Return dictCellTypes.Value(sRowType)
		  End If
		  Return dictCellTypes.Value("GrandParent")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetFieldNames(sRowType as String, dictFieldNames as Dictionary) As String()
		  
		  If dictFieldNames.Keys.IndexOf(sRowType) <> -1 Then
		    Return dictFieldNames.Value(sRowType)
		  End If
		  Return dictFieldNames.Value("GrandParent")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function JoinedGroupStructure() As String
		  Return Join(arsGroupStructure, ".")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PopulateCellTypes(ariColumnTypes() as Integer)
		  
		  oRowData.ariColumnTypes = ariColumnTypes()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PopulateColumnValues(arsFieldNames() as String, ariCellTypes() as Integer)
		  If StorType = "GroupFolder" or StorType = "LinkedFolder" Then
		    oRowData.arsColumnValues.Append(sFolderName)
		  ElseIf StorType = "GrandParent" or StorType.InStr("Child -") > 0 Then
		    
		    dim jsFieldValues as JSONItem = oTableRecord.GetMyFieldValues(True)
		    dim sTableName as String = oTableRecord.GetTableName
		    
		    redim oRowData.arsColumnValues(-1)
		    
		    For Each sFieldName as String In arsFieldNames
		      dim sDBDotNotation as String
		      dim sFTable, sFField as string
		      
		      // Check if our field name is already in table.field format
		      dim dotIndex as Integer = sFieldName.InStr( "." )
		      If dotIndex <> 0 Then
		        'this is already in dotnotation
		        sDBDotNotation = sFieldName
		        dim s1() as string = sFieldName.Split(".")
		        sFTable = s1(0)
		        sFField = s1(1)
		      Else
		        sDBDotNotation = sTableName + "." + sFieldName
		        sFField = sFieldName
		        sFTable = sTableName
		      End If
		      
		      // Check that the field actually exists
		      If jsFieldValues.Names.IndexOf( sFField ) <> -1 Then
		        ' the field exists
		        
		        dim sValue as String = jsFieldValues.Value( sFField )
		        sValue = str( sValue, modFieldFormatting.GetFormattingString( sDBDotNotation ) )
		        
		        oRowData.arsColumnValues.Append( sValue )
		        
		      End If
		      
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PopulateFieldNames(arsFieldNames() as string)
		  
		  oRowData.arsFieldNames = arsFieldNames()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PopulateLbData(dictFieldNames as Dictionary, dictCellTypes as Dictionary)
		  dim arsFieldNames() as String
		  dim ariCellTypes() as Integer
		  
		  
		  // Get the cell types and field names
		  If isFolder And Not isChild And Not isLinker And Not isRecord Then
		    // This Stor is a Group Folder
		    arsFieldNames() = GetFieldNames( "GroupFolder", dictFieldNames )
		    ariCellTypes() = GetCellTypes( "GroupFolder", dictCellTypes )
		  ElseIf Not isChild And Not isLinker And isRecord Then
		    // This is a Grandparent
		    arsFieldNames() = GetFieldNames( "GrandParent", dictFieldNames )
		    ariCellTypes() = GetCellTypes( "GrandParent", dictCellTypes )
		  ElseIf isFolder And isChild And isLinker And Not isRecord Then
		    // This is a linked Folder
		    arsFieldNames() = GetFieldNames( "LinkedFolder", dictFieldNames )
		    ariCellTypes() = GetCellTypes( "LinkedFolder", dictCellTypes )
		  ElseIf isChild And Not isLinker And isRecord Then
		    // This is a Child Record
		    dim s1 as string = "Child - " + oParentStor.sFolderName
		    arsFieldNames() = GetFieldNames( s1, dictFieldNames )
		    ariCellTypes() = GetCellTypes( s1, dictCellTypes )
		  End If
		  
		  
		  // Start populating the column values based on field names and types
		  PopulateColumnValues(arsFieldNames, ariCellTypes)
		  PopulateCellTypes(ariCellTypes)
		  PopulateFieldNames(arsFieldNames)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PopulatePrintColumnValues(arsFieldNames() as String)
		  If StorType = "GroupFolder" or StorType = "LinkedFolder" Then
		    oPrintData.arsColumnValues.Append(sFolderName)
		  ElseIf StorType = "GrandParent" or StorType.InStr("Child -") > 0 Then
		    
		    dim jsFieldValues as JSONItem = oTableRecord.GetMyFieldValues(True)
		    dim sTableName as String = oTableRecord.GetTableName
		    
		    redim oPrintData.arsColumnValues(-1)
		    
		    For Each sFieldName as String In arsFieldNames
		      dim sDBDotNotation as String
		      dim sFTable, sFField as string
		      
		      // Check if our field name is already in table.field format
		      dim dotIndex as Integer = sFieldName.InStr( "." )
		      If dotIndex <> 0 Then
		        'this is already in dotnotation
		        sDBDotNotation = sFieldName
		        dim s1() as string = sFieldName.Split(".")
		        sFTable = s1(0)
		        sFField = s1(1)
		      Else
		        sDBDotNotation = sTableName + "." + sFieldName
		        sFField = sFieldName
		        sFTable = sTableName
		      End If
		      
		      // Check that the field actually exists
		      If jsFieldValues.Names.IndexOf( sFField ) <> -1 Then
		        ' the field exists
		        
		        dim sValue as String = jsFieldValues.Value( sFField )
		        sValue = str( sValue, modFieldFormatting.GetFormattingString( sDBDotNotation ) )
		        
		        oPrintData.arsColumnValues.Append( sValue )
		        
		      End If
		      
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PopulatePrintData(dictFieldNames as Dictionary, oParentStory as LineItemStory)
		  dim arsFieldNames() as String
		  
		  
		  // Get the cell types and field names
		  Select Case StorType
		  Case "GroupFolder"
		    // This Stor is a Group Folder
		    arsFieldNames() = GetFieldNames( "GroupFolder", dictFieldNames )
		  Case "GrandParent"
		    // This is a Grandparent
		    arsFieldNames() = GetFieldNames( "GrandParent", dictFieldNames )
		  Case "LinkedFolder"
		    // This is a linked Folder
		    arsFieldNames() = GetFieldNames( "LinkedFolder", dictFieldNames )
		  Else
		    If StorType.InStr("Child -") > 0 Then
		      // This is a Child Record
		      dim s1 as string = "Child - " + oParentStor.sFolderName
		      arsFieldNames() = GetFieldNames( s1, dictFieldNames )
		    End If
		  End Select
		  
		  
		  // Start populating the column values based on field names and types
		  PopulatePrintColumnValues(arsFieldNames)
		  PopulatePrintFieldNames(arsFieldNames)
		  
		  oPrintData.oParentStory = oParentStory
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PopulatePrintFieldNames(arsFieldNames() as string)
		  
		  oRowData.arsFieldNames = arsFieldNames()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StorType() As String
		  dim sRet as string
		  
		  if isFolder and not isChild and not isLinker and not isRecord Then
		    sRet = "GroupFolder"
		  ElseIf not isChild and not isLinker and isRecord Then
		    sRet = "GrandParent"
		  ElseIf isFolder and isChild and isLinker and not isRecord Then
		    sRet = "LinkedFolder"
		  ElseIf isChild and not isLinker and isRecord Then
		    sRet = "Child"
		  end if
		  
		  Return sRet
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		aroChildren() As RecordStorageClass
	#tag EndProperty

	#tag Property, Flags = &h0
		arsGroupStructure() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		isChild As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		isFolder As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		isLinker As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		isRecord As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		oLinkRecord As DataFile.ActiveRecordBase
	#tag EndProperty

	#tag Property, Flags = &h0
		oParentStor As RecordStorageClass
	#tag EndProperty

	#tag Property, Flags = &h0
		oPrintData As printData
	#tag EndProperty

	#tag Property, Flags = &h0
		oRowData As lbData
	#tag EndProperty

	#tag Property, Flags = &h0
		oTableRecord As DataFile.ActiveRecordBase
	#tag EndProperty

	#tag Property, Flags = &h0
		sFolderName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sUUID As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isChild"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isFolder"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isLinker"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isRecord"
			Group="Behavior"
			Type="Boolean"
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
			Name="sFolderName"
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
			Name="sUUID"
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
