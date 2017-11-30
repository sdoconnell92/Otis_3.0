#tag Window
Begin ContainerControl contEI
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   518
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
   Width           =   901
   Begin PagePanel ppEIPLSwitcher
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   496
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      Top             =   22
      Value           =   0
      Visible         =   True
      Width           =   901
      Begin contLineItems instLineItemList
         AcceptFocus     =   True
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFF00FF
         Backdrop        =   0
         bDisplayGrouped =   False
         bPickerMode     =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   353
         HelpTag         =   ""
         InitialParent   =   "ppEIPLSwitcher"
         iStartingTop    =   0
         LastSearchValue =   ""
         Left            =   262
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   0
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Top             =   44
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   639
      End
      Begin contInventory instInventoryList
         AcceptFocus     =   True
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFF00FF
         Backdrop        =   0
         bDisplayGrouped =   False
         bPickerMode     =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   473
         HelpTag         =   ""
         InitialParent   =   "ppEIPLSwitcher"
         iStartingTop    =   0
         LastSearchValue =   ""
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Top             =   44
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   261
      End
      Begin contEIPLContactablesList instEIPLContactablesList
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFF00FF
         Backdrop        =   0
         EIPLID          =   ""
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   181
         HelpTag         =   ""
         InitialParent   =   "ppEIPLSwitcher"
         Left            =   343
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Top             =   61
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   292
      End
      Begin entPushButton pbAddRecord
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   True
         Caption         =   "Add"
         Default         =   False
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ppEIPLSwitcher"
         Italic          =   False
         Left            =   343
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   241
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin entTextField tfEIPLName
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFF00FF
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ppEIPLSwitcher"
         Italic          =   False
         Left            =   112
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Mask            =   ""
         Password        =   False
         ReadOnly        =   False
         Scope           =   0
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   41
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   200
      End
      Begin Label labEIPLName
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ppEIPLSwitcher"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   3
         TabPanelIndex   =   2
         Text            =   "EIPL Name"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   42
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Label labEIPLType
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ppEIPLSwitcher"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   4
         TabPanelIndex   =   2
         Text            =   "EIPL Type"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   68
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Popupmenu pmEIPLType
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ppEIPLSwitcher"
         InitialValue    =   ""
         Italic          =   False
         Left            =   112
         ListIndex       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   5
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   67
         Underline       =   False
         Visible         =   True
         Width           =   200
      End
      Begin Label labDueDate
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ppEIPLSwitcher"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   6
         TabPanelIndex   =   2
         Text            =   "Due Date"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   94
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin DateControl dcDueDate
         AutoDeactivate  =   True
         Checked         =   False
         DateFormat      =   0
         Day             =   0
         DropDownIcon    =   0
         DropDownIconRetina=   0
         EmptyDates      =   True
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ppEIPLSwitcher"
         Left            =   112
         LinuxDropDownMode=   False
         LinuxFontBold   =   False
         LinuxTextFont   =   ""
         LinuxTextSize   =   0.0
         LinuxTextUnit   =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacFontBold     =   False
         MacTextFont     =   ""
         MacTextSize     =   0.0
         Month           =   0
         OSXDropDownMode =   False
         Scope           =   0
         TabIndex        =   7
         TabPanelIndex   =   2
         TabStop         =   True
         Top             =   93
         Visible         =   True
         Width           =   200
         WinFontBold     =   False
         WinTextFont     =   ""
         WinTextSize     =   0.0
         WinTextUnit     =   0
         Year            =   0
      End
      Begin Label labEIPLTaxRate
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ppEIPLSwitcher"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   8
         TabPanelIndex   =   2
         Text            =   "Tax Rate"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   119
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin entTextField tfEIPLTaxRate
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFF00FF
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ppEIPLSwitcher"
         Italic          =   False
         Left            =   112
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Mask            =   ""
         Password        =   False
         ReadOnly        =   False
         Scope           =   0
         TabIndex        =   9
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   118
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   200
      End
      Begin contLIDetails instLIDetails
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFF00FF
         Backdrop        =   0
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   120
         HelpTag         =   ""
         InitialParent   =   "ppEIPLSwitcher"
         Left            =   262
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   0
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Top             =   398
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   639
      End
      Begin contGroupDiscountList instGroupDiscountList
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFF00FF
         Backdrop        =   0
         bDisplayGrouped =   False
         bPickerMode     =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   181
         HelpTag         =   ""
         InitialParent   =   "ppEIPLSwitcher"
         iStartingTop    =   0
         LastSearchValue =   ""
         Left            =   343
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         PickerMode      =   False
         Scope           =   0
         TabIndex        =   10
         TabPanelIndex   =   2
         TabStop         =   True
         Top             =   297
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   293
      End
      Begin Label labDiscounts
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ppEIPLSwitcher"
         Italic          =   False
         Left            =   343
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   12
         TabPanelIndex   =   2
         Text            =   "Discounts"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   277
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin Label labEIPLNumber
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ppEIPLSwitcher"
         Italic          =   False
         Left            =   4
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   3
         TabPanelIndex   =   1
         Text            =   "EIPL Number"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   24
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   111
      End
      Begin Label labEIPLDiscount
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ppEIPLSwitcher"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   13
         TabPanelIndex   =   2
         Text            =   "EIPL Discount"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   145
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin entTextField tfEIPLDiscount
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFF00FF
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ppEIPLSwitcher"
         Italic          =   False
         Left            =   112
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Mask            =   ""
         Password        =   False
         ReadOnly        =   False
         Scope           =   0
         TabIndex        =   14
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   144
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   200
      End
      Begin contPaymentList instPaymentList
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFF00FF
         Backdrop        =   0
         bDisplayGrouped =   False
         bPickerMode     =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   179
         HelpTag         =   ""
         InitialParent   =   "ppEIPLSwitcher"
         iStartingTop    =   0
         LastSearchValue =   ""
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         PickerMode      =   False
         Scope           =   0
         TabIndex        =   15
         TabPanelIndex   =   2
         TabStop         =   True
         Top             =   297
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   292
      End
      Begin Label labContactablesList
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ppEIPLSwitcher"
         Italic          =   False
         Left            =   343
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   16
         TabPanelIndex   =   2
         Text            =   "Contactables"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   42
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin Label labPayments
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ppEIPLSwitcher"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   17
         TabPanelIndex   =   2
         Text            =   "Payments"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   277
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin PushButton pbPrintPreview
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Print"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ppEIPLSwitcher"
         Italic          =   False
         Left            =   821
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   0
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   23
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Label labSubtotal
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ppEIPLSwitcher"
         Italic          =   False
         Left            =   127
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   5
         TabPanelIndex   =   1
         Text            =   "Subtotal:"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   24
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   143
      End
      Begin Label labDiscountSum
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ppEIPLSwitcher"
         Italic          =   False
         Left            =   273
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   6
         TabPanelIndex   =   1
         Text            =   "Disc Sum:"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   24
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   149
      End
      Begin Label labTaxSum
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ppEIPLSwitcher"
         Italic          =   False
         Left            =   427
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   7
         TabPanelIndex   =   1
         Text            =   "Tax:"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   24
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   99
      End
      Begin Label labBalance
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ppEIPLSwitcher"
         Italic          =   False
         Left            =   673
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   9
         TabPanelIndex   =   1
         Text            =   "Balance:"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   24
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   136
      End
      Begin Label labTotal
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ppEIPLSwitcher"
         Italic          =   False
         Left            =   531
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   10
         TabPanelIndex   =   1
         Text            =   "Total:"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   23
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   138
      End
   End
   Begin TabPanel tbEIPLSwitcher
      AutoDeactivate  =   True
      Bold            =   False
      Enabled         =   True
      Height          =   23
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Panels          =   ""
      Scope           =   0
      SmallTabs       =   False
      TabDefinition   =   "Line Items\rDetails"
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   0
      Underline       =   False
      Value           =   0
      Visible         =   True
      Width           =   901
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Sub AddLinkedContactable(CreateNewOrUseExisting as string = "")
		  dim sResult as String
		  
		  sResult = CreateNewOrUseExisting
		  If CreateNewOrUseExisting = "" Then
		    
		    // Create a prompt asking the user if they want to use an existing inventory item or create a new one
		    Dim d as New MessageDialog                  //declare the MessageDialog object
		    Dim b as MessageDialogButton                //for handling the result
		    d.icon=MessageDialog.GraphicCaution         //display warning icon
		    d.ActionButton.Caption="Use Existing"
		    d.CancelButton.Visible=True                 
		    d.AlternateActionButton.Visible=True        //show the "Don't Save" button
		    d.AlternateActionButton.Caption="Create New"
		    d.Message="Do you want to use an existing contactable or create a new one?"
		    d.Explanation= "Think about it hard, the pancakes may suffer."
		    
		    // Show the dialog window
		    b=d.ShowModal
		    
		    
		    Select Case b
		    Case d.ActionButton
		      //user pressed Use Existing
		      sResult = "Use Existing"
		    Case d.AlternateActionButton
		      //user pressed  Create New
		      sResult = "Create New"
		    Case d.CancelButton
		      //user pressed Cancel
		      sResult = "Cancel"
		    End Select
		    
		  End If
		  
		  dim oLinkTheseToParent() as DataFile.tbl_contactables
		  
		  // Check which button was clicked
		  Select Case sResult
		  Case "Use Existing"
		    
		    // Open up the inventory picker so the user can choose which item they want to link
		    dim winPicker as New winContactablePicker
		    winPicker.instContactableList.bDisplayGrouped = True
		    winPicker.instContactableList.methLoadMe
		    winPicker.ShowModal
		    
		    // Loop through each record selected
		    For Each oRecord as DataFile.tbl_contactables In winPicker.oSelectedRecords()
		      
		      // append the item to the array of things to link to parent
		      oLinkTheseToParent.Append(oRecord)
		      
		    Next
		    
		  Case "Create New"
		    
		    // Create a new record
		    dim oNewRecord as New DataFile.tbl_contactables
		    oNewRecord.sname_first = "-"
		    oNewRecord.Save
		    
		    // Add this record to the linking list
		    oLinkTheseToParent.Append(oNewRecord)
		    
		    // Open a new tab with this in it
		    dim instContactable as New contContactable
		    app.MainWindow.AddTab("New Contact",True)
		    
		    instContactable.EmbedWithinPanel(app.MainWindow.tbMainWindow, app.MainWindow.tbMainWindow.PanelCount - 1)
		    
		    instContactable.LoadMe(oNewRecord)
		    
		  Case "Cancel"
		    Return
		  End select
		  
		  
		  
		  // Create the linking records
		  For Each oChild as DataFile.tbl_contactables In oLinkTheseToParent
		    
		    // Create a new link table item
		    dim oLinkItem as New DataFile.tbl_contactable_linking
		    oLinkItem.sfk_parent = oCurrentRecord.suuid
		    oLinkItem.sfk_child = oChild.suuid
		    oLinkItem.sparent_table = "tbl_eipl"
		    oLinkItem.Save
		    
		  Next
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub methAddInventoryToEIPL(aroRecords() as DataFile.tbl_inventory)
		  
		  // First we start looping through all of the selected records
		  For Each oRecord as DataFile.tbl_inventory In aroRecords()
		    
		    // Create a new lineitem record for this inventory item
		    dim oNewLI as DataFile.tbl_lineitems = oRecord.CopyToLI
		    oNewLI.sfkeipl = oCurrentRecord.suuid
		    oNewLI.Save
		    
		    // Lets find its children now 
		    // THe only onew we care about are the things contained within
		    dim oChildLinkRecords() as DataFile.tbl_internal_linking = DataFile.tbl_internal_linking.List( "fk_parent = '" + oRecord.suuid + "' And link_type = 'contained'" )
		    For Each oLinkRecord as DataFile.tbl_internal_linking In oChildLinkRecords()
		      
		      dim oChildInv as DataFile.tbl_inventory = DataFile.tbl_inventory.FindByID(oLinkRecord.sfk_child)
		      
		      // Copy the child over to a line item
		      dim oChildLI as DataFile.tbl_lineitems = oChildInv.CopyToLI
		      oChildLI.sfkeipl = ""
		      oChildLI.Save
		      
		      // Make a new link record for this child
		      dim oChildLink as New DataFile.tbl_internal_linking
		      oChildLink.sfk_parent = oNewLI.suuid
		      oChildLink.sfk_child = oChildLI.suuid
		      oChildLink.slink_type = "Contained"
		      oChildLink.Save
		      
		    Next
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function methGetSelectedRecordsFromInventory() As DataFile.tbl_inventory()
		  
		  
		  // Get all the selected rows from the inventory listbox
		  dim aroRowTags() as RecordStorageClass
		  aroRowTags = instInventoryList.lbItems.GetSelectedRows
		  
		  // Loop through all of the rowtags
		  dim aroRecords() as DataFile.tbl_inventory
		  For Each oRowTag as RecordStorageClass In aroRowTags
		    
		    // Extract the record from the rowtag
		    If oRowTag.oTableRecord <> Nil Then
		      
		      aroRecords.Append( oRowTag.GetTableRecordVariant )
		      
		    End If
		    
		  Next
		  
		  Return aroRecords()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub methLoadControls()
		  
		  labEIPLNumber.Text = "EIPL #: " + oCurrentRecord.ieipl_number.ToText
		  
		  instInventoryList.methLoadMe
		  
		  instLineItemList.oEIPLRecord = DataFile.StorifyRecords(oCurrentRecord)
		  instLineItemList.methLoadMe
		  
		  instEIPLContactablesList.EIPLID = oCurrentRecord.suuid
		  instEIPLContactablesList.methLoadMe
		  
		  instPaymentList.oEIPLRecord = oCurrentRecord
		  instPaymentList.methLoadMe
		  
		  instGroupDiscountList.oCurrentEIPL = oCurrentRecord
		  instGroupDiscountList.methLoadMe
		  
		  tfEIPLName.Text = oCurrentRecord.seipl_name
		  tfEIPLTaxRate.Text = str( oCurrentRecord.seipl_tax_rate, modFieldFormatting.tbl_eipl.eipl_tax_rate )
		  
		  dim sType as string = oCurrentRecord.seipl_type
		  For i1 as integer = 0 To pmEIPLType.ListCount - 1
		    If pmEIPLType.List(i1) = sType Then
		      pmEIPLType.ListIndex = i1
		      exit
		    End If
		  Next
		  
		  tfEIPLDiscount.Text = modFieldFormatting.FormatDiscountFields( oCurrentRecord.sdiscount )
		  
		  // Dates Times
		  dim dt1 as New Date
		  dim dtString, timeString as string
		  If oCurrentRecord.sdue_date = "" Then
		    dtString = dt1.SQLDate
		    dcDueDate.DateValue = Nil
		  Else
		    dtString = oCurrentRecord.sdue_date
		    dim dat1 as New Date
		    dat1.SQLDateTime = dtString + " 11:11:11"
		    dcDueDate.DateValue = dat1
		  End If
		  
		  // Load Total Labels
		  methPopulateTotals
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub methLoadMe(oRecord as DataFile.tbl_eipl)
		  
		  
		  oCurrentRecord = oRecord
		  
		  methLoadControls
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub methLoadMe(sUUID as String)
		  
		  
		  If sUUID <> "" Then
		    oCurrentRecord = DataFile.tbl_eipl.FindByID(sUUID)
		    
		    methLoadMe(oCurrentRecord)
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub methPopulateTotals()
		  dim retTots as TotalsClass = EICalculations.CalculateGroup(instLineItemList.aroStorClass, True, True)
		  
		  labSubTotal.Text = "SubTotal: " + str(retTots.a_SubTotal, "\$###,###,###,###.00")
		  labDiscountSum.Text = "Discount Sum: " + str(retTots.RunningDiscountSum, "\$###,###,###,###.00")
		  labTaxSum.Text = "Tax: " + str(retTots.TaxSum, "\$###,###,###,###.00")
		  labTotal.Text = "Total: " + str(retTots.c_Total, "\$###,###,###,###.00")
		  labBalance.Text = "Balance: " + str(retTots.d_BalanceDue, "\$###,###,###,###.00")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function methPrintingColWidths() As String
		  
		  dim s as string
		  
		  // Check database to see if there are any lineitems with discounts
		  dim sql as string =_
		  "Select disc_a, disc_b, Count(disc_a) as iCnt From "_
		  + "(SELECT "_
		  + "substr(li_discount, 1, instr(li_discount, ':') - 1) AS disc_a, "_
		  + "substr(li_discount,    instr(li_discount, ':') + 1) AS disc_b "_
		  + "FROM tbl_lineitems "_
		  + "Where fkeipl = ?) "_
		  + "Where (disc_a <> '' and disc_a <> '0%' and Cast(disc_a as decimal) <> 0 ) "_
		  + "Or (disc_b <> '' and disc_b <> '0%' and Cast(disc_b as decimal) <> 0);"
		  dim ps as SQLitePreparedStatement = app.db.Prepare(sql)
		  ps.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		  ps.Bind(0, oCurrentRecord.suuid)
		  dim discount_count as integer = DataFile.tbl_eipl.ListCount(ps)
		  
		  If discount_count = 0 Then
		    s = "25%,9%,9%,25%,5%,6%,5%,8%,8%"
		  Else
		    s = "25%,8%,7%,20%,5%,6%,5%,8%,8%,8%"
		  End If
		  
		  Return s
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function methPrintingFieldNames() As Dictionary
		  dim s1,s2() as string
		  
		  dim sRowType as string
		  
		  // Initialize dictionaries
		  dim dictFieldNames as New Dictionary
		  
		  // Check database to see if there are any lineitems with discounts
		  dim sql as string =_
		  "Select disc_a, disc_b, Count(disc_a) as iCnt From "_
		  + "(SELECT "_
		  + "substr(li_discount, 1, instr(li_discount, ':') - 1) AS disc_a, "_
		  + "substr(li_discount,    instr(li_discount, ':') + 1) AS disc_b "_
		  + "FROM tbl_lineitems "_
		  + "Where fkeipl = ?) "_
		  + "Where (disc_a <> '' and disc_a <> '0%' and Cast(disc_a as decimal) <> 0 ) "_
		  + "Or (disc_b <> '' and disc_b <> '0%' and Cast(disc_b as decimal) <> 0);"
		  dim ps as SQLitePreparedStatement = app.db.Prepare(sql)
		  ps.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		  ps.Bind(0, oCurrentRecord.suuid)
		  dim discount_count as integer = DataFile.tbl_eipl.ListCount(ps)
		  
		  If discount_count = 0 Then
		    s1 = "li_name,li_category,li_subcategory,li_description,li_time,li_rate,li_quantity,li_price,CalcTotal"
		  Else
		    s1 = "li_name,li_category,li_subcategory,li_description,li_time,li_rate,li_quantity,li_price,li_discount,CalcTotal"
		  End If
		  
		  // **********
		  // Set up the cell types and field names for each type of row
		  
		  // Group Folders
		  sRowType = "GroupFolder"
		  'field names
		  dictFieldNames.Value(sRowType) = Array("")
		  
		  // GrandParent
		  sRowType = "GrandParent"
		  'field names
		  s2() = Split(s1,",")
		  dictFieldNames.Value(sRowType) = s2
		  
		  // Linking Type Folder
		  sRowType = "LinkingTypeFolder"
		  'field names
		  dictFieldNames.Value(sRowType) = Array("")
		  
		  // LinkedItem - Version
		  sRowType = "Child - version"
		  'field names
		  s2() = Split(s1,",")
		  dictFieldNames.Value(sRowType) = s2
		  
		  // LinkedItem - Contained
		  sRowType = "Child - contained"
		  'field names
		  s2() = Split(s1,",")
		  dictFieldNames.Value(sRowType) = s2
		  
		  // LinkedItem - Contained
		  sRowType = "Child - kit"
		  'field names
		  s2() = Split(s1,",")
		  dictFieldNames.Value(sRowType) = s2
		  
		  // LinkedItem - Contained
		  sRowType = "Child - package"
		  'field names
		  s2() = Split(s1,",")
		  dictFieldNames.Value(sRowType) = s2
		  
		  Return dictFieldNames
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function methPrintingHeaders() As String()
		  dim s1, s2() as string
		  dim arsHeaders() as String
		  
		  // Check database to see if there are any lineitems with discounts
		  dim sql as string =_
		  "Select disc_a, disc_b, Count(disc_a) as iCnt From "_
		  + "(SELECT "_
		  + "substr(li_discount, 1, instr(li_discount, ':') - 1) AS disc_a, "_
		  + "substr(li_discount,    instr(li_discount, ':') + 1) AS disc_b "_
		  + "FROM tbl_lineitems "_
		  + "Where fkeipl = ?) "_
		  + "Where (disc_a <> '' and disc_a <> '0%' and Cast(disc_a as decimal) <> 0 ) "_
		  + "Or (disc_b <> '' and disc_b <> '0%' and Cast(disc_b as decimal) <> 0);"
		  dim ps as SQLitePreparedStatement = app.db.Prepare(sql)
		  ps.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		  ps.Bind(0, oCurrentRecord.suuid)
		  dim discount_count as integer = DataFile.tbl_eipl.ListCount(ps)
		  
		  If discount_count = 0 Then
		    s1 = "Name,Cat,SubCat,Description,Time,Rate,Qty,Price,Total"
		  Else
		    s1 = "Name,Cat,SubCat,Description,Time,Rate,Qty,Price,Discount,Total"
		  End If
		  
		  // Set header names
		  s2() = Split(s1,",")
		  arsHeaders() = s2()
		  
		  Return arsHeaders
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function methPrintingJustification() As Integer()
		  
		  dim ari() as integer
		  
		  // Check database to see if there are any lineitems with discounts
		  dim sql as string =_
		  "Select disc_a, disc_b, Count(disc_a) as iCnt From "_
		  + "(SELECT "_
		  + "substr(li_discount, 1, instr(li_discount, ':') - 1) AS disc_a, "_
		  + "substr(li_discount,    instr(li_discount, ':') + 1) AS disc_b "_
		  + "FROM tbl_lineitems "_
		  + "Where fkeipl = ?) "_
		  + "Where (disc_a <> '' and disc_a <> '0%' and Cast(disc_a as decimal) <> 0 ) "_
		  + "Or (disc_b <> '' and disc_b <> '0%' and Cast(disc_b as decimal) <> 0);"
		  dim ps as SQLitePreparedStatement = app.db.Prepare(sql)
		  ps.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		  ps.Bind(0, oCurrentRecord.suuid)
		  dim discount_count as integer = DataFile.tbl_eipl.ListCount(ps)
		  
		  If discount_count = 0 Then
		    ari = Array(1,1,1,1,2,2,2,3,3)
		  Else
		    ari = Array(1,1,1,1,2,2,2,3,2,3)
		  End If
		  
		  Return ari()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetUpPrintDocument() As BaseDocument
		  dim oEstimateInit as New EstimateInitObject
		  
		  // Gather Event Based Data
		  dim oEvent as DataFile.tbl_events = oCurrentRecord.FindParentEvent
		  dim sEventName as String 
		  If oEvent <> Nil Then
		    sEventName = oEvent.sevent_name
		  End If
		  
		  // Gather eipl based data
		  dim sDiscPerc, sDiscAmt as string
		  
		  
		  // Gather Contact Data
		  dim oContact as DataFile.tbl_contactables = oCurrentRecord.FindPrimaryContact
		  If oContact <> Nil Then
		    dim oPhone as DataFile.tbl_contact_methods = oContact.FindPrimaryPhone
		    dim oEmail as DataFile.tbl_contact_methods = oContact.FindPrimaryEmail
		    
		    oEstimateInit.BoxA_CompanyName = oContact.scompany
		    oEstimateInit.BoxA_ContactName = oContact.sname_first + " " + oContact.sname_last
		    oEstimateInit.BoxA_AddressLine1 = oContact.saddress_line1
		    oEstimateInit.BoxA_AddressLine2 = oContact.saddress_line2
		    oEstimateInit.BoxA_City = oContact.saddress_city
		    oEstimateInit.BoxA_State = oContact.saddress_state
		    oEstimateInit.BoxA_Zip = oContact.saddress_zip
		    If oPhone <> Nil Then oEstimateInit.BoxA_Phone = oPhone.smethod
		    If oEmail <> Nil Then oEstimateInit.BoxA_Email = oEmail.smethod
		  End If
		  
		  // Gather Venue Data
		  dim oVenue as DataFile.tbl_contactables = oCurrentRecord.FindPrimaryVenue
		  If oVenue <> Nil Then
		    dim oPhone as DataFile.tbl_contact_methods = oVenue.FindPrimaryPhone
		    dim oEmail as DataFile.tbl_contact_methods = oVenue.FindPrimaryEmail
		    
		    oEstimateInit.BoxB_VenueName = oVenue.sname_first + " " + oVenue.sname_last
		    oEstimateInit.BoxB_AddressLine1 = oVenue.saddress_line1
		    oEstimateInit.BoxB_AddressLine2 = oVenue.saddress_line2
		    oEstimateInit.BoxB_City = oVenue.saddress_city
		    oEstimateInit.BoxB_State = oVenue.saddress_state
		    oEstimateInit.BoxB_Zip = oVenue.saddress_zip
		    If oPhone <>  Nil Then oEstimateInit.BoxB_Phone = oPhone.smethod
		    If oEmail <> Nil Then oEstimateInit.BoxB_Email = oEmail.smethod
		  End If
		  
		  
		  oEstimateInit.HeaderLine1 = oCurrentRecord.seipl_type
		  oEstimateInit.HeaderLine2 = sEventName
		  oEstimateInit.HeaderLine3 = oCurrentRecord.seipl_name
		  oEstimateInit.LogoImage = EIPL_HeaderLogo
		  
		  
		  oEstimateInit.Box1_AccountManager = oEvent.saccount_manager
		  oEstimateInit.Box2_EventStartTime = modFieldFormatting.FormatTimeDisplay( oEvent.sstart_time )
		  oEstimateInit.Box2_EventStartDate = modFieldFormatting.FormatDateDisplay( oEvent.sstart_date )
		  oEstimateInit.Box3_EventEndTime = modFieldFormatting.FormatTimeDisplay( oEvent.send_time )
		  oEstimateInit.Box3_EventEndDate = modFieldFormatting.FormatDateDisplay( oEvent.send_date )
		  oEstimateInit.Box4_LoadInTime = modFieldFormatting.FormatTimeDisplay( oEvent.sloadin_time )
		  oEstimateInit.Box4_LoadInDate = modFieldFormatting.FormatDateDisplay( oEvent.sloadin_date )
		  oEstimateInit.Box5_LoadOutTime = modFieldFormatting.FormatTimeDisplay( oEvent.sloadout_time )
		  oEstimateInit.Box5_LoadOutDate = modFieldFormatting.FormatDateDisplay( oEvent.sloadout_date )
		  dim arsDisc() as String = oCurrentRecord.GetDiscounts  ' Get the discounts
		  If arsDisc(0) <> "" Then oEstimateInit.Box6_DiscountPercent = arsDisc(0)
		  If arsDisc(1) <> "" Then oEstimateInit.Box6_DiscountAmount = arsDisc(1)
		  If val(Methods.StripNonDigitsDecimals( oCurrentRecord.seipl_tax_rate )) <> 0 Then oEstimateInit.Box7_Tax = oCurrentRecord.seipl_tax_rate
		  oEstimateInit.Box8_PaymentDue = modFieldFormatting.FormatDateDisplay( oCurrentRecord.sdue_date )
		  
		  oEstimateInit.LI_Records = instLineItemList.aroStorClass
		  oEstimateInit.LI_FieldNames = methPrintingFieldNames
		  oEstimateInit.LI_Headers = methPrintingHeaders
		  oEstimateInit.LI_ColumnWidths = methPrintingColWidths
		  oEstimateInit.LI_Justification = methPrintingJustification
		  
		  
		  // Create the Estimate
		  dim oStor as RecordStorageClass = DataFile.StorifyRecords(oCurrentRecord)
		  
		  dim oEst as New EstimateDocument(oStor, oEstimateInit)
		  
		  
		  
		  Return oEst
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		oCurrentRecord As DataFile.tbl_eipl
	#tag EndProperty


