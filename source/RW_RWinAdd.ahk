; ==============================================================================
; RWIN ADD (RW) =ru= RWIN ДОБАВЛЕНИЕ (RW)
; ==============================================================================
; FileDescription: RWin add =ru= RWin добавление
; FileVersion: 2.0.3.0 2023-01-28 \\ (Major version).(Minor version).(Revision number).(Build number) (year)-(month)-(day)
; Author: kaiu@mail.ru \\ author of code changes 
; ProductName: Keybord_Assistant \\ included in the product
; OriginalFilename: RW_RWinAdd.ahk \\ What file is this code from
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−

 
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
*$vkB6:: ; necessarily without ~ =ru= обязательно без ~        
    if  ( Trim(LS_RWinOption) <> "Disable")  
      and ( (Trim(LS_RWinReassign) = "RAlt") OR  (not GetKeyState("Alt", "P")) )
      and ( (Trim(LS_RWinReassign) = "RCtrl") OR  (not GetKeyState("Ctrl", "P")) )
      and ( (Trim(LS_RWinReassign) = "RWin") OR  (not GetKeyState("Win", "P")) )
      and (not GetKeyState("CapsLock", "P"))  and (not GetKeyState("Shift", "P")) and (not GetKeyState("Tab", "P"))          
    {
        if( KeyPressTime = 0 )
        {
            SetTimer, TimerKeyPressTime, %LS_TimeSwitchLayout%
            KeyPressTime := 1
        }
    }    
    
    if ( Trim(LS_RWinReassign) = "RAlt")
    {
        SetKeyDelay -1	
        SendInput {Blind}{RAlt Down}        
    }
    else
    if ( Trim(LS_RWinReassign) = "RCtrl")
    {
        SetKeyDelay -1	
        SendInput {Blind}{RCtrl Down}
    }
    else
    if ( Trim(LS_RWinReassign) = "RWin")
    {
        SetKeyDelay -1	
        SendInput {Blind}{RWin Down}
    }


        
return    


*~$vkB6 Up:: 
        
    if ( Trim(LS_RWinReassign) = "RAlt")
    {
        SetKeyDelay -1	
        SendInput {Blind}{RAlt Up}
    }
    else
    if ( Trim(LS_RWinReassign) = "RCtrl")
    {
        SetKeyDelay -1	
        SendInput {Blind}{RCtrl Up}
    }
    else
    if ( Trim(LS_RWinReassign) = "RWin")
    {
        SetKeyDelay -1	
        SendInput {Blind}{RWin Up}
    }


    
    if  ( Trim(LS_RWinOption) <> "Disable")  
      and ( (Trim(LS_RWinReassign) = "RAlt") OR  (not GetKeyState("Alt", "P")) )
      and ( (Trim(LS_RWinReassign) = "RCtrl") OR  (not GetKeyState("Ctrl", "P")) )
      and ( (Trim(LS_RWinReassign) = "RWin") OR  (not GetKeyState("Win", "P")) )
      and (not GetKeyState("CapsLock", "P"))  and (not GetKeyState("Shift", "P")) and (not GetKeyState("Tab", "P"))          
    {
        if( KeyPressTime = 1 )
        {   
            if( A_PriorKey = "Launch_App1" )
            {                

                
                if( LS_RWinOption = "AllLayouts" )
                    switch_next_Lang() ; next language in order =ru= следующий язык по порядку
                else
                    switch_next_LangList( LS_RWinOption ) ; next language in order LAYOUT_LIST =ru= следующий язык по порядку LAYOUT_LIST
               
            }        
        }    
    }
    
    
    SetTimer, TimerKeyPressTime, off
    KeyPressTime := 0
return
 





; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc039:: ; RWin, Launch_App1 + Space
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc039:: ; RWin, Launch_App1 + Space
#if
    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if( GetKeyState("Shift", "P") )
        {
            if( Trim(LS_RWin_Shift_Space) <> "Disable" )
                SendInput {Text}%LS_RWin_Shift_Space%
        }
        else
        {
            if( Trim(LS_RWin_Space) <> "Disable" )
                SendInput {Text}%LS_RWin_Space%        
        }
    }
return



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; Birman layout support =ru= поддержка раскладки Бирмана
; https://ilyabirman.ru/typography-layout/
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−

#if (LS_RWinBirmanLayout = 1) and ( Trim(LS_RWinReassign) = "Disable" )

