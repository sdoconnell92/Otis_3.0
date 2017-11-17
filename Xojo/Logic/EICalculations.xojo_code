#tag Module
Protected Module EICalculations
	#tag Method, Flags = &h0
		Function CalculateGroup(aroLIStor() as RecordStorageClass, bApplyEIPLDiscount as Boolean = False, bCalcBalanceDue as Boolean = False) As TotalsClass
		  dim oRetTots as New TotalsClass
		  
		  For Each oLine as RecordStorageClass In aroLIStor()
		    dim oCurrentTots as TotalsClass = CalculateSingleLine(oLine)
		    
		    If bApplyEIPLDiscount Then
		      oRetTots.AddTotalsSmart(oCurrentTots)
		    Else
		      oRetTots.AddTotalsStraight(oCurrentTots)
		    End If
		  Next
		  
		  If bApplyEIPLDiscount Then
		    
		    If oRetTots.sEIPLuuid <> "" Then
		      dim oEIPLRecord as DataFile.tbl_eipl = DataFile.tbl_eipl.FindByID(oRetTots.sEIPLuuid)
		      
		      dim iDiscountAmount, iDiscountPercent as Double
		      dim sDiscountPercent, sDiscountAmount, arsDiscount() as String
		      arsDiscount() = oEIPLRecord.sdiscount.Split(":")
		      
		      For i1 as integer = 0 To arsDiscount.Ubound
		        dim sDiscount as string = arsDiscount(i1)
		        If InStr( sDiscount , "%") > 0 Then
		          ' discount is a percent
		          iDiscountPercent = val( Methods.StripNonDigitsDecimals(sDiscount) ) /100
		        Else
		          iDiscountAmount = val( Methods.StripNonDigitsDecimals(sDiscount) )
		        End If
		      Next
		      
		      If iDiscountPercent <> 0 Then
		        oRetTots.b_PostDiscount = oRetTots.a_SubTotal * iDiscountPercent
		      Else
		        oRetTots.b_PostDiscount = oRetTots.a_SubTotal
		      End If
		      oRetTots.b_PostDiscount = oRetTots.b_PostDiscount - iDiscountAmount
		      
		      oRetTots.LocalDiscountSum = oRetTots.a_SubTotal - oRetTots.b_PostDiscount
		      oRetTots.RunningDiscountSum = oRetTots.RunningDiscountSum + oRetTots.LocalDiscountSum
		      
		      oRetTots.c_Total = oRetTots.b_PostDiscount + oRetTots.TaxSum
		      
		      
		      
		    End If
		    
		  End If
		  
		  If bCalcBalanceDue THen
		    // Grab payment Information
		    If oRetTots.sEIPLuuid <> "" Then
		      dim aroPayments() as DataFile.tbl_payments = DataFile.tbl_payments.List("fkeipl = '" + oRetTots.sEIPLuuid + "'")
		      
		      dim i as Currency
		      If aroPayments.Ubound <> -1 Then
		        For Each p as DataFile.tbl_payments In aroPayments()
		          i = i + val(Methods.StripNonDigitsDecimals(p.spayment_amount))
		        Next
		      End If
		      dim TotalPayed as Currency = i
		      dim BalanceDue as Currency = oRetTots.c_Total - TotalPayed
		      
		      oRetTots.TotalPayed = TotalPayed
		      oRetTots.d_BalanceDue = BalanceDue
		      
		    End If
		  End If
		  
		  Return oRetTots
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CalculateSingleLine(oLIStor as RecordStorageClass) As TotalsClass
		  dim oRetTotals as New TotalsClass
		  
		  Select Case oLIStor.StorType
		  Case "Total"
		  Case "LinkedFolder"
		    
		    // Check if this folder has children and loop through them
		    For Each oLine as RecordStorageClass In oLIStor.aroChildren
		      dim oCurrentTotals as TotalsClass = CalculateSingleLine(oLine)
		      oRetTotals.AddTotalsStraight(oCurrentTotals)
		    Next
		    
		  Case "GroupFolder"
		    
		    dim sEIPLuuid as string
		    
		    // Loop through all of this folders children
		    For Each oLine as RecordStorageClass In oLIStor.aroChildren
		      dim oCurrentTotals as TotalsClass = CalculateSingleLine(oLine)
		      oRetTotals.AddTotalsSmart(oCurrentTotals)
		      If sEIPLuuid = "" And oCurrentTotals.sEIPLuuid <> "" Then sEIPLuuid = oCurrentTotals.sEIPLuuid
		    Next
		    
		    oRetTotals.sEIPLuuid = sEIPLuuid
		    
		    // Get the discounts for this group
		    dim aroDiscountRecords() as DataFile.tbl_group_discounts
		    aroDiscountRecords() = DataFile.tbl_group_discounts.List( "fkeipl = '" + sEIPLuuid + "' And group_name = '" + Join(oLIStor.arsGroupStructure,".") + "'" )
		    
		    oRetTotals.b_PostDiscount = oRetTotals.a_SubTotal
		    
		    dim sDiscountPercent as String
		    For Each oDiscount as DataFile.tbl_group_discounts In aroDiscountRecords()
		      
		      dim iDiscountAmount, iDiscountPercent as Double
		      dim sDiscountAmount, arsDiscount() as String
		      arsDiscount() = oDiscount.sgroup_discount.Split(":")
		      
		      For i1 as integer = 0 To arsDiscount.Ubound
		        dim sDiscount as string = arsDiscount(i1)
		        If InStr( sDiscount , "%") > 0 Then
		          ' discount is a percent
		          sDiscountPercent = sDiscount
		          iDiscountPercent = val( Methods.StripNonDigitsDecimals(sDiscount) ) /100
		        Else
		          iDiscountAmount = val( Methods.StripNonDigitsDecimals(sDiscount) )
		        End If
		      Next
		      
		      oRetTotals.b_PostDiscount = oRetTotals.b_PostDiscount - ( iDiscountPercent * oRetTotals.b_PostDiscount ) - iDiscountAmount
		      
		    Next
		    
		    // Figure out discount sum
		    oRetTotals.LocalDiscountSum = oRetTotals.a_SubTotal - oRetTotals.b_PostDiscount
		    oRetTotals.RunningDiscountSum = oRetTotals.LocalDiscountSum + oRetTotals.RunningDiscountSum
		    
		    // round things
		    oRetTotals.a_SubTotal = round(oRetTotals.a_SubTotal*100)/100
		    oRetTotals.b_PostDiscount = round(oRetTotals.b_PostDiscount*100)/100
		    oRetTotals.c_Total = oRetTotals.b_PostDiscount
		    oRetTotals.LocalDiscountSum = round(oRetTotals.LocalDiscountSum*100)/100
		    oRetTotals.RunningDiscountSum = round(oRetTotals.RunningDiscountSum*100)/100
		    oRetTotals.TaxSum = round( oRetTotals.TaxSum*100)/100
		    oRetTotals.sDiscountPercent = sDiscountPercent
		    
		  Case "GrandParent", "Child"
		    
		    // Extract the table record from the storage class
		    dim v as Variant = oLIStor.oTableRecord
		    dim oLIRecord as DataFile.tbl_lineitems = v
		    
		    // Get the EIPL Table record
		    dim oEIPLRecord as DataFile.tbl_eipl = DataFile.tbl_eipl.FindByID(oLIRecord.sfkeipl)
		    oRetTotals.sEIPLuuid = oEIPLRecord.suuid
		    
		    // Extract the Discounts for this line into some variables
		    dim arsDiscounts() as String
		    dim iDiscountPercent, iDiscountAmount as double
		    arsDiscounts() = oLIRecord.sli_discount.Split(":")
		    For i1 as integer = 0 To arsDiscounts.Ubound
		      dim sDiscount as string = arsDiscounts(i1)
		      If InStr( sDiscount , "%") > 0 Then
		        ' discount is a percent
		        iDiscountPercent = val( Methods.StripNonDigitsDecimals(sDiscount) ) /100
		      Else
		        iDiscountAmount = val( Methods.StripNonDigitsDecimals(sDiscount) )
		      End If
		    Next
		    
		    // Check if this Line has any children and if we want to use the total generated by the children
		    If oLIStor.aroChildren.ubound <> -1 And oLIRecord.buse_children_total Then
		      // There are Children and we want to use the total generated by them
		      oRetTotals = CalculateGroup(oLIStor.aroChildren)
		      
		    ElseIf oLIStor.aroChildren.ubound = -1 Or Not oLIRecord.buse_children_total Then
		      // There are no Children or we don't want to use the total generated by them
		      '_________________|---------SubTotal----------|-----------------After DIscount--------|
		      // Calculation is: ( (Price * Quantity * Time) If %: * (discount/100) If $: - discount ) * ( Tax / 100 ) = Total
		      
		      dim iPrice, iSubTotal, iPostDiscount, iDiscountSum, iTotal, iTaxSum as Currency
		      dim iQuantity as Integer
		      dim iTime, iTax as Double
		      
		      iPrice = val( Methods.StripNonDigitsDecimals( oLIRecord.sli_price ) )
		      iQuantity = val( Methods.StripNonDigitsDecimals( oLIRecord.sli_quantity ) )
		      iTime = val( Methods.StripNonDigitsDecimals( oLIRecord.sli_time ) )
		      iTax = val( Methods.StripNonDigitsDecimals( oEIPLRecord.seipl_tax_rate) )
		      
		      // Calculate the subtotal
		      iSubTotal = iPrice * iQuantity * iTime
		      
		      // Calculate the after discount price
		      If iDiscountPercent <> 0 Then
		        iPostDiscount = iSubTotal - ( ( iDiscountPercent / 100 ) * iSubTotal )
		      Else
		        iPostDiscount = iSubTotal
		      End If
		      iPostDiscount = iPostDiscount - iDiscountAmount
		      
		      // Calculate the Discount Sum
		      iDiscountSum = iSubTotal - iPostDiscount
		      
		      // Apply Tax
		      If oLIRecord.bli_taxable Then
		        If iTax = 0 Then
		          iTotal = iPostDiscount
		        Else
		          iTotal = iPostDiscount * (iTax / 100)
		        End If
		      Else
		        iTotal = iPostDiscount
		      End If
		      // Figure out the tax sum
		      iTaxSum = iTotal - iPostDiscount
		      
		      // round things
		      iSubTotal = round(iSubTotal*100)/100
		      iPostDiscount = round(iPostDiscount*100)/100
		      iTotal = round( iTotal*100)/100
		      iDiscountSum = round(iDiscountSum*100)/100
		      iTaxSum = round( iTaxSum*100)/100
		      
		      // Fill in values in the return classssss
		      oRetTotals.PreAllDisc = iSubTotal
		      oRetTotals.a_SubTotal = iSubTotal
		      oRetTotals.b_PostDiscount = iPostDiscount
		      oRetTotals.c_Total = iTotal
		      oRetTotals.LocalDiscountSum = iDiscountSum
		      oRetTotals.RunningDiscountSum = iDiscountSum
		      oRetTotals.TaxSum = iTaxSum
		      
		    End If
		    
		  End Select
		  
		  Return oRetTotals
		End Function
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
End Module
#tag EndModule
