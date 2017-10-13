#tag Class
Protected Class BaseDocument
	#tag Method, Flags = &h0
		Sub DrawInfoBoxes()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Go(sOutputType as String)
		  Select Case sOutputType
		  Case "Image"
		    
		  Case "Printer"
		    
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Print()
		  Dim ps As New PrinterSetup
		  If ps.PageSetupDialog Then
		    Dim g As Graphics
		    g = OpenPrinterDialog(ps)
		    If g <> Nil Then
		      
		      While Not bPrintDone
		        
		      Wend
		      
		    End If
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		bPrintDone As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		vStory() As Variant
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
