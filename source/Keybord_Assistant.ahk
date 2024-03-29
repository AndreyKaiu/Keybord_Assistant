; ==============================================================================
; KEYBORD ASSISTANT (M)
; ==============================================================================
; FileDescription: Keyboard layout switcher, Birman layout and more  =ru= Переключатель раскладки клавиатуры, раскладка Бирмана и другое 
; FileVersion: 2.0.5.0 2024-01-28 \\ (Major version).(Minor version).(Revision number).(Build number) (year)-(month)-(day)
; Author: kaiu@mail.ru \\ author of code changes 
; ProductName: Keybord_Assistant \\ included in the product
; OriginalFilename: Keybord_Assistant.ahk \\ What file is this code from
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
#MaxThreads 200 ; max. threads for everything =ru= максимальное кол. потоков для всего вообще
#SingleInstance ; running only one copy =ru= запуск только одной копии
SetWorkingDir %A_ScriptDir% ; working directory like a script, otherwise they change through a shortcut =ru= рабочий каталог как у скрипта, а то меняют через ярлык
SetBatchlines, -1 ; Determines the script execution speed (affects CPU usage) and by default 10ms, and now max. speed =ru= Определяет скорость выполнения скрипта (влияет на загрузку ЦП) и по умолчанию 10ms, а сейчас макс. скорость
Process, Priority, , High ; high priority for the script =ru= приоритет высокий для скрипта
#KeyHistory 3 ; Sets the maximum number of keyboard and mouse events displayed by the KeyHistory window
#NoEnv ; skip undefined variables =ru= не заданные переменные пропускать 
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
switch_Lang_lang := "" ; what language will we switch to =ru= на какой язык переключаться будем
old_n_layout_list := 0 ; previous number active list of layouts =ru= прошлый номер активного списка раскладок 
KeyPressTime := 0 ; 0,1,2 - key time measurement status =ru= статус измерения времени нажатия клавиши
KeyCapsLockPressTime := 0 ; 0,1,2 - key time measurement status (for CapsLock) =ru= статус измерения времени нажатия клавиши (для CapsLock)
CapsLockShiftOFF := 0 ; disabling CapsLock by Shift =ru= отключение CapsLock по Shift   
CapsLockStateOld := 0 ; CapsLock status before Down =ru= CapsLock статус перед Down
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
vmBeg:=2 ; mouse cursor initial speed =ru= скорость перемещения курсора мыши начальная
vm:=vmBeg ; mouse cursor speed =ru= скорость перемещения курсора мыши
pmN:=0 ; mouse cursor movement direction (1-right, 2-left, 3-down, 4-up) =ru= направление перемещения курсора мыши (1-вправо,2-влево,3-вниз,4-вверх)
pmNOLD:=0 ; the previous value of the variable (for fast transition to edges) =ru= предыдущее значение переменной (для быстрого перехода к краям)
plav:=0 ; smoothness of mouse cursor movement =ru= плавность перемещения курсора мыши
timePAdd:=150 ; increase period =ru= период увеличения
timeUpdPer:=30 ; move update =ru= обновление перемещения
MouseClDownL:=0 ; hold-click mode on the left mouse button =ru= режим удержания клика на левой кнопке мыши
MouseClDownR:=0 ; hold-click mode on the right mouse button =ru= режим удержания клика на правой кнопке мыши
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; messages in the system =ru= сообщения в системе
kbd_msg_1 := "Hold Disabled" ; "Удержание отключено"
kbd_msg_2 := "Hold left mouse button" ; "Удержание левой кн. мыши"
kbd_msg_3 := "Hold right mouse button" ; "Удержание правой кн. мыши"
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; Change the layout of already typed text (1-yes, 0-no)
; =ru= Смена раскладки уже набранного текста (1-да, 0-нет)
txtHook := ""
WinIDHOOL := 0
OLDWinIDHOOL := 0
StopHook := 0
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−

; add Firewall rules to block programs =ru= добавить правила Firewall для блокировки программ
delFRuleIN := A_ScriptName . "_Block_In"
delFRuleOUT := A_ScriptName . "_Block_Out"
delFRuleIN2 := "RAltRWin.exe_Block_In"
delFRuleOUT2 := "RAltRWin.exe_Block_Out"
deleteFirewallRule(delFRuleIN)
deleteFirewallRule(delFRuleOUT)
deleteFirewallRule(delFRuleIN2)
deleteFirewallRule(delFRuleOUT2)
Sleep 100
addFirewallRule(delFRuleIN, A_ScriptFullPath, "block", "in")
addFirewallRule(delFRuleOUT, A_ScriptFullPath, "block", "out")
addFirewallRule(delFRuleIN2, A_Scriptdir . "\RAltRWin.exe", "block", "in")
addFirewallRule(delFRuleOUT2, A_Scriptdir . "\RAltRWin.exe", "block", "out")


; reset possible stuck keys =ru= сброс возможных зависших клавиш 
SetKeyDelay -1	
SendInput {LCtrl Up}{RCtrl Up}{LWin Up}{RWin Up}{LAlt Up}{RAlt Up}{LShift Up}{RShift Up}{vkB6 Up}{vkA9 Up}{Tab Up}

; disabling CapsLock by Shift =ru= отключение CapsLock по Shift 
CapsLockShiftOFF := 0   
RegRead, OutputVar, HKEY_CURRENT_USER\Keyboard Layout, Attributes
if(ErrorLevel = 0)
{
    if( OutputVar = 65536 )
    {
        CapsLockShiftOFF := 1                    
    }
}



; list of keyboard layouts =ru= список клавиатурных раскладок
#Include KL_list_of_Keyboard_Layouts.ahk
KL_InitLNG() 


; close this script returning RAlt RWin if it is run =ru= закрыть данный скрипт возвращающий RAlt RWin если он будет запущен
Process, Exist, RAltRWin.exe
_pid = %ErrorLevel%
Process, Close, %_pid%


; loading settings from the settings.ini file =ru= загрузка настроек с файла settings.ini
#Include LS_Loading_Settings.ahk


