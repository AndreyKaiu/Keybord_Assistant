; ==============================================================================
; RALT ADD (RA) =ru= RALT ДОБАВЛЕНИЕ (RA)
; ==============================================================================
; FileDescription: RAlt add =ru= RAlt добавление
; FileVersion: 2.0.4.0 2023-03-07 \\ (Major version).(Minor version).(Revision number).(Build number) (year)-(month)-(day)
; Author: kaiu@mail.ru \\ author of code changes 
; ProductName: Keybord_Assistant \\ included in the product
; OriginalFilename: RA_RAltAdd.ahk \\ What file is this code from
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−

; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; increase mouse cursor speed =ru= увеличение скорости перемещения курсора мыши
TimerVAdd:    
    if pmN > 0
    {                
        if vm < 4 ; do not write the variable name vmBeg - slows down =ru= не писать имя переменной vmBeg — тормозит
            vm := 4
        else if vm <= 4
            vm := 8    
        else if vm <= 8
            vm := 16
        else if vm <= 16
            vm := 24
        else if vm <= 24
            vm := 32
        else if vm <= 32
            vm := 40
        else if vm <= 40
            vm := 56
        else if vm <= 56
            vm := 72
        else if vm <= 72
            vm := 88
        ;else if vm <= 88
        ;    vm := 104            
    }
return

; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; moving the mouse pointer =ru= перемещение указателя мыши
TimerMoveU:
    if pmN > 0
    {
        if pmN=1
            MouseMove, vm, 0, plav, Relative
        else if pmN=2
            MouseMove, -vm, 0, plav, Relative
        else if pmN=3
            MouseMove, 0, vm, plav, Relative
        else if pmN=4
            MouseMove, 0, -vm, plav, Relative    
    }
return

; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
#if ( Trim(LS_RAltReassign) = "Disable" )
vkA9 & Tab::return

LAlt & vkA9::return

vkA9 & F1::
    Gosub MN_HelpFile
return

#if
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−





; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
#if (LS_RAltAddMouse = 1) and ( Trim(LS_RAltReassign) = "Disable" )

vkA9 & Tab Up::
	SetTimer, TimerMoveU, off
	SetTimer, TimerVAdd, off	
	pmN:=0
	vm:=0
	
	if MouseClDownL=1 
		Click, Up
	if MouseClDownR=1
		Click, Up, Right
	if( (MouseClDownL=1) or (MouseClDownR=1) )
	{
		kbd_msg(kbd_msg_1)
        if( LS_PlaySound )
        {
            SoundPlay, ""
            SoundPlay, %A_ScriptDir%\sound\%LS_FileSoundMouseStuckOFF%
        }
	}
    
	MouseClDownL:=0 ; click operation mode on the left side of the mouse =ru= режим удержания клика на левой кнопке мыши
    MouseClDownR:=0 ; hold-click mode on the right mouse button =ru= режим удержания клика на правой кнопке мыши
return


vkA9 & sc016 Up::
vkA9 & sc018 Up::
vkA9 & sc017 Up::
vkA9 & sc025 Up::
vkA9 & sc024 Up::
vkA9 & sc026 Up::
	SetTimer, TimerMoveU, off
	SetTimer, TimerVAdd, off	
	pmN:=0
	vm:=0
return

#if
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−




; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
*$vkA9:: ; necessarily without ~ =ru= обязательно без ~       
    if  ( Trim(LS_RAltOption) <> "Disable")  
      and ( (Trim(LS_RAltReassign) = "RAlt") OR  (not GetKeyState("Alt", "P")) )
      and ( (Trim(LS_RAltReassign) = "RCtrl") OR  (not GetKeyState("Ctrl", "P")) )
      and (not GetKeyState("CapsLock", "P"))  and (not GetKeyState("Shift", "P")) and (not GetKeyState("Win", "P"))  and (not GetKeyState("Tab", "P"))          
    {
        if( KeyPressTime = 0 )
        {
            SetTimer, TimerKeyPressTime, %LS_TimeSwitchLayout%
            KeyPressTime := 1
        }
    }    
    
    if ( Trim(LS_RAltReassign) = "RAlt")
    {
        SetKeyDelay -1	
        SendInput {Blind}{RAlt Down}        
    }
    else
    if ( Trim(LS_RAltReassign) = "RCtrl")
    {
        SetKeyDelay -1	
        SendInput {Blind}{RCtrl Down}
    }


        
