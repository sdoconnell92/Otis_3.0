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
		Sub DrawGrid(g as Graphics)
		  dim x, y as integer
		  
		  While y < g.Height
		    
		    g.Drawline(0, y, g.Width, y)
		    
		    y = y + 100
		    
		  Wend
		  
		  While x < g.Width
		    
		    g.DrawLine(x, 0, x, g.Height )
		    
		    x = x + 100
		    
		  Wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawLogo(g as Graphics)
		  dim p as Picture 
		  
		  If bForScreen Then
		    p = EIPL_HeaderLogo_Screen
		  Else
		    p = EIPL_HeaderLogo
		  End If
		  
		  g.DrawPicture( p, 0, 0, 160, 80, 0, 0, p.Width, p.Height )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Go(Fullg as Graphics)
		  dim bDone as Boolean = False
		  
		  // reduce the area we are working with by the margins
		  dim g as Graphics
		  g = Fullg.Clip(margin.Left, margin.Top, Fullg.Width - (Margin.Left + Margin.Right), fullg.Height - (Margin.Top + Margin.Bottom) )
		  //g = Fullg.Clip(0, 0, Fullg.Width, fullg.Height )
		  DrawLogo(g)
		  
		  dim x, y as integer
		  
		  // Loop through all story objects to determine the amount of space on the last page above lineitems
		  // Also figure out the amount of space above line items on the first page in case the first page is the last page
		  dim listart as integer
		  
		  For i1 as integer = 0 to aroStory.Ubound
		    dim oStory as BaseStoryObject = aroStory(i1)
		    
		    // Determine how much space is needed at the end of page after line items
		    dim iHeightNeededAfterLI as integer
		    If oStory IsA LineItemStory Then
		      listart = y
		      For i2 as integer = i1 + 1 to aroStory.Ubound
		        dim o as BaseStoryObject = aroStory(i2)
		        If o IsA RemitStory Then
		          Continue
		        Else
		          iHeightNeededAfterLI = iHeightNeededAfterLI + o.Height
		        End If
		      Next
		    End If
		    
		    // Determine if we are on the last page so we know if we want to draw last page stuff
		    if oStory.bOnlyLastPage Then
		      dim bCom as Boolean
		      For i3 as integer = 0 To aroStory.Ubound
		        dim oStory1 as BaseStoryObject = aroStory(i3)
		        If oStory1 IsA LineItemStory Then
		          dim v as Variant = oStory1
		          dim oli as LineItemStory = v
		          bCom = oli.bComplete
		          Exit
		        End If
		      Next
		      
		      If Not bCom Then
		        // Line items not complete so we move on with our story objects
		        Continue
		      Else
		        // Line items complete, now we determine the remity spot
		        If iCurrentPage = 1 Then
		          RemitY = RemitY + listart
		        Else
		          RemitY = RemitY + listart
		        end if
		      end if
		      
		    end if
		    
		    if oStory.bComplete then
		      if not oStory.bRepeatEveryPage then
		        Continue
		      end if
		    end if
		    
		    dim iClipWidth, iClipHeight as integer
		    If oStory.Height = -1 Then
		      iClipHeight = g.Height - y
		    Else
		      iClipHeight = oStory.Height
		    End If
		    If oStory IsA LineItemStory Then iClipHeight = iClipHeight - iHeightNeededAfterLI
		    If oStory.Width = -1 Then
		      iClipWidth = g.Width
		    Else
		      iClipWidth = oStory.Width
		    End If
		    dim gClip as Graphics
		    If oStory IsA RemitStory Then
		      // subtracting 90 here is just the wrong way to do it, but i cannot seem to figure out why remit payment wont print in the right spot.... it always prints too low [11/14/2017]
		      gClip = g.Clip(x,RemitY - 90, iClipWidth, iClipHeight)
		    ElseIf oStory IsA FooterStory Then
		      gClip = g.Clip(x, g.Height - iClipHeight, iClipWidth, iClipHeight)
		    Else
		      gClip = g.Clip(x,y, iClipWidth, iClipHeight)
		    End If
		    
		    oStory.Draw(gClip)
		    
		    y = y + gClip.Height + StorySpacing
		  Next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Print(AutoAdjust as Boolean = True)
		  dim arp() as Picture
		  Margin = New MarginsClass
		  
		  bForScreen = False
		  
		  Dim ps As New PrinterSetup
		  If ps.PageSetupDialog Then
		    Dim Fullg As Graphics
		    Fullg = OpenPrinterDialog(ps)
		    If Fullg <> Nil Then
		      
		      // expand graphics to full width of page
		      dim g as Graphics = Fullg
		      dim top, left, width, height as integer
		      top = ps.Top + ps.PageTop
		      left = ps.Left + ps.PageLeft
		      width = ps.PageWidth
		      height = ps.PageHeight
		      
		      g = Fullg.Clip(left, top, width, height)
		      
		      // If AutoAdjust Then
		      // Break
		      // dim Adjusted as Boolean
		      // While Not Adjusted
		      // dim pa as New Picture(width, height)
		      // dim g2 as Graphics = pa.Graphics
		      // dim arp1() as Picture = PrintPreview(g2.Width, g2.Height, False, False)
		      // If LastPageLines < 6 Then
		      // // Find the lineitem story
		      // For Each oStory as BaseStoryObject In aroStory()
		      // If oStory IsA LineItemStory THen
		      // dim v as Variant = oStory
		      // dim o as LineItemStory = v
		      // dim p1 as New Picture(200,200)
		      // dim g1 as Graphics = p1.Graphics
		      // g1.TextSize = o.FontSize
		      // 
		      // dim n1 as integer = (g1.TextHeight + o.iLineBuffer) * LastPageLines
		      // If n1 < 80 Then
		      // dim half as integer = Ceil(n1 / 2)
		      // Margin.Top = Margin.Top - half
		      // Margin.Bottom = Margin.Bottom - half
		      // Else
		      // Adjusted = True
		      // End If
		      // End If
		      // Next
		      // Else
		      // Adjusted = True
		      // End If
		      // ResetComplete
		      // Wend
		      // End If
		      
		      // Set stuff up
		      iNumberofPages = PrintPreview(g.Width, g.Height, False, False).Ubound + 1
		      iCurrentPage = 1
		      ResetComplete
		      
		      While not bPrintDone
		        
		        Go(g)
		        
		        
		        if AllDone Then bPrintDone = True
		        if not bPrintDone then
		          g.NextPage
		          iCurrentPage = iCurrentPage + 1
		        end if
		        
		      Wend
		      
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PrintPreview(iWidth as integer = 593, iHeight as integer = 773, CalcPages as Boolean = True, AutoAdjust as Boolean = True) As Picture()
		  dim arp() as Picture
		  Margin = New MarginsClass
		  
		  // If AutoAdjust Then
		  // Break
		  // dim Adjusted as Boolean
		  // While Not Adjusted
		  // dim pa as New Picture(iWidth, iHeight)
		  // dim g as Graphics = pa.Graphics
		  // dim arp1() as Picture = PrintPreview(g.Width, g.Height, False, False)
		  // If LastPageLines < 6 Then
		  // // Find the lineitem story
		  // For Each oStory as BaseStoryObject In aroStory()
		  // If oStory IsA LineItemStory THen
		  // dim v as Variant = oStory
		  // dim o as LineItemStory = v
		  // dim p1 as New Picture(200,200)
		  // dim g1 as Graphics = p1.Graphics
		  // g1.TextSize = o.FontSize
		  // 
		  // dim n1 as integer = (g1.TextHeight + o.iLineBuffer) * LastPageLines
		  // If n1 < 80 Then
		  // dim half as integer = Ceil(n1 / 2)
		  // Margin.Top = Margin.Top - half
		  // Margin.Bottom = Margin.Bottom - half
		  // Else
		  // Adjusted = True
		  // End If
		  // End If
		  // Next
		  // Else
		  // Adjusted = True
		  // End If
		  // ResetComplete
		  // Wend
		  // End If
		  
		  
		  If CalcPages Then
		    dim pa as New Picture(iWidth, iHeight)
		    dim g as Graphics = pa.Graphics
		    iNumberofPages = PrintPreview(g.Width, g.Height, False, False).Ubound + 1
		    iCurrentPage = 1
		    ResetComplete
		  End If
		  
		  bForScreen = True
		  
		  While not bPrintDone
		    dim p as New Picture(iWidth, iHeight)
		    
		    Go(p.Graphics)
		    
		    arp.Append(p)
		    
		    if AllDone Then bPrintDone = True
		    
		    iCurrentPage = iCurrentPage + 1
		    
		  Wend
		  
		  Return arp()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetComplete()
		  For Each oStory as BaseStoryObject In aroStory
		    oStory.bComplete = False
		    if oStory IsA LineItemStory Then
		      dim va as Variant = oStory
		      dim o as LineItemStory = va
		      o.oCurs = New ArrayCursorClass
		      o.PageLines = 0
		    end if
		  Next
		  
		  bForScreen = False
		  bPrintDone = False
		  LastPageLines = 0
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		aroStory() As BaseStoryObject
	#tag EndProperty

	#tag Property, Flags = &h0
		bForScreen As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		bPrintDone As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		iCurrentPage As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		iNumberofPages As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		LastPageLines As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Margin As MarginsClass
	#tag EndProperty

	#tag Property, Flags = &h0
		RemitY As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		StorySpacing As Integer = 5
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="bForScreen"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="bPrintDone"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="iCurrentPage"
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
			Name="iNumberofPages"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastPageLines"
			Group="Behavior"
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
			Name="RemitY"
			Group="Behavior"
			Type="Integer"
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
