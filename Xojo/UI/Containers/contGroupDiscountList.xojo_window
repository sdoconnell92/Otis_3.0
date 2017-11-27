#tag Window
Begin ContainerControl contGroupDiscountList
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
   Width           =   300
   Begin entListbox lbDiscounts
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
      Height          =   273
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   4
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   25
      Transparent     =   True
      UseFocusRing    =   False
      Visible         =   True
      Width           =   294
   End
   Begin entPushButton pbRefresh
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Refresh"
      Default         =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   3
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
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
      Width           =   80
   End
   Begin entPushButton pbAddDiscount
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Add"
      Default         =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   83
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   3
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Sub methLoadMe(oRecord as DataFile.tbl_eipl)
		  lbDiscounts.DeleteAllRows
		  'Break
		  If oRecord = Nil Then
		    oCurrentEIPL = oRecord
		    Return
		  Else
		    oCurrentEIPL = oRecord
		  End If
		  
		  // Get the discount records from the database
		  dim aroDiscounts() as DataFile.tbl_group_discounts = DataFile.tbl_group_discounts.List( "fkeipl = '" + oCurrentEIPL.suuid + "'" )
		  
		  // Check to make sure we actually got records
		  If aroDiscounts.Ubound <> -1 Then
		    
		    // Create a new rowtag for this each record
		    For Each oDiscount as DataFile.tbl_group_discounts In aroDiscounts()
		      
		      dim var1, var2 as Variant
		      var1 = oDiscount.sgroup_name
		      var2 = modFieldFormatting.FormatDiscountFields( oDiscount.sgroup_discount )
		      
		      dim oRowtag as New lbRowTag
		      oRowtag.uuid = oDiscount.suuid
		      oRowtag.vColumnValues = Array( var1,var2 )
		      oRowtag.vtblRecord = oDiscount
		      oRowtag.sFieldNames = Array("group_name","group_discount")
		      
		      lbDiscounts.AddRow( var1,var2 )
		      lbDiscounts.RowTag( lbDiscounts.LastIndex ) = oRowtag
		      
		    Next
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub methLoadMe(sUUID as String)
		  
		  
		  If sUUID <> "" Then
		    dim oRecord as DataFile.tbl_eipl = DataFile.tbl_eipl.FindByID(sUUID)
		    
		    If oRecord <> Nil Then
		      oCurrentEIPL = oRecord
		      methLoadMe(oRecord)
		    End If
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub methRefresh()
		  
		  dim oUIState as lbUIState
		  oUIState = lbDiscounts.GetUIState
		  methLoadMe(oCurrentEIPL)
		  lbDiscounts.ResetUIState(oUIState)
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		oCurrentEIPL As DataFile.tbl_eipl
	#tag EndProperty


#tag EndWindowCode

#tag Events lbDiscounts
	#tag Event
		Sub Open()
		  
		  me.ColumnCount = 2
		  me.Heading = Array( "Group", "Discount" )
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoubleClick()
		  
		  
		  If lbDiscounts.ListIndex <> -1 Then
		    
		    dim oRowTag as lbRowTag = lbDiscounts.RowTag( lbDiscounts.ListIndex )
		    
		    If oRowTag <> Nil Then
		      
		      If oRowTag.vtblRecord <> Nil THen
		        
		        dim oDiscount as DataFile.tbl_group_discounts = oRowTag.vtblRecord
		        
		        dim instDiscountDetails as New contDiscountDetails
		        dim instFlWindow as New winFloatingWindow
		        
		        instFlWindow.Width = instDiscountDetails.Width
		        instFlWindow.Height = instDiscountDetails.Height
		        
		        instDiscountDetails.oCurrentRecord = oDiscount
		        instDiscountDetails.EmbedWithin(instFlWindow)
		        instDiscountDetails.methLoadMe
		        
		        instFlWindow.Top = MouseY
		        instFlWindow.Left = MouseX
		        
		      End If
		      
		    End If
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function entContextualMenuAction(hitItem as MenuItem) As Boolean
		  
		  
		  Select Case hitItem.Text
		  Case "Delete"
		    
		    
		    dim oRowTags() as lbRowTag
		    oRowTags = lbDiscounts.GetSelectedRows
		    
		    // Goal is to delete all selected rows allowing the user an option to apply their choice of whether or not to delete an item to all items
		    
		    dim sYesOrNoToAll as String
		    
		    // Loop through each row
		    For Each oRowTag as lbRowTag in oRowTags
		      
		      // Get the table record out of the rowtag
		      dim oRecord as DataFile.tbl_group_discounts
		      If oRowTag.vtblRecord <> Nil Then
		        oRecord = oRowTag.vtblRecord
		      Else
		        Continue
		      End If
		      
		      dim bDelete as Boolean
		      
		      If sYesOrNoToAll = "" Then
		        
		        // Prepare the prompt window
		        dim contDeletePromt as New contDeleteBreakPrompt
		        dim winWindow as New winFloatingWindow
		        winWindow.Width = contDeletePromt.Width
		        winWindow.Height = contDeletePromt.Height
		        
		        contDeletePromt.EmbedWithin(winWindow)
		        contDeletePromt.labMesgTop.Text = "Are you sure you want to delete the discount for " + oRecord.sgroup_name
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
		  
		  dim mi1 as New MenuItem("Delete")
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
#tag Events pbAddDiscount
	#tag Event
		Sub Action()
		  
		  If oCurrentEIPL <> Nil Then
		    dim oNewDiscount as New DataFile.tbl_group_discounts
		    oNewDiscount.sfkeipl = oCurrentEIPL.suuid
		    oNewDiscount.Save
		    
		    dim instDiscountDetails as New contDiscountDetails
		    dim instFlWindow as New winFloatingWindow
		    
		    instFlWindow.Width = instDiscountDetails.Width
		    instFlWindow.Height = instDiscountDetails.Height
		    
		    instDiscountDetails.oCurrentRecord = oNewDiscount
		    instDiscountDetails.EmbedWithin(instFlWindow)
		    instDiscountDetails.methLoadMe
		    
		    instFlWindow.Top = MouseY
		    instFlWindow.Left = MouseX
		    
		  End If
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
