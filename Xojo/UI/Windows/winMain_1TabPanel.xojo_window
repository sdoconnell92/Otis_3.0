#tag Window
Begin Window winMain_1TabPanel
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   574
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   1143859199
   MenuBarVisible  =   True
   MinHeight       =   548
   MinimizeButton  =   True
   MinWidth        =   978
   Placement       =   0
   Resizeable      =   True
   Title           =   "Untitled"
   Visible         =   False
   Width           =   1010
   Begin entPushButton bRunSync
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "RunSync"
      Default         =   False
      Enabled         =   True
      Height          =   25
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   930
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   0
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin PagePanel tbMainWindow
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   549
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   3
      Panels          =   ""
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      Top             =   26
      Value           =   0
      Visible         =   True
      Width           =   1010
      Begin contEventList contEventList1
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFF00FFFF
         Backdrop        =   0
         bDisplayGrouped =   False
         DoNotLoad       =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   545
         HelpTag         =   ""
         InitialParent   =   "tbMainWindow"
         iStartingTop    =   0
         LastSearchValue =   ""
         Left            =   2
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         PickerMode      =   False
         Scope           =   0
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Top             =   27
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   1006
      End
      Begin contInventory contInventory1
         AcceptFocus     =   True
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         bDisplayGrouped =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   544
         HelpTag         =   ""
         InitialParent   =   "tbMainWindow"
         iStartingTop    =   0
         LastSearchValue =   ""
         Left            =   3
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   0
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Top             =   29
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   1005
      End
      Begin contContactableList contContactableList1
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         bDisplayGrouped =   False
         DoNotLoad       =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   542
         HelpTag         =   ""
         InitialParent   =   "tbMainWindow"
         LastSearchValue =   ""
         Left            =   3
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         PickerMode      =   False
         Scope           =   0
         sFilterID       =   ""
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Top             =   29
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   1004
      End
   End
   Begin entPushButton pbCloseTab
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Close Tab"
      Default         =   False
      Enabled         =   True
      Height          =   25
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   851
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   0
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin TabPanel tbTabs
      AutoDeactivate  =   True
      Bold            =   False
      Enabled         =   True
      Height          =   24
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   7
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Panels          =   ""
      Scope           =   0
      SmallTabs       =   False
      TabDefinition   =   "Events\rInventory\rContacts"
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   0
      Underline       =   False
      Value           =   1
      Visible         =   True
      Width           =   605
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Activate()
		  
		  
		  
		  
		  ''dim thinsl as Dictionary
		  ''thinsl = DataFile.tbl_contactables.ListGrouped("","name_first,name_last,job_title","name_first, name_last, job_title")
		  'dim s1 as string = thinsl.ToString
		  ''dim s2 as string
		  'dim randomthing as BKS_ActiveRecord.Base
		  'dim baselistthting as New BKS_ActiveRecord.BaseList
		  
		  'randomthing = baselistthting.Operator_Subscript(0)
		  
		  'if 1 = 1 then
		  
		  'end if
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddTab(sName as string, GoToTab as Boolean = True)
		  tbMainWindow.Append
		  tbTabs.Append(sName)
		  
		  if GoToTab Then
		    tbMainWindow.Value = tbMainWindow.PanelCount - 1
		    tbTabs.Value = tbTabs.PanelCount - 1
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveTab(index as integer)
		  tbTabs.Remove(index)
		  tbMainWindow.Remove(index)
		  
		  dim n1 as integer
		  n1 = tbTabs.PanelCount - 1
		  
		  tbTabs.Value = n1
		  tbMainWindow.Value = n1
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private theid As String
	#tag EndProperty


#tag EndWindowCode

#tag Events bRunSync
	#tag Event
		Sub Action()
		  Break
		  If App.DbSync.PushSync Then 
		  Else
		    Break
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events contEventList1
	#tag Event
		Sub evdefOpen()
		  
		  me.bDisplayGrouped = False
		  me.methLoadMe()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events contInventory1
	#tag Event
		Sub evdefOpen()
		  
		  me.bDisplayGrouped = True
		  me.methLoadMe()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events contContactableList1
	#tag Event
		Sub evdefOpen()
		  
		  me.bDisplayGrouped = True
		  me.methLoadMe()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events pbCloseTab
	#tag Event
		Sub Action()
		  
		  RemoveTab(tbMainWindow.Value)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events tbTabs
	#tag Event
		Sub Change()
		  tbMainWindow.Value = tbTabs.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Name="CloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Frame"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
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
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		Type="MenuBar"
		EditorType="MenuBar"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Placement"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
