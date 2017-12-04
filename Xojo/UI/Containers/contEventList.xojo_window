#tag Window
Begin ContainerControl contEventList
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   300
   HelpTag         =   ""
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
   LockLeft        =   False
   LockRight       =   False
   LockTop         =   False
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   False
   Visible         =   True
   Width           =   498
   Begin entListbox lbEvents
      AcceptFocus     =   False
      AcceptTabs      =   True
      AutoDeactivate  =   True
      BackColor       =   &cFFFF00FF
      Backdrop        =   0
      CellBackColor   =   &cFFFF00FF
      Enabled         =   True
      EraseBackground =   True
      GridLinesColor  =   &c00000000
      HasBackColor    =   False
      HasHeading      =   True
      Height          =   268
      HelpTag         =   ""
      InitialParent   =   ""
      Left            =   3
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   29
      Transparent     =   True
      UseFocusRing    =   False
      Visible         =   True
      Width           =   492
   End
   Begin SearchControl scSearchField
      AutoDeactivate  =   True
      Enabled         =   True
      HasCancelButton =   True
      HasMenu         =   False
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   360
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacBorderStyle  =   0
      PlaceHolderText =   ""
      Scope           =   0
      SendSearchStringImmediately=   False
      SendWholeSearchString=   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      Top             =   3
      Visible         =   True
      Width           =   135
   End
   Begin CheckBox chbShowHidden
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Show Hidden"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   260
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      State           =   0
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   4
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   100
   End
   Begin entRefreshButton pbRefresh
      AcceptFocus     =   True
      AutoDeactivate  =   True
      BackColor       =   &c00000000
      Bevel           =   0
      Bold            =   False
      ButtonType      =   0
      Caption         =   ""
      CaptionAlign    =   3
      CaptionDelta    =   0
      CaptionPlacement=   1
      Enabled         =   True
      HasBackColor    =   False
      HasMenu         =   0
      Height          =   24
      HelpTag         =   ""
      Icon            =   277895167
      IconAlign       =   1
      IconDX          =   0
      IconDY          =   0
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   3
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MenuValue       =   0
      Scope           =   0
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   3
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   30
   End
   Begin entAddButton pbAdd
      AcceptFocus     =   True
      AutoDeactivate  =   True
      BackColor       =   &c00000000
      Bevel           =   0
      Bold            =   False
      ButtonType      =   0
      Caption         =   ""
      CaptionAlign    =   3
      CaptionDelta    =   0
      CaptionPlacement=   1
      Enabled         =   True
      HasBackColor    =   False
      HasMenu         =   0
      Height          =   24
      HelpTag         =   ""
      Icon            =   633014271
      IconAlign       =   1
      IconDX          =   0
      IconDY          =   0
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   34
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MenuValue       =   0
      Scope           =   0
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   2
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   30
   End
   Begin entSortButton pbSort
      AcceptFocus     =   True
      AutoDeactivate  =   True
      BackColor       =   &c00000000
      Bevel           =   0
      Bold            =   False
      ButtonType      =   0
      Caption         =   ""
      CaptionAlign    =   3
      CaptionDelta    =   0
      CaptionPlacement=   1
      Enabled         =   True
      HasBackColor    =   False
      HasMenu         =   0
      Height          =   24
      HelpTag         =   ""
      Icon            =   1215768575
      IconAlign       =   1
      IconDX          =   0
      IconDY          =   0
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   65
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MenuValue       =   0
      Scope           =   0
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   2
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   30
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function MouseWheel(X As Integer, Y As Integer, DeltaX as Integer, DeltaY as Integer) As Boolean
		  
		  
		  Return methHandleMouseWheel(X,Y,DeltaX,DeltaY)
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
		  
		  // Set all the settings up for our listbox
		  methListboxSettings
		  
		  evdefOpen
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function methAcquireRecords(oSQLStor as SQLStorageClass, sGroupBy as String, bGetChildren as Boolean = False, bGroupRecords as Boolean = False) As RecordStorageClass()
		  
		  
		  // First get a list of all records
		  dim aroRecords() as DataFile.ActiveRecordBase = DataFile.tbl_events.List( oSQLStor.oPS )
		  
		  // Storify the records
		  dim aroStor() as RecordStorageClass = DataFile.StorifyRecords( aroRecords )
		  
		  // Check if we need to get the children
		  If bGetChildren Then DataFile.PopulateListWithChildren( aroStor() )
		  
		  // Check if we need to group the records
		  If bGroupRecords Then aroStor() = DataFile.GroupRecords( aroStor(), sGroupBy )
		  
		  Return aroStor
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub methAddEvent()
		  '!@! Table Dependent !@!
		  
		  // Create the new record
		  dim oNew as New DataFile.tbl_events  '!@! Table Dependent !@!
		  oNew.sevent_name = "-"  '!@! Table Dependent !@!
		  dim oStor as RecordStorageClass = DataFile.StorifyRecords(oNew)
		  
		  
		  methOpenRecordInTab(oStor)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function methBuildSQL(bShowHidden as Boolean, sSearchString as String, sOrderBy as String) As SQLStorageClass
		  dim aroSQL() as String
		  dim arsConditions() as String
		  dim arsOrderBy() as String
		  dim ariTypes() as Integer
		  dim arvValue() as Variant
		  
		  // Add the base sql
		  aroSQL.Append( DataFile.tbl_events.BaseSQL )
		  
		  
		  // Build condition array
		  ' Build Search Condition
		  If sSearchString <> "" Then
		    arsConditions.Append( "event_name Like ?" )
		    ariTypes.Append( SQLitePreparedStatement.SQLITE_TEXT )
		    arvValue.Append( "%" + sSearchString + "%" )
		  End If
		  
		  ' Build the Hidden Items Condition
		  If bShowHidden Then
		  Else
		    arsConditions.Append( "(hide <> 1 Or hide Is Null)" )
		  End If
		  
		  If arsConditions.Ubound <> -1 Then
		    aroSQL.Append( "Where" )
		    aroSQL.Append( Join(arsConditions, " And ") )
		  End If
		  
		  // Build OrderBy String
		  If sOrderBy <> "" Then
		    aroSQL.Append( "Order By" )
		    aroSQL.Append( sOrderBy )
		  End If
		  
		  aroSQL.Append(";")
		  
		  // Join the sql into one string
		  dim sSQL as String
		  sSQL = aroSQL.JoinSQL
		  
		  // Put all of this into a sql Storage Class
		  dim oSQLStor as New SQLStorageClass
		  oSQLStor.sSQL = sSQL
		  oSQLStor.ariTypes = ariTypes
		  oSQLStor.arvValues = arvValue
		  
		  // Prepare a statement
		  oSQLStor.PrepareStatement
		  
		  Return oSQLStor
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub methExpandAllRows(JustTopLevel as Boolean = True)
		  dim lb1 As entListbox = methGetListbox
		  
		  // Loop through all the rows
		  dim i1 as integer
		  While i1 < lb1.ListCount 
		    
		    dim oRowData as RecordStorageClass
		    
		    // extract the rowtag
		    oRowData = lb1.RowTag(i1)
		    
		    // Chgeck if its a folder
		    If lb1.RowIsFolder(i1) Then
		      
		      // Check if its a top level folder
		      Select Case oRowData.FolderLevel
		      Case 0 
		        lb1.Expanded(i1) = True
		      Else
		        If Not JustTopLevel Then
		          lb1.Expanded(i1) = True
		        End If
		      End Select
		      
		    End If
		    
		    i1 = i1 + 1
		    
		  Wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function methGetListbox() As entListbox
		  '!@! Table Dependent !@!
		  Return lbEvents
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub methHandleCellAction(row as integer, column as integer)
		  dim lb as entListbox = methGetListbox
		  
		  If lb.CellType(row,column) = 2 Then
		    'its a checkbox
		    
		    // Get the state of the checkbox
		    dim CheckBoxState as CheckBox.CheckedStates
		    CheckBoxState = lb.CellState(row,column)
		    
		    // Pull the rowtag
		    dim oStor as RecordStorageClass
		    oStor = lb.RowTag(row)
		    
		    // Check if there is a record here
		    If oStor.oTableRecord <> Nil Then
		      
		      dim bValue as Boolean
		      Select Case CheckBoxState
		      Case CheckBox.CheckedStates.Checked
		        bValue = True
		      Else
		        bValue = False
		      End Select
		      
		      oStor.oTableRecord.ChangeMySavedValue( oStor.oRowData.arsFieldNames(column), bValue )
		      
		    End If
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub methHandleCellLostFocus(row as integer, col as integer)
		  dim lb as entListbox = methGetListbox
		  
		  If lb.CellType(row,col) = 3 Then
		    ' it's a text edit
		    
		    // Get the storage class from the rowtag
		    dim oStor as RecordStorageClass = lb.RowTag(row)
		    
		    // Check if there is a table record in this class
		    If oStor.oTableRecord <> Nil Then
		      
		      // Grab the value of the cell
		      dim vValue as Variant = lb.Cell(row,col)
		      
		      // Get the field values
		      dim jsFieldValues as JSONItem = oStor.oTableRecord.GetMyFieldValues(True)
		      
		      // Check if our field name is already in table.field format
		      dim sFieldName as string = oStor.oRowData.arsFieldNames(col)
		      dim sTableName as String = oStor.oTableRecord.GetTableName
		      dim sDBDotNotation as String
		      dim sFTable, sFField as string
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
		        Select Case VarType( jsFieldValues.Value(sFField) )
		        Case 2 'int32
		          vValue = val(vValue)
		        Case 3 'int64
		          vValue = val(vValue)
		        Case 8 'string
		        Case 37 'text
		        End Select
		        
		        oStor.oTableRecord.ChangeMySavedValue(sFField,vValue)
		        
		      End If
		      
		    End If
		    
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub methHandleDoubleClick()
		  dim lb as entListbox = methGetListbox
		  
		  
		  If evdefDoubleClick Then
		    
		    // the event was handled and we do not want to do anything else
		    
		  Else
		    
		    
		    dim oStor as RecordStorageClass
		    
		    If lb.ListIndex <> -1 Then
		      
		      oStor = lb.RowTag(lb.ListIndex)
		      
		      If oStor.oTableRecord <> Nil Then
		        
		        methOpenRecordInTab(oStor)
		        
		      End If
		      
		    End If
		    
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub methHandleExpandRow(row as integer)
		  dim lb1 as entListbox = methGetListbox
		  
		  // Extract the rowtag out of the parent
		  dim oParentStor as RecordStorageClass
		  oParentStor = lb1.RowTag(row)
		  
		  // Grab all the children
		  dim aroChildrenStor() as RecordStorageClass
		  aroChildrenStor() = oParentStor.aroChildren
		  
		  For Each oChild as RecordStorageClass In aroChildrenStor
		    
		    // Add a row
		    lb1.AddRow("")
		    
		    // Load the rowtag into the row
		    lb1.RowTag(lb1.LastIndex) = oChild
		    
		    // Load the row
		    methPopulateRow( lb1.LastIndex, oChild )
		    
		  Next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function methHandleMouseWheel(X As Integer, Y As Integer, DeltaX as Integer, DeltaY as Integer) As Boolean
		  'me.EraseBackground = False
		  
		  me.top = me.Top - DeltaY
		  me.Invalidate
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub methListboxSettings()
		  _
		  
		  
		  // Set up some basic stuff
		  
		  // trigger event to allow me to set information externally
		  evdefListboxSettings(lbEvents,dictCellTypes,dictFieldNames)
		  
		  If dictFieldNames = Nil And dictCellTypes = Nil Then
		    
		    dim s1,s2() as string
		    
		    dim sRowType as string
		    
		    // Set Column Count
		    dim iColCount as integer = 4
		    lbEvents.ColumnCount = iColCount
		    
		    // Initialize dictionaries
		    dictFieldNames = New Dictionary
		    dictCellTypes = New Dictionary
		    
		    // Set header names
		    s1 = "Name,Start Date, End Date, Account Manager"
		    s2() = Split(s1,",")
		    lbEvents.Heading = s2()
		    
		    
		    // **********
		    // Set up the cell types and field names for each type of row
		    
		    // Group Folders
		    sRowType = "GroupFolder"
		    'field names
		    dictFieldNames.Value(sRowType) = Array("")
		    
		    'cell types
		    dim iCellTypes() as integer
		    ReDim iCellTypes(iColCount - 1) 
		    dictCellTypes.Value(sRowType) = iCellTypes
		    
		    
		    // GrandParent
		    sRowType = "GrandParent"
		    'field names
		    s1 = "tbl_events.event_name,tbl_events.start_date,tbl_events.end_date,tbl_events.account_manager"
		    s2() = Split(s1,",")
		    dictFieldNames.Value(sRowType) = s2
		    
		    'cell types
		    dim iCellTypes2() as integer
		    ReDim iCellTypes2(iColCount - 1) 
		    dictCellTypes.Value(sRowType) = iCellTypes2
		    
		    
		    // Linking Type Folder
		    sRowType = "LinkingTypeFolder"
		    'field names
		    dictFieldNames.Value(sRowType) = Array("")
		    
		    'cell types
		    dim iCellTypes3() as integer
		    ReDim iCellTypes3(iColCount - 1) 
		    dictCellTypes.Value(sRowType) = iCellTypes3
		    
		    
		    // Child - 
		    sRowType = "Child - NoType"
		    'field names
		    s1 = "tbl_events.event_name,tbl_events.start_date,tbl_events.end_date,tbl_events.account_manager"
		    s2() = Split(s1,",")
		    dictFieldNames.Value(sRowType) = s2
		    
		    'cell types
		    dim iCellTypes4() as integer = Array(0,0,0,0)
		    dictCellTypes.Value(sRowType) = iCellTypes4
		    
		    
		    
		  End If
		  
		  
		  
		  
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub methLoadMe(bGrouped as Boolean = False, sGroupFields as String = "", bGetChildren as boolean = True)
		  dim lb as entListbox = lbEvents
		  
		  
		  // Prepare the sql statement to get our records
		  dim bHidden as Boolean = chbShowHidden.Value
		  dim sSearchString as String = scSearchField.Text
		  dim sOrderBy as String = "start_date"
		  dim oSQL as SQLStorageClass = methBuildSQL( bHidden, sSearchString, sOrderBy )
		  
		  // Get the records from the database
		  dim aroStor() as RecordStorageClass = methAcquireRecords( oSQL, sGroupFields, bGetChildren, bGrouped )
		  
		  aroStorClass = aroStor
		  
		  If aroStor.Ubound <> -1 Then
		    // Populate RowData values
		    aroStor.PopulateLbDataList( dictFieldNames, dictCellTypes )
		    'methPopulateLbData( aroStor )
		    methPopulateListbox( aroStor )
		  Else
		    lb.DeleteAllRows
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub methLoadMe(oStor as RecordStorageClass)
		  // THis version of loadme is for expanding on a single record and displaying children below it only
		  
		  // Make the add event button invisible
		  pbAdd.Visible = False
		  
		  // Store the Record so we know who the parent is later
		  oParentStor = oStor
		  
		  // Get its children
		  DataFile.GetChildren( oStor )
		  dim aroChildren() as RecordStorageClass = oStor.aroChildren
		  
		  aroStorClass = aroChildren
		  
		  aroChildren.PopulateLbDataList( dictFieldNames, dictCellTypes )
		  
		  methPopulateListbox( aroChildren )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub methOpenRecordInTab(oStor as RecordStorageClass)
		  // Get the name
		  dim sName as String = oStor.oTableRecord.GetRecordName
		  
		  If oStor.sUUID <> "" Then
		    
		    // load up an Event container
		    dim conEventInst as New contEvent
		    dim oTabPanel as PagePanel = app.MainWindow.tbMainWindow
		    
		    app.MainWindow.AddTab(sName)
		    
		    conEventInst.EmbedWithinPanel(oTabPanel,oTabPanel.PanelCount - 1 )
		    
		    conEventInst.LoadEvent(oStor.sUUID)
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub methPopulateListbox(aroRecordStor() as RecordStorageClass)
		  dim lb as entListbox = methGetListbox
		  
		  lb.DeleteAllRows
		  
		  For Each oStor as RecordStorageClass In aroRecordStor()
		    
		    lb.AddRow("")
		    dim iLastIndex as integer = lb.LastIndex
		    
		    // Populate the row
		    methPopulateRow( iLastIndex, oStor )
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub methPopulateRow(iRowIndex as integer, oStor as RecordStorageClass)
		  dim lb as entListbox = lbEvents
		  dim oDummy as New DataFile.tbl_events
		  dim sTableName as String = oDummy.GetTableName
		  
		  For iCellIndex as integer = 0 To oStor.oRowData.arsColumnValues.Ubound
		    dim sColumnValue as string = oStor.oRowData.arsColumnValues(iCellIndex)
		    dim sFieldName as string = oStor.oRowData.arsFieldNames(iCellIndex)
		    dim iColumnType as integer = oStor.oRowData.ariColumnTypes(iCellIndex)
		    dim sDotNotation as String = sTableName + "." + sFieldName
		    
		    // Set the cell type
		    lb.CellType( iRowIndex, iCellIndex ) = iColumnType
		    
		    // Format the value
		    sColumnValue = str( sColumnValue, modFieldFormatting.GetFormattingString( sDotNotation ) )
		    
		    Select Case iColumnType
		    Case 0 'default
		      lb.Cell(iRowIndex,iCellIndex) = sColumnValue
		    Case 1 'text
		      lb.Cell(iRowIndex,iCellIndex) = sColumnValue
		    Case 2 'CheckBox
		      If sColumnValue = "True" then
		        lb.CellState(iRowIndex ,iCellIndex) = CheckBox.CheckedStates.Checked
		      Else
		        lb.CellState(iRowIndex ,iCellIndex) = CheckBox.CheckedStates.Unchecked
		      End If
		    Case 3 'edit text
		      lb.Cell(iRowIndex,iCellIndex) = sColumnValue
		    Else
		      lb.Cell(iRowIndex,iCellIndex) = sColumnValue
		    End Select
		    
		  Next
		  
		  // Add the rowtag
		  lb.RowTag( iRowIndex ) = oStor
		  
		  // Set folder status
		  lb.RowisFolder( iRowIndex ) = oStor.isFolder
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub methRefresh()
		  dim lb as entListbox = methGetListbox
		  dim oUIState as lbUIState
		  oUIState = lb.GetUIState
		  
		  If oParentStor = Nil Then
		    methLoadMe()
		  Else
		    methLoadMe(oParentStor)
		  End If
		  
		  lb.ResetUIState(oUIState)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event evdefDoubleClick() As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event evdefListBoxSettings(theListbox as entListbox, CellTypes as Dictionary, Fieldnames as Dictionary)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event evdefOpen()
	#tag EndHook


	#tag Property, Flags = &h0
		aroStorClass() As RecordStorageClass
	#tag EndProperty

	#tag Property, Flags = &h0
		arsHeaders() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		bDisplayGrouped As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		dictCellTypes As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		dictFieldNames As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		DoNotLoad As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		iStartingTop As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		LastSearchValue As String
	#tag EndProperty

	#tag Property, Flags = &h0
		LastUIState As lbUIState
	#tag EndProperty

	#tag Property, Flags = &h0
		oParentStor As RecordStorageClass
	#tag EndProperty

	#tag Property, Flags = &h0
		PickerMode As Boolean
	#tag EndProperty


