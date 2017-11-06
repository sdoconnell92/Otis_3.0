#tag Module
Protected Module modPriceCalculations
	#tag Method, Flags = &h0
		Function CalculateEIPLTotal(oRecordStors() as RecordStorageClass, oEIPLStor as RecordStorageClass) As Dictionary
		  dim iSubTotal, iAfterDiscount, iAfterTax, iDiscountSum, iTaxSum, iDiscount, iBalance, iPaymentSum as Currency
		  dim v1 as Variant = oEIPLStor.oTableRecord
		  dim oEIPLRecord as DataFile.tbl_eipl = v1
		  
		  ForEIPLTotal = True
		  
		  // get the total of the groups
		  dim retDict as Dictionary = CalculateGroupTotal( oRecordStors, oEIPLStor, "" )
		  iSubTotal = retDict.Value("PreDiscount")
		  iDiscountSum = retDict.Value("DiscountSum")
		  iTaxSum = retDict.Value("TaxSum")
		  
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
		  
		  iDiscount = iDiscountPercent * iSubTotal
		  iDiscount = iDiscount + iDiscountAmount
		  
		  '// Calculate the after discount price
		  'iDiscount = val( Methods.StripNonDigitsDecimals( oEIPLRecord.sdiscount ) )
		  'If iDiscount = 0 Then
		  ''iAfterDiscount = iSubTotal
		  'ElseIf InStr( oEIPLRecord.sdiscount, "%") > 0 Then
		  '// the discount is a percent
		  'iDiscount = ( ( iDiscount / 100 ) * iSubTotal )
		  'Else
		  '// the discount is an amount
		  'End If
		  
		  // Calculate discount sum
		  iDiscountSum = iDiscountSum + iDiscount
		  
		  // Calculate after discount
		  iAfterDiscount = iSubTotal - iDiscountSum
		  
		  // Calculate the after tax amount
		  iAfterTax = iAfterDiscount + iTaxSum
		  
		  // Calculate amount payed and balance
		  dim oPayments() as DataFile.tbl_payments = DataFile.tbl_payments.List( "fkeipl = '" + oEIPLRecord.suuid + "'" )
		  For Each oPayment as DataFile.tbl_payments In oPayments()
		    dim iAmount as Currency = val( Methods.StripNonDigitsDecimals( oPayment.spayment_amount ) )
		    iPaymentSum = iPaymentSum + iAmount
		  Next
		  iBalance = iAfterTax - iPaymentSum
		  
		  // Round things
		  iSubTotal = round(iSubTotal*100)/100
		  iAfterDiscount = round(iAfterDiscount*100)/100
		  iAfterTax = round(iAfterTax*100)/100
		  iDiscountSum = round(iDiscountSum*100)/100
		  iTaxSum = round(iTaxSum*100)/100
		  iPaymentSum = round(iPaymentSum*100)/100
		  iBalance = round(iBalance*100)/100
		  
		  dim retDictionary as New Dictionary
		  retDictionary.Value("SubTotal") = iSubTotal
		  retDictionary.Value("AfterDiscount") = iAfterDiscount
		  retDictionary.Value("Total") = iAfterTax
		  retDictionary.Value("DiscountSum") = iDiscountSum
		  retDictionary.Value("TaxSum") = iTaxSum
		  retDictionary.Value("PaymentSum") = iPaymentSum
		  retDictionary.Value("Balance") = iBalance
		  
		  ForEIPLTotal = False
		  
		  Return retDictionary
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CalculateEIPLTotal(oMaster as RecordStorageClass, oEIPLStor as RecordStorageClass) As Dictionary
		  dim iSubTotal, iAfterDiscount, iAfterTax, iDiscountSum, iTaxSum, iDiscount, iPaymentSum, iBalance as Currency
		  dim v1 as Variant = oEIPLStor.oTableRecord
		  dim oEIPLRecord as DataFile.tbl_eipl = v1
		  
		  ForEIPLTotal = True
		  
		  // get the total of the groups
		  dim retDict as Dictionary = CalculateGroupofGroupTotal( oMaster, oEIPLStor, "" )
		  iSubTotal = retDict.Value("PreDiscount")
		  iDiscountSum = retDict.Value("DiscountSum")
		  iTaxSum = retDict.Value("TaxSum")
		  
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
		  
		  iDiscount = iDiscountPercent * iSubTotal
		  iDiscount = iDiscount + iDiscountAmount
		  
		  '// Calculate the after discount price
		  'iDiscount = val( Methods.StripNonDigitsDecimals( oEIPLRecord.sdiscount ) )
		  'If iDiscount = 0 Then
		  ''iAfterDiscount = iSubTotal
		  'ElseIf InStr( oEIPLRecord.sdiscount, "%") > 0 Then
		  '// the discount is a percent
		  'iDiscount = ( ( iDiscount / 100 ) * iSubTotal )
		  'Else
		  '// the discount is an amount
		  'End If
		  
		  // Calculate discount sum
		  iDiscountSum = iDiscountSum + iDiscount
		  
		  // Calculate after discount
		  iAfterDiscount = iSubTotal - iDiscountSum
		  
		  // Calculate the after tax amount
		  iAfterTax = iAfterDiscount + iTaxSum
		  
		  // Calculate amount payed and balance
		  dim oPayments() as DataFile.tbl_payments = DataFile.tbl_payments.List( "fkeipl = '" + oEIPLRecord.suuid + "'" )
		  For Each oPayment as DataFile.tbl_payments In oPayments()
		    dim iAmount as Currency = val( Methods.StripNonDigitsDecimals( oPayment.spayment_amount ) )
		    iPaymentSum = iPaymentSum + iAmount
		  Next
		  iBalance = iAfterTax - iPaymentSum
		  
		  // Round things
		  iSubTotal = round(iSubTotal*100)/100
		  iAfterDiscount = round(iAfterDiscount*100)/100
		  iAfterTax = round(iAfterTax*100)/100
		  iDiscountSum = round(iDiscountSum*100)/100
		  iTaxSum = round(iTaxSum*100)/100
		  iPaymentSum = round(iPaymentSum*100)/100
		  iBalance = round(iBalance*100)/100
		  
		  dim retDictionary as New Dictionary
		  retDictionary.Value("SubTotal") = iSubTotal
		  retDictionary.Value("AfterDiscount") = iAfterDiscount
		  retDictionary.Value("Total") = iAfterTax
		  retDictionary.Value("DiscountSum") = iDiscountSum
		  retDictionary.Value("TaxSum") = iTaxSum
		  retDictionary.Value("PaymentSum") = iPaymentSum
		  retDictionary.Value("Balance") = iBalance
		  
		  ForEIPLTotal = False
		  
		  Return retDictionary
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CalculateGroupofGroupTotal(oMaster as RecordStorageClass, oEIPLStor as RecordStorageClass, sGroupStructure as string) As Dictionary
		  dim iPreDiscount, iAfterDiscount, iTotal, iDiscountSum, iTaxSum as currency
		  dim v1 as Variant = oEIPLStor.oTableRecord
		  dim oEIPLRecord as DataFile.tbl_eipl = v1
		  
		  
		  // Loop through each group in the dictionary
		  For Each oStor as RecordStorageClass In oMaster.aroChildren()
		    dim sInnerGroupStructure as string
		    
		    If oStor.StorType = "GroupFolder" then
		      // This value is a group of more groups so we 
		      'increase the group struccture 
		      'If sGroupStructure <> "" Then
		      'sInnerGroupStructure = sGroupStructure + "." + oStor.sFolderName
		      'Else
		      'sInnerGroupStructure = str( vKey )
		      'End If
		      
		      // Extract the group structure info
		      sInnerGroupStructure = Join( oStor.arsGroupStructure, "." )
		      
		      'recipricate this method to dig deeper into groups
		      dim retDictionary as Dictionary
		      retDictionary = CalculateGroupofGroupTotal( oStor, oEIPLStor, sInnerGroupStructure )
		      
		      // Add up totals
		      If ForEIPLTotal Then
		        iPreDiscount = iPreDiscount + retDictionary.Value("PreDiscount")
		      Else
		        iPreDiscount = iPreDiscount + retDictionary.Value("Total")
		      End If
		      iDiscountSum = iDiscountSum + retDictionary.Value("DiscountSum")
		      iTaxSum = iTaxSum + retDictionary.Value("TaxSum")
		      
		    Else
		      // THis value is an array of records
		      
		      'increase the group struccture 
		      'If sGroupStructure <> "" Then
		      'sInnerGroupStructure = sGroupStructure + "." + str( vKey )
		      'Else
		      'sInnerGroupStructure = str( vKey )
		      'End If
		      
		      // Extract the group structure
		      sInnerGroupStructure = Join( oStor.arsGroupStructure, "." )
		      
		      // Send this group to CalculateGroupTotal
		      dim retDictionary as Dictionary
		      retDictionary = CalculateGroupTotal( oStor.aroChildren, oEIPLStor, sInnerGroupStructure )
		      
		      // Add up totals
		      If ForEIPLTotal Then
		        iPreDiscount = iPreDiscount + retDictionary.Value("PreDiscount")
		      Else
		        iPreDiscount = iPreDiscount + retDictionary.Value("Total")
		      End If
		      iDiscountSum = iDiscountSum + retDictionary.Value("DiscountSum")
		      iTaxSum = iTaxSum + retDictionary.Value("TaxSum")
		      
		    End If
		    
		    
		  Next
		  
		  // Now we can determine discounts
		  iAfterDiscount = iPreDiscount
		  
		  'grab discounts relating to this group structure and eipl
		  dim aroDiscounts() as DataFile.tbl_group_discounts
		  aroDiscounts = DataFile.tbl_group_discounts.List( " fkeipl = '" + oEIPLRecord.suuid + "' And group_name = '" + sGroupStructure + "'" )
		  
		  For Each oDiscount as DataFile.tbl_group_discounts In aroDiscounts()
		    
		    dim iDiscountAmount, iDiscountPercent as Double
		    dim sDiscountPercent, sDiscountAmount, arsDiscount() as String
		    arsDiscount() = oDiscount.sgroup_discount.Split(":")
		    
		    For i1 as integer = 0 To arsDiscount.Ubound
		      dim sDiscount as string = arsDiscount(i1)
		      If InStr( sDiscount , "%") > 0 Then
		        ' discount is a percent
		        iDiscountPercent = val( Methods.StripNonDigitsDecimals(sDiscount) ) /100
		      Else
		        iDiscountAmount = val( Methods.StripNonDigitsDecimals(sDiscount) )
		      End If
		    Next
		    
		    iAfterDiscount = iAfterDiscount - ( iDiscountPercent * iAfterDiscount ) - iDiscountAmount
		    
		    '// Put the group discount into a number variable
		    'dim iDiscount as Double = val( Methods.StripNonDigitsDecimals( oDiscount.sgroup_discount ) )
		    
		    'If InStr( oDiscount.sgroup_discount, "%" ) > 0 Then
		    '// the discount is a percent
		    'iAfterDiscount = iAfterDiscount - ( ( iDiscount / 100 ) * iAfterDiscount )
		    'Else 
		    '// the discount is a dollar sum
		    'iAfterDiscount = iAfterDiscount - iDiscount
		    'End If
		    
		  Next
		  
		  iDiscountSum = iDiscountSum + ( iPreDiscount - iAfterDiscount )
		  
		  iAfterDiscount = round(iAfterDiscount*100)/100
		  iPreDiscount = round(iPreDiscount*100)/100
		  iDiscountSum = round(iDiscountSum*100)/100
		  iTaxSum = round(iTaxSum*100)/100
		  
		  dim retDictionary as New Dictionary
		  retDictionary.Value( "Total" ) = iAfterDiscount
		  retDictionary.Value( "PreDiscount" ) = iPreDiscount
		  retDictionary.Value( "DiscountSum" ) = iDiscountSum
		  retDictionary.Value( "TaxSum" ) = iTaxSum
		  
		  Return retDictionary
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CalculateGroupTotal(aroLIStors() as RecordStorageClass, oEIPlStor as RecordStorageClass, sGroupName as String) As Dictionary
		  dim iPreDiscount, iAfterDiscount, iDiscountSum, iTaxSum as Currency
		  dim v1 as Variant = oEIPlStor.oTableRecord
		  dim oEIPlRecord as DataFile.tbl_eipl = v1
		  
		  // Loop through each Line item record
		  For Each oLIStor as RecordStorageClass In aroLIStors()
		    dim v as Variant = oLIStor.oTableRecord
		    dim oLIRecord as DataFile.tbl_lineitems = v
		    dim retDictionary as Dictionary
		    retDictionary = CalculateLineItemPrices( oLIStor, oEIPlStor )
		    If ForEIPLTotal Then
		      iPreDiscount = iPreDiscount + retDictionary.Value("SubTotal")
		    Else
		      iPreDiscount = iPreDiscount + retDictionary.Value("AfterDiscount")
		    End If
		    iTaxSum = iTaxSum + retDictionary.Value( "TaxSum" )
		    iDiscountSum = iDiscountSum + retDictionary.Value("DiscountSum")
		  Next
		  
		  // Now we can apply the discounts that are related to this particular group
		  
		  // Get any discount records relating to this group and eipl
		  dim aroDiscountRecords() as DataFile.tbl_group_discounts
		  aroDiscountRecords() = DataFile.tbl_group_discounts.List( "fkeipl = '" + oEIPlRecord.suuid + "' And group_name = '" + sGroupName + "'" )
		  
		  iAfterDiscount = iPreDiscount
		  
		  For Each oDiscount as DataFile.tbl_group_discounts In aroDiscountRecords()
		    
		    dim iDiscountAmount, iDiscountPercent as Double
		    dim sDiscountPercent, sDiscountAmount, arsDiscount() as String
		    arsDiscount() = oDiscount.sgroup_discount.Split(":")
		    
		    For i1 as integer = 0 To arsDiscount.Ubound
		      dim sDiscount as string = arsDiscount(i1)
		      If InStr( sDiscount , "%") > 0 Then
		        ' discount is a percent
		        iDiscountPercent = val( Methods.StripNonDigitsDecimals(sDiscount) ) /100
		      Else
		        iDiscountAmount = val( Methods.StripNonDigitsDecimals(sDiscount) )
		      End If
		    Next
		    
		    iAfterDiscount = iAfterDiscount - ( iDiscountPercent * iAfterDiscount ) - iDiscountAmount
		    
		    '// Put the group discount into a number variable
		    'dim iDiscount as double = val( Methods.StripNonDigitsDecimals( oDiscount.sgroup_discount ) )
		    
		    'If InStr( oDiscount.sgroup_discount, "%" ) > 0 Then
		    '// the discount is a percent
		    'iAfterDiscount = iAfterDiscount - ( ( iDiscount / 100 ) * iAfterDiscount )
		    'Else 
		    '// the discount is a dollar sum
		    'iAfterDiscount = iAfterDiscount - iDiscount
		    'End If
		    
		  Next
		  
		  iDiscountSum = iDiscountSum + ( iPreDiscount - iAfterDiscount )
		  
		  iAfterDiscount = round(iAfterDiscount*100)/100
		  iPreDiscount = round(iPreDiscount*100)/100
		  iDiscountSum = round(iDiscountSum*100)/100
		  iTaxSum = round(iTaxSum*100)/100
		  
		  dim retDictionary as New Dictionary
		  retDictionary.Value("Total") = iAfterDiscount
		  retDictionary.Value("PreDiscount") = iPreDiscount
		  retDictionary.Value("DiscountSum") = iDiscountSum
		  retDictionary.Value("TaxSum") = iTaxSum
		  
		  Return retDictionary
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CalculateLineItemPrices(oLIStor as RecordStorageClass, oEIStor as RecordStorageClass) As Dictionary
		  dim d1 as Currency
		  dim v1 as Variant = oLIStor.oTableRecord
		  dim oLIRecord as DataFile.tbl_lineitems = v1
		  dim v2 as Variant = oEIStor.oTableRecord
		  dim oEIRecord as DataFile.tbl_eipl = v2
		  
		  '_________________|---------SubTotal----------|-----------------After DIscount--------|
		  // Calculation is: ( (Price * Quantity * Time) If %: * (discount/100) If $: - discount ) * ( Tax / 100 ) = Total
		  
		  dim iPrice, iQuantity, iTime, iTax, iSubTotal, iAfterDiscount, iTotal, iDiscountSum, iTaxSum as Currency
		  dim iDiscountAmount, iDiscountPercent as Double
		  dim sDiscountPercent, sDiscountAmount, arsDiscount() as String
		  arsDiscount() = oLIRecord.sli_discount.Split(":")
		  
		  For i1 as integer = 0 To arsDiscount.Ubound
		    dim sDiscount as string = arsDiscount(i1)
		    If InStr( sDiscount , "%") > 0 Then
		      ' discount is a percent
		      iDiscountPercent = val( Methods.StripNonDigitsDecimals(sDiscount) ) /100
		    Else
		      iDiscountAmount = val( Methods.StripNonDigitsDecimals(sDiscount) )
		    End If
		  Next
		  
		  iPrice = val( Methods.StripNonDigitsDecimals( oLIRecord.sli_price ) )
		  iQuantity = val( Methods.StripNonDigitsDecimals( oLIRecord.sli_quantity ) )
		  iTime = val( Methods.StripNonDigitsDecimals(  oLIRecord.sli_time ) )
		  iTax = val( Methods.StripNonDigitsDecimals( oEIRecord.seipl_tax_rate ) )
		  
		  
		  // Calculate the subtotal
		  iSubTotal = iPrice * iQuantity * iTime
		  
		  // Calculate the after discount price
		  If iDiscountPercent <> 0 Then
		    iAfterDiscount = iSubTotal - ( ( iDiscountPercent / 100 ) * iSubTotal )
		  End If
		  iAfterDiscount = iSubTotal - iDiscountAmount
		  'If iDiscount = 0 Then
		  'iAfterDiscount = iSubTotal
		  'ElseIf InStr( oLIRecord.sli_discount, "%") > 0 Then
		  '// the discount is a percent
		  'iAfterDiscount = iSubTotal - ( ( iDiscount / 100 ) * iSubTotal )
		  'Else
		  '// the discount is an amount
		  'iAfterDiscount = iSubTotal - iDiscount
		  'End If
		  
		  iDiscountSum = iSubTotal - iAfterDiscount
		  
		  // Calculate total
		  If oLIRecord.bli_taxable Then
		    If iTax <> 0 Then
		      iTotal = iAfterDiscount * ( (iTax / 100) + 1 ) 
		    Else
		      iTotal = iAfterDiscount
		    End If
		  Else
		    iTotal = iAfterDiscount
		  End If
		  
		  // Calculate amount of tax applied
		  iTaxSum = iTotal - iAfterDiscount
		  
		  // round things
		  iSubTotal = round(iSubTotal*100)/100
		  iAfterDiscount = round(iAfterDiscount*100)/100
		  iTotal = round( iTotal*100)/100
		  iDiscountSum = round(iDiscountSum*100)/100
		  iTaxSum = round( iTaxSum*100)/100
		  
		  
		  dim retDictionary as New Dictionary
		  retDictionary.Value("SubTotal") = iSubTotal
		  retDictionary.Value("AfterDiscount") = iAfterDiscount
		  retDictionary.Value("TaxSum") = iTaxSum
		  retDictionary.Value("Total") = iTotal
		  retDictionary.Value("DiscountSum") = iDiscountSum
		  
		  Return retDictionary
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected ForEIPLTotal As Boolean
	#tag EndProperty


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
