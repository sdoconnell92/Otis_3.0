#tag Class
Protected Class Base
	#tag Method, Flags = &h0
		Sub BeginTransaction()
		  
		  dim sql as string
		  dim db as SQLiteDatabase = DataFile.GetDB
		  
		  If db <> Nil Then
		    sql = "Begin Transaction;"
		    db.SQLExecute(sql)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Bind(ByRef ps as SQLitePreparedStatement, props() as Introspection.PropertyInfo, sColumnNames() as string)
		  
		  For i1 as integer = 0 To props.Ubound
		    dim p as Introspection.PropertyInfo = props(i1)
		    
		    dim sColumnType as string = p.PropertyType.FullName
		    dim sColumnName as string = Mid( p.Name, 2 )
		    dim iColumnPosition as integer = sColumnNames.IndexOf(sColumnName)
		    
		    If iColumnPosition <> -1 Then
		      Select Case sColumnType
		      Case "String"
		        ps.BindType(iColumnPosition, SQLitePreparedStatement.SQLITE_TEXT)
		        ps.Bind(iColumnPosition, p.Value(me).StringValue )
		      Case "Int32"
		        ps.BindType(iColumnPosition, SQLitePreparedStatement.SQLITE_INTEGER)
		        ps.Bind(iColumnPosition, p.Value(me).IntegerValue )
		      Case "Int64"
		        ps.BindType(iColumnPosition, SQLitePreparedStatement.SQLITE_INT64)
		        ps.Bind(iColumnPosition, p.Value(me).Int64Value )
		      Case "Boolean"
		        ps.BindType(iColumnPosition, SQLitePreparedStatement.SQLITE_BOOLEAN)
		        ps.Bind(iColumnPosition, p.Value(me).BooleanValue )
		      End Select
		    End If
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChangeMySavedValue(sFieldName as String, vValue as Variant)
		  dim props() as Introspection.PropertyInfo = Introspection.GetType(me).GetProperties
		  
		  For Each p as Introspection.PropertyInfo In props()
		    If Mid( p.Name, 2 ) = sFieldName Then
		      p.Value(me) = vValue
		      Save
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Variant
		  dim ty as Introspection.TypeInfo = Introspection.GetType( self )
		  dim oConstructor as Introspection.ConstructorInfo
		  
		  For Each o as Introspection.ConstructorInfo In ty.GetConstructors
		    oConstructor = o
		  Next
		  
		  dim oClone as Base
		  dim vSelf as Variant = self
		  
		  If oConstructor <> Nil Then
		    oClone = oConstructor.Invoke( Array(vSelf) )
		  End If
		  
		  If oClone <> Nil Then
		    
		    ' Copy the Properties over
		    dim OldProps() as Introspection.PropertyInfo = Introspection.GetType(self).GetProperties
		    dim NewProps() as Introspection.PropertyInfo = Introspection.GetType(oClone).GetProperties
		    
		    For Each OldP as Introspection.PropertyInfo in OldProps()
		      
		      If OldP.IsPublic And OldP.Name <> "suuid" And OldP.Name <> "ipkid" Then
		        ' this is a column and not the uuid
		        
		        For Each NewP as Introspection.PropertyInfo in NewProps()
		          If NewP.Name = OldP.Name Then
		            NewP.Value(oClone) = OldP.Value(me)
		          End If
		        Next
		        
		      End If
		      
		    Next
		    
		    oClone.UpdateSavedValues
		    
		    Return oClone
		    
		  End If
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CommitTransaction()
		  
		  dim sql as string
		  dim db as SQLiteDatabase = app.db
		  
		  If db <> Nil Then
		    sql = "Commit;"
		    db.SQLExecute(sql)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		  dictSavedValues = New Dictionary
		  UpdateSavedValues
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Delete()
		  dim sql as string
		  dim db as SQLiteDatabase = DataFile.GetDB
		  dim ps as SQLitePreparedStatement
		  
		  BeforeDelete
		  
		  sql = "Delete From " + GetTableName + " Where uuid = ? ;"
		  
		  BeginTransaction
		  
		  ps = db.Prepare(sql)
		  ps.BindType(0,SQLitePreparedStatement.SQLITE_TEXT)
		  ps.bind(0,GetID)
		  
		  ps.SQLExecute
		  If db.Error Then
		    ErrManage("Base.Delete", "Could not delete record: " + db.ErrorMessage )
		    RollbackTransaction
		    Return
		  End If
		  
		  CommitTransaction
		  
		  AfterDelete
		  
		  Return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetID() As String
		  
		  dim props() as Introspection.PropertyInfo = Introspection.GetType(me).GetProperties
		  
		  For Each p as Introspection.PropertyInfo In props()
		    If p.Name = "suuid" Then
		      Return p.Value(me).StringValue
		    End If
		  Next
		  
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMyFieldValues(UnModifiedFields as Boolean = False) As JSONItem
		  dim jsItem as New JSONItem
		  dim props() as Introspection.PropertyInfo = Introspection.GetType(me).GetProperties
		  
		  If Not UnModifiedFields Then
		    If IsModified Then
		      
		    End If
		  End If
		  
		  For Each p as Introspection.PropertyInfo In props()
		    If p.IsPublic Then
		      dim sColumnName as string = Mid( p.Name, 2 )
		      If Not UnModifiedFields And sModifiedFields.IndexOf( sColumnName ) > -1 Then
		        jsItem.Value(sColumnName) = p.Value(me)
		      ElseIf UnModifiedFields Then
		        ' this is a column
		        jsItem.Value( sColumnName ) = p.Value(me)
		      End If
		    End If
		  Next
		  
		  Return jsItem
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTableName() As String
		  dim tableInfo as Introspection.TypeInfo = Introspection.GetType(me)
		  dim sTableName as string = tableInfo.Name
		  Return sTableName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Insert()
		  dim db as SQLiteDatabase = DataFile.GetDB
		  dim sql as string
		  dim ars() as String
		  dim ps as SQLitePreparedStatement
		  
		  BeforeCreate
		  
		  dim props() as Introspection.PropertyInfo = Introspection.GetType(me).GetProperties
		  dim tableInfo as Introspection.TypeInfo = Introspection.GetType(me)
		  dim sTableName as string = tableInfo.Name
		  dim sColumnNames() as String
		  dim sColumnTypes() as String
		  
		  For i1 as integer = props.Ubound DownTo 0
		    dim p as Introspection.PropertyInfo = props(i1)
		    If p.IsPublic Then
		      sColumnNames.Append( Mid( p.Name, 2 ) )
		      sColumnTypes.Append( p.PropertyType.FullName )
		    Else
		      props.Remove(i1)
		    End If
		  Next
		  
		  // Create some placeholders
		  dim sPlaceHolders() as String
		  For i1 as integer = 0 To sColumnNames.Ubound
		    sPlaceHolders.Append( "?" )
		  Next
		  
		  ars.Append( "Insert Into " + sTableName )
		  ars.Append( "(" + Join( sColumnNames, "," ) + ")" )
		  ars.Append( "Values(" + Join(sPlaceHolders, ",") + ")" )
		  
		  sql = Join( ars, " " ) + ";"
		  
		  BeginTransaction
		  
		  ps = db.Prepare(sql)
		  
		  Bind( ps, props(), sColumnNames() )
		  
		  ps.SQLExecute
		  If db.Error Then
		    ErrManage("Base.Insert", "Could not insert record: " + db.ErrorMessage )
		    RollbackTransaction
		    Return
		  End If
		  
		  CommitTransaction
		  
		  AfterCreate
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsModified() As Boolean
		  dim bModified as Boolean
		  redim sModifiedFields(-1)
		  
		  dim props() as Introspection.PropertyInfo = Introspection.GetType(me).GetProperties
		  
		  For Each p as Introspection.PropertyInfo In props()
		    If p.IsPublic Then
		      dim sColumnName as String = Mid( p.Name, 2 )
		      
		      If dictSavedValues.Value(sColumnName) <> p.Value(me) Then
		        bModified = True
		        sModifiedFields.Append(sColumnName)
		      End If
		    End If
		    
		  Next
		  
		  Return bModified
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IsNew() As Boolean
		  If GetID = "" Then Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReadRecord(rs as RecordSet)
		  dictSavedValues = New Dictionary
		  
		  dim props() as Introspection.PropertyInfo = Introspection.GetType(me).GetProperties
		  
		  For Each p as Introspection.PropertyInfo In props()
		    If p.IsPublic Then
		      'This is a column
		      dim sColumnName as String = Mid( p.Name, 2 )
		      
		      Select Case p.PropertyType.FullName
		      Case "String"
		        p.Value(me) = rs.Field(sColumnName).StringValue
		        dictSavedValues.Value(sColumnName) = p.Value(me).StringValue
		      Case "Int32"
		        p.Value(me) = rs.Field(sColumnName).IntegerValue
		        dictSavedValues.Value(sColumnName) = p.Value(me).IntegerValue
		      Case "Int64"
		        p.Value(me) = rs.Field(sColumnName).Int64Value
		        dictSavedValues.Value(sColumnName) = p.Value(me).Int64Value
		      Case "Boolean"
		        p.Value(me) = rs.Field(sColumnName).BooleanValue
		        dictSavedValues.Value(sColumnName) = p.Value(me).BooleanValue
		      End Select
		      
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RollbackTransaction()
		  
		  dim sql as string
		  dim db as SQLiteDatabase = app.db
		  
		  If db <> Nil Then
		    sql = "Rollback;"
		    db.SQLExecute(sql)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Save()
		  
		  BeforeSave
		  
		  If IsNew Then
		    Insert
		  Else
		    Update
		  End If
		  
		  AfterSave
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TableName() As String
		  dim ti as Introspection.TypeInfo = Introspection.GetType(me)
		  Return ti.Name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Update()
		  dim db as SQLiteDatabase = DataFile.GetDB
		  dim sql as string
		  dim ars() as string
		  dim ps as SQLitePreparedStatement
		  
		  If Not IsModified Then
		    Return
		  End If
		  
		  BeforeUpdate
		  
		  dim props() as Introspection.PropertyInfo = Introspection.GetType(me).GetProperties
		  dim tableInfo as Introspection.TypeInfo = Introspection.GetType(me)
		  dim sTableName as string = tableInfo.Name
		  dim sColumnNames() as String
		  dim sColumnTypes() as String
		  dim sNamePlaceHoldersPairs() as String
		  dim sID as string
		  
		  // Filter out any columns that are not modified
		  For i1 as integer = props.Ubound DownTo 0
		    dim p as Introspection.PropertyInfo = props(i1)
		    dim sColumnName as string = Mid( p.Name, 2 )
		    If sColumnName = "uuid" Then
		      sID = p.Value(me).StringValue
		    End If
		    If sModifiedFields.IndexOf( sColumnName ) = -1 Then
		      props.Remove(i1)
		    Else
		      sColumnNames.Append(sColumnName)
		      sColumnTypes.Append(p.PropertyType.FullName)
		      sNamePlaceHoldersPairs.Append( sColumnName + " = ?" )
		    End If
		  Next
		  
		  ars.Append( "Update " + sTableName )
		  ars.Append( "Set " + Join(sNamePlaceHoldersPairs, ",") )
		  ars.Append( "Where uuid = ?" )
		  
		  BeginTransaction
		  
		  sql = Join( ars, " " ) + ";"
		  ps = db.Prepare(sql)
		  
		  Bind(ps, props(), sColumnNames() )
		  
		  ps.BindType(props.Ubound + 1, SQLitePreparedStatement.SQLITE_TEXT )
		  ps.Bind(props.Ubound + 1, sID )
		  
		  ps.SQLExecute
		  If db.Error Then
		    ErrManage("Base.Update", "Could not update record: " + db.ErrorMessage )
		    RollbackTransaction
		    Return
		  End If
		  
		  CommitTransaction
		  
		  AfterUpdate
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateSavedValues()
		  dictSavedValues = New Dictionary
		  
		  dim props() as Introspection.PropertyInfo = Introspection.GetType(me).GetProperties
		  
		  For Each p as Introspection.PropertyInfo In props()
		    If p.IsPublic Then
		      'This is a column
		      dim sColumnName as String = Mid( p.Name, 2 )
		      
		      Select Case p.PropertyType.FullName
		      Case "String"
		        dictSavedValues.Value(sColumnName) = p.Value(me).StringValue
		      Case "Int32"
		        dictSavedValues.Value(sColumnName) = p.Value(me).IntegerValue
		      Case "Int64"
		        dictSavedValues.Value(sColumnName) = p.Value(me).Int64Value
		      Case "Boolean"
		        dictSavedValues.Value(sColumnName) = p.Value(me).BooleanValue
		      End Select
		      
		    End If
		  Next
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event AfterCreate()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event AfterDelete()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event AfterSave()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event AfterUpdate()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event BeforeCreate()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event BeforeDelete()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event BeforeSave()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event BeforeUpdate()
	#tag EndHook


	#tag Property, Flags = &h1
		Protected dictSavedValues As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected oChangeDescription As JSONItem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected sModifiedFields() As String
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
