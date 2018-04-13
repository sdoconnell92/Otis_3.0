#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Open()
		  Dim customPython as FolderItem
		  
		  #if TargetMacOS
		    // Code to force use of 3.4 instead of 3.5
		    //customPython = GetFolderItem("/Library/Frameworks/Python.framework/Versions/3.4/lib/libpython3.4.dylib", FolderItem.PathTypeNative)
		    
		    // Example linking to Anaconda installation
		    // Note that as far as we know then there is only 64 bit version of Anaconda on OS X so dont try this on 32 bit application.
		    customPython = GetFolderItem("/Users/bjorneiriksson/anaconda/lib/libpython3.5m.dylib", FolderItem.PathTypeNative)
		    
		  #elseif TargetWindows
		    // Example linking to Anaconda installation
		    customPython = GetFolderItem("C:\Users\sean\Desktop\python-3.5.3-embed-win32\python35.dll", FolderItem.PathTypeNative)
		    
		  #else
		    // In this example then we are just using the default one on Linux
		    customPython = GetFolderItem("/home/bjorneiriksson/anaconda3/lib/libpython3.5m.so", FolderItem.PathTypeNative)
		  #endif
		  
		  if customPython = nil or not customPython.Exists then
		    // The custom installation could not be found so we just fall back to default one
		    MsgBox "Could not find custom path, will try default installation"
		    
		  elseif customPython.Exists then
		    Python3Script.SetPythonPath(customPython)
		    
		    If  not Python3Script.PythonIsFound() then
		      // The custom installation could not be loaded so we just fall back to default one
		      MsgBox "Could not load custom path, will try default installation"
		      
		      Python3Script.SetPythonPath(nil)
		    end if
		  end if
		  
		  If  not Python3Script.PythonIsFound() then
		    // If we still cannot find Python then it is probably not installed.
		    MsgBox "Correct Python installation was not found on this machine"
		    Quit()
		  else 
		    Python3Script.Init("StinkSync")
		  end if
		  
		  
		End Sub
	#tag EndEvent


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
