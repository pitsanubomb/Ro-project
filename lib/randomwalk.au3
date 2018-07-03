#include <../config/walk.config.au3>

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