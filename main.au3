#include  <core/core.au3>

#include <lib/autopotion.au3>
#include <lib/randomwalk.au3>

#include <config/core.config.au3>

HotKeySet("{s}", "Start")
HotKeySet("{ESC}", "_Exit")
HotKeySet("{p}", "Stop")

$hGUI = GUICreate("Form1", 401, 401, -1, -1,  BitOR($WS_POPUP,$WS_BORDER), $WS_EX_TOPMOST)
GUISetBkColor($Bg)
$Button1 = GUICtrlCreateButton("Button1", 80, 280, 75, 25)
$Button2 = GUICtrlCreateButton("Button2", 216, 280, 75, 25)
Local $hEdit = GUICtrlCreateEdit("", 4, 156, 393, 89,BitOR($ES_READONLY,$ES_WANTRETURN,$WS_BORDER,$WS_VSCROLL, $ES_AUTOVSCROLL),0)
GUICtrlSetColor($hEdit, $Font)

GUICtrlSetBkColor(-1, $Bg)
GUISetState(@SW_SHOW)



While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		 Case $GUI_EVENT_CLOSE
			Exit
		 Case $Button1
			Start()
		 Case $Button2
			Stop()
		 Case $GUI_EVENT_PRIMARYDOWN
            _SendMessage($hGUI, $WM_SYSCOMMAND, $SC_DRAGMOVE, 0)
   EndSwitch
 WEnd

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
	  MouseClick("left",$FindMonster[0] + 25,$FindMonster[1] + 25)
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
				MouseClick("Primary", $itemall[0] + 25, $itemall[1] + 25)
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

Func Start()
	$STOPPED = 1
	  If $STOPPED = 1 Then
	  GUICtrlSetData($hEdit,@HOUR & ":" & @MIN& " : Start Bot" ,1)
		While $STOPPED = 1
		 If WinExists("Ragnarok") Then
			AttackMonster()
		  Else
			GUICtrlSetData(-1, StringFormat(""))
		 EndIf
		 WEnd
	EndIf
 EndFunc

 Func Stop()
	ConsoleWrite("Stoped")
	$STOPPED = 0
 EndFunc

