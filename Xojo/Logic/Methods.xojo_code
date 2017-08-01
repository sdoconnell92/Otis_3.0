#tag Module
Protected Module Methods
	#tag Method, Flags = &h0
		Function ConvertDictToJSON(oDictionary as Dictionary) As JSONItem
		  dim jsItem as New JSONItem
		  
		  For Each vKey as Variant In oDictionary.Keys
		    
		    dim sKey as string = str(vKey)
		    jsItem.Value(sKey) = oDictionary.Value(vKey)
		    
		  Next
		  
		  Return jsItem
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function StripNonDigitsDecimals(sString as String) As String
		  
		  
		  dim re as new RegEx
		  re.SearchPattern = "[^\d.]"
		  re.ReplacementPattern = ""
		  re.Options.ReplaceAllMatches = True
		  
		  Return re.Replace(sString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub UpdateItemQuantity(fkInventory as String)
		  // Figure out how many inventory expanded items there are related to our inventory item
		  dim qty as integer
		  qty = DataFile.tbl_internal_linking.ListCount("fk_parent = '" + fkInventory + "' And link_type = 'version'" )
		  
		  // Change the quantity of said inventory item
		  dim oItem as DataFile.tbl_inventory
		  oItem = DataFile.tbl_inventory.FindByID(fkInventory)
		  If oItem <> Nil Then 
		    oItem.sitem_quantity = str(qty)
		    oItem.Save
		  End If
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
End Module
#tag EndModule