#tag EndWindowCode

#tag Events ppEIPLSwitcher
	#tag Event
		Sub Change()
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events instLineItemList
	#tag Event
		Sub evdefOpen()
		  me.bDisplayGrouped = True
		  
		End Sub
	#tag EndEvent
	#tag Event
		Function evdefDoubleClick() As Boolean
		  
		  
		  If instLineItemList.lbItems.ListIndex <> -1 Then
		    
		    dim oRowTag as RecordStorageClass = instLineItemList.lbItems.RowTag( instLineItemList.lbItems.ListIndex )
		    
		    dim oRecord as DataFile.tbl_lineitems
		    If oRowTag.oTableRecord <> Nil Then
		      dim v as Variant = oRowTag.oTableRecord
		      oRecord = v
		      instLIDetails.LoadMe(oRecord)
		    End If
		    
		  End If
		  
		  
		  
		  Return True
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events instInventoryList
	#tag Event
		Sub evdefListboxSettings(lbItems as entListbox, ByRef dictCellTypes as Dictionary, ByRef dictFieldNames as Dictionary)
		  
		  
		  dim s1,s2() as string
		  
		  dim sRowType as string
		  
		  // Set Column Count
		  dim iColCount as integer = 4
		  lbItems.ColumnCount = iColCount
		  
		  // Initialize dictionaries
		  dictFieldNames = New Dictionary
		  dictCellTypes = New Dictionary
		  
		  // Set header names
		  s1 = "Name,Description,Qty,Price"
		  s2() = Split(s1,",")
		  lbItems.Heading = s2()
		  
		  
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
		  s1 = "item_name,item_description,item_quantity,item_rental_price"
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
		  
		  
		  // LinkedItem - Version
		  sRowType = "Child - version"
		  'field names
		  s1 = "item_name,item_description,item_quantity,item_rental_price"
		  s2() = Split(s1,",")
		  dictFieldNames.Value(sRowType) = s2
		  
		  'cell types
		  dim iCellTypes4() as integer = Array(0,0,0,0)
		  dictCellTypes.Value(sRowType) = iCellTypes4
		  
		  
		  // LinkedItem - Contained
		  sRowType = "Child - contained"
		  'field names
		  s1 = "item_name,item_description,item_quantity,item_rental_price"
		  s2() = Split(s1,",")
		  dictFieldNames.Value(sRowType) = s2
		  
		  'cell types
		  dim iCellTypes5() as integer = Array(0,0,0,0)
		  dictCellTypes.Value(sRowType) = iCellTypes5
		  
		  // LinkedItem - Contained
		  sRowType = "Child - kit"
		  'field names
		  s1 = "item_name,item_description,item_quantity,item_rental_price"
		  s2() = Split(s1,",")
		  dictFieldNames.Value(sRowType) = s2
		  
		  'cell types
		  dim iCellTypes6() as integer = Array(0,0,0,0)
		  dictCellTypes.Value(sRowType) = iCellTypes6
		  
		  // LinkedItem - Contained
		  sRowType = "Child - package"
		  'field names
		  s1 = "item_name,item_description,item_quantity,item_rental_price"
		  s2() = Split(s1,",")
		  dictFieldNames.Value(sRowType) = s2
		  
		  'cell types
		  dim iCellTypes7() as integer = Array(0,0,0,0)
		  dictCellTypes.Value(sRowType) = iCellTypes7
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub evdefOpen()
		  
		  me.bDisplayGrouped = True
		  me.bPickerMode = True
		End Sub
	#tag EndEvent
	#tag Event
		Function evdefDoubleClick() As Boolean
		  
		  // Lets add the inventory item selected to the eipl
		  dim aroRecords() as DataFile.tbl_inventory
		  aroRecords = methGetSelectedRecordsFromInventory
		  methAddInventoryToEIPL( aroRecords )
		  
		  
		  
		  Return True
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events pbAddRecord
	#tag Event
		Sub Action()
		  dim sNewOrExisting as string
		  
		  // ===============================
		  // Define menu extries
		  // ===============================
		  dim base as new MenuItem
		  base.Append( new MenuItem( "Create New" ) )  '0
		  dim MI1 as New MenuItem( "Use Existing" )
		  MI1.Enabled = True
		  base.Append( MI1 )  '1
		  'dim MI2 as New MenuItem( "Package" )
		  'MI2.Enabled = True
		  'base.Append( new MenuItem( MI2 ) )  '2
		  // ===============================
		  // Set the enabled status
		  // ===============================
		  
		  // ===============================
		  // Carry out actions
		  // ===============================
		  dim hitItem as MenuItem
		  hitItem = base.PopUp
		  
		  If hitItem <> Nil Then
		    Select Case hitItem.Text
		    Case "Create New"
		      sNewOrExisting = "Create New"
		    Case "Use Existing"
		      sNewOrExisting = "Use Existing"
		    End Select
		  Else
		    Return
		  End If
		  
		  AddLinkedContactable(sNewOrExisting)
		  
		  instEIPLContactablesList.methRefresh
		  
		  
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events tfEIPLName
	#tag Event
		Sub LostFocus()
		  
		  oCurrentRecord.seipl_name = me.Text
		  oCurrentRecord.Save
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events pmEIPLType
	#tag Event
		Sub Open()
		  
		  dim sTypes() as string = ValueRef.EIPLTypes.Split(",")
		  For Each sType as string In sTypes()
		    me.AddRow(sType)
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  
		  oCurrentRecord.seipl_type = me.Text
		  oCurrentRecord.Save
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events dcDueDate
	#tag Event
		Sub LostFocus()
		  dim d1 as Date
		  dim s1 as string
		  
		  If me.Checked Then
		    d1 = me.DateValue
		    s1 = d1.SQLDate
		  Else 
		    s1 = ""
		  End If
		  
		  oCurrentRecord.sdue_date = s1
		  oCurrentRecord.Save
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events tfEIPLTaxRate
	#tag Event
		Sub LostFocus()
		  
		  oCurrentRecord.seipl_tax_rate = Methods.StripNonDigitsDecimals( me.Text )
		  oCurrentRecord.Save
		  
		  me.Text = str( oCurrentRecord.seipl_tax_rate, modFieldFormatting.tbl_eipl.eipl_tax_rate )
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events labEIPLNumber
	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  
		  dim sUUID as string = oCurrentRecord.suuid
		  base.Append( New MenuItem(sUUID) )
		  base.Append( New MenuItem("Copy UUID") )
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  
		  Select Case hitItem.Text
		  Case "Copy UUID"
		    dim s as String = oCurrentRecord.suuid
		    dim c as new Clipboard
		    c.Text = s
		    c.Close
		  End Select
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events tfEIPLDiscount
	#tag Event
		Sub LostFocus()
		  
		  oCurrentRecord.sdiscount = modFieldFormatting.DeFormatDiscountFields(me.Text)
		  oCurrentRecord.Save
		  
		  me.Text = modFieldFormatting.FormatDiscountFields(oCurrentRecord.sdiscount)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events pbPrintPreview
	#tag Event
		Sub Action()
		  dim oDoc as BaseDocument = SetUpPrintDocument
		  
		  dim base as new MenuItem
		  base.Append( new MenuItem( "Preview" ) )  '0
		  base.Append( new MenuItem( "Print" ) )  '1
		  
		  dim hitItem as MenuItem
		  hitItem = base.PopUp
		  
		  Select Case hitItem.Text
		  Case "Preview"
		    
		    // Display the EIPL
		    dim winPP as New winPrintPreview
		    winPP.Canvas1.Backdrop = New Picture(winPP.Canvas1.Width, winPP.Canvas1.Height)
		    dim arp() as Picture
		    
		    
		    arp = oDoc.PrintPreview(winPP.Canvas1.Width, winPP.Canvas1.Height)
		    
		    winPP.NewArray(arp)
		    
		    
		    winPP.Visible = True
		    
		  Case "Print"
		    
		    oDoc.Print
		    
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events tbEIPLSwitcher
	#tag Event
		Sub Change()
		  
		  ppEIPLSwitcher.Value = tbEIPLSwitcher.Value
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