#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc029:: ; ` 
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc029:: ; ` 
#if
    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}₴
        else
            SendInput {Text}̀
    }
return


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc002:: ; 1 
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc002:: ; 1
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}¹
        else
            SendInput {Text}¡
    }
return


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc003:: ; 2
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc003:: ; 2 
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}²
        else
            SendInput {Text}½
    }
return


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc004:: ; 3
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc004:: ; 3
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}³
        else
            SendInput {Text}⅓
    }
return


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc005:: ; 4
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc005:: ; 4
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}$
        else
            SendInput {Text}¼
    }
return    



#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc006:: ; 5
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc006:: ; 5
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}‰
        else
            return
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc007:: ; 6
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc007:: ; 6
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}↑
        else
            SendInput {Text}̂
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc008:: ; 7
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc008:: ; 7
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            return
        else
            SendInput {Text}¿
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc009:: ; 8
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc009:: ; 8
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}∞
        else
            return
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc00A:: ; 9
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc00A:: ; 9
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}←
        else
            SendInput {Text}‹
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc00B:: ; 0
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc00B:: ; 0
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}→
        else
            SendInput {Text}›
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc00C:: ; -
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc00C:: ; -
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}—
        else
            SendInput {Text}–
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc00D:: ; =
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc00D:: ; =
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}≠
        else
            SendInput {Text}±
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc02B:: ; \
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc02B:: ; \
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            return
        else
            return
    }
return    


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc010:: ; q
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc010:: ; q
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            return
        else
            SendInput {Text}̆
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc011:: ; w
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc011:: ; w
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}✓
        else
            SendInput {Text}⌃
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc012:: ; e
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc012:: ; e
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}€
        else
            SendInput {Text}⌥
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc013:: ; r
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc013:: ; r
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}®
        else
            SendInput {Text}̊
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc014:: ; t
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc014:: ; t
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}™
        else
            return
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc015:: ; y
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc015:: ; y
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}ѣ
        else
            SendInput {Text}Ѣ
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc016:: ; u
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc016:: ; u
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}ѵ
        else
            SendInput {Text}Ѵ
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc017:: ; i
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc017:: ; i
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}і
        else
            SendInput {Text}І
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc018:: ; o
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc018:: ; o
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}ѳ
        else
            SendInput {Text}Ѳ
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc019:: ; p
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc019:: ; p
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}′
        else
            SendInput {Text}″
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc01A:: ; [
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc01A:: ; [
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}[
        else
            SendInput {Text}{
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc01B:: ; ]
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc01B:: ; ]
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}]
        else
            SendInput {Text}}
    }
return    


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc01E:: ; a
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc01E:: ; a
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}≈
        else
            SendInput {Text}⌘
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc01F:: ; s
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc01F:: ; s
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}§
        else
            SendInput {Text}⇧
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc020:: ; d 
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc020:: ; d 
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}°
        else
            SendInput {Text}⌀
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc021:: ; f
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc021:: ; f
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}£
        else
            return
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc022:: ; g
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc022:: ; g
#if
 
    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            return
        else
            return
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc023:: ; h
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc023:: ; h
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}₽
        else
            SendInput {Text}̋
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc024:: ; j
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc024:: ; j
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}„
        else
            return

    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc025:: ; k
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc025:: ; k 
#if
 
    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}“
        else
            SendInput {Text}‘
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc026:: ; l
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc026:: ; l
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}”
        else    
            SendInput {Text}’
    }
return        


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc027:: ; ;
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc027:: ; ;
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}‘
        else
            SendInput {Text}̈
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc028:: ; '
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc028:: ; '
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}’
        else
            return
    }
return    


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc02C:: ; z
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc02C:: ; z
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            return
        else
            SendInput {Text}̧
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc02D:: ; x
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc02D:: ; x
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}×
        else
            SendInput {Text}·
    }
return 


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc02E:: ; c
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc02E:: ; c
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}©
        else
            SendInput {Text}¢
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc02F:: ; v
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc02F:: ; v
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}↓
        else
            SendInput {Text}̌
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc030:: ; b
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc030:: ; b
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}ß
        else
            SendInput {Text}ẞ
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc031:: ; n
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc031:: ; n
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            return
        else
            SendInput {Text}̃
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc032:: ; m
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc032:: ; m
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}−
        else
            SendInput {Text}•
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc033:: ; , 
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc033:: ; , 
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}«
        else
            SendInput {Text}„
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc034:: ; .
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc034:: ; .
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}»
        else
            SendInput {Text}“
    }
return    


#if ( Trim(LS_RCtrlReassign) = "vkB6") 
RCtrl & sc035:: ; /
#if
#if ( Trim(LS_RWinReassign) = "Disable") 
vkB6 & sc035:: ; /
#if

    if (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
        and ( (Trim(LS_RCtrlReassign) = "vkB6") OR (not GetKeyState("Ctrl", "P")) )
    {
        if not GetKeyState("Shift")
            SendInput {Text}…
        else
            SendInput {Text}́
    }
return

#if
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−


; ==============================================================================