if (LS_RAlt_BackSpace=1)
{   
    ih := InputHook( "L2048 MC", "{Enter}{Esc}{vk21}{vk22}{vk23}{vk24}{vk25}{vk26}{vk27}{vk28}")
    ih.VisibleNonText := 1
    ih.VisibleText := 1
    ih.NotifyNonText := 1
    ih.OnKeyDown := Func("F_Hook_OnKeyDown")
    ih.OnEnd := Func("F_Hook_OnEnd")
    ih.KeyOpt("{All}", "NV")
    StopHook := 0
    ih.Start() 
}




; allow Win+L to lock (but will be allowed with hot key LWin+L ) =ru= разрешить Win+L для блокировки ( но разрешено будет с помощью горячей клавиши LWin+L )
SetDisableLockWorkstationRegKeyValue( 1 ) 

; subroutine executed at the end of the script =ru= подпрограмма выполняемая при завершении скрипта
OnExit, OnExitSub




; menu loading =ru= загрузка меню
#Include MN_Menu.ahk
return


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; starting Powershell =ru= запуск Powershell
runPowershellCmd(cmd) 
{
    Run PowerShell.exe -Command & {%cmd%},, hide
}

; starting Powershell with wait =ru= запуск Powershell с ожиданием
runWaitPowershellCmd(cmd) 
{
    RunWait PowerShell.exe -Command & {%cmd%},, hide
}

