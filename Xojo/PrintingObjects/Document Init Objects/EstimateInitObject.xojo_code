#tag Class
Protected Class EstimateInitObject
Inherits BaseDocInitObject
	#tag Property, Flags = &h0
		Box1_AccountManager As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Box2_EventStartDate As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Box2_EventStartTime As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Box3_EventEndDate As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Box3_EventEndTime As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Box4_LoadInDate As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Box4_LoadInTime As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Box5_LoadOutDate As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Box5_LoadOutTime As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Box6_DiscountAmount As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Box6_DiscountPercent As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Box7_Tax As String
	#tag EndProperty

	#tag Property, Flags = &h0
		BoxA_AddressLine1 As String
	#tag EndProperty

	#tag Property, Flags = &h0
		BoxA_AddressLine2 As String
	#tag EndProperty

	#tag Property, Flags = &h0
		BoxA_City As String
	#tag EndProperty

	#tag Property, Flags = &h0
		BoxA_CompanyName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		BoxA_ContactName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		BoxA_Email As String
	#tag EndProperty

	#tag Property, Flags = &h0
		BoxA_Phone As String
	#tag EndProperty

	#tag Property, Flags = &h0
		BoxA_State As String
	#tag EndProperty

	#tag Property, Flags = &h0
		BoxA_Zip As String
	#tag EndProperty

	#tag Property, Flags = &h0
		BoxB_AddressLine1 As String
	#tag EndProperty

	#tag Property, Flags = &h0
		BoxB_AddressLine2 As String
	#tag EndProperty

	#tag Property, Flags = &h0
		BoxB_City As String
	#tag EndProperty

	#tag Property, Flags = &h0
		BoxB_Email As String
	#tag EndProperty

	#tag Property, Flags = &h0
		BoxB_Phone As String
	#tag EndProperty

	#tag Property, Flags = &h0
		BoxB_State As String
	#tag EndProperty

	#tag Property, Flags = &h0
		BoxB_VenueName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		BoxB_Zip As String
	#tag EndProperty

	#tag Property, Flags = &h0
		HeaderLine1 As String
	#tag EndProperty

	#tag Property, Flags = &h0
		HeaderLine2 As String
	#tag EndProperty

	#tag Property, Flags = &h0
		HeaderLine3 As String
	#tag EndProperty

	#tag Property, Flags = &h0
		LI_ColumnWidths As String
	#tag EndProperty

	#tag Property, Flags = &h0
		LI_FieldNames() As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		LI_Headers() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		LI_Records() As RecordStorageClass
	#tag EndProperty

	#tag Property, Flags = &h0
		LogoImage As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		RemitPaymentBox As String
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
			Name="LogoImage"
			Group="Behavior"
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
