#tag Class
Protected Class LineItemStory
Inherits BaseStoryObject
	#tag Method, Flags = &h0
		Sub Constructor(aroLIs() as RecordStorageClass, pdictFieldNames as Dictionary, parsHeaders() as String, sColWidths as string = "")
		  aroLineItems = aroLIs
		  dictFieldNames = pdictFieldNames
		  arsColWidths = split( sColWidths, ",")
		  arsHeaders = parsHeaders
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Draw(g as Graphics)
		  
		  
		  // Find the true widths
		  PopulateTrueWidths(g)
		  
		  dim y as integer = RecipricateThroughLI(g, aroLineItems)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PopulateTrueWidths(g as Graphics)
		  
		  If arsColWidths().Ubound <> arsHeaders.ubound Then
		    redim ariTrueWidths(-1)
		    
		    For i1 as integer = 0 To arsHeaders.Ubound
		      dim i2 as integer = g.Width / (arsHeaders.Ubound + 1)
		      ariTrueWidths.Append(i2)
		    Next
		    
		  Else
		    
		    For each s1 as string In arsColWidths
		      
		      If s1.InStr("%") <> 0 Then
		        // this is a percent
		        dim d1 as Double = val(Methods.StripNonDigitsDecimals(s1))
		        d1 = d1 / 100
		        ariTrueWidths.Append(g.Width * d1)
		      Else
		        // not a percent
		        dim i1 as integer = floor(val(Methods.StripNonDigitsDecimals(s1)))
		        ariTrueWidths.Append(i1)
		      End If
		      
		      
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RecipricateThroughLI(g as Graphics, aroLines() as RecordStorageClass,  yIndexInput as integer = 0) As integer
		  dim iTextHeight as integer
		  dim iLineBuffer as integer = 1
		  
		  g.TextSize = FontSize
		  iTextHeight = g.TextHeight
		  
		  dim yIndex as integer = yIndexInput
		  For Each oLine as RecordStorageClass In aroLines()
		    
		    oLine.PopulatePrintData(dictFieldNames, me)
		    
		    dim iLeftOffset as integer = (oLine.arsGroupStructure.Ubound + 1) * 10
		    dim gClip as Graphics
		    dim iClipWidth, iClipHeight as integer
		    iClipWidth = g.Width - iLeftOffset
		    iClipHeight = iTextHeight + iLineBuffer + iLineBuffer
		    
		    gClip = g.Clip( iLeftOffset, yIndex, iClipWidth, iClipHeight )
		    gClip.TextSize = FontSize
		    
		    
		    oLine.oPrintData.Draw(gClip, iLeftOffset)
		    
		    yIndex = yIndex + iClipHeight
		    
		    // Check if this Record has children
		    If oLine.aroChildren.Ubound <> -1 Then
		      yIndex = yIndex + RecipricateThroughLI(g, oLine.aroChildren, yIndex)
		    End If
		    
		  Next
		  
		  Return yIndex
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		ariTrueWidths() As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		aroLineItems() As RecordStorageClass
	#tag EndProperty

	#tag Property, Flags = &h0
		arsColWidths() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		arsHeaders() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		dictFieldNames As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		FontSize As Integer = 9
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="FontSize"
			Group="Behavior"
			InitialValue="9"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Group="Behavior"
			InitialValue="-1"
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
		#tag ViewProperty
			Name="Width"
			Group="Behavior"
			InitialValue="-1"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
