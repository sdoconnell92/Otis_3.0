#tag Class
Protected Class EstimateDocument
Inherits BaseDocument
	#tag Method, Flags = &h0
		Sub Constructor(oEIPLStor as RecordStorageClass)
		  oEIPL = oEIPLStor
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		oEIPL As RecordStorageClass
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
			Name="Margin"
			Group="Behavior"
			InitialValue="40"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="StorySpacing"
			Group="Behavior"
			InitialValue="10"
			Type="Integer"
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