; deleting a firewall rule =ru= удаление правила Firewall 
deleteFirewallRule(rulename)
{
    psScript := "netsh advfirewall firewall delete rule name=""" rulename """"
    runWaitPowershellCmd(psScript)
}

; add Firewall rule =ru= добавить правило Firewall 
addFirewallRule(rulename, programPath := "", action := "allow", direction := "out")
{
    ;  action =  allow or block
    ; direction = out or in  
    psScript := "netsh advfirewall firewall add rule name=""" rulename """ dir=" direction " action=" Action " program=""" programPath """ enable=yes"          	
    runPowershellCmd(psScript)
}



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
TimerKeyPressTime:
    KeyPressTime := 2
    SetTimer, TimerKeyPressTime, off
return

TimerKeyCapsLockPressTime:
    KeyCapsLockPressTime := 0
    SetTimer, TimerKeyCapsLockPressTime, off
return



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; test mode (1-yes, 0-no) (*F12 - show sticky keys, RWin+F1 = ListHotkeys)
; =ru= режим тестирования (1-да, 0-нет) (*F12 - показ залипших клавиш, RWin+F1 = ListHotkeys)
#if LS_TestMode=1 

vkB6 & F1::
    ListHotkeys
return

*F12::
    LCt_P := GetKeyState("LCtrl", "P")
    LCt := GetKeyState("LCtrl")
    RCt_P := GetKeyState("RCtrl", "P")
    RCt := GetKeyState("RCtrl")
    AllCt := LCt_P OR LCt OR RCt_P OR RCt   
        
    LSh_P := GetKeyState("LShift", "P")
    LSh := GetKeyState("LShift")
    RSh_P := GetKeyState("RShift", "P")
    RSh := GetKeyState("RShift")
    AllSh := LSh_P OR LSh OR RSh_P OR RSh 
    
    LAl_P := GetKeyState("LAlt", "P")
    LAl := GetKeyState("LAlt")
    RAl_P := GetKeyState("RAlt", "P")
    RAl := GetKeyState("RAlt")
    AllAl := LAl_P OR LAl OR RAl_P OR RAl 
    
    LW_P := GetKeyState("LWin", "P")
    LW := GetKeyState("LWin")
    RW_P := GetKeyState("RWin", "P")
    RW := GetKeyState("RWin")
    AllW := LW_P OR LW OR RW_P OR RW 
    
    vkA9_P := GetKeyState("vkA9", "P")
    vkA9 := GetKeyState("vkA9")
    vkB6_P := GetKeyState("vkB6", "P")
    vkB6 := GetKeyState("vkB6")
    AllA9B6 := vkA9_P OR vkA9 OR vkB6_P OR vkB6
    
    
    if( not(AllCt OR AllSh OR AllAl OR AllW OR AllA9B6) )
        MsgBox,, Status Ctrl; Alt..., ALL OK
    else
    {
        Str := "LCt_P=" LCt_P " LCt=" LCt " RCt_P=" RCt_P " RCt=" RCt " LSh_P=" LSh_P " LSh=" LSh " RSh_P=" RSh_P " RSh=" RSh "`nLAl_P=" LAl_P " LAl=" LAl " RAl_P=" RAl_P " RAl=" RAl " LW_P=" LW_P " LW=" LW " RW_P=" RW_P " RW=" RW "`nvkA9_P=" vkA9_P " vkA9=" vkA9 " vkB6_P=" vkB6_P " vkB6=" vkB6
        MsgBox, , Status Ctrl; Alt..., %Str%
    }
return
#if
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; (in any case, you can switch by pressing Alt + CapsLock)
; =ru= (в любом случае, вы можете переключить нажав Alt + CapsLock)
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
#if !((LS_RAltReassign = "Disable") and (Trim(LS_CapsLockReassign) = "LCtrl"))
; only not in the case when you need LCtrl =ru= только не в случае когда нужен LCtrl
vkA9 & CapsLock:: ; RAlt + CapsLock 
    if (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Alt", "P")) and (not GetKeyState("Shift", "P")) and (not GetKeyState("Tab", "P"))   
    {   
        switch_CapsLock() ; caps lock toggle =ru= переключение CapsLock         
    }
return
#if
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
#if (LS_CapsLockReassign <> "Tab") and (Trim(LS_CapsLockReassign) <> "")
LAlt & CapsLock::
    if (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("Shift", "P")) and (not GetKeyState("Tab", "P"))   
    {           
        switch_CapsLock() ; caps lock toggle =ru= переключение CapsLock 
    }
return
#if
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
#if (LS_RWinReassign = "RAlt") and ( (LS_CapsLockReassign <> "Tab") and (Trim(LS_CapsLockReassign) <> "") )
vkB6 & CapsLock:: ; RWin + CapsLock 
    if (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Alt", "P")) and (not GetKeyState("Shift", "P")) and (not GetKeyState("Tab", "P"))   
    {   
        switch_CapsLock() ; caps lock toggle =ru= переключение CapsLock
    }
return
#if
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−

/*
2022-11-29 kaiu@mail.ru
Hidden for the reason to allow third-party applications to work with RCtrl
=ru= Скрыто по причине дать возможность работать с RCtrl сторонним приложениям
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
#if (LS_RCtrlReassign = "RAlt") and ( (LS_CapsLockReassign <> "Tab") and (Trim(LS_CapsLockReassign) <> "") )
RCtrl & CapsLock::  
    if (not GetKeyState("Alt", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("Shift", "P")) and (not GetKeyState("Tab", "P"))   
    {   
        switch_CapsLock() ; caps lock toggle =ru= переключение CapsLock 
    }
return

#if
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
*/


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; caps lock toggle
; =ru= переключение CapsLock 
switch_CapsLock()
{
    global
        
    
    if( KeyCapsLockPressTime = 0 ) 
    {
        KeyCapsLockPressTime = 2
        SetTimer, TimerKeyCapsLockPressTime, %LS_TimeSwitchCapsLock%               
       
        stCL := GetKeyState("CapsLock", "T")
        
        
        if( (CapsLockShiftOFF = 1) and stCL )
        {
            SetKeyDelay -1
            SendInput {Blind}{LShift down}{LShift up}
            Sleep 10
            
            if( GetKeyState("CapsLock", "T") )
            {
                kbd_msg("CAPS LOCK ON")	
                if( LS_PlaySound )
                {
                    SoundPlay, ""	
                    SoundPlay, %A_ScriptDir%\sound\%LS_FileSoundCapsLockON%					
                }
            }
            else
            {
                kbd_msg("off caps lock")
                if( LS_PlaySound )
                {
                    SoundPlay, ""	
                    SoundPlay, %A_ScriptDir%\sound\%LS_FileSoundCapsLockOFF%					
                }
            }            
            
            return
        }
        
        
        
        if( !stCL )
        {
            SetCapsLockState, ON
            kbd_msg("CAPS LOCK ON")	
            if( LS_PlaySound )
            {
                SoundPlay, ""	
                SoundPlay, %A_ScriptDir%\sound\%LS_FileSoundCapsLockON%					
            }            
        }
        else
        {
            SetCapsLockState, OFF
            kbd_msg("off caps lock")
            if( LS_PlaySound )
            {
                SoundPlay, ""	
                SoundPlay, %A_ScriptDir%\sound\%LS_FileSoundCapsLockOFF%					
            }
        }
  
               
    }
    
    return
}






; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
*CapsLock:: ; necessarily without ~ =ru= обязательно без ~
    
    if( (CapsLockShiftOFF = 1) and !GetKeyState("CapsLock", "P") )
        return
        
    if  ( ( Trim(LS_CapsLockOption) = "AllLayouts") or ( (LS_CapsLockOption >= 1) and (LS_CapsLockOption <= 8) ) ) 
      and ( Trim(LS_CapsLockReassign) <> "Tab")  
      and ( (Trim(LS_CapsLockReassign) = "LCtrl") OR  (not GetKeyState("Ctrl", "P")) )
      and ( (Trim(LS_CapsLockReassign) = "LShift") OR  (not GetKeyState("Shift", "P")) )
      and (not GetKeyState("Alt", "P"))  and (not GetKeyState("Win", "P"))  and (not GetKeyState("Tab", "P"))          
    {
        if( KeyPressTime = 0 )
        {
            SetTimer, TimerKeyPressTime, %LS_TimeSwitchLayout%
            KeyPressTime := 1
        }
    }
    
    
    
   
    if( (CapsLockShiftOFF = 1) and GetKeyState("CapsLock", "T") and GetKeyState("Shift", "P") )
    {        
        SetKeyDelay -1            
        SendInput {Blind}{CapsLock up}{LShift down}{LShift up}      
    }
    else
    {    
        SetKeyDelay -1
        if ( Trim(LS_CapsLockReassign) = "")
        {
            if (not GetKeyState("Alt", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("Shift", "P")) and (not GetKeyState("Tab", "P"))   
            {   
                switch_CapsLock() ; caps lock toggle =ru= переключение CapsLock 
            }
        }
        
        if ( Trim(LS_CapsLockReassign) = "LCtrl")    
            SendInput {Blind}{CapsLock up}{LCtrl down}
        if ( Trim(LS_CapsLockReassign) = "LShift")
            SendInput {Blind}{CapsLock up}{LShift down}
        if ( Trim(LS_CapsLockReassign) = "Tab")
            SendInput {Blind}{CapsLock up}{Tab down}
    }



            
    
return


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
*~CapsLock Up::  
    
    if( (CapsLockShiftOFF = 1) and GetKeyState("CapsLock", "T") )
        return
    
    if  ( ( Trim(LS_CapsLockOption) = "AllLayouts") or ( (LS_CapsLockOption >= 1) and (LS_CapsLockOption <= 8) ) ) 
      and ( Trim(LS_CapsLockReassign) <> "Tab")  
      and ( (Trim(LS_CapsLockReassign) = "LCtrl") OR  (not GetKeyState("Ctrl", "P")) )
      and ( (Trim(LS_CapsLockReassign) = "LShift") OR  (not GetKeyState("Shift", "P")) )
      and (not GetKeyState("Alt", "P"))  and (not GetKeyState("Win", "P"))  and (not GetKeyState("Tab", "P"))          
    {
        if( KeyPressTime = 1 )
        {        
            if( A_PriorKey = "CapsLock" )
            {
                if( LS_CapsLockOption = "AllLayouts" )
                    switch_next_Lang() ; next language in order =ru= следующий язык по порядку
                else
                    switch_next_LangList( LS_CapsLockOption ) ; next language in order LAYOUT_LIST =ru= следующий язык по порядку LAYOUT_LIST
            }        
        }
    }
    
    
    
    if ( Trim(LS_CapsLockReassign) = "LCtrl")
    {
        SetKeyDelay -1	
        SendInput {Blind}{LCtrl Up}
    }
    
    if ( Trim(LS_CapsLockReassign) = "LShift")
    {
        SetKeyDelay -1	
        SendInput {Blind}{LShift Up}            
    }
    
    if ( Trim(LS_CapsLockReassign) = "Tab")
    {
        SetKeyDelay -1	
        SendInput {Blind}{Tab Up} 
    }
    
    SetTimer, TimerKeyPressTime, off
    KeyPressTime := 0    
return




/*
2023-01-28 kaiu@mail.ru
I open the previously closed one, and I make it easier to "disable CapsLock by Shift"
=ru= Открываю ранее закрытое, а "отключение CapsLock по Shift" делаю проще
*/
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; Toggle CapsLock by simultaneously pressing LShift + RShift (1-yes, 0-no)
; =ru= Переключать CapsLock одновременным нажатием LShift + RShift (1-да, 0-нет)
#if (LS_LShift_RShift_CapsLock = 1)
LShift & RShift::
RShift & LShift::
    if (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Alt", "P"))  and (not GetKeyState("Win", "P")) and (not GetKeyState("Tab", "P"))
    {
        if( CapsLockShiftOFF = 1 )
        {   
            if( !CapsLockStateOld )
            {
                switch_CapsLock() ; caps lock toggle =ru= переключение CapsLock 
            }
        }
        else
        {
            switch_CapsLock() ; caps lock toggle =ru= переключение CapsLock 		
        }
    }
return    
#if



/*
2023-01-28 kaiu@mail.ru
The code will only work when you need to switch the language or the system needs to "disable CapsLock by Shift"
=ru= Код будет работать только когда надо переключать язык или в системе надо "отключение CapsLock по Shift" 
*/
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
#if ( Trim(LS_LShiftOption) = "AllLayouts") or ( (LS_LShiftOption >= 1) and (LS_LShiftOption <= 8) ) or (CapsLockShiftOFF = 1)
~$LShift:: 
    if (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Alt", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
    {
        if( KeyPressTime = 0 )
        {
            SetTimer, TimerKeyPressTime, %LS_TimeSwitchLayout%
            KeyPressTime := 1
        }
    }
    
    CapsLockStateOld := GetKeyState("CapsLock", "T") 
    
    if( CapsLockShiftOFF = 1 )
    {   
        if( CapsLockStateOld )
        {
            SetKeyDelay -1
            ;SendInput {Blind}{LShift down}{LShift up}{LShift down}
            SendInput {Blind}{LShift down}{LShift up}
        }
    }
    
return    



~LShift Up::
    if (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Alt", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
    {
        if( KeyPressTime = 1 )
        {        
            if( A_PriorKey = "LShift" )
            {
                if( LS_LShiftOption = "AllLayouts" )
                    switch_next_Lang() ; next language in order =ru= следующий язык по порядку
                else
                    switch_next_LangList( LS_LShiftOption ) ; next language in order LAYOUT_LIST =ru= следующий язык по порядку LAYOUT_LIST
            }        
        }
        
        SetTimer, TimerKeyPressTime, off
        KeyPressTime := 0 
    }
    
    
    if( CapsLockShiftOFF = 1 )
    {   
        if( CapsLockStateOld )
        {
            kbd_msg("off caps lock")	
            if( LS_PlaySound )
            {
                SoundPlay, ""	
                SoundPlay, %A_ScriptDir%\sound\%LS_FileSoundCapsLockOFF%					
            }
        }   
    }

return
#if


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
#if ( Trim(LS_RShiftOption) = "AllLayouts") or ( (LS_RShiftOption >= 1) and (LS_RShiftOption <= 8) ) or (CapsLockShiftOFF = 1)
~$RShift:: 
    if (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Alt", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
    {
        if( KeyPressTime = 0 )
        {
            SetTimer, TimerKeyPressTime, %LS_TimeSwitchLayout%
            KeyPressTime := 1
        }
    }
    
    CapsLockStateOld := GetKeyState("CapsLock", "T") 
    
    if( CapsLockShiftOFF = 1 )
    {   
        if( CapsLockStateOld )
        {
            SetKeyDelay -1
            ;SendInput {Blind}{RShift down}{RShift up}{RShift down}
            SendInput {Blind}{RShift down}{RShift up}
        }
    }
    
return    

~RShift Up::
    if (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Alt", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
    {
        if( KeyPressTime = 1 )
        {        
            if( A_PriorKey = "RShift" )
            {
                if( LS_RShiftOption = "AllLayouts" )
                    switch_next_Lang() ; next language in order =ru= следующий язык по порядку
                else
                    switch_next_LangList( LS_RShiftOption ) ; next language in order LAYOUT_LIST =ru= следующий язык по порядку LAYOUT_LIST
            }        
        }
        
        SetTimer, TimerKeyPressTime, off
        KeyPressTime := 0 
    }
    
    
    if( CapsLockShiftOFF = 1 )
    {   
        if( CapsLockStateOld )
        {
            kbd_msg("off caps lock")	
            if( LS_PlaySound )
            {
                SoundPlay, ""	
                SoundPlay, %A_ScriptDir%\sound\%LS_FileSoundCapsLockOFF%					
            }
        }   
    }
    
return
#if
 



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
#if ( Trim(LS_LCtrlOption) = "Disable")
LCtrl::return
#if
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
/*
2023-01-28 kaiu@mail.ru
The code will only work when you need to switch the language
=ru= Код будет работать только когда надо переключать язык
*/
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
#if ( Trim(LS_LCtrlOption) <> "Disable") and ( Trim(LS_LCtrlOption) <> "")
~LCtrl::

    if (not GetKeyState("Alt", "P")) and (not GetKeyState("Shift", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
    {
        if( KeyPressTime = 0 )
        {
            SetTimer, TimerKeyPressTime, %LS_TimeSwitchLayout%
            KeyPressTime := 1
        }
    }

return


~LCtrl Up:: 

    if (not GetKeyState("Alt", "P")) and (not GetKeyState("Shift", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P"))
    {
        if( KeyPressTime = 1 )
        {        
            if( A_PriorKey = "LControl" )
            {
                if( LS_LCtrlOption = "AllLayouts" )
                    switch_next_Lang() ; next language in order =ru= следующий язык по порядку
                else
                    switch_next_LangList( LS_LCtrlOption ) ; next language in order LAYOUT_LIST =ru= следующий язык по порядку LAYOUT_LIST
            }        
        }    
    }
    
    SetTimer, TimerKeyPressTime, off
    KeyPressTime := 0

return
#if
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−




/*
2022-11-29 kaiu@mail.ru
Hidden for the reason to allow third-party applications to work with RCtrl
=ru= Скрыто по причине дать возможность работать с RCtrl сторонним приложениям

#if (Trim(LS_RCtrlOption) = "Disable") and (Trim(LS_RCtrlReassign) = "Disable") 
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
RCtrl::return
#if
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−


#if (Trim(LS_RCtrlOption) = "Disable") and (Trim(LS_RCtrlReassign) = "RAlt")
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
RCtrl::RAlt
#if
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−

#if (Trim(LS_RCtrlOption) = "Disable") and (Trim(LS_RCtrlReassign) = "RShift")
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
RCtrl::RShift
#if
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
*/


#if (Trim(LS_RCtrlOption) <> "Disable") or (Trim(LS_RCtrlReassign) <> "Disable") 
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
*~RCtrl:: ; 2022-11-29 kaiu@mail.ru required c ~ =ru= 2022-11-29 kaiu@mail.ru обязательно c ~ 
    
    
     if  ( ( Trim(LS_RCtrlOption) = "AllLayouts") or ( (LS_RCtrlOption >= 1) and (LS_RCtrlOption <= 8) ) ) 
      and ( (Trim(LS_RCtrlReassign) = "RAlt") OR  (not GetKeyState("Alt", "P")) )
      and ( (Trim(LS_RCtrlReassign) = "RShift") OR  (not GetKeyState("Shift", "P")) )
      and (not GetKeyState("CapsLock", "P"))  and (not GetKeyState("Win", "P"))  and (not GetKeyState("Tab", "P"))          
    {
        if( KeyPressTime = 0 )
        {
            SetTimer, TimerKeyPressTime, %LS_TimeSwitchLayout%
            KeyPressTime := 1
        }
    }
 
; 2022-11-29 kaiu@mail.ru SendEvent is applied below because SendInput gives 0.5 delay 
; =ru= 2022-11-29 kaiu@mail.ru тут ниже применен SendEvent так как SendInput дает 0.5 задержку 
 
    
    if ( Trim(LS_RCtrlReassign) = "")
    {
        SetKeyDelay -1	
        SendEvent {Blind}{RCtrl Down}
    }
    else 
    if ( Trim(LS_RCtrlReassign) = "Disable")
    {
        SetKeyDelay -1	
        SendEvent {Blind}{RCtrl Up}       
    }
    else
    if ( Trim(LS_RCtrlReassign) = "RAlt")
    {
        SetKeyDelay -1	
        SendEvent {Blind}{RCtrl Up}{RAlt Down}
    }
    else
    if ( Trim(LS_RCtrlReassign) = "RShift")
    {
        SetKeyDelay -1	
        SendEvent {Blind}{RCtrl Up}{RShift Down}
    }
            
return   


*~$RCtrl Up::    
    
    if ( Trim(LS_RCtrlReassign) = "")
    {
        SetKeyDelay -1	
        SendEvent {Blind}{RCtrl Up}
    }
    else 
    if ( Trim(LS_RCtrlReassign) = "RAlt")
    {
        SetKeyDelay -1	
        SendEvent {Blind}{RCtrl Up}{RAlt Up}
    }
    else
    if ( Trim(LS_RCtrlReassign) = "RShift")
    {
        SetKeyDelay -1	
        SendEvent {Blind}{RCtrl Up}{RShift Up}
    }
    

    
  
    if  ( ( Trim(LS_RCtrlOption) = "AllLayouts") or ( (LS_RCtrlOption >= 1) and (LS_RCtrlOption <= 8) ) ) 
      and ( (Trim(LS_RCtrlReassign) = "RAlt") OR  (not GetKeyState("Alt", "P")) )
      and ( (Trim(LS_RCtrlReassign) = "RShift") OR  (not GetKeyState("Shift", "P")) )
      and (not GetKeyState("CapsLock", "P"))  and (not GetKeyState("Win", "P"))  and (not GetKeyState("Tab", "P"))          
    {
        if( KeyPressTime = 1 )
        {        
            if( A_PriorKey = "RControl" )
            {
                if( LS_RCtrlOption = "AllLayouts" )
                    switch_next_Lang() ; next language in order =ru= следующий язык по порядку
                else
                    switch_next_LangList( LS_RCtrlOption ) ; next language in order LAYOUT_LIST =ru= следующий язык по порядку LAYOUT_LIST             
/*  
2022-11-29 kaiu@mail.ru
Не выявлена необходимость этого кода при использовании SendEvent 
=ru= No need for this code when using SendEvent
                  
                ; again to not activate the menu =ru= повторно, чтобы не активировало меню
                if ( Trim(LS_RCtrlReassign) = "RAlt")
                {
                    SetKeyDelay -1	
                    SendInput {Blind}{RAlt Up}{RAlt Down}{RAlt Up}
                }
*/    
            }        
        }    
    }       
    
    SetTimer, TimerKeyPressTime, off
    KeyPressTime := 0

return
#if
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−






; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
#if ( Trim(LS_LAltSpaceOption) = "AllLayouts" )
LAlt & sc039:: ; Space
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Shift", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
	{
        switch_next_Lang() ; next language in order =ru= следующий язык по порядку
    }
return
#if

#if ( (LS_LAltSpaceOption >= 1) and (LS_LAltSpaceOption <= 8) )
LAlt & sc039:: ; Space
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Shift", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
	{
        switch_next_LangList( LS_LAltSpaceOption ) ; next language in order LAYOUT_LIST =ru= следующий язык по порядку LAYOUT_LIST
    }
return
#if
    



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
#if ( (LS_LAlt13_Enable = 1) and (Trim(LS_LAlt0) <> "Disable") )
LAlt & sc029:: ; `
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Shift", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        SendInput {Text}%LS_LAlt0%
    }
    return
#if

#if ( (LS_LAlt13_Enable = 1) and (Trim(LS_LAlt1) <> "Disable") )
LAlt & sc002:: ; 1
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Shift", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        SendInput {Text}%LS_LAlt1%
    }
    return
#if

#if ( (LS_LAlt13_Enable = 1) and (Trim(LS_LAlt2) <> "Disable") )
LAlt & sc003:: ; 2
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Shift", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        SendInput {Text}%LS_LAlt2%
    }
    return
#if

#if ( (LS_LAlt13_Enable = 1) and (Trim(LS_LAlt3) <> "Disable") )
LAlt & sc004:: ; 3
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Shift", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        SendInput {Text}%LS_LAlt3%
    }
    return
#if

#if ( (LS_LAlt13_Enable = 1) and (Trim(LS_LAlt4) <> "Disable") )
LAlt & sc005:: ; 4
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Shift", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        SendInput {Text}%LS_LAlt4%
    }
    return
#if

#if ( (LS_LAlt13_Enable = 1) and (Trim(LS_LAlt5) <> "Disable") )
LAlt & sc006:: ; 5
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Shift", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        SendInput {Text}%LS_LAlt5%
    }
    return
#if

#if ( (LS_LAlt13_Enable = 1) and (Trim(LS_LAlt6) <> "Disable") )
LAlt & sc007:: ; 6
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Shift", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        SendInput {Text}%LS_LAlt6%
    }
    return
#if


#if ( (LS_LAlt13_Enable = 1) and (Trim(LS_LAlt7) <> "Disable") )
LAlt & sc008:: ; 7
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Shift", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        SendInput {Text}%LS_LAlt7%
    }
    return
#if

#if ( (LS_LAlt13_Enable = 1) and (Trim(LS_LAlt8) <> "Disable") )
LAlt & sc009:: ; 8
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Shift", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        SendInput {Text}%LS_LAlt8%
    }
    return
#if

#if ( (LS_LAlt13_Enable = 1) and (Trim(LS_LAlt9) <> "Disable") )
LAlt & sc00A:: ; 9
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Shift", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        SendInput {Text}%LS_LAlt9%
    }
    return
#if

#if ( (LS_LAlt13_Enable = 1) and (Trim(LS_LAlt10) <> "Disable") )
LAlt & sc00B:: ; 0
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Shift", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        SendInput {Text}%LS_LAlt10%
    }
    return
#if

#if ( (LS_LAlt13_Enable = 1) and (Trim(LS_LAlt11) <> "Disable") )
LAlt & sc00C:: ; -
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Shift", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        SendInput {Text}%LS_LAlt11%
    }
    return
#if

#if ( (LS_LAlt13_Enable = 1) and (Trim(LS_LAlt12) <> "Disable") )
LAlt & sc00D:: ; =
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Shift", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        SendInput {Text}%LS_LAlt12%
    }
    return
#if

#if ( (LS_LAlt13_Enable = 1) and (Trim(LS_LAlt13) <> "Disable") )
LAlt & sc02B:: ; \
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Shift", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        SendInput {Text}%LS_LAlt13%
    }
    return
#if




/*
2023-01-28 kaiu@mail.ru
; the ability to assign the user some more keys
; 14 more hot combinations for LAlt+[  LAlt+]  LAlt+;  LAlt+'  LAlt+,  LAlt+.  LAlt+/
; =ru= the ability to assign the user some more keys
; =ru= еще 14 горячих комбинации для LAlt+[  LAlt+]  LAlt+;  LAlt+'  LAlt+,  LAlt+.  LAlt+/
*/
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−− 
; LAltAdd14
#if ( (LS_LAltAdd14_Enable = 1) and ( (Trim(LS_LAltAdd0) <> "Disable") or (Trim(LS_LAltAdd00) <> "Disable") ) )
LAlt & sc01A:: ; [
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if ( GetKeyState("Shift", "P") )
        {        
            SendInput {Text}%LS_LAltAdd00%
        }
        else
        {
            SendInput {Text}%LS_LAltAdd0%
        }
    }
    return
#if


#if ( (LS_LAltAdd14_Enable = 1) and ( (Trim(LS_LAltAdd1) <> "Disable") or (Trim(LS_LAltAdd11) <> "Disable") ) )
LAlt & sc01B:: ; ]
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if ( GetKeyState("Shift", "P") )
        {        
            SendInput {Text}%LS_LAltAdd11%
        }
        else
        {
            SendInput {Text}%LS_LAltAdd1%
        }
    }
    return
#if


#if ( (LS_LAltAdd14_Enable = 1) and ( (Trim(LS_LAltAdd2) <> "Disable") or (Trim(LS_LAltAdd22) <> "Disable") ) )
LAlt & sc027:: ; ;
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if ( GetKeyState("Shift", "P") )
        {        
            SendInput {Text}%LS_LAltAdd22%
        }
        else
        {
            SendInput {Text}%LS_LAltAdd2%
        }
    }
    return
#if


#if ( (LS_LAltAdd14_Enable = 1) and ( (Trim(LS_LAltAdd3) <> "Disable") or (Trim(LS_LAltAdd33) <> "Disable") ) )
LAlt & sc028:: ; '
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if ( GetKeyState("Shift", "P") )
        {        
            SendInput {Text}%LS_LAltAdd33%
        }
        else
        {
            SendInput {Text}%LS_LAltAdd3%
        }
    }
    return
#if


#if ( (LS_LAltAdd14_Enable = 1) and ( (Trim(LS_LAltAdd4) <> "Disable") or (Trim(LS_LAltAdd44) <> "Disable") ) )
LAlt & sc033:: ; ,
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if ( GetKeyState("Shift", "P") )
        {        
            SendInput {Text}%LS_LAltAdd44%
        }
        else
        {
            SendInput {Text}%LS_LAltAdd4%
        }
    }
    return
#if


#if ( (LS_LAltAdd14_Enable = 1) and ( (Trim(LS_LAltAdd5) <> "Disable") or (Trim(LS_LAltAdd55) <> "Disable") ) )
LAlt & sc034:: ; .
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if ( GetKeyState("Shift", "P") )
        {        
            SendInput {Text}%LS_LAltAdd55%
        }
        else
        {
            SendInput {Text}%LS_LAltAdd5%
        }
    }
    return
#if


#if ( (LS_LAltAdd14_Enable = 1) and ( (Trim(LS_LAltAdd6) <> "Disable") or (Trim(LS_LAltAdd66) <> "Disable") ) )
LAlt & sc035:: ; / 
    SetKeyDelay -1
    if ( (not GetKeyState("Ctrl", "P")) and (not GetKeyState("Win", "P")) and (not GetKeyState("CapsLock", "P")) and (not GetKeyState("Tab", "P")) )
    {
        if ( GetKeyState("Shift", "P") )
        {        
            SendInput {Text}%LS_LAltAdd66%
        }
        else
        {
            SendInput {Text}%LS_LAltAdd6%
        }
    }
    return
#if



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−− 

; RAlt add =ru= RAlt добавление
#Include RA_RAltAdd.ahk



; RWin add =ru= RWin добавление
#Include RW_RWinAdd.ahk


; Other add =ru= Прочее добавление
#Include OA_OtherAdd.ahk






; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; subroutine executed at the end of the script
; =ru= подпрограмма выполняемая при завершении скрипта
OnExitSub:	
    ; allow Win+L to lock (but will be allowed with hot key LWin+L ) =ru= разрешить Win+L для блокировки ( но разрешено будет с помощью горячей клавиши LWin+L )
    SetDisableLockWorkstationRegKeyValue( 1 ) 

    ; close this script returning RAlt RWin if it is run =ru= закрыть данный скрипт возвращающий RAlt RWin если он будет запущен
    Process, Exist, RAltRWin.exe
    _pid = %ErrorLevel%
    Process, Close, %_pid%
    
    ; reset possible stuck keys =ru= сброс возможных зависших клавиш 
    SetKeyDelay -1
    SendInput {LCtrl Up}{RCtrl Up}{LWin Up}{RWin Up}{LAlt Up}{RAlt Up}{LShift Up}{RShift Up}{vkB6 Up}{vkA9 Up}{Tab Up}
    
    
    ExitApp
return

; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; allow Win+L to lock (but will be allowed with hot key LWin+L )
; =ru= разрешить Win+L для блокировки ( но разрешено будет с помощью горячей клавиши LWin+L )
SetDisableLockWorkstationRegKeyValue( value )
{
    RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation, %value%
}

; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; blocking the computer (it is necessary that there are no problems with LWin + RAlt + L, which led to LAlt hanging after blocking)
; =ru= блокировка компьютера (нужно чтобы не было проблем с LWin+RAlt+L что приводило к зависанию LAlt после блокировки)
LWin & sc026:: ; L
    if Not A_IsPaused
    {
        ; allow Win+L to lock (but will be allowed with hot key LWin+L ) =ru= разрешить Win+L для блокировки ( но разрешено будет с помощью горячей клавиши LWin+L )
        SetDisableLockWorkstationRegKeyValue( 0 )
        DllCall("LockWorkStation")
        Suspend Toggle
        Pause Toggle
    }
    else
    {
        ; allow Win+L to lock (but will be allowed with hot key LWin+L ) =ru= разрешить Win+L для блокировки ( но разрешено будет с помощью горячей клавиши LWin+L )
        SetDisableLockWorkstationRegKeyValue( 0 ) 
        Sleep 200
        DllCall("LockWorkStation")
    }
return




; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; next language in order LAYOUT_LIST 
; =ru= следующий язык по порядку LAYOUT_LIST
switch_next_LangList( n_layout_list )
{
    global
    SetFormat, Integer, D
    if(n_layout_list >= 1 and n_layout_list <= 8)
    {  
        Switch n_layout_list
        {
        case 1:
            LS_ListLX := LS_ListL1
            LS_ListLX_Count := LS_ListL1_Count
            LS_ListLX_N := LS_ListL1_N
        case 2:
            LS_ListLX := LS_ListL2
            LS_ListLX_Count := LS_ListL2_Count
            LS_ListLX_N := LS_ListL2_N
        case 3:
            LS_ListLX := LS_ListL3
            LS_ListLX_Count := LS_ListL3_Count
            LS_ListLX_N := LS_ListL3_N
        case 4:
            LS_ListLX := LS_ListL4
            LS_ListLX_Count := LS_ListL4_Count
            LS_ListLX_N := LS_ListL4_N
        case 5:
            LS_ListLX := LS_ListL5
            LS_ListLX_Count := LS_ListL5_Count
            LS_ListLX_N := LS_ListL5_N
        case 6:
            LS_ListLX := LS_ListL6
            LS_ListLX_Count := LS_ListL6_Count
            LS_ListLX_N := LS_ListL6_N
        case 7:
            LS_ListLX := LS_ListL7
            LS_ListLX_Count := LS_ListL7_Count
            LS_ListLX_N := LS_ListL7_N
        case 8:
            LS_ListLX := LS_ListL8    
            LS_ListLX_Count := LS_ListL8_Count
            LS_ListLX_N := LS_ListL8_N
        }    
                
        
        curlng := check_lang() ; checking which language is current =ru= проверка какой язык текущий
        LS_ListLX_N2 := 0
        Loop, %LS_ListLX_Count% 
        {
            M_LNG := LS_ListLX[ A_Index ]
            ret := ""
            ret := KL_ARLG1%M_LNG% 
            if (ret="") or (ret=)
                ret := KL_ARLG2%M_LNG% 
            M_LNG := ret
            
            if(curlng = M_LNG)
            {
                LS_ListLX_N2 := A_Index
                Break
            }
        }   
        
        if( (LS_ListLX_N2 = LS_ListLX_N) and (n_layout_list = old_n_layout_list) )
        {
            LS_ListLX_N := LS_ListLX_N + 1
            if(LS_ListLX_N > LS_ListLX_Count)
                LS_ListLX_N := 1
        }
        
        if(LS_ListLX_N < 1 OR LS_ListLX_N > LS_ListLX_Count)
            LS_ListLX_N := 1
        
        
        
        Switch n_layout_list
        {
        case 1:
            LS_ListL1_N := LS_ListLX_N
        case 2:
            LS_ListL2_N := LS_ListLX_N
        case 3:
            LS_ListL3_N := LS_ListLX_N
        case 4:
            LS_ListL4_N := LS_ListLX_N
        case 5:
            LS_ListL5_N := LS_ListLX_N
        case 6:
            LS_ListL6_N := LS_ListLX_N
        case 7:
            LS_ListL7_N := LS_ListLX_N
        case 8:
            LS_ListL8_N := LS_ListLX_N
        } 
        
     
        M_LNG := LS_ListLX[ LS_ListLX_N ]    
        ; take from variable =ru= берем из переменной
        ret := ""
        ret := KL_ARLG1%M_LNG% 
        if (ret="") or (ret=)
            ret := KL_ARLG2%M_LNG% 
        M_LNG := ret    
        
        switch_Lang(M_LNG) ; language switching =ru= переключение языка
            
        old_n_layout_list := n_layout_list ; previous number active list of layouts =ru= прошлый номер активного списка раскладок     
    }
    SetFormat, Integer, H
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; next language in order
; следующий язык по порядку	
switch_next_Lang()
{
    old_n_layout_list := 0 ; previous number active list of layouts =ru= прошлый номер активного списка раскладок
    
    ControlGetFocus, control, A	
    SendMessage 0x50, 2,, %control%, A                
    Sleep 20
    
    curlng := check_lang() ; checking which language is current =ru= проверка какой язык текущий
    
    kbd_msg(curlng)
    
    global LS_PlaySound    
    if( LS_PlaySound  ) ; if you need to say =ru= если надо озвучить
    {
        ; we take the voice acting from the file =ru= озвучку берем из файла        
        fileSnd := KL_ARSOUND%curlng%
        SoundPlay, ""    
        SoundPlay, %A_ScriptDir%\sound\%fileSnd%
    }    
    
    return
}

                
                
                

; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; language switching
; =ru= переключение языка
switch_Lang(lang)
{	 
    global
    switch_Lang_lang := lang
    
    SetTimer, TimerSwitch_Lang, off
    SetTimer, TimerSwitch_Lang, 50 ; no more than 50 ms =ru= не чаще 50 мс

    return    
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; what language will we switch to
; =ru= на какой язык переключаться будем
TimerSwitch_Lang:
    Critical
    
    lang := switch_Lang_lang 
    WinGet, WinID,, A
    WinGet , WinProcessName, ProcessName, A
    
    
    ; get HKL by language =ru= получим HKL по языку   
    Lhkl := KL_ARHKL%lang%   
    
    sendswitchLang := 0
    if Lhkl <> "" 
    {
        LhklInt := (Lhkl << 32) >> 32 ; here it wants in 64 bit form =ru= тут оно хочет в 64 битном виде        

        ControlGetFocus, control, A            
        PostMessage 0x50, 2, %LhklInt%, %control%, A   
        sendswitchLang := 1
    }
    
    if(sendswitchLang = 1)
        kbd_msg(lang)

    
    Critical OFF ; disable critical section =ru= отключение критической секции
    Sleep -1 ; Critical definitely worked =ru= Critical точно отработал    
    

    global LS_PlaySound    
    if( LS_PlaySound and (sendswitchLang = 1) ) ; if you need to say =ru= если надо озвучить
    {
        ; we take the voice acting from the file =ru= озвучку берем из файла        
        fileSnd := KL_ARSOUND%lang%
        SoundPlay, ""    
        SoundPlay, %A_ScriptDir%\sound\%fileSnd%
    }
    
    SetTimer, TimerSwitch_Lang, off
return





; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; checking which language is current
; =ru= проверка какой язык текущий
check_lang()
{
    SetFormat, Integer, H
    WinGet, WinID,, A    
    return check_lang_by_window_id( WinID ) 
}

; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; return current language of 2 characters (or more if layouts are different)
; =ru= возврат текущего языка из 2 символов (или более если раскладки другие)
check_lang_by_window_id(hWnd)
{    
    if !hWnd
        return
        
    WinGetClass, winClass, A
    if (winClass != "ConsoleWindowClass") || (b := SubStr(A_OSVersion, 1, 2) = "10")
    {
        if b
        {
            WinGet, consolePID, PID
            childConhostPID := GetCmdChildConhostPID(consolePID)
            dhw_prev := A_DetectHiddenWindows
            DetectHiddenWindows, On
            hWnd := WinExist("ahk_pid " . childConhostPID)
            DetectHiddenWindows, % dhw_prev
        }
        threadId := DllCall("GetWindowThreadProcessId", Ptr, hWnd, UInt, 0)
        lyt := DllCall("GetKeyboardLayout", Ptr, threadId, UInt)        
        langID := Format("{:#x}", lyt)
    }
    else ; console window in win7 =ru= окно консольное в вин7
    {            
        WinGet, dwProcessId, PID, A 
        bResult := DllCall("AttachConsole", "uint", dwProcessId, "int")
        if(!bResult)
        {        
            langID := "" 
        }
        else
        {
            VarSetCapacity(lyt, 16)
            DllCall("GetConsoleKeyboardLayoutName", Str, lyt)
            DllCall("FreeConsole")    
            langID := "0x" . lyt
        }
    }


    langID := "" KL_FormatHEX8(langID)    
    ; take from variable =ru= берем из переменной
    ret := ""
    ret := KL_ARLG1%langID% 
    if (ret="") or (ret=)
        ret := KL_ARLG2%langID% 
        
    return ret   
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
GetCmdChildConhostPID(CmdPID)
{
   static TH32CS_SNAPPROCESS := 0x2, MAX_PATH := 260
   
   h := DllCall("CreateToolhelp32Snapshot", UInt, TH32CS_SNAPPROCESS, UInt, 0, Ptr)
   VarSetCapacity(PROCESSENTRY32, size := 4*7 + A_PtrSize*2 + (MAX_PATH << !!A_IsUnicode), 0)
   NumPut(size, PROCESSENTRY32, "UInt")
   res := DllCall("Process32First", Ptr, h, Ptr, &PROCESSENTRY32)
   while res  {
      parentPid := NumGet(PROCESSENTRY32, 4*4 + A_PtrSize*2, "UInt")
      if (parentPid = CmdPID)  {
         exeName := StrGet(&PROCESSENTRY32 + 4*7 + A_PtrSize*2, "CP0")
         if (exeName = "conhost.exe" && PID := NumGet(PROCESSENTRY32, 4*2, "UInt"))
            break
      }
      res := DllCall("Process32Next", Ptr, h, Ptr, &PROCESSENTRY32)
   }
   DllCall("CloseHandle", Ptr, h)
   Return PID
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; display layout message
; показ сообщения о раскладке
kbd_msg(text)
{
    global LS_ShowToolTip
    if( not LS_ShowToolTip ) 
    {
        return
    }
    
    ToolTip, %text%, A_CaretX + 10, A_CaretY - 20    
    SetTimer, KbdRemoveToolTip, -1000
    return
    
    KbdRemoveToolTip:
    ToolTip, "" , 0, 0    
    ToolTip    
    return
}


; ==============================================================================