#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

verText = Wheel Zoom for WIN 1.0

byText = Source code: https://github.com/rexct/wheel-zoom-win

titleText = %verText% - 等待啟動放大鏡
titleStarted = %verText% - 放大鏡已啟動

useTransparent = 1

startText = `n將放大鏡齒輪按鈕中 [設定縮放時檢視的變更方式] 調整到最小有較佳效果，`n並按放大鏡的視窗 [最小化] 按鈕隱藏放大鏡視窗`n`n%byText%
transStepVal := 15 ; 透明度變動單位

;######################
; win-key+Wheel zoom-in and zoom-out
;######################
IfWinNotExist ahk_class MagUIClass
{
	Run, Magnify.exe
	MsgBox, 0, %titleText%, %startText%, 3
}
else
{
	WinGet, titleName, 
	MsgBox, 0, %titleStarted%, %byText%, 1
}

#WheelUp::
	Send #=
	IfWinNotExist ahk_class MagUIClass
	{
		MsgBox, 0, %titleText%, %startText%, 2
	}
return

#WheelDown::
	Send #-
return

;######################
; alt+wheel transparent
;######################
!WheelUp::
	MouseGetPos,,, MouseWin
	WinGet, winTrans, Transparent, ahk_id %MouseWin% ; get Transparency of window under the mouse cursor.
	setTrans := 255
	if ( winTrans = "" )
	{
		setTrans := 255 - transStepVal
	}
	else if ( winTrans > transStepVal && winTrans < 256)
	{
		setTrans := winTrans - transStepVal
	}
	WinSet Transparent, %setTrans%, ahk_id %MouseWin%
return

!WheelDown::
	MouseGetPos,,, MouseWin
	WinGet, winTrans, Transparent, ahk_id %MouseWin% ; get Transparency of window under the mouse cursor.
	if ( winTrans < 255)
	{
		setTrans := winTrans + transStepVal
		WinSet Transparent, %setTrans%, ahk_id %MouseWin%
	}
return