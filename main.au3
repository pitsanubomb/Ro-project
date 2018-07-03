#RequireAdmin
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <String.au3>
#include <AutoItConstants.au3>
#include <INet.au3>
#include <ColorConstants.au3>
#include <SendMessage.au3>
#include <GuiEdit.au3>
#Include <ScrollBarConstants.au3>


#include <lib/autopotion.au3>

HotKeySet("{HOME}", "Start")
HotKeySet("{ESC}", "_Exit")
HotKeySet("{INS}", "Stop")

Global $sw = 1
Global $FloorColor = 0x21242B
Global $monster =  0x00FF00
Global $lock = 0x440088
Global $checkLiftMonster = "440088"
Global $STOPPED
Global $Bg = 0xF6D9CC
Global $Font = 0x0422e2
Global $item = 0x6B29A5

Global Const $SC_DRAGMOVE = 0xF012

Global $left
Global $top
Global $right
Global $bottom
Global $checkpoint

Global $WALKALL = [WalkUp, WalkDown, WalkLeft, WalkRight, WalkUpperLeft, WalkUpperRight, WalkLowerLeft, WalkLowerRight]
Global $NOTWALKLEFT = [WalkUp, WalkDown, WalkRight, WalkUpperRight, WalkLowerRight]
Global $NOTWALKRIGHT = [WalkUp, WalkDown, WalkLeft, WalkUpperLeft,WalkLowerLeft]
Global $NOTWALKUP = [WalkDown, WalkLeft, WalkRight, WalkLowerLeft, WalkLowerRight]
Global $NOTWALKDOWN = [WalkUp, WalkLeft, WalkRight, WalkUpperLeft, WalkUpperRight]
Global $NOTWALKDOWNANDUP = [WalkLeft, WalkRight]
Global $NOTWALKDOWNANDUPRANDOM = [WalkLeft, WalkRight, WalkDown, WalkLowerRight, WalkLowerLeft]
Global $NOTWALKDOWNANDLEFT = [WalkUp, WalkRight, WalkUpperRight]
Global $NOTWALKDOWNANDRIGHT = [WalkUp, WalkLeft, WalkUpperLeft]

Opt("PixelCoordMode", 2) ;1=absolute, 0=relative, 2=client
Opt("MouseCoordMode", 2) ;1=absolute, 0=relative, 2=client

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
   $FindMonster = PixelSearch(0,0,@DesktopWidth,@DesktopHeight,$monster)
   If Not @error Then
	  MouseClick("left",$FindMonster[0] + 25 ,$FindMonster[1] + 25,3, 0)
	  GUICtrlSetData($hEdit, @CRLF & @HOUR & ":" & @MIN& " : ตีม้อนส์เตอร์" ,1)
	  _GUICtrlEdit_Scroll($hEdit, $SB_SCROLLCARET)
	  While(1)
		$Alive = PixelSearch(0,0,@DesktopWidth,@DesktopHeight,$lock)
		 If Not @error Then
			MouseClick("left",$Alive[0]+ 25,$Alive[1]+ 25)
		 Else
			GUICtrlSetData($hEdit, @CRLF & @HOUR & ":" & @MIN& " : ม้อนส์เตอร์ตายแล้ว", 1)
			_GUICtrlEdit_Scroll($hEdit, $SB_SCROLLCARET)
			While(1)
			   $itmesall = PixelSearch(0,0,@DesktopWidth,@DesktopHeight,$item)
			   If not @error Then
			   	GUICtrlSetData($hEdit, @CRLF & @HOUR & ":" & @MIN& " : ได้ทำการเก็บไอเทม", 1)
			   	_GUICtrlEdit_Scroll($hEdit, $SB_SCROLLCARET)
				MouseClick("Primary", $itmesall[0] + 20, $itmesall[1] + 20, 5, 0)
			   Else
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

Func Walk()
;~    0x21242B
   $iColor = PixelGetColor(843, 433) ;=> UP
;~    ConsoleWrite(Hex($iColor) & @CRLF)
   If Hex($iColor) = "0021242B" Then
	  $iColor = PixelGetColor(701, 513)
	  If Hex($iColor) = "0021242B" Then
		 ConsoleWrite("Can Left" & @CRLF)
		 $iColor = PixelGetColor(993, 516) ;=> Right
		 If Hex($iColor) = "0021242B" Then
			ConsoleWrite("Can Right" & @CRLF)
			$iColor = PixelGetColor(843, 680) ;=> Down
			If Hex($iColor) = "0021242B" Then
			   ConsoleWrite("Can Down" & @CRLF)
			   ConsoleWrite("Randor All" & @CRLF)
			   $WALKALL[Random(0, 7, 1)]()
			Else
			   ConsoleWrite("Random not down" & @CRLF)
			   $NOTWALKDOWN[Random(0, 4, 1)]()
			EndIf
		 Else
			$NOTWALKRIGHT[Random(0, 4, 1)]()
		 EndIf
	  Else
		 $iColor = PixelGetColor(993, 516) ;=> Right
		 If Hex($iColor) = "0021242B" Then
