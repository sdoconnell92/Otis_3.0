#tag Class
Protected Class BaseDocument
	#tag Method, Flags = &h0
		Function AllDone() As Boolean
		  
		  For Each oStory as BaseStoryObject in aroStory()
		    if not oStory.bComplete Then
		      Return False
		    end if
		  Next
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Go(Fullg as Graphics)
		  dim bDone as Boolean = False
		  
		  // reduce the area we are working with by the margins
		  dim g as Graphics
		  g = Fullg.Clip(margin, margin, Fullg.Width - (Margin * 2), fullg.Height - (Margin*2) )
		  
		  dim x, y as integer
		  
		  For i1 as integer = 0 to aroStory.Ubound
		    dim oStory as BaseStoryObject = aroStory(i1)
		    
		    if oStory.bComplete then
		      if not oStory.bRepeatEveryPage then
		        Continue
		      end if
		    end if
		    
		    dim iClipWidth, iClipHeight as integer
		    If oStory.Height = -1 Then
		      iClipHeight = g.Height
		    Else
		      iClipHeight = oStory.Height
		    End If
		    If oStory.Width = -1 Then
		      iClipWidth = g.Width
		    Else
		      iClipWidth = oStory.Width
		    End If
		    dim gClip as Graphics = g.Clip(x,y, iClipWidth, iClipHeight)
		    
		    oStory.Draw(gClip)
		    
		    y = y + iClipHeight + StorySpacing
		  Next
		  
		  
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

	#tag Method, Flags = &h0
		Function PrintPreview() As Picture()
		  dim arp() as Picture
		  
		  
		  While not bPrintDone
		    dim p as New Picture(593, 773)
		    dim iWidth,iHeight as integer
		    
		    Go(p.Graphics)
		    
		    arp.Append(p)
		    
		    if AllDone Then bPrintDone = True
		    
		  Wend
		  
		  Return arp()
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		aroStory() As BaseStoryObject
	#tag EndProperty

	#tag Property, Flags = &h0
		bPrintDone As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Margin As Integer = 40
	#tag EndProperty

	#tag Property, Flags = &h0
		StorySpacing As Integer = 10
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
