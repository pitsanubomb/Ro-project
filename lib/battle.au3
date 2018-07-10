Func AttackMonster()
   	WinActivate("Ragnarok")
   	Autopotion()
	$checkpoint+=1
	If $checkpoint = 5 Then
		$checkpoint = 0
		GUICtrlSetData($hEdit, @CRLF & @HOUR & ":" & @MIN& " : Wing เนื่องจากเดินไม่ได้ และไม่พบม้อนส์เตอร์" ,1)
	    _GUICtrlEdit_Scroll($hEdit, $SB_SCROLLCARET)
		ControlSend("Ragnarok","","","{F2}")
	EndIf
   $FindMonster = PixelSearch(0,0,@DesktopWidth,@DesktopHeight,$monster)
   If Not @error Then
	  GUICtrlSetData($hEdit, @CRLF & @HOUR & ":" & @MIN& " : เจอมอนส์เตอร์" ,1)
	  _GUICtrlEdit_Scroll($hEdit, $SB_SCROLLCARET)
	  MouseClick("left",$FindMonster[0],$FindMonster[1])
	  GUICtrlSetData($hEdit, @CRLF & @HOUR & ":" & @MIN& " : ตีม้อนส์เตอร์" ,1)
	  _GUICtrlEdit_Scroll($hEdit, $SB_SCROLLCARET)
	  While(1)
		$Alive = PixelSearch(0,0,@DesktopWidth,@DesktopHeight,$lock)
		 If Not @error Then
			;~ MouseClick("left",$Alive[0],$Alive[1])
			Autopotion()
		 Else
			GUICtrlSetData($hEdit, @CRLF & @HOUR & ":" & @MIN& " : ม้อนส์เตอร์ตายแล้ว", 1)
			_GUICtrlEdit_Scroll($hEdit, $SB_SCROLLCARET)
			$checkpoint = 0
			While(1)
			   $itemall = PixelSearch(0,0,@DesktopWidth,@DesktopHeight,$item)
			   If not @error Then
			   	GUICtrlSetData($hEdit, @CRLF & @HOUR & ":" & @MIN& " : ได้ทำการเก็บไอเทม", 1)
			   	_GUICtrlEdit_Scroll($hEdit, $SB_SCROLLCARET)
				MouseClick("Primary", $itemall[0], $itemall[1])
			   Else
			   	  GUICtrlSetData($hEdit, @CRLF & @HOUR & ":" & @MIN& " : Walk Alone", 1)
				  ExitLoop
			   EndIf
			WEnd
			ExitLoop
		 EndIf
	  WEnd
	  Sleep(100)
   Else
	  Walk()
   EndIf
EndFunc