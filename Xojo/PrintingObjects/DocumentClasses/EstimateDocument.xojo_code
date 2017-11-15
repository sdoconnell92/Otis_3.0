#tag Class
Protected Class EstimateDocument
Inherits BaseDocument
	#tag Method, Flags = &h0
		Sub BuildFooter()
		  // Create the Header Object
		  dim oFooter as New FooterStory
		  oFooter.Height = 30
		  oFooter.bRepeatEveryPage = True
		  
		  // Create Right side text
		  dim oPageNumbers as New InnerPageNumbers( me )
		  oPageNumbers.Bold = False
		  oPageNumbers.FontSize = 9
		  oPageNumbers.xPosition = "0.85%"
		  oPageNumbers.yPosition = "0.1%"
		  
		  oFooter.aroInnerObjects.Append(oPageNumbers)
		  
		  // Append the story items to the document
		  aroStory.Append(oFooter)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BuildHeader()
		  // Create the Header Object
		  dim oHeader as New BaseStoryObject
		  oHeader.Height = 80
		  oHeader.bRepeatEveryPage = True
		  
		  // // Create Logo for header
		  // dim oLogoImage as New InnerImage(me)
		  // oLogoImage.Content = EIPLHeaderLogo_Print_v20
		  // 
		  // oHeader.aroInnerObjects.Append(oLogoImage)
		  
		  // Create Right side text
		  dim oHeaderText as New InnerText( Array( InitObject.HeaderLine1, InitObject.HeaderLine2, InitObject.HeaderLine3 ), me )
		  oHeaderText.Bold = Array( True, False, False )
		  oHeaderText.FontSize = Array(16,12,12)
		  oHeaderText.JustificationHor = 0
		  oHeaderText.xPosition = "0.75%"
		  oHeaderText.yPosition = "0.1%"
		  
		  oHeader.aroInnerObjects.Append(oHeaderText)
		  
		  // Append the story items to the document
		  aroStory.Append(oHeader)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BuildLargeBoxes()
		  
		  dim oLargeBoxStory as New BaseStoryObject
		  oLargeBoxStory.Height = 104
		  
		  dim oBoxes as New InnerBoxes(me)
		  
		  dim csz as string
		  If InitObject.BoxA_City <> "" And InitObject.BoxA_State <> "" And InitObject.BoxA_Zip <> "" Then csz = InitObject.BoxA_City + " " + InitObject.BoxA_State + ", " + InitObject.BoxA_Zip
		  oBoxes.AddBox( Array( "Contact",_
		  InitObject.BoxA_CompanyName,_
		  InitObject.BoxA_ContactName,_
		  InitObject.BoxA_AddressLine1,_
		  InitObject.BoxA_AddressLine2,_
		  csz,_
		  InitObject.BoxA_Phone,_
		  InitObject.BoxA_Email _
		  ) )
		  
		  dim csz1 as string
		  If InitObject.BoxB_City <> "" And InitObject.BoxB_State <> "" And InitObject.BoxB_Zip <> "" Then csz1 = InitObject.BoxB_City + " " + InitObject.BoxB_State + ", " + InitObject.BoxB_Zip
		  oBoxes.AddBox( Array( "Venue / Site",_
		  InitObject.BoxB_VenueName,_
		  InitObject.BoxB_AddressLine1,_
		  InitObject.BoxB_AddressLine2,_
		  csz1,_
		  InitObject.BoxB_Phone,_
		  InitObject.BoxB_Email _
		  ) )
		  
		  oBoxes.BoxSpacing = 15
		  oBoxes.ChangeFontSizes( Array( 11,10,10,10,10,10,10,10) )
		  
		  oLargeBoxStory.aroInnerObjects.Append(oBoxes)
		  
		  aroStory.Append(oLargeBoxStory)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BuildLineItemStory()
		  
		  dim oLIStory as New LineItemStory( InitObject.LI_Records, InitObject.LI_FieldNames, InitObject.LI_Headers, me, InitObject.LI_ColumnWidths)
		  
		  aroStory.Append(oLIStory)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BuildRemitBox()
		  // Create the Header Object
		  dim oRemit as New RemitStory
		  oRemit.Width = 250
		  oRemit.Height = 100
		  oRemit.bOnlyLastPage = True
		  
		  dim s as string = "Thank you for your bisiness! We look forward to continuing to work with you on great events in the future! Please remit payment to: Northern Sun Productions, 522 6th Ave NW, Rochester, MN 55901. Thank You."
		  // Create Right side text
		  dim oRemitText as New InnerText( Array(s), me )
		  dim bord as new BorderClass
		  bord.Left = True
		  bord.Right = True
		  bord.Top = True
		  bord.Bottom = True
		  oRemitText.ContentBorder = Array(bord)
		  oRemitText.Width = 200
		  oRemitText.Bold = Array( False )
		  oRemitText.FontSize = Array(9)
		  oRemitText.JustificationHor = -1
		  oRemitText.xPosition = "0.20%"
		  oRemitText.yPosition = "0.1%"
		  
		  oRemit.aroInnerObjects.Append(oRemitText)
		  
		  // Append the story items to the document
		  aroStory.Append(oRemit)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BuildSmallBoxes()
		  dim oSmallBoxStory as New BaseStoryObject
		  oSmallBoxStory.Height = 36
		  
		  dim oSmBoxes1 as New InnerBoxes(me)
		  dim s as string
		  
		  If InitObject.Box1_AccountManager = "" Then
		    s = ""
		  Else
		    s = "Account Manager"
		  End If
		  oSmBoxes1.AddBox( Array( s,_
		  InitObject.Box1_AccountManager ),_
		  0 )
		  If InitObject.Box2_EventStartTime = ""  And InitObject.Box2_EventStartDate = "" Then
		    s = ""
		  Else
		    s = "Event Start"
		  End If
		  oSmBoxes1.AddBox( Array( s,_
		  InitObject.Box2_EventStartTime,_
		  InitObject.Box2_EventStartDate ),_
		  0 )
		  If InitObject.Box3_EventEndTime = ""  And InitObject.Box3_EventEndDate = "" Then
		    s = ""
		  Else
		    s = "Event End"
		  End If
		  oSmBoxes1.AddBox( Array( s,_
		  InitObject.Box3_EventEndTime,_
		  InitObject.Box3_EventEndDate ),_
		  0 )
		  If InitObject.Box4_LoadInTime = ""  And InitObject.Box4_LoadInDate = "" Then
		    s = ""
		  Else
		    s = "Event End"
		  End If
		  oSmBoxes1.AddBox( Array( s,_
		  InitObject.Box4_LoadInTime,_
		  InitObject.Box4_LoadInDate ),_
		  0 )
		  
		  // Change font sizes
		  oSmBoxes1.ChangeFontSizes( Array( 10,9,9 ) )
		  
		  oSmallBoxStory.aroInnerObjects.Append(oSmBoxes1)
		  aroStory.Append(oSmallBoxStory)
		  
		  
		  dim oSmallBoxStory2 as New BaseStoryObject
		  oSmallBoxStory2.Height = 36
		  
		  dim oSmBoxes2 as New InnerBoxes(me)
		  
		  If InitObject.Box5_LoadOutTime = ""  And InitObject.Box5_LoadOutDate = "" Then
		    s = ""
		  Else
		    s = "Load-Out"
		  End If
		  oSmBoxes2.AddBox( Array( s,_
		  InitObject.Box5_LoadOutTime,_
		  InitObject.Box5_LoadOutDate ),_
		  0 )
		  If InitObject.Box6_DiscountPercent = ""  And InitObject.Box6_DiscountAmount = "" Then
		    s = "dssadd"
		  Else
		    s = "Discount"
		  End If
		  oSmBoxes2.AddBox( Array( s,_
		  InitObject.Box6_DiscountPercent,_
		  InitObject.Box6_DiscountAmount ),_
		  0 )
		  If InitObject.Box7_Tax = "" Then
		    s = ""
		  Else
		    s = "Tax"
		  End If
		  oSmBoxes2.AddBox( Array( s,_
		  InitObject.Box7_Tax ),_
		  0 )
		  If InitObject.Box8_PaymentDue = "" Then
		    s = ""
		  Else
		    s = "Payment Due"
		  End If
		  oSmBoxes2.AddBox( Array( s,_
		  InitObject.Box8_PaymentDue),_
		  0 )
		  
		  // Change Font Sizes
		  oSmBoxes2.ChangeFontSizes( Array( 10,9,9 ) )
		  
		  oSmallBoxStory2.aroInnerObjects.Append(oSmBoxes2)
		  aroStory.Append(oSmallBoxStory2)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(oEIPLStor as RecordStorageClass, EstInit as EstimateInitObject)
		  InitObject = EstInit
		  oEIPL = oEIPLStor
		  
		  BuildHeader
		  BuildLargeBoxes
		  BuildSmallBoxes
		  BuildLineItemStory
		  BuildRemitBox
		  BuildFooter
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		InitObject As EstimateInitObject
	#tag EndProperty

	#tag Property, Flags = &h0
		oEIPL As RecordStorageClass
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="bPrintDone"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="iCurrentPage"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="iNumberofPages"
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
			Name="Margin"
			Group="Behavior"
			InitialValue="40"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RemitY"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="StorySpacing"
			Group="Behavior"
			InitialValue="10"
			Type="Integer"
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
