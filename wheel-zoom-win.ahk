;SetTimer WatchCursor, 100

;useTransparent := 1

transStepVal := 15 ; 透明度變動單位

;######################
; win-key+Wheel zoom-in and zoom-out
;######################
if !WinExist("ahk_class MagUIClass")
{
      Run("Magnify.exe")
      WinWait("ahk_class MagUIClass")
      ; if WinWait("ahk_class MagUIClass")
        ; MsgBox "放大鏡啟動"
}

;!LButton::
;{
;  move windows with Alt

;}

!WheelUp::
{
  MouseGetPos ,,&mouseWin
;  WinActivate "ahk_id" mouseWin


  setTrans := WinGetTransparent(mouseWin)

    if (setTrans = "")
    {
        setTrans := 255 - transStepVal
    }
    else 
    {
        if (setTrans > transStepVal && setTrans < 256){
            setTrans := setTrans - transStepVal
        }
    }
    WinSetTransparent setTrans, "ahk_id " mouseWin
}

!WheelDown::
{
  MouseGetPos ,,&mouseWin
;  WinActivate "ahk_id" mouseWin

  setTrans := WinGetTransparent(mouseWin)


    if(setTrans = ""){
        Exit
    } 
    if (setTrans < 255)
    {
        setTrans := setTrans + transStepVal
        WinSetTransparent setTrans, "ahk_id" mouseWin
    }
    
}

#WheelUp::
{
  Send "#="
}


#WheelDown::
{
  Send "#-"
}

;; invert window color
#n::
{
  Send "^!i"
  ;active_id := WinGetID("A")
  ;MouseGetPos ,,&mouseWin
  ;wTitle := WinGetTitle(mouseWin)
  ;MsgBox "The active window's ID is " wTitle
}

#o::
{
    appName := "Skype"
    WinGetPos &skypeX, &skypeY,,,appName
    ; MsgBox "Skype at " skypeX " " skypeY

    if( skypeX > 3800) {
        WinMove -8,-8,500,1040,appName
        WinMaximize appName
        WinActivate appName
    } else {
        WinRestore appName
        WinMove 3831,1076,500,1040, appName
    }
}