#tag EndWindowCode

#tag Events lbEvents
	#tag Event
		Sub ExpandRow(Row as integer)
		  
		  methHandleExpandRow(Row)
		End Sub
	#tag EndEvent
	#tag Event
		Function CellBackgroundPaint(g as Graphics,row as integer, column as integer) As Boolean
		  
		  If row Mod 2 = 0 Then
		    g.ForeColor = UiColors.ListboxRowEven
		  Else
		    g.ForeColor = UiColors.ListboxRowOdd
		  End If
		  
		  g.FillRect(0,0,g.Width,g.Height)
		End Function
	#tag EndEvent
	#tag Event
		Sub DoubleClick()
		  
		  methHandleDoubleClick
		End Sub
	#tag EndEvent
	#tag Event
		Function entContextualMenuAction(hitItem as MenuItem) As Boolean
		  dim lb as entListbox = methGetListbox
		  
		  Select Case hitItem.Text
		  Case "Open"
		    
		    If lb.ListIndex <> -1 Then
		      
		      // Grab the rowtag
		      dim oStor as RecordStorageClass = lb.RowTag(lb.ListIndex)
		      
		      // Get the Event name
		      dim vRecord as Variant = oStor.oTableRecord
		      dim oRecord as DataFile.tbl_events = vRecord
		      dim sName as string
		      sName = oRecord.GetRecordName
		      
		      If oStor.sUUID <> "" Then
		        
		        // load up a inventory item container
		        dim conEventInst as New contEvent
		        dim oTabPanel as PagePanel = app.MainWindow.tbMainWindow
		        
		        app.MainWindow.AddTab(sName)
		        
		        conEventInst.EmbedWithinPanel(oTabPanel,oTabPanel.PanelCount - 1 )
		        
		        conEventInst.LoadEvent(oStor.sUUID)
		      End If
		    End If
		    
		  Case "Break Link"
		    
		    dim aroStor() as RecordStorageClass
		    aroStor = lb.GetSelectedRowTags
		    
		    dim sYesOrNoToAll as String
		    
		    // Loop through each row
		    For Each oStor as RecordStorageClass in aroStor
		      
		      // Get the table record out of the rowtag
		      If oStor.oTableRecord = Nil Or oStor.oLinkRecord = Nil Then
		        Continue
		      End If
		      dim vRecord as Variant = oStor.oTableRecord
		      dim oRecord as DataFile.tbl_events = vRecord
		      dim vLinkRecord as Variant = oStor.oLinkRecord
		      dim oLinkRecord as DataFile.tbl_internal_linking = vLinkRecord
		      
		      // Get the name of the item
		      dim sName as string
		      sName = oRecord.GetRecordName
		      
		      dim bDelete as Boolean
		      
		      If sYesOrNoToAll = "" Then
		        
		        // Prepare the prompt window
		        dim contDeletePromt as New contDeleteBreakPrompt
		        dim winWindow as New winFloatingWindow
		        winWindow.Width = contDeletePromt.Width
		        winWindow.Height = contDeletePromt.Height
		        
		        contDeletePromt.EmbedWithin(winWindow)
		        contDeletePromt.labMesgTop.Text = "Are you sure you want to break link to " + sName + "."
		        contDeletePromt.labMesgBottom.Text = ""
		        
		        // Display the window to the user
		        winWindow.ShowModal
		        
		        // Check the users response
		        bDelete = contDeletePromt.UserResponse
		        If contDeletePromt.propApplyToAll Then
		          If bDelete Then
		            sYesOrNoToAll = "Yes"
		          Else
		            sYesOrNoToAll = "No"
		          End If
		        End If
		        
		      ElseIf sYesOrNoToAll = "Yes" Then
		        bDelete = True
		      ElseIf sYesOrNoToAll = "No" Then
		        bDelete = False
		      End If
		      
		      // Carry out the users request
		      If bDelete Then
		        oLinkRecord.Delete
		      End If
		    Next
		    
		  Case "Delete Item"
		    
		    dim aroStor() as RecordStorageClass = lb.GetSelectedRowTags
		    
		    dim sYesOrNoToAll as String
		    
		    // Loop through each row
		    For Each oStor as RecordStorageClass in aroStor
		      
		      // Get the table record out of the rowtag
		      If oStor.oTableRecord = Nil Then
		        Continue
		      End If
		      dim vRecord as Variant = oStor.oTableRecord
		      dim oRecord as DataFile.tbl_events = vRecord
		      
		      // Get the name of the item
		      dim sName as string
		      sName = oRecord.sevent_name
		      
		      dim bDelete as Boolean
		      
		      If sYesOrNoToAll = "" Then
		        
		        // Prepare the prompt window
		        dim contDeletePromt as New contDeleteBreakPrompt
		        dim winWindow as New winFloatingWindow
		        winWindow.Width = contDeletePromt.Width
		        winWindow.Height = contDeletePromt.Height
		        
		        contDeletePromt.EmbedWithin(winWindow)
		        contDeletePromt.labMesgTop.Text = "Are you sure you want to delete " + sName + "."
		        contDeletePromt.labMesgBottom.Text = ""
		        
		        // Display the window to the user
		        winWindow.ShowModal
		        
		        // Chekc the users response
		        bDelete = contDeletePromt.UserResponse
		        If contDeletePromt.propApplyToAll Then
		          If bDelete Then
		            sYesOrNoToAll = "Yes"
		          Else
		            sYesOrNoToAll = "No"
		          End If
		        End If
		        
		      ElseIf sYesOrNoToAll = "Yes" Then
		        bDelete = True
		      ElseIf sYesOrNoToAll = "No" Then
		        bDelete = False
		      End If
		      
		      // Carry out the users request
		      If bDelete Then
		        oRecord.Delete
		      End If
		    Next
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		  End Select
		End Function
	#tag EndEvent
	#tag Event
		Function entConstructContextualMenu(base as menuitem, x as integer, y as integer) As Boolean
		  dim lb as entListbox = methGetListbox
		  
		  If lb.ListIndex <> -1 Then
		    
		    // Grab the rowtag
		    dim oStor as RecordStorageClass = lb.RowTag(lb.ListIndex)
		    
		    If oStor.oTableRecord <> Nil Then
		      
		      base.Append( New MenuItem("Open") )
		      base.Append( New MenuItem(MenuItem.TextSeparator) )
		      
		      If  oStor.oLinkRecord <> Nil Then
		        dim mi1 as New MenuItem("Break Link")
		        mi1.Enabled = False
		        base.Append( mi1 )
		      End If
		      
		      base.Append( New MenuItem("Delete Item") )
		      
		    End If
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Sub CellAction(row as integer, column as integer)
		  methHandleCellAction(row,column)
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellLostFocus(row as integer, col as integer)
		  methHandleCellLostFocus(row,col)
		End Sub
	#tag EndEvent
	#tag Event
		Function evdefMouseWheel(X As Integer, Y As Integer, DeltaX as Integer, DeltaY as Integer) As Boolean
		  
		  Return methHandleMouseWheel(X,Y,DeltaX,DeltaY)
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events scSearchField
	#tag Event
		Sub Search()
		  dim sSearchValue as string
		  dim lb1 as entListbox = lbEvents
		  
		  sSearchValue = scSearchField.Text
		  
		  
		  // Populate listbox with filterd inventory
		  methLoadMe()
		  
		  
		  
		  
		  
		  LastSearchValue = sSearchValue
		  
		  
		  
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events chbShowHidden
	#tag Event
		Sub Action()
		  methRefresh
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events pbRefresh
	#tag Event
		Sub Action()
		  methRefresh
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events pbAdd
	#tag Event
		Sub Action()
		  methAddEvent
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events pbSort
	#tag Event
		Sub Open()
		  me.AddRow( "Client" )
		  me.AddRow( "None" )
		  me.AddRow( "Venue" )
		  me.AddRow( "Year" )
		  me.AddRow( "Year/Month" )
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action()
		  dim s as string = me.list( me.MenuValue )
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="AcceptFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AcceptTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		Type="Picture"
		EditorType="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="bDisplayGrouped"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="DoNotLoad"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="EraseBackground"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Group="Position"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="iStartingTop"
		Group="Behavior"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LastSearchValue"
		Group="Behavior"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="PickerMode"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabStop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="UseFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
