#tag Window
Begin Window winLogin
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   1
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   218
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   False
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   False
   Title           =   "Login"
   Visible         =   True
   Width           =   582
   Begin CheckBox chbSavePassword
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Save Password"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   False
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   295
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      State           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "FreeSerif"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   141
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   248
   End
   Begin CheckBox chbSaveUsername
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Save Username"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   295
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      State           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "FreeSerif"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   122
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   248
   End
   Begin ImageWell pictLogo
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   150
      HelpTag         =   ""
      Image           =   0
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   31
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   28
      Visible         =   True
      Width           =   150
   End
   Begin Label labErrorText
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   297
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlign       =   0
      TextColor       =   &cFF808000
      TextFont        =   "FreeSerif"
      TextSize        =   10.0
      TextUnit        =   0
      Top             =   15
      Transparent     =   True
      Underline       =   False
      Visible         =   False
      Width           =   247
   End
   Begin Label labPassword
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   209
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Password"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "FreeSerif"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   70
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   74
   End
   Begin Label labUsername
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   209
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Username"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "FreeSerif"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   40
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   74
   End
   Begin entTextField tfPassword
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   25
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   295
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   67
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   261
   End
   Begin entTextField tfUsername
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   25
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   295
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   37
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   261
   End
   Begin CheckBox chbShowPassword
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Show Password"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   295
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      State           =   0
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "FreeSerif"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   93
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   248
   End
   Begin entOkCancel butOKCancel
      AcceptFocus     =   False
      AcceptTabs      =   True
      AutoDeactivate  =   True
      BackColor       =   &cFFFFFF00
      Backdrop        =   0
      CancelButtonText=   "Cancel"
      Enabled         =   True
      EraseBackground =   True
      HasBackColor    =   False
      Height          =   30
      HelpTag         =   ""
      InitialParent   =   ""
      Left            =   386
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      OkButtonText    =   "Ok"
      Scope           =   0
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   175
      Transparent     =   True
      UseFocusRing    =   False
      Visible         =   True
      Width           =   176
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  retUn = tfUsername.Text
		  retPw = tfPassword.Text
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  
		  
		  dim p as Picture = evdefSetLogo
		  If p = Nil Then 
		    p = HexNut
		  End If
		  
		  SetLogo(p)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub ChangeCheckboxes()
		  
		  
		  chbSavePassword.Enabled = chbSaveUsername.Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Display(un as string = "", pw as string = "", ErrorCode as integer = 0) As Dictionary
		  dim d as new Dictionary
		  
		  dim err as string = ErrorMessages.GetByErrorCode(ErrorCode)
		  
		  // Set fields in window
		  me.SetUsername = un
		  me.SetPassword = pw
		  me.SetError = ErrorCode
		  
		  me.ShowModal
		  
		  d.Value("Username") = retUn
		  d.Value("Password") = retPw
		  d.Value("UserCancelled") = UserCancelled
		  
		  Return d
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetError(assigns ErrorCode as integer)
		  If ErrorCode = ErrorCodes.kNoError Then
		    labErrorText.Visible = True
		  Else
		    labErrorText.Visible = True
		    labErrorText.Text = ErrorMessages.GetByErrorCode(ErrorCode)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetLogo(pict as Picture)
		  pictLogo.Image = pict
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetPassword(assigns t as string)
		  tfPassword.Text = t
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetUsername(assigns t as string)
		  tfUsername.Text = t
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowHidePassword(value as Boolean)
		  tfPassword.Password = chbShowPassword.Value.Invert
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event evdefSetLogo() As Picture
	#tag EndHook


	#tag Property, Flags = &h21
		Private retPw As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private retUn As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private theLogo As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private UserCancelled As Boolean
	#tag EndProperty


#tag EndWindowCode

#tag Events chbSaveUsername
	#tag Event
		Sub Action()
		  ChangeCheckboxes
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events chbShowPassword
	#tag Event
		Sub Action()
		  ChangeCheckboxes
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events butOKCancel
	#tag Event
		Sub Action()
		  me.Window.Close
		End Sub
	#tag EndEvent
	#tag Event
		Sub CancelAction()
		  UserCancelled = True
		  
		  me.Window.Close
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
