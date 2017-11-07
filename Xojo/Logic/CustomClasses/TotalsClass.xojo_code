#tag Class
Protected Class TotalsClass
	#tag Method, Flags = &h1
		Protected Sub AcquireEIPLuuid(oTots as TotalsClass)
		  If sEIPLuuid = "" And oTots.sEIPLuuid <> "" Then
		    sEIPLuuid = oTots.sEIPLuuid
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddTotalsSmart(oTots as TotalsClass)
		  PreAllDisc = PreAllDisc + oTots.PreAllDisc
		  a_SubTotal = a_SubTotal + oTots.b_PostDiscount
		  TaxSum = TaxSum + oTots.TaxSum
		  RunningDiscountSum = RunningDiscountSum + oTots.RunningDiscountSum
		  
		  AcquireEIPLuuid(oTots)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddTotalsStraight(oTots as TotalsClass)
		  PreAllDisc = PreAllDisc + oTots.PreAllDisc
		  a_SubTotal = a_SubTotal + oTots.a_SubTotal
		  b_PostDiscount = b_PostDiscount + oTots.b_PostDiscount
		  c_Total = c_Total + oTots.c_Total
		  localDiscountSum = LocalDiscountSum + oTots.LocalDiscountSum
		  RunningDiscountSum = RunningDiscountSum + oTots.RunningDiscountSum
		  TaxSum = TaxSum + oTots.TaxSum
		  
		  AcquireEIPLuuid(oTots)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  a_SubTotal = 0
		  b_PostDiscount = 0
		  c_Total = 0
		  localDiscountSum = 0
		  RunningDiscountSum = 0
		  TaxSum = 0
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		a_SubTotal As Currency
	#tag EndProperty

	#tag Property, Flags = &h0
		b_PostDiscount As Currency
	#tag EndProperty

	#tag Property, Flags = &h0
		c_Total As Currency
	#tag EndProperty

	#tag Property, Flags = &h0
		LocalDiscountSum As Currency
	#tag EndProperty

	#tag Property, Flags = &h0
		PreAllDisc As Currency
	#tag EndProperty

	#tag Property, Flags = &h0
		RunningDiscountSum As Currency
	#tag EndProperty

	#tag Property, Flags = &h0
		sDiscountPercent As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sEIPLuuid As string
	#tag EndProperty

	#tag Property, Flags = &h0
		TaxSum As Currency
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
			Name="sEIPLuuid"
			Group="Behavior"
			Type="string"
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