return    


*~$vkA9 Up::    
        
    if ( Trim(LS_RAltReassign) = "RAlt")
    {
        SetKeyDelay -1	
        SendInput {Blind}{RAlt Up}
    }
    else
    if ( Trim(LS_RAltReassign) = "RCtrl")
    {
        SetKeyDelay -1	
        SendInput {Blind}{RCtrl Up}
    }


    
    if  ( Trim(LS_RAltOption) <> "Disable") 
      and ( (Trim(LS_RAltReassign) = "RAlt") OR  (not GetKeyState("Alt", "P")) )
      and ( (Trim(LS_RAltReassign) = "RCtrl") OR  (not GetKeyState("Ctrl", "P")) )
      and (not GetKeyState("CapsLock", "P"))  and (not GetKeyState("Shift", "P")) and (not GetKeyState("Win", "P"))  and (not GetKeyState("Tab", "P"))          
    {
        if( KeyPressTime = 1 )
        {   
            if( A_PriorKey = "Browser_Stop" )
            {
                if( LS_RAltOption = "AllLayouts" )
                    switch_next_Lang() ; next language in order =ru= следующий язык по порядку
                else
                    switch_next_LangList( LS_RAltOption ) ; next language in order LAYOUT_LIST =ru= следующий язык по порядку LAYOUT_LIST
            
            }        
        }    
    }
    
    
    SetTimer, TimerKeyPressTime, off
    KeyPressTime := 0
return






; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
#if (LS_RAltAddChars = 1) and ( Trim(LS_RAltReassign) = "Disable" )

vkA9 & sc002:: ; 1     RAlt, Browser_Stop + 1
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if( GetKeyState("Shift", "P") )
        {
            if (Trim(LS_RAlt_Shift_1) <> "Disable")
                SendInput {Text}%LS_RAlt_Shift_1%
        }
        else            
            SendInput {vkA9 Up}{Text}!
    }
return

vkA9 & sc003:: ; 2
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if( GetKeyState("Shift", "P") )
        {
            if (Trim(LS_RAlt_Shift_2) <> "Disable")
                SendInput {Text}%LS_RAlt_Shift_2%
        }
        else            
            SendInput {vkA9 Up}{Text}@
    }
return

vkA9 & sc004:: ; 3
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if( GetKeyState("Shift", "P") )
        {
            if (Trim(LS_RAlt_Shift_3) <> "Disable")
                SendInput {Text}%LS_RAlt_Shift_3%
        }
        else            
            SendInput {vkA9 Up}{Text}#
    }
return



vkA9 & sc039:: ;  RAlt, Browser_Stop + Space
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if( GetKeyState("Shift", "P") )
        {
            if( Trim(LS_RAlt_Shift_Space) <> "Disable" )
                SendInput {Text}%LS_RAlt_Shift_Space%
        }
        else
        {
            if( Trim(LS_RAlt_Space) <> "Disable" )
                SendInput {Text}%LS_RAlt_Space%        
        }
    }
return


vkA9 & sc010:: ; q
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if( not GetKeyState("Shift", "P") )  
        {
            if( Trim(LS_RAlt_Q) <> "Disable" )
                SendInput {Text}%LS_RAlt_Q%
        }
        else
        {
            if( Trim(LS_RAlt_Shift_Q) <> "Disable" )
                SendInput {Text}%LS_RAlt_Shift_Q%
        }
    }
return


vkA9 & sc011:: ; w
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if( not GetKeyState("Shift", "P") )
        {
            if( Trim(LS_RAlt_W) <> "Disable" )
                SendInput {Text}%LS_RAlt_W%
        }
        else
        {
            if( Trim(LS_RAlt_Shift_W) <> "Disable" )
                SendInput {Text}%LS_RAlt_Shift_W%
        }
    }
return


vkA9 & sc01E:: ; a
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if( not GetKeyState("Shift", "P") )
        {
            if( Trim(LS_RAlt_A) <> "Disable" )
                SendInput {Text}%LS_RAlt_A%
        }
        else
        {
            if( Trim(LS_RAlt_Shift_A) <> "Disable" )
                SendInput {Text}%LS_RAlt_Shift_A%
        }
    }
return


