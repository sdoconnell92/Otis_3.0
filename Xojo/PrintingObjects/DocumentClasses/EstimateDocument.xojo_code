#tag Class
Protected Class EstimateDocument
Inherits BaseDocument
	#tag Method, Flags = &h0
		Sub Constructor()
		  
		  // Create the Header
		  dim oHeader as New BaseStoryObject
		  oHeader.Height = 80
		  
		  // Create Logo for header
		  dim oLogoImage as New InnerImage(me)
		  oLogoImage.Content = img0old
		  
		  oHeader.aroInnerObjects.Append(oLogoImage)
		  
		  // Create RIght side text
		  dim oHeaderText as New InnerText( Array( "Estimate", "Event Name", "Estimate Name" ), me )
		  oHeaderText.Bold = Array( True, False, False )
		  oHeaderText.FontSize = Array(16,12,12)
		  oHeaderText.JustificationHor = 0
		  oHeaderText.xPosition = "0.75%"
		  oHeaderText.yPosition = "0.1%"
		  
		  oHeader.aroInnerObjects.Append(oHeaderText)
		  
		  // Append the story items to the document
		  aroStory.Append(oHeader)
		  
		  
		  
		  dim oLargeBoxStory as New BaseStoryObject
		  oLargeBoxStory.Height = 104
		  
		  dim oBoxes as New InnerBoxes(me)
		  oBoxes.AddBox( Array( "Contact", "Company Name", "Contact Name", "Address Line 1", "Address Line 2", "City State, Zip", "Phone Number", "Email Address" ) )
		  oBoxes.AddBox( Array( "Venue / Site", "Venue Name", "Address Line 1", "City State, Zip", "Phone Number" ) )
		  oBoxes.BoxSpacing = 15
		  oBoxes.ChangeFontSizes( Array( 11,10,10,10,10,10,10,10) )
		  
		  oLargeBoxStory.aroInnerObjects.Append(oBoxes)
		  
		  aroStory.Append(oLargeBoxStory)
		  
		  dim oSmallBoxStory as New BaseStoryObject
		  oSmallBoxStory.Height = 36
		  
		  dim oSmBoxes1 as New InnerBoxes(me)
		  oSmBoxes1.AddBox( Array( "Account Manager", "Name Here" ), 0 )
		  oSmBoxes1.AddBox( Array( "Event Start", "Start Time", "Start Date" ), 0 )
		  oSmBoxes1.AddBox( Array( "Event End", "End Time", "End Date" ), 0 )
		  oSmBoxes1.AddBox( Array( "Load-In", "Load-In Time", "Load-In Date" ), 0 )
		  oSmBoxes1.ChangeFontSizes( Array( 10,9,9 ) )
		  
		  oSmallBoxStory.aroInnerObjects.Append(oSmBoxes1)
		  
		  aroStory.Append(oSmallBoxStory)
		  
		  
		  dim oSmallBoxStory2 as New BaseStoryObject
		  oSmallBoxStory2.Height = 36
		  
		  dim oSmBoxes2 as New InnerBoxes(me)
		  oSmBoxes2.AddBox( Array( "Load-Out", "Load-Out Time", "Load-Out Date" ), 0 )
		  oSmBoxes2.AddBox( Array( "Discount", "0%" ), 0 )
		  oSmBoxes2.AddBox( Array( "Tax", "0%" ), 0 )
		  oSmBoxes2.ChangeFontSizes( Array( 10,9,9 ) )
		  
		  oSmallBoxStory2.aroInnerObjects.Append(oSmBoxes2)
		  
		  aroStory.Append(oSmallBoxStory2)
		  
		  dim oLIStory as New LineItemStory
		  dim oLI1 as New InnerLineItem(me)
		  dim oLI2 as New InnerLineItem(me)
		  dim oLI3 as New InnerLineItem(me)
		  dim oLI4 as New InnerLineItem(me)
		  dim oLI5 as New InnerLineItem(me)
		  dim oLI6 as New InnerLineItem(me)
		  
		  oLIStory.aroInnerObjects = Array(oLI1,oLI2,oLI3,oLI4,oLI5,oLI6)
		  
		  aroStory.Append(oLIStory)
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod


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
