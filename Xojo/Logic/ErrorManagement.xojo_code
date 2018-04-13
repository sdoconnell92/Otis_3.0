#tag Module
Protected Module ErrorManagement
	#tag Method, Flags = &h21
		Private Sub CommitLogsToFile(ars() as String)
		  // Get the error log filepath
		  dim fiErrorFile as FolderItem = Directory.PrimaryLogFile
		  
		  // Open up a text output stream
		  If fiErrorFile <> Nil Then
		    If fiErrorFile.Exists Then
		      Try
		        For Each sErrorMessage as string In ars()
		          dim tos as TextOutputStream = TextOutputStream.Append( fiErrorFile )
		          tos.Write( sErrorMessage )
		          tos.Close
		        Next
		      Catch err as IOException
		        // well we are already in our error log...what else can we do
		      End Try
		      
		    Else
		      Try
		        For Each sErrorMessage as string In ars()
		          dim tos as TextOutputStream = TextOutputStream.Create( fiErrorFile )
		          tos.Write( sErrorMessage )
		          tos.Close
		        Next
		      Catch err as IOException
		        // well we are already in our error log...what else can we do
		      End Try
		      
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ErrManage(sFacility as string, sMessage as string, bUserDisplay as boolean = False)
		  dim CurrentDate as New date
		  
		  // Assemble the error message
		  dim sErrorMessage as String
		  sErrorMessage = "{" + CurrentDate.SQLDateTime + "} [ " + sFacility + " ] - " + sMessage + EndOfLine
		  
		  arsLog.Append(sErrorMessage)
		  If bUserDisplay Then
		    arsUserMessage.Append(sErrorMessage)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandletmLogQueueAction(sender as Timer)
		  dim ars() as string
		  
		  For i1 as integer = 0 to arsLog.Ubound
		    
		    dim s as string = arsLog.PopFirst
		    ars.Append( s )
		    
		  Next
		  
		  
		  CommitLogsToFile(ars)
		  
		  For i1 as integer = 0 To arsUserMessage.Ubound
		    
		    dim s as string = arsUserMessage.PopFirst
		    MsgBox(s)
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Init()
		  
		  tmLogQueue = New timer
		  AddHandler tmLogQueue.Action, AddressOf ErrorManagement.HandletmLogQueueAction
		  tmLogQueue.Period = 500
		  tmLogQueue.Enabled = True
		  tmLogQueue.Mode = timer.ModeMultiple
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private arsLog() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private arsUserMessage() As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected tmLogQueue As Timer
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
