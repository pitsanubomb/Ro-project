Local $hEdit = GUICtrlCreateEdit("", 4, 156, 393, 89,BitOR($ES_READONLY,$ES_WANTRETURN,$WS_BORDER,$WS_VSCROLL, $ES_AUTOVSCROLL),0)
Func Autopotion()
	$potioncheck = PixelGetColor(165, 57)
	If Not (Hex($potioncheck) = "009CB5EF") Then
        GUICtrlSetData($hEdit, @CRLF & @HOUR & ":" & @MIN& " : เคิมเลือด เนื่องจากเลือดลด" ,1)
	    _GUICtrlEdit_Scroll($hEdit, $SB_SCROLLCARET)
		ControlSend("Ragnarok","","","{F1}")
	EndIf
EndFunc