Local $hEdit = GUICtrlCreateEdit("", 4, 156, 393, 89,BitOR($ES_READONLY,$ES_WANTRETURN,$WS_BORDER,$WS_VSCROLL, $ES_AUTOVSCROLL),0)
Func Pitionauto()
	$potioncheck = PixelGetColor(460, 82)
	If Not Hex($potioncheck) = "00CEE7FF" Then
        GUICtrlSetData($hEdit, @CRLF & @HOUR & ":" & @MIN& " : เคิมเลือด เนื่องจากเลือดลด" ,1)
	    _GUICtrlEdit_Scroll($hEdit, $SB_SCROLLCARET)
		ControlSend("Ragnarok","","","{F1}")
	EndIf

EndFunc