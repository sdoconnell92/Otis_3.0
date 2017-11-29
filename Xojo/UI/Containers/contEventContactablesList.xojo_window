#tag Window
Begin ContainerControl contEventContactablesList
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   224
   HelpTag         =   ""
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   False
   Visible         =   True
   Width           =   338
   Begin entListbox lbContactables
      AcceptFocus     =   False
      AcceptTabs      =   True
      AutoDeactivate  =   True
      BackColor       =   &cFFFFFF00
      Backdrop        =   0
      CellBackColor   =   &cFFFFFF00
      Enabled         =   True
      EraseBackground =   True
      GridLinesColor  =   &c00000000
      HasBackColor    =   False
      HasHeading      =   True
      Height          =   187
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
      Top             =   35
      Transparent     =   True
      UseFocusRing    =   False
      Visible         =   True
      Width           =   332
   End
   Begin entPushButton pbRefresh
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Refresh"
      Default         =   False
      Enabled         =   True
      Height          =   30
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   2
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   3
      Underline       =   False
      Visible         =   True
      Width           =   66
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Function methGetListbox() As entListbox
		  Return lbContactables
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub methLoadMe()
		  dim db1 as SQLiteDatabase = app.db
		  
		  lbContactables.DeleteAllRows
		  
		  // First lets grab all of the records from the database that are related to this event
		  dim rs1 as RecordSet
		  dim sql1 as string
		  
		  sql1 = "Select c.uuid, c.name_first, c.name_last,c.type, il.uuid as liuuid "_
		  + "From tbl_contactables as c "_
		  + "Inner Join tbl_contactable_linking as il on ( c.uuid = il.fk_child ) "_
		  + "Inner Join tbl_events as e on ( il.fk_parent = e.uuid ) "_
		  + "Where e.uuid = '" + EventID + "';"
		  
		  rs1 = db1.SQLSelect(sql1)
		  If db1.Error Then
		    ErrManage("contEventContactablesList.methLoadMe", "Cant get contacts related to event: " + db1.ErrorMessage )
		    Return
		  End If
		  
		  If rs1.RecordCount > 0 Then
		    
		    For iRecordIndex as integer = 1 To rs1.RecordCount
		      
		      lbContactables.AddRow( rs1.Field("name_first").StringValue, rs1.Field("name_last").StringValue, rs1.Field("type").StringValue )
		      
		      dim oRowTag as New lbRowTag
		      oRowTag.uuid = rs1.Field("uuid").Value
		      oRowTag.vColumnValues = Array( rs1.Field("name_first").Value, rs1.Field("name_last").Value, rs1.Field("type").Value )
		      If rs1.Field("liuuid").StringValue <> "" Then oRowTag.vLinkTable = DataFile.tbl_contactable_linking.FindByID( rs1.Field("liuuid").StringValue )
		      If rs1.Field("uuid").StringValue <> "" Then oRowTag.vtblRecord = DataFile.tbl_contactables.FindByID( rs1.Field("uuid").StringValue )
		      
		      lbContactables.RowTag(lbContactables.LastIndex) = oRowTag
		      
		      rs1.MoveNext
		      
		    Next
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub methRefresh()
		  
		  dim oUIState as lbUIState
		  oUIState = lbContactables.GetUIState
		  methLoadMe()
		  lbContactables.ResetUIState(oUIState)
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		EventID As String
	#tag EndProperty


#tag EndWindowCode

#tag Events lbContactables
	#tag Event
		Sub Open()
		  
		  // Lets set up our headers
		  me.ColumnCount = 3
		  me.Heading = Array("Name"," ","Type")
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoubleClick()
		  dim oRowTag as lbRowTag
		  
		  If lbContactables.ListIndex <> -1 Then
		    
		    oRowTag = lbContactables.RowTag( lbContactables.ListIndex )
		    
		    // load up a inventory item container
		    dim conInst as New contContactable
		    dim oTabPanel as PagePanel = app.MainWindow.tbMainWindow
		    
		    app.MainWindow.AddTab( lbContactables.Cell(lbContactables.ListIndex,0) )
		    
		    conInst.EmbedWithinPanel(oTabPanel,oTabPanel.PanelCount - 1 )
		    
		    conInst.LoadMe(oRowTag.uuid)
		    
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function entContextualMenuAction(hitItem as MenuItem) As Boolean
		  dim lb as entListbox = methGetListbox
		  
		  Select Case hitItem.Text
		  Case "Break Link"
		    
		    dim oRowTags() as RecordStorageClass
		    oRowTags = lb.GetSelectedRows
		    
		    // Goal is to delete all selected rows allowing the user an option to apply their choice of whether or not to delete an item to all items
		    
		    dim sYesOrNoToAll as String
		    
		    // Loop through each row
		    For Each oRowTag as RecordStorageClass in oRowTags
		      
		      If oRowTag.oTableRecord = Nil Or oRowTag.oLinkRecord = Nil Then Continue
		      
		      // Get the name of the item
		      dim sName as string
		      sName = oRowTag.oTableRecord.GetRecordName
		      
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
		        oRowTag.oLinkRecord.Delete
		      End If
		    Next
		    
		  End Select
		End Function
	#tag EndEvent
	#tag Event
		Function entConstructContextualMenu(base as menuitem, x as integer, y as integer) As Boolean
		  
		  dim mi1 as New MenuItem("Break Link")
		  mi1.Enabled = True
		  base.Append( mi1 )
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events pbRefresh
	#tag Event
		Sub Action()
		  methRefresh
		  
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
		Name="EventID"
		Group="Behavior"
		Type="String"
		EditorType="MultiLineEditor"
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
