#tag Class
Protected Class EstimateDocument
Inherits BaseDocument
	#tag Method, Flags = &h0
		Sub BuildHeader()
		  // Create the Header Object
		  dim oHeader as New BaseStoryObject
		  oHeader.Height = 80
		  
		  // Create Logo for header
		  dim oLogoImage as New InnerImage(oEst)
		  oLogoImage.Content = EIPLHeaderLogo_Print_v20
		  
		  oHeader.aroInnerObjects.Append(oLogoImage)
		  
		  // Create Right side text
		  dim oHeaderText as New InnerText( Array( InitObject.HeaderLine1, InitObject.HeaderLine3, InitObject.HeaderLine3 ), me )
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
		  
		  oBoxes.AddBox( Array( "Contact",_
		  InitObject.BoxA_CompanyName,_
		  InitObject.BoxA_ContactName,_
		  InitObject.BoxA_AddressLine1,_
		  InitObject.BoxA_AddressLine2,_
		  InitObject.BoxA_City + InitObject.BoxA_State + ", " + InitObject.BoxA_Zip,_
		  InitObject.BoxA_Phone,_
		  InitObject.BoxA_Email _
		   ) )
		  
		  oBoxes.AddBox( Array( "Venue / Site",_
		  InitObject.BoxB_VenueName,_
		  InitObject.BoxB_AddressLine1,_
		  InitObject.BoxB_AddressLine2,_
		  InitObject.BoxB_City + InitObject.BoxB_State + ", " + InitObject.BoxB_Zip,_
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
		  
		  dim oLIStory as New LineItemStory(_
		  InitObject.LI_Records,_
		  InitObject.LI_FieldNames,_
		  InitObject.LI_Headers,_
		  me,_
		  InitObject.LI_ColumnWidths)
		  
		  aroStory.Append(oLIStory)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BuildSmallBoxes()
		  dim oSmallBoxStory as New BaseStoryObject
		  oSmallBoxStory.Height = 36
		  
		  dim oSmBoxes1 as New InnerBoxes(oEst)
		  
		  oSmBoxes1.AddBox( Array( "Account Manager",_
		   InitObject.Box1_AccountManager ),_
		   0 )
		  oSmBoxes1.AddBox( Array( "Event Start",_
		   InitObject.Box2_EventStartTime,_
		   InitObject.Box2_EventStartDate ),_
		   0 )
		  oSmBoxes1.AddBox( Array( "Event End",_
		   InitObject.Box3_EventEndTime,_
		   InitObject.Box3_EventEndDate ),_
		   0 )
		  oSmBoxes1.AddBox( Array( "Load-In",_
		   InitObject.Box4_LoadInTime,_
		   InitObject.Box4_LoadInDate ),_
		   0 )
		  
		  // Change font sizes
		  oSmBoxes1.ChangeFontSizes( Array( 10,9,9 ) )
		  
		  oSmallBoxStory.aroInnerObjects.Append(oSmBoxes1)
		  aroStory.Append(oSmallBoxStory)
		  
		  
		  dim oSmallBoxStory2 as New BaseStoryObject
		  oSmallBoxStory2.Height = 36
		  
		  dim oSmBoxes2 as New InnerBoxes(oEst)
		  
		  oSmBoxes2.AddBox( Array( "Load-Out",_
		  InitObject.Box5_LoadOutTime,_
		  InitObject.Box5_LoadOutDate ),_
		   0 )
		  oSmBoxes2.AddBox( Array( "Discount",_
		  InitObject.Box6_DiscountPercent,_
		   InitObject.Box6_DiscountAmount ),_
		   0 )
		  oSmBoxes2.AddBox( Array( "Tax",_
		  InitObject.Box7_Tax ),_
		  0 )
		  
		  // Change Font Sizes
		  oSmBoxes2.ChangeFontSizes( Array( 10,9,9 ) )
		  
		  oSmallBoxStory2.aroInnerObjects.Append(oSmBoxes2)
		  aroStory.Append(oSmallBoxStory2)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(oEIPLStor as RecordStorageClass, EstInit as EsitmateInitObject)
		  oEIPL = oEIPLStor
		  
		  BuildHeader
		  BuildLargeBoxes
		  BuildSmallBoxes
		  BuildLineItemStory
		  
		  dim winPP as New winPrintPreview
		  winPP.Canvas1.Backdrop = New Picture(winPP.Canvas1.Width, winPP.Canvas1.Height)
		  dim arp() as Picture
		  
		  
		  arp = oEst.PrintPreview(winPP.Canvas1.Width, winPP.Canvas1.Height)
		  
		  winPP.NewArray(arp)
		  
		  
		  winPP.Visible = True
		  
		  
		  // oEst.Print
		  
		  
		  
		  
		  
		  
		  
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