vkA9 & sc02C:: ; z
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if( not GetKeyState("Shift", "P") )
        {
            if( Trim(LS_RAlt_Z) <> "Disable" )
                SendInput {Text}%LS_RAlt_Z%
        }
        else
        {
            if( Trim(LS_RAlt_Shift_Z) <> "Disable" )
                SendInput {Text}%LS_RAlt_Shift_Z%
        }
    }
return



vkA9 & sc030:: ; b
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if( not GetKeyState("Shift", "P") )
        {
            if( Trim(LS_RAlt_B) <> "Disable" )
                SendInput {Text}%LS_RAlt_B%
        }
        else
        {
            if( Trim(LS_RAlt_Shift_B) <> "Disable" )
                SendInput {Text}%LS_RAlt_Shift_B%
        }
    }
return




; further not customizable via ini file
; =ru=  далее не настраевые через ini файл


vkA9 & sc029:: ; for ` send ~ or ` =ru= для ` отправить ~ или `
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if( GetKeyState("Shift", "P") = GetKeyState("CapsLock", "T") )
            SendInput {vkA9 Up}{Text}~
        else
            SendInput {vkA9 Up}{Text}``
    }
return


vkA9 & sc005:: ; 4
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if( not GetKeyState("Shift", "P") )
            SendInput {vkA9 Up}{Text}$
        else
            SendInput {vkA9 Up}{Text}§
    }       
return

