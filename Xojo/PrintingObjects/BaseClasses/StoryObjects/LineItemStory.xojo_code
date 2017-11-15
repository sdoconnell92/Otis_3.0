#tag Class
Protected Class LineItemStory
Inherits BaseStoryObject
	#tag Method, Flags = &h0
		Sub AddTotals()
		  DeleteTotals(aroLineItems)
		  
		  For Each oLine as RecordStorageClass In aroLineItems()
		    
		    dim retTotals as TotalsClass = CalculateSingleLine(oLine)
		    dim gn as string = oLine.sFolderName
		    
		    dim oTotalLine1 as New RecordStorageClass
		    oTotalLine1.oParentStor = oLine
		    oTotalLine1.oPrintData.oParentStory = me
		    oTotalLine1.isTotal = True
		    oTotalLine1.oPrintData.arsColumnValues = Array( gn +" SubTotal", str(retTotals.a_SubTotal, "\$###,###,###,###.00"))
		    
		    dim oTotalLine2 as New RecordStorageClass
		    oTotalLine2.oParentStor = oLine
		    oTotalLine2.oPrintData.oParentStory = me
		    oTotalLine2.isTotal = True
		    dim sTitle as String
		    If val(methods.StripNonDigitsDecimals(retTotals.sDiscountPercent)) <> 0 Then
		      sTitle = gn + " Discount(" + retTotals.sDiscountPercent + ")"
		    Else
		      sTitle = gn + " Discount"
		    End If
		    oTotalLine2.oPrintData.arsColumnValues = Array(sTitle, str(retTotals.LocalDiscountSum, "\$###,###,###,###.00"))
		    
		    dim oTotalLine3 as New RecordStorageClass
		    oTotalLine3.oParentStor = oLine
		    oTotalLine3.oPrintData.oParentStory = me
		    oTotalLine3.isTotal = True
		    oTotalLine3.oPrintData.arsColumnValues = Array( gn + " Total", str(retTotals.c_Total, "\$###,###,###,###.00"))
		    
		    If retTotals.LocalDiscountSum <> 0 Then oLine.aroChildren.Append(oTotalLine1)
		    If retTotals.LocalDiscountSum <> 0 Then oLine.aroChildren.Append(oTotalLine2)
		    oLine.aroChildren.Append(oTotalLine3)
		  Next
		  
		  dim retTotals as TotalsClass = CalculateGroup(aroLineItems, True)
		  
		  dim oTotalLine1 as New RecordStorageClass
		  oTotalLine1.oPrintData.oParentStory = me
		  oTotalLine1.isTotal = True
		  oTotalLine1.oPrintData.arsColumnValues = Array("SubTotal", str(retTotals.PreAllDisc, "\$###,###,###,###.00"))
		  
		  dim oTotalLine2 as New RecordStorageClass
		  oTotalLine2.oPrintData.oParentStory = me
		  oTotalLine2.isTotal = True
		  oTotalLine2.oPrintData.arsColumnValues = Array("Discount", str(retTotals.RunningDiscountSum, "\$###,###,###,###.00"))
		  
		  dim oTotalLine3 as New RecordStorageClass
		  oTotalLine3.oPrintData.oParentStory = me
		  oTotalLine3.isTotal = True
		  oTotalLine3.oPrintData.arsColumnValues = Array("Grand Total", str(retTotals.c_Total, "\$###,###,###,###.00"))
		  
		  aroLineItems.Append(oTotalLine1)
		  If retTotals.RunningDiscountSum <> 0 Then aroLineItems.Append(oTotalLine2)
		  aroLineItems.Append(oTotalLine3)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(aroLIs() as RecordStorageClass, pdictFieldNames as Dictionary, parsHeaders() as String, EDoc as EstimateDocument, sColWidths as string = "")
		  aroLineItems = aroLIs
		  dictFieldNames = pdictFieldNames
		  arsColWidths = split( sColWidths, ",")
		  arsHeaders = parsHeaders
		  oParentEIPLDoc = EDoc
		  
		  AddTotals
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateClip(g as Graphics, oLine as RecordStorageClass, yIndex as integer) As Graphics
		  dim iTextHeight as integer = g.TextHeight
		  
		  dim gClip as Graphics
		  dim iClipWidth, iClipHeight as integer
		  iClipWidth = g.Width
		  iClipHeight = (iTextHeight * oLine.oPrintData.StringLines) + (iLineBuffer * 2)
		  
		  gClip = g.Clip( 0, yIndex, iClipWidth, iClipHeight )
		  
		  Return gClip
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteTotals(aro() as RecordStorageClass)
		  For i1 as integer = aro.Ubound DownTo 0
		    dim oLine as RecordStorageClass = aro(i1)
		    
		    If oLine.StorType = "Total" Then 
		      aro.Remove(i1)
		      Continue
		    End If
		    
		    If oLine.aroChildren.Ubound <> -1 Then
		      DeleteTotals(oLine.aroChildren)
		    End If
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Draw(g as Graphics)
		  
		  
		  // Find the true widths
		  PopulateTrueWidths(g)
		  
		  dim yIndex as integer
		  // Create a record storage object to write the headers
		  dim oHeaderRecord as New RecordStorageClass
		  oHeaderRecord.oPrintData.arsColumnValues = arsHeaders()
		  oHeaderRecord.oPrintData.oParentStory = me
		  oHeaderRecord.oPrintData.ariJustification = oParentEIPLDoc.InitObject.LI_Justification
		  
		  // Create graphics clip
		  dim gClip as Graphics = CreateClip(g, oHeaderRecord, yindex)
		  gClip.TextSize = FontSize
		  
		  // Draw the Header
		  DrawLine(gClip, oHeaderRecord)
		  
		  yIndex = yIndex + gClip.Height
		  
		  dim y as integer = RecipricateThroughLI(g, aroLineItems, yIndex)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawLine(g as Graphics, oLine as RecordStorageClass)
		  
		  
		  
		  oLine.oPrintData.Draw(g)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HaveSpaceForLine(g as Graphics, gClip as Graphics, yIndex as integer) As Boolean
		  
		  if yIndex + gClip.Height > g.Height Then
		    Return False
		  Else
		    Return True
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function iTotalCenter(g as Graphics, bFinalTotals as Boolean = False) As Integer
		  dim iRet as integer
		  dim itc as string
		  
		  If bFinalTotals Then
		    itc = kiMasterTotalCenter
		  Else
		    itc = kiTotalCenter
		  End If
		  
		  If itc.InStr("%") <> 0  Then
		    // THere is a % in the string
		    
		    dim i1 as double = val( Methods.StripNonDigitsDecimals(itc) ) / 100
		    iRet = i1 * g.Width
		    
		  Else
		    iRet = val( Methods.StripNonDigitsDecimals(itc) )
		  End If
		  
		  Return iRet
		End Function
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
		Function RecipricateThroughLI(g as Graphics, aroLines() as RecordStorageClass, yIndexPar as integer = 0) As integer
		  g.TextSize = FontSize
		  
		  If oCurs = Nil Then
		    // Create a Cursor Object
		    oCurs = New ArrayCursorClass
		  End If
		  
		  dim yIndex as integer = yIndexPar
		  dim NoSpace as Boolean
		  For iLineIndex as integer = oCurs.GetCurrentIndex To aroLines.Ubound
		    dim oLine as RecordStorageClass = aroLines(iLineIndex)
		    oLine.PopulatePrintData(dictFieldNames,oParentEIPLDoc.InitObject.LI_Justification, me)
		    
		    If oCurs.OnLast Then
		      // Draw this line
		      
		      If oCurs.iCursorIndex = 0 Then
		        If oLine.StorType = "Total" And oParentEIPLDoc.RemitY = 0 Then
		          oParentEIPLDoc.RemitY = yIndex
		        End If
		      End If
		      
		      // Create graphics clip
		      dim gClip as Graphics = CreateClip(g, oLine, yIndex)
		      gClip.TextSize = FontSize
		      
		      // Check if we are going to go past the edge of the page
		      If Not HaveSpaceForLine(g, gClip, yIndex) Then
		        NoSpace = True
		        Exit
		      End If
		      
		      // Draw the line
		      DrawLine(gClip, oLine)
		      
		      yIndex = yIndex + gClip.Height
		      
		      // Check if this line has children
		      If oLine.aroChildren.Ubound <> -1 Then
		        oCurs.DrillIn
		        yIndex = RecipricateThroughLI(g, oLine.aroChildren, yIndex)
		      End If
		      
		    Else
		      // Relaunch this method with the children of this line
		      oCurs.MoveIn
		      yIndex = RecipricateThroughLI(g, oLine.aroChildren, yIndex)
		    End If
		    
		    If oCurs.onLast Then
		      oCurs.IncreaseCurrentDepth
		    else
		      exit
		    End If
		  Next
		  
		  // Check if we have made it through all of the lines
		  If oCurs.GetCurrentIndex >= aroLines.Ubound Then
		    // all lines have been completed for this level 
		    // let us step out
		    If Not NoSpace Then
		      oCurs.DrillOut
		      If oCurs.CursorRemoved Then
		        bComplete = True
		      End If
		    End If
		  Elseif not oCurs.onFirst Then
		    oCurs.MoveOut
		  End If
		  
		  Return yIndex
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		ariCursorLocation() As Integer
	#tag EndProperty

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

	#tag Property, Flags = &h0
		iLineBuffer As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		iLinesonPage As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		oCurs As ArrayCursorClass
	#tag EndProperty

	#tag Property, Flags = &h0
		oParentEIPLDoc As EstimateDocument
	#tag EndProperty


	#tag Constant, Name = kiMasterTotalCenter, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"65%"
	#tag EndConstant

	#tag Constant, Name = kiTotalCenter, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"75%"
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="bComplete"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="bOnlyLastPage"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="bRepeatEveryPage"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
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
			Name="iLineBuffer"
			Group="Behavior"
			InitialValue="1"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="iLinesonPage"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MultiPage"
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
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