;~ 			PixelSearch(0,0,848, 643,$FloorColor) ;=>Down
			$iColor = PixelGetColor(843, 680)
			If Hex($iColor) = "0021242B" Then
			   $NOTWALKLEFT[Random(0, 4, 1)]()
			Else
			   $NOTWALKDOWN[Random(0, 4, 1)]()
			EndIf
		 Else
			$NOTWALKRIGHT[Random(0, 4, 1)]()
		 EndIf
	  EndIf
   Else
	  ConsoleWrite("Can not walk up" & @CRLF)
	;~   ConsoleWrite(Hex($iColor) & @CRLF)
	  $iColor = PixelGetColor(701, 513)
	  If Hex($iColor) = "0021242B" Then
		 ConsoleWrite("Can Left" & @CRLF)
		 $iColor = PixelGetColor(993, 516) ;=> Right
		 If Hex($iColor) = "0021242B" Then
			$iColor = PixelGetColor(405, 514)
			If Hex($iColor) = "0021242B" Then
			   $NOTWALKUP[Random(0, 4, 1)]()
			Else
			   $NOTWALKDOWNANDUP[Random(0, 1, 1)]()
			EndIf
		 Else
			$NOTWALKRIGHT[Random(0, 4, 1)]()
		 EndIf
	  Else
		 $iColor = PixelGetColor(993, 516) ;=> Right
		 If Hex($iColor) = "0021242B" Then
;~ 			PixelSearch(0,0,848, 643,$FloorColor) ;=>Down
			$iColor = PixelGetColor(843, 680)
			If Hex($iColor) = "0021242B" Then
			   $NOTWALKDOWNANDLEFT[Random(0, 2, 1)]()
			Else
			   $NOTWALKDOWNANDUP[Random(0, 1, 1)]()
			EndIf
		 Else
			$NOTWALKDOWNANDRIGHT[Random(0, 2, 1)]()
		 EndIf
	  EndIf
   EndIf
EndFunc

Func WalkUp()
   Global $WALKCOUNT = 0
   Do
	  MouseClick("left",845, 196, 5)
	  Sleep(100)
	  $iColor = PixelGetColor(843, 433)
	  If Not Hex($iColor) = "0021242B" Then
		 ExitLoop
	  EndIf
	  $WALKCOUNT = $WALKCOUNT + 1
   Until $WALKCOUNT = 3
EndFunc   ;==>WalkUp

Func WalkDown()
   Global $WALKCOUNT = 0
   Do
	  MouseClick("left", 845, 842, 5)
	  Sleep(100)
	  $iColor = PixelGetColor(843, 680)
	  If Not Hex($iColor) = "0021242B" Then
		 ExitLoop
	  EndIf
	  $WALKCOUNT = $WALKCOUNT + 1
   Until $WALKCOUNT = 3
EndFunc   ;==>WalkDown

Func WalkLeft()
   Global $WALKCOUNT = 0
   Do
	  MouseClick("left", 436, 550, 5)
	  Sleep(100)
	  $iColor = PixelGetColor(701, 513)
	  If Not Hex($iColor) = "0021242B" Then
		 ExitLoop
	  EndIf
	  $WALKCOUNT = $WALKCOUNT + 1
   Until $WALKCOUNT = 3
EndFunc   ;==>WalkLeft

Func WalkRight()
   Global $WALKCOUNT = 0
   Do
	  MouseClick("left", 1190, 550, 5)
	  Sleep(100)
	  $iColor = PixelGetColor(993, 516)
	  If Not Hex($iColor) = "0021242B" Then
		 ExitLoop
	  EndIf
	  $WALKCOUNT = $WALKCOUNT + 1
   Until $WALKCOUNT = 3
EndFunc   ;==>WalkRight

Func WalkUpperLeft()
   MouseClick("left",510, 223, 5)
   Sleep(100)
EndFunc   ;==>WalkUpperLeft

Func WalkUpperRight()
   MouseClick("left", 1173, 223, 5)
   Sleep(100)
EndFunc   ;==>WalkUpperRight

Func WalkLowerLeft()
   MouseClick("left", 442, 789, 5)
   Sleep(100)
EndFunc   ;==>WalkLowerLeft

Func WalkLowerRight()
   MouseClick("left", 1119, 632, 5)
   Sleep(100)
 EndFunc   ;==>WalkLowerRight

 Func _Exit()
	ConsoleWrite("Exit")
	Exit
EndFunc
