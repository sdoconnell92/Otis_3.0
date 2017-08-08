#tag Module
Protected Module modFieldFormatting
	#tag Method, Flags = &h1
		Protected Function DeFormatDiscountFields(sRawValue as string) As String
		  dim sDiscountAmount, sDiscountPercent as String
		  dim arsDiscounts() as String
		  
		  arsDiscounts() = Split( sRawValue, ":" )
		  For Each sDiscount as String In arsDiscounts()
		    If InStr( sDiscount, "%" ) > 0 Then
		      sDiscountPercent = Methods.StripNonDigitsDecimals( sDiscount )
		    Else
		      sDiscountAmount = Methods.StripNonDigitsDecimals( sDiscount )
		    End If
		  Next
		  
		  dim sReturn as String
		  If sDiscountPercent <> "" And sDiscountAmount <> "" Then
		    sReturn = sDiscountAmount + ":" + sDiscountPercent + "%"
		  ElseIf sDiscountPercent <> "" Then
		    sReturn = sDiscountPercent + "%"
		  Else
		    sReturn = sDiscountAmount
		  End If
		  
		  Return sReturn
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FormatDiscountFields(sRawValue as String) As String
		  dim sDiscountAmount, sDiscountPercent, arsRaw() as String
		  dim arsDisplay() as string
		  
		  arsRaw() = Split(sRawValue,":")
		  
		  For Each sDiscount as string In arsRaw()
		    If InStr( sDiscount, "%" ) > 0 Then
		      sDiscountPercent = Methods.StripNonDigitsDecimals(sDiscount)
		    Else
		      sDiscountAmount = Methods.StripNonDigitsDecimals(sDiscount)
		    End If
		  Next
		  
		  
		  If val( sDiscountAmount ) <> 0 Then
		    sDiscountAmount = str( sDiscountAmount, "\$###,###,###,###.00" )
		    arsDisplay.Append( sDiscountAmount )
		  End If
		  If val( Methods.StripNonDigitsDecimals( sDiscountPercent ) ) <> 0 Then
		    sDiscountPercent = str( sDiscountPercent, "###.###\%" )
		    arsDisplay.Append( sDiscountPercent )
		  End If
		  
		  Return Join( arsDisplay, ":" )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetFormattingString(sFieldPath as String) As String
		  
		  dim sTableName, sFieldName, sArray() as String
		  sArray = sFieldPath.Split(".")
		  If sArray.Ubound = 1 Then
		    sTableName = sArray(0)
		    sFieldName = sArray(1)
		  End If
		  
		  Select Case sTableName
		  Case "tbl_lineitems"
		    Select Case sFieldName
		    Case "li_price"
		      Return tbl_lineitems.li_price
		    Case "li_discount"
		      Return tbl_lineitems.li_discount
		    End Select
		    
		  Case "tbl_inventory"
		    Select Case sFieldName
		    Case "item_purchase_price"
		      Return tbl_inventory.item_purchase_price
		    Case "item_rental_price"
		      Return tbl_inventory.item_rental_price
		    Case "item_sale_price"
		      Return tbl_inventory.item_sale_price
		    End Select
		    
		  Case "tbl_maintenance_logs"
		    Select Case sFieldName
		    Case "work_cost"
		      Return tbl_maintenance_logs.work_cost
		    End Select
		    
		  Case "tbl_eipl"
		    Select Case sFieldName
		    Case "eipl_tax_rate"
		      Return tbl_eipl.eipl_tax_rate
		    Case "discount"
		      Return tbl_eipl.discount
		    End Select
		    
		    
		    
		  End Select
		  
		  Return ""
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