vkA9 & sc006:: ; 5
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if( not GetKeyState("Shift", "P") )
            SendInput {vkA9 Up}{Text}`%
        else
            SendInput {vkA9 Up}{Text}‰
    }    
return

vkA9 & sc007:: ; 6
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if( not GetKeyState("Shift", "P") )
            SendInput {vkA9 Up}{Text}^
        else
            SendInput {vkA9 Up}{Text}√
    }    
return

vkA9 & sc008:: ; 7
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if( not GetKeyState("Shift", "P") )
            SendInput {vkA9 Up}{Text}&
        else
            SendInput {vkA9 Up}{Text}∞
    }            
return

vkA9 & sc00C:: ; for - send em dash - or en dash - =ru= для - отправить длинное тире — или короткое тире – 
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if( not GetKeyState("Shift", "P") )
            SendInput {vkA9 Up}{Text}—
        else
            SendInput {vkA9 Up}{Text}–
    }
return

vkA9 & sc00D:: ; for = send ≠ or ± =ru= для = отправить ≠ или ± 
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if( not GetKeyState("Shift", "P") )
            SendInput {vkA9 Up}{Text}≠
        else
            SendInput {vkA9 Up}{Text}±
    }
return



vkA9 & sc02B:: ; for \ send | or division sign ÷ (technical range sign) =ru= для \ отправить | или знак деления ÷ (техн. знак диапазона)
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if( not GetKeyState("Shift", "P") )
            SendInput {vkA9 Up}{Text}|
        else
            SendInput {vkA9 Up}{Text}÷
    }
return

; brackets from English layouts on [, ] =ru= скобки из англ. раскладки на [, ]
vkA9 & sc01A:: 
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if( not GetKeyState("Shift", "P") )
            SendInput {vkA9 Up}{Text}[
        else
            SendInput {vkA9 Up}{Text}{
    }
return

vkA9 & sc01B::
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if( not GetKeyState("Shift", "P") )
            SendInput {vkA9 Up}{Text}]
        else
            SendInput {vkA9 Up}{Text}}
    }
return

; signs <> and Russian quotes =ru= знаки <> и русские кавычки
vkA9 & sc033:: 
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if( not GetKeyState("Shift", "P") )
            SendInput {vkA9 Up}{Text}<
        else
            SendInput {vkA9 Up}{Text}„
    }

return

vkA9 & sc034:: 
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if( not GetKeyState("Shift", "P") )
            SendInput {vkA9 Up}{Text}>
        else
            SendInput {vkA9 Up}{Text}“
    }

return

; apostrophe and quotation mark =ru= апостроф и кавычка англ.
vkA9 & sc028:: 
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if( not GetKeyState("Shift", "P") )
            SendInput {vkA9 Up}{Text}'
        else
            SendInput {vkA9 Up}{Text}"
    }
return

; ellipsis and middle dot on / =ru= многоточие и средняя точка на /
vkA9 & sc035:: 
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if( not GetKeyState("Shift", "P") )
            SendInput {vkA9 Up}{Text}…
        else
            SendInput {vkA9 Up}{Text}·
    }
return

; minus sign − on M and list marker • =ru= знак минус − на M и маркер списка •
vkA9 & sc032:: 
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if( not GetKeyState("Shift", "P") )
            SendInput {vkA9 Up}{Text}−
        else
            SendInput {vkA9 Up}{Text}•
    }
return


    
#if
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
#if ( (LS_RAltAddChars = 1) or (LS_RAltAddMouse = 1) ) and ( Trim(LS_RAltReassign) = "Disable" )

vkA9 & sc02D:: ; x
    GetKeyState, state, Tab, P
    if state = U
    {
        if (LS_RAltAddChars = 1)
        {
            SetKeyDelay -1
            if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
            {
                if( not GetKeyState("Shift", "P") )
                {
                    if( Trim(LS_RAlt_X) <> "Disable" )
                        SendInput {Text}%LS_RAlt_X%
                }
                else
                {
                    if( Trim(LS_RAlt_Shift_X) <> "Disable" )
                        SendInput {Text}%LS_RAlt_Shift_X%
                }
            } 
        }
    }
    else
    {        
        if (LS_RAltAddMouse = 1)
        {
            if MouseClDownL=1
                Click, Up
            MouseClDownL:=0 ; hold-click mode on the left mouse button =ru= режим удержания клика на левой кнопке мыши

            if MouseClDownR=1
            {
                Click, Up, Right
                MouseClDownR:=0 
                kbd_msg(kbd_msg_1)
                if( LS_PlaySound )
                {
                    SoundPlay, ""
                    SoundPlay, %A_ScriptDir%\sound\%LS_FileSoundMouseStuckOFF%
                }
            }
            else
            {
                Click, Down, Right
                MouseClDownR:=1                 
                kbd_msg(kbd_msg_3)
                if( LS_PlaySound )
                {
                    SoundPlay, ""
                    SoundPlay, %A_ScriptDir%\sound\%LS_FileSoundMouseStuckON%
                }
            }        
        }
        
    }
return



vkA9 & sc02E:: ; c
    GetKeyState, state, Tab, P
    if state = U
    {
        if (LS_RAltAddChars = 1)
        {
            SetKeyDelay -1
            if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
            {
                if( not GetKeyState("Shift", "P") )
                {
                    if( Trim(LS_RAlt_C) <> "Disable" )
                        SendInput {Text}%LS_RAlt_C%
                }
                else
                {
                    if( Trim(LS_RAlt_Shift_C) <> "Disable" )
                        SendInput {Text}%LS_RAlt_Shift_C%
                }
            } 
        }
    }
    else
    {
        if (LS_RAltAddMouse = 1)
        {            
            if MouseClDownR=1
                Click, Up, Right
            MouseClDownR:=0 ; hold-click mode on the right mouse button =ru= режим удержания клика на правой кнопке мыши

            if MouseClDownL=1
            {
                Click, Up
                MouseClDownL:=0
                kbd_msg(kbd_msg_1)
                if( LS_PlaySound )
                {
                    SoundPlay, ""
                    SoundPlay, %A_ScriptDir%\sound\%LS_FileSoundMouseStuckOFF%
                }
            }
            else
            {
                Click, Down
                MouseClDownL:=1
                kbd_msg(kbd_msg_2)
                if( LS_PlaySound )
                {
                    SoundPlay, ""
                    SoundPlay, %A_ScriptDir%\sound\%LS_FileSoundMouseStuckON%
                }
            }        
        }
    }
return


#if
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
#if (LS_RAltAddMouse = 1) and ( Trim(LS_RAltReassign) = "Disable" )

vkA9 & sc01F:: ; s
    ; SendInput {Blind}{vkA9 Up}
    Click, Middle
return


vkA9 & sc021:: ; f 
    ; SendInput {Blind}{vkA9 Up}
    if MouseClDownL=1 
        Click, Up
    if MouseClDownR=1
        Click, Up, Right
    if( (MouseClDownL=1) or (MouseClDownR=1) )
    {
        kbd_msg(kbd_msg_1)
        if( LS_PlaySound )
        {
            SoundPlay, ""
            SoundPlay, %A_ScriptDir%\sound\%LS_FileSoundMouseStuckOFF%
        }
    }

    MouseClDownL:=0 ; click operation mode on the left side of the mouse =ru= режим удержания клика на левой кнопке мыши
    MouseClDownR:=0 ; hold-click mode on the right mouse button =ru= режим удержания клика на правой кнопке мыши
    Click
return


vkA9 & sc020:: ; d
    ; SendInput {Blind}{vkA9 Up}
    if MouseClDownL=1 
        Click, Up
    if MouseClDownR=1
        Click, Up, Right
    if( (MouseClDownL=1) or (MouseClDownR=1) )
    {
        kbd_msg(kbd_msg_1)
        if( LS_PlaySound )
        {
            SoundPlay, ""
            SoundPlay, %A_ScriptDir%\sound\%LS_FileSoundMouseStuckOFF%
        }
    }
    
    MouseClDownL:=0 ; click operation mode on the left side of the mouse =ru= режим удержания клика на левой кнопке мыши
    MouseClDownR:=0 ; hold-click mode on the right mouse button =ru= режим удержания клика на правой кнопке мыши    
    Click, Right
return


vkA9 & sc013:: ; r
    ; SendInput {Blind}{vkA9 Up}
    if MouseClDownL=1 
        Click, Up
    if MouseClDownR=1
        Click, Up, Right
    if( (MouseClDownL=1) or (MouseClDownR=1) )
    {
        kbd_msg(kbd_msg_1)
        if( LS_PlaySound )
        {
            SoundPlay, ""
            SoundPlay, %A_ScriptDir%\sound\%LS_FileSoundMouseStuckOFF%
        }
    }
    
    MouseClDownL:=0 ; click operation mode on the left side of the mouse =ru= режим удержания клика на левой кнопке мыши
    MouseClDownR:=0 ; hold-click mode on the right mouse button =ru= режим удержания клика на правой кнопке мыши
    Click, 2
return


vkA9 & sc012:: ; e
    ; SendInput {Blind}{vkA9 Up}
    if MouseClDownL=1 
        Click, Up
    if MouseClDownR=1
        Click, Up, Right
    if( (MouseClDownL=1) or (MouseClDownR=1) )
    {
        kbd_msg(kbd_msg_1)
        if( LS_PlaySound )
        {
            SoundPlay, ""
            SoundPlay, %A_ScriptDir%\sound\%LS_FileSoundMouseStuckOFF%
        }
    }
    
    MouseClDownL:=0 ; click operation mode on the left side of the mouse =ru= режим удержания клика на левой кнопке мыши
    MouseClDownR:=0 ; hold-click mode on the right mouse button =ru= режим удержания клика на правой кнопке мыши
    Click, 2, Right
return

#if
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
#if (LS_RAltAddCursor = 1) and ( Trim(LS_RAltReassign) = "Disable" )

; PrintScreen, ScrollLock, Pause  (8,9,0)
vkA9 & sc009:: SendInput {Blind}{PrintScreen Down}{PrintScreen Up} ; SendInput {Blind}{vkA9 Up}{PrintScreen Down}{PrintScreen Up}
vkA9 & sc00A:: SendInput {Blind}{ScrollLock Down}{ScrollLock Up} ; SendInput {Blind}{vkA9 Up}{ScrollLock Down}{ScrollLock Up}
vkA9 & sc00B:: SendInput {Blind}{Pause Down}{Pause Up} ; SendInput {Blind}{vkA9 Up}{Pause Down}{Pause Up} 


vkA9 & sc014:: ; t ESC
    SendInput {Blind}{Escape Down}{Escape Up} ; {Blind}{vkA9 Up}{Escape Down}{Escape Up}    
return

vkA9 & sc022:: ; g ENTER
    SendInput {Blind}{Enter Down}{Enter Up} ; {Blind}{vkA9 Up}{Enter Down}{Enter Up}    
return

; Insert, Backspace, Delete (y,h,n)    
vkA9 & sc015:: SendInput {Blind}{Insert Down}{Insert Up} ; SendInput {Blind}{vkA9 Up}{Insert Down}{Insert Up}
vkA9 & sc023:: SendInput {Blind}{Backspace Down}{Backspace Up} ; SendInput {Blind}{vkA9 Up}{Backspace Down}{Backspace Up}}    
vkA9 & sc031:: SendInput {Blind}{Delete Down}{Delete Up} ; SendInput {Blind}{vkA9 Up}{Delete Down}{Delete Up}    


#if
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
#if ( (LS_RAltAddCursor = 1) or (LS_RAltAddMouse = 1) ) and ( Trim(LS_RAltReassign) = "Disable" )

; up =ru= вверх
vkA9 & sc017:: ; i
    GetKeyState, state, Tab, P
    if state = U
    {
        if( LS_RAltAddCursor = 1 )
            SendInput {Blind}{Up Down}{Up Up} ; {Blind}{vkA9 Up}{Up Down}{Up Up}
    }
    else
    {
        if (LS_RAltAddMouse = 1)
        {
            if (pmN=0) OR (pmN<>4)
            {    
                pmN:=4
                pmNOLD:=pmN
                vm:=vmBeg                
                SetTimer, TimerVAdd, %timePAdd%
                SetTimer, TimerMoveU, %timeUpdPer%
            }    
            ; SendInput {Blind}{vkA9 Up}        
            MouseMove, 0, -vm, plav, Relative    
        }
    }
return


; down =ru= вниз
vkA9 & sc025:: ; k
    GetKeyState, state, Tab, P
    if state = U
    {
        if( LS_RAltAddCursor = 1 )
            SendInput {Blind}{Down Down}{Down Up} ; {Blind}{vkA9 Up}{Down Down}{Down Up}
    }
    else
    {
        if (LS_RAltAddMouse = 1)
        {
            if (pmN=0) OR (pmN<>3)
            {    
                pmN:=3
                pmNOLD:=pmN    
                vm:=vmBeg                
                SetTimer, TimerVAdd, %timePAdd%
                SetTimer, TimerMoveU, %timeUpdPer%
            }    
            ; SendInput {Blind}{vkA9 Up}        
            MouseMove, 0, vm, plav, Relative    
        }
    }
return


; left =ru= влево
vkA9 & sc024:: ; j
    GetKeyState, state, Tab, P
    if state = U
    {
        if( LS_RAltAddCursor = 1 )
            SendInput {Blind}{Left Down}{Left Up} ; {Blind}{vkA9 Up}{Left Down}{Left Up}
    }
    else
    {
        if (LS_RAltAddMouse = 1)
        {
            if (pmN=0) OR (pmN<>2)
            {    
                pmN:=2
                pmNOLD:=pmN
                vm:=vmBeg                
                SetTimer, TimerVAdd, %timePAdd%
                SetTimer, TimerMoveU, %timeUpdPer%
            }    
            ; SendInput {Blind}{vkA9 Up}        
            MouseMove, -vm, 0, plav, Relative            
        }        
    }
return


; right =ru= вправо
vkA9 & sc026:: ; l
    GetKeyState, state, Tab, P
    if state = U
    {
        if( LS_RAltAddCursor = 1 )
            SendInput {Blind}{Right Down}{Right Up} ; {Blind}{vkA9 Up}{Right Down}{Right Up}
    }
    else
    {
        if (LS_RAltAddMouse = 1)
        {
            if (pmN=0) OR (pmN<>1)
            {    
                pmN:=1
                pmNOLD:=pmN
                vm:=vmBeg                
                SetTimer, TimerVAdd, %timePAdd%
                SetTimer, TimerMoveU, %timeUpdPer%
            }    
            ; SendInput {Blind}{vkA9 Up}        
            MouseMove, vm, 0, plav, Relative
        }        
    }        
return


; to the begining =ru= в начало
vkA9 & sc016:: ; u
    GetKeyState, state, Tab, P
    if state = U
    {
        if( LS_RAltAddCursor = 1 )
            SendInput {Blind}{Home Down}{Home Up} ; {Blind}{vkA9 Up}{Home Down}{Home Up}
    }
    else
    {
        if (LS_RAltAddMouse = 1)
        {
            SetTimer, TimerMoveU, off
            SetTimer, TimerVAdd, off    
            vm:=0
            pmN:=0
            if (pmNOLD=0)
            {            
                MouseMove, 40, 40, 0
            }    
            else if(pmNOLD=1)
            {
                CoordMode, Mouse, Screen 
                MouseGetPos, pzX, pzY, ,
                CoordMode, Mouse, Screen 
                MouseMove, 40, pzY, 0
            }
            else if(pmNOLD=2)
            {
                CoordMode, Mouse, Screen
                MouseGetPos, pzX, pzY, , 
                CoordMode, Mouse, Screen            
                MouseMove, A_ScreenWidth-40, pzY, 0
            }
            else if(pmNOLD=3)
            {
                CoordMode, Mouse, Screen
                MouseGetPos, pzX, pzY, , 
                CoordMode, Mouse, Screen
                MouseMove, pzX, 40, 0        
            }
            else
            {
                CoordMode, Mouse, Screen
                MouseGetPos, pzX, pzY, , 
                CoordMode, Mouse, Screen    
                MouseMove, pzX, A_ScreenHeight-40, 0    
            }    
        }
        
        ; SendInput {Blind}{vkA9 Up}
    }
return


; In the end =ru= в конец
vkA9 & sc018:: ; o
    GetKeyState, state, Tab, P
    if state = U
    {
        if( LS_RAltAddCursor = 1 )
            SendInput {Blind}{End Down}{End Up} ; {Blind}{vkA9 Up}{End Down}{End Up}
    }
    else
    {
        if (LS_RAltAddMouse = 1)
        {
            SetTimer, TimerMoveU, off
            SetTimer, TimerVAdd, off    
            vm:=0
            pmN:=0
            if (pmNOLD=0) 
            {            
                MouseMove, A_ScreenWidth-40, 40, 0
            }            
            else if(pmNOLD=1)
            {
                CoordMode, Mouse, Screen
                MouseGetPos, pzX, pzY, , 
                CoordMode, Mouse, Screen            
                MouseMove, A_ScreenWidth-40, pzY, 0            
            }
            else if(pmNOLD=2)
            {
                CoordMode, Mouse, Screen 
                MouseGetPos, pzX, pzY, ,
                CoordMode, Mouse, Screen 
                MouseMove, 40, pzY, 0            
            }
            else if(pmNOLD=3)
            {
                
                CoordMode, Mouse, Screen
                MouseGetPos, pzX, pzY, , 
                CoordMode, Mouse, Screen    
                MouseMove, pzX, A_ScreenHeight-40, 0                    
            }
            else
            {
                CoordMode, Mouse, Screen
                MouseGetPos, pzX, pzY, , 
                CoordMode, Mouse, Screen
                MouseMove, pzX, 40, 0                
            }
            
            ; SendInput {Blind}{vkA9 Up}
        }
        
    }
return


; page up or scroll up =ru= на страницу вверх или прокрутка вверх
vkA9 & sc019:: ; p
    GetKeyState, state, Tab, P
    if state = U
    {
        if( LS_RAltAddCursor = 1 )
            SendInput {Blind}{PgUp Down}{PgUp Up} ; {Blind}{vkA9 Up}{PgUp Down}{PgUp Up}
    }
    else
    {
        if (LS_RAltAddMouse = 1)
        {
            ; SendInput {Blind}{vkA9 Up}        
            Click, WheelUp
        }
    }
return


; page down or scroll down =ru= на страницу вниз или прокрутка вниз
vkA9 & sc027:: ;
    GetKeyState, state, Tab, P
    if state = U
    {
        if( LS_RAltAddCursor = 1 )
            SendInput {Blind}{PgDn Down}{PgDn Up} ; {Blind}{vkA9 Up}{PgDn Down}{PgDn Up}
    }
    else
    {
        if (LS_RAltAddMouse = 1)
        {
            ;SendInput {Blind}{vkA9 Up}
            Click, WheelDown
        }
    }
return




vkA9 & sc02F:: ; m context menu button =ru= кнопка контекстного меню
    if (LS_RAltAddMouse = 1)
    {
        if MouseClDownL=1 
            Click, Up
        if MouseClDownR=1
            Click, Up, Right
        if( (MouseClDownL=1) or (MouseClDownR=1) )
        {
            kbd_msg(kbd_msg_1)
            if( LS_PlaySound )
            {
                SoundPlay, ""
                SoundPlay, %A_ScriptDir%\sound\%LS_FileSoundMouseStuckOFF%
            }
        }
    }
    
    MouseClDownL:=0 ; click operation mode on the left side of the mouse =ru= режим удержания клика на левой кнопке мыши
    MouseClDownR:=0 ; hold-click mode on the right mouse button =ru= режим удержания клика на правой кнопке мыши
    
    if( LS_RAltAddCursor = 1 )
        SendInput {Blind}{vk5D Down}{vk5D Up} ; {Blind}{vkA9 Up}{vk5D Down}{vk5D Up}
return

#if
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−





; ==============================================================================