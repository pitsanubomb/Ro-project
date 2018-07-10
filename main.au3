#include  <core/core.au3>

#include <lib/autopotion.au3>
#include <lib/randomwalk.au3>
#include <lib/battle.au3>

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

