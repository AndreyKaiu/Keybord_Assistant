; ==============================================================================
; MENU (MN) =ru= МЕНЮ (MN)
; ==============================================================================
; FileDescription: menu =ru= меню
; FileVersion: 2.0.5.0 2024-01-28 \\ (Major version).(Minor version).(Revision number).(Build number) (year)-(month)-(day)
; Author: kaiu@mail.ru \\ author of code changes 
; ProductName: Keybord_Assistant \\ included in the product
; OriginalFilename: MN_Menu.ahk \\ What file is this code from
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−


MN_FileLocalization := LS_FileLocalization
MN_Tip := "Keyboard layout switcher, Birman layout and more. Version: 2.0.5; Website: kaiu.narod.ru; Avtor: Krutov A"

Menu, MN_LVSubmenu, Add, quiet, MN_SLV1
Menu, MN_LVSubmenu, Add, medium, MN_SLV2
Menu, MN_LVSubmenu, Add, loudly, MN_SLV3

Menu, MN_LVSubmenu, Uncheck, quiet
Menu, MN_LVSubmenu, Uncheck, medium
Menu, MN_LVSubmenu, Uncheck, loudly
if( LS_SoundLevelAtStartup = 1 )
{
    Menu, MN_LVSubmenu, Check, quiet
    SoundSet, 30
}
if( LS_SoundLevelAtStartup = 2 )
{   
    Menu, MN_LVSubmenu, Check, medium
    SoundSet, 50
}
if( LS_SoundLevelAtStartup = 3 )
{
    Menu, MN_LVSubmenu, Check, loudly
    SoundSet, 70
}
    

Loop, %A_WorkingDir%\localization\*.ini
{
    fileN := A_LoopFileName
    fileN := SubStr(fileN, 1, StrLen(fileN)-4)
    Menu, MN_LgSubmenu, Add, %fileN%, MN_LGLOAD
    if( A_LoopFileName = MN_FileLocalization )
        Menu, MN_LgSubmenu, Check, %fileN%
}


Loop, %A_WorkingDir%\translit_1\*.ini
{
    fileN := A_LoopFileName
    fileN := SubStr(fileN, 1, StrLen(fileN)-4)
    Menu, MN_Tr1Submenu, Add, %fileN%, MN_TRANSL1
    if( A_LoopFileName = LS_FileTranslit_1 )
        Menu, MN_Tr1Submenu, Check, %fileN%
}

Loop, %A_WorkingDir%\translit_2\*.ini
{
    fileN := A_LoopFileName
    fileN := SubStr(fileN, 1, StrLen(fileN)-4)
    Menu, MN_Tr2Submenu, Add, %fileN%, MN_TRANSL2
    if( A_LoopFileName = LS_FileTranslit_2 )
        Menu, MN_Tr2Submenu, Check, %fileN%
}



Menu, tray, icon, KeybAs.ico ; script icon =ru= иконка скрипта
Menu, tray, NoStandard
Menu, tray, Add, Exit, MN_Exit
Menu, tray, Add	
Menu, tray, Add, Reload, MN_Reload
Menu, tray, Add	
if ( LS_Alt_ScrollLock = 1 )
    Menu, tray, Add, Translit_1  [Alt + Scroll Lock], :MN_Tr1Submenu
else    
    Menu, tray, Add, Translit_1, :MN_Tr1Submenu
    
if ( LS_Alt_Shift_ScrollLock = 1 )    
    Menu, tray, Add, Translit_2  [Alt + Shift + Scroll Lock], :MN_Tr2Submenu
else
    Menu, tray, Add, Translit_2, :MN_Tr2Submenu

Menu, tray, Add	

Menu, tray, Add, Show tooltip, MN_Show_tooltip
if( LS_ShowToolTip = 1) 
{
    Menu, tray, Check, Show tooltip
}
Else
{
    Menu, tray, Uncheck, Show tooltip
}

Menu, tray, Add, Sound for switching layouts, MN_Sound_for_switching_layouts
if( LS_PlaySound = 1) 
    Menu, tray, Check, Sound for switching layouts
Else
    Menu, tray, Uncheck, Sound for switching layouts    

Menu, tray, Add, Sound level at startup, :MN_LVSubmenu
Menu, tray, Add	
Menu, tray, Add, Language, :MN_LgSubmenu
Menu, tray, Add, Hotkeys..., MN_Hotkeys
Menu, tray, Add, Help file... [RAlt + F1], MN_HelpFile
Menu, tray, Add
MN_L15 := "Startup with operating system"
Menu, tray, Add, %MN_L15%, MN_RunWithOS 

RegRead, OutputVar, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run, Keybord_Assistant
if ErrorLevel
{
    Menu, tray, UnCheck, %MN_L15%
}
else
{
    Menu, tray, Check, %MN_L15%
}

MN_L11 := "Settings: " LS_SETTINGSINI 
Menu, tray, Add, %MN_L11%, MN_Settings
Menu, tray, Add
Menu, tray, Add, Stop\Start, MN_Stop_Start
Menu, tray, Tip, %MN_Tip%

MN_Load_INI( MN_FileLocalization )

return

; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
MN_SLV1:
    LS_SoundLevelAtStartup := 1
    Gosub MN_SLV1_3
return

MN_SLV1_3:
    IniWrite, %LS_SoundLevelAtStartup%, %LS_SETTINGSINI%, MAIN, SoundLevelAtStartup
    Menu, MN_LVSubmenu, Uncheck, %MN_L1%
    Menu, MN_LVSubmenu, Uncheck, %MN_L2%
    Menu, MN_LVSubmenu, Uncheck, %MN_L3%
    if( LS_SoundLevelAtStartup = 1 )
    {
        Menu, MN_LVSubmenu, Check, %MN_L1%
        SoundSet, 30
    }
    if( LS_SoundLevelAtStartup = 2 )
    {
        Menu, MN_LVSubmenu, Check, %MN_L2%
        SoundSet, 50
    }
    if( LS_SoundLevelAtStartup = 3 )
    {
        Menu, MN_LVSubmenu, Check, %MN_L3%
        SoundSet, 70
    }
return

; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
MN_SLV2:
    LS_SoundLevelAtStartup := 2
    Gosub MN_SLV1_3
return

; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
MN_SLV3:
    LS_SoundLevelAtStartup := 3    
    Gosub MN_SLV1_3
return



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
MN_LGLOAD:
    LS_FileLocalization := A_ThisMenuItem ".ini"
    IniWrite, %LS_FileLocalization%, %LS_SETTINGSINI%, MAIN, FileLocalization
    Reload
return


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
MN_TRANSL1:
    LS_FileTranslit_1 := A_ThisMenuItem ".ini"
    IniWrite, %LS_FileTranslit_1%, %LS_SETTINGSINI%, ADDITIONALLY, FileTranslit_1
    
    Loop, %A_WorkingDir%\translit_1\*.ini
    {
        fileN := A_LoopFileName
        fileN := SubStr(fileN, 1, StrLen(fileN)-4)        
        if( A_LoopFileName = LS_FileTranslit_1 )
            Menu, MN_Tr1Submenu, Check, %fileN%
        Else
            Menu, MN_Tr1Submenu, Uncheck, %fileN%
    }
    
    Critical ; critical section of code =ru= критическая секция кода
    
    fileN := A_WorkingDir "\translit_1\" LS_FileTranslit_1
    Clipboard := StringReplaceParrIni( Clipboard, fileN )

    
    Critical OFF ; disable critical section =ru= отключение критической секции
    Sleep -1 ; Critical definitely worked =ru= Critical точно отработал
    
return


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
MN_TRANSL2:
    LS_FileTranslit_2 := A_ThisMenuItem ".ini"
    IniWrite, %LS_FileTranslit_2%, %LS_SETTINGSINI%, ADDITIONALLY, FileTranslit_2
    
    Loop, %A_WorkingDir%\translit_2\*.ini
    {
        fileN := A_LoopFileName
        fileN := SubStr(fileN, 1, StrLen(fileN)-4)        
        if( A_LoopFileName = LS_FileTranslit_2 )
            Menu, MN_Tr2Submenu, Check, %fileN%
        Else
            Menu, MN_Tr2Submenu, Uncheck, %fileN%
    }
    
    Critical ; critical section of code =ru= критическая секция кода

    fileN := A_WorkingDir "\translit_2\" LS_FileTranslit_2
    Clipboard := StringReplaceParrIni( Clipboard, fileN )

    
    Critical OFF ; disable critical section =ru= отключение критической секции
    Sleep -1 ; Critical definitely worked =ru= Critical точно отработал
return

; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
MN_Exit:
    ExitApp
return

; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
MN_Reload:
    Reload
return

; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
MN_RunWithOS:
    asfp := A_ScriptFullPath
    if( A_Args[1] <> "" )
    {
        asfp := asfp " " A_Args[1]
    }
        
    RegRead, OutputVar, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run, Keybord_Assistant
    if ErrorLevel
    {   
        RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run, Keybord_Assistant, %asfp%
        Sleep 200
        RegRead, OutputVar, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run, Keybord_Assistant
        if ErrorLevel
        {
            Menu, tray, UnCheck, %MN_L15%
        }
        else
        {
            Menu, tray, Check, %MN_L15%
        }
    }
    else
    {
        RegDelete, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run, Keybord_Assistant
        Menu, tray, UnCheck, %MN_L15%
    }   
    
    
return



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
MN_Show_tooltip:
    if( LS_ShowToolTip = 1 )
        LS_ShowToolTip := 0
    Else
        LS_ShowToolTip := 1
        
    IniWrite, %LS_ShowToolTip%, %LS_SETTINGSINI%, MAIN, ShowToolTip    
        
    if( LS_ShowToolTip = 1) 
        Menu, tray, Check, % MN_L6
    Else
        Menu, tray, Uncheck, % MN_L6
return

; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
MN_Sound_for_switching_layouts:
    if( LS_PlaySound = 1 )
        LS_PlaySound := 0
    Else
        LS_PlaySound := 1
        
    IniWrite, %LS_PlaySound%, %LS_SETTINGSINI%, MAIN, PlaySound 
    
    if( LS_PlaySound = 1) 
        Menu, tray, Check, % MN_L7
    Else
        Menu, tray, Uncheck, % MN_L7
return


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
MN_Hotkeys:
    FileHKName := "Hotkeys.txt"
    FileDelete, %FileHKName%
    txtF := ""
    
    txtF:= txtF "CapsLock = "
    if( LS_CapsLockReassign <> "" )
        txtF:= txtF LS_CapsLockReassign "; "   
        
    if(LS_CapsLockOption >= 1 and LS_CapsLockOption <= 8 )
    {
        Nlay := LS_CapsLockOption 
        list := ""
        cnt := LS_ListL%Nlay%_Count
        Loop, %cnt%
        {
            if( Trim(LS_ListL%Nlay%[A_Index]) <> "" )
            {
                if(list <> "")
                    list := list "; "
                strHKL := Trim(LS_ListL%Nlay%[A_Index])
                idx := Format( "{:d}", KL_Index%strHKL%)
                list := list KL_LNAME%idx%
            }
        }
        txtF:= txtF "switch layouts: " list "`n"
    }
    else
    if ( LS_CapsLockOption = "AllLayouts" )
    {
        txtF:= txtF "switch ALL layouts`n"
    }
    else
        txtF:= txtF "`n"
    
    
         
    txtF:= txtF "LShift   = "
    if(LS_LShiftOption >= 1 and LS_LShiftOption <= 8 )
    {
        Nlay := LS_LShiftOption 
        list := ""
        cnt := LS_ListL%Nlay%_Count
        Loop, %cnt%
        {
            if( Trim(LS_ListL%Nlay%[A_Index]) <> "" )
            {
                if(list <> "")
                    list := list "; "
                strHKL := Trim(LS_ListL%Nlay%[A_Index])
                idx := Format( "{:d}", KL_Index%strHKL%)
                list := list KL_LNAME%idx%
            }
        }
        txtF:= txtF "switch layouts: " list "`n"
    }
    else
    if ( LS_LShiftOption = "AllLayouts" )
    {
        txtF:= txtF "switch ALL layouts`n"
    }
    else
        txtF:= txtF "`n"
    
    
    
    txtF:= txtF "RShift   = "
    if(LS_RShiftOption >= 1 and LS_RShiftOption <= 8 )
    {
        Nlay := LS_RShiftOption 
        list := ""
        cnt := LS_ListL%Nlay%_Count
        Loop, %cnt%
        {
            if( Trim(LS_ListL%Nlay%[A_Index]) <> "" )
            {
                if(list <> "")
                    list := list "; "
                strHKL := Trim(LS_ListL%Nlay%[A_Index])
                idx := Format( "{:d}", KL_Index%strHKL%)
                list := list KL_LNAME%idx%
            }
        }
        txtF:= txtF "switch layouts: " list "`n"
    }
    else
    if ( LS_RShiftOption = "AllLayouts" )
    {
        txtF:= txtF "switch ALL layouts`n"
    }
    else
        txtF:= txtF "`n"
        
    
    
    
    
    txtF:= txtF "LCtrl    = "
    if(LS_LCtrlOption >= 1 and LS_LCtrlOption <= 8 )
    {
        Nlay := LS_LCtrlOption 
        list := ""
        cnt := LS_ListL%Nlay%_Count
        Loop, %cnt%
        {
            if( Trim(LS_ListL%Nlay%[A_Index]) <> "" )
            {
                if(list <> "")
                    list := list "; "
                strHKL := Trim(LS_ListL%Nlay%[A_Index])
                idx := Format( "{:d}", KL_Index%strHKL%)
                list := list KL_LNAME%idx%
            }
        }
        txtF:= txtF "switch layouts: " list "`n"
    }
    else
    if ( LS_LCtrlOption = "AllLayouts" )
    {
        txtF:= txtF "switch ALL layouts`n"
    }
    else
        txtF:= txtF "`n"
        
       
       
    txtF:= txtF "LAlt + Space = "
    if(LS_LAltSpaceOption >= 1 and LS_LAltSpaceOption <= 8 )
    {
        Nlay := LS_LAltSpaceOption 
        list := ""
        cnt := LS_ListL%Nlay%_Count
        Loop, %cnt%
        {
            if( Trim(LS_ListL%Nlay%[A_Index]) <> "" )
            {
                if(list <> "")
                    list := list "; "
                strHKL := Trim(LS_ListL%Nlay%[A_Index])
                idx := Format( "{:d}", KL_Index%strHKL%)
                list := list KL_LNAME%idx%
            }
        }
        txtF:= txtF "switch layouts: " list "`n"
    }
    else
    if ( LS_LAltSpaceOption = "AllLayouts" )
    {
        txtF:= txtF "switch ALL layouts`n"
    }
    else
        txtF:= txtF "`n"    
        
       
    
    
    
    txtF:= txtF "RAlt     = "
    if( LS_RAltReassign <> "" )
        txtF:= txtF LS_RAltReassign "; "
        
    if(LS_RAltOption >= 1 and LS_RAltOption <= 8 )
    {
        Nlay := LS_RAltOption 
        list := ""
        cnt := LS_ListL%Nlay%_Count
        Loop, %cnt%
        {
            if( Trim(LS_ListL%Nlay%[A_Index]) <> "" )
            {
                if(list <> "")
                    list := list "; "
                strHKL := Trim(LS_ListL%Nlay%[A_Index])
                idx := Format( "{:d}", KL_Index%strHKL%)
                list := list KL_LNAME%idx%
            }
        }
        txtF:= txtF "switch layouts: " list "`n"
    }
    else
    if ( LS_RAltOption = "AllLayouts" )
    {
        txtF:= txtF "switch ALL layouts`n"
    }
    else
        txtF:= txtF "`n"
    
    
    
    
    
    txtF:= txtF "RWin     = "
    if( LS_RWinReassign <> "" )
        txtF:= txtF LS_RWinReassign "; "
        
    if(LS_RWinOption >= 1 and LS_RWinOption <= 8 )
    {
        Nlay := LS_RWinOption 
        list := ""
        cnt := LS_ListL%Nlay%_Count
        Loop, %cnt%
        {
            if( Trim(LS_ListL%Nlay%[A_Index]) <> "" )
            {
                if(list <> "")
                    list := list "; "
                strHKL := Trim(LS_ListL%Nlay%[A_Index])
                idx := Format( "{:d}", KL_Index%strHKL%)
                list := list KL_LNAME%idx%
            }
        }
        txtF:= txtF "switch layouts: " list "`n"
    }
    else
    if ( LS_RWinOption = "AllLayouts" )
    {
        txtF:= txtF "switch ALL layouts`n"
    }
    else
        txtF:= txtF "`n"
    
    
    
    
    
    txtF:= txtF "RCtrl    = "
    if( LS_RCtrlReassign <> "" )
        txtF:= txtF LS_RCtrlReassign "; "
        
    if(LS_RCtrlOption >= 1 and LS_RCtrlOption <= 8 )
    {
        Nlay := LS_RCtrlOption 
        list := ""
        cnt := LS_ListL%Nlay%_Count
        Loop, %cnt%
        {
            if( Trim(LS_ListL%Nlay%[A_Index]) <> "" )
            {
                if(list <> "")
                    list := list "; "
                strHKL := Trim(LS_ListL%Nlay%[A_Index])
                idx := Format( "{:d}", KL_Index%strHKL%)
                list := list KL_LNAME%idx%
            }
        }
        txtF:= txtF "switch layouts: " list "`n"
    }
    else
    if ( LS_RCtrlOption = "AllLayouts" )
    {
        txtF:= txtF "switch ALL layouts`n"
    }
    else
        txtF:= txtF "`n"
    
           
    
    PerShiftCapsLockOFF := 0
    RegRead, OutputVar, HKEY_CURRENT_USER\Keyboard Layout, Attributes
    if(ErrorLevel = 0)
    {         
        if( OutputVar = 65536 )
            PerShiftCapsLockOFF := 1               
    }
    
    if( PerShiftCapsLockOFF = 1 )
    {
        txtF:= txtF "Alt + CapsLock = CapsLock ON" "`n"
        if(LS_LShift_RShift_CapsLock = 1)
            txtF:= txtF "LShift + RShift = CapsLock ON" "`n"
        txtF:= txtF "Shift = CapsLock OFF" "`n"    
    }
    else
    {
        txtF:= txtF "Alt + CapsLock = CapsLock" "`n"
        if(LS_LShift_RShift_CapsLock = 1)
            txtF:= txtF "LShift + RShift = CapsLock" "`n"
    }
    
    
    txtF:= txtF "------------------------------------------------------------------------------" "`n"
    
    
    if(LS_LAlt13_Enable = 1)
        txtF:= txtF "LAlt Add Chars  = YES" "`n"
    else
        txtF:= txtF "LAlt Add Chars  = NO" "`n"
        
    if(LS_RAltAddChars = 1)
        txtF:= txtF "RAlt Add Chars  = YES" "`n"
    else
        txtF:= txtF "RAlt Add Chars  = NO" "`n"     
        
    if(LS_RAltAddCursor = 1)
        txtF:= txtF "RAlt Add Cursor = YES" "`n"
    else
        txtF:= txtF "RAlt Add Cursor = NO" "`n"
        
    if(LS_RAltAddMouse = 1)
        txtF:= txtF "RAlt Add Mouse  = YES" "`n"
    else
        txtF:= txtF "RAlt Add Mouse  = NO" "`n" 
    
    if(LS_RWinBirmanLayout = 1)
        txtF:= txtF "RWin Birman Layout = YES" "`n"
    else
        txtF:= txtF "RWin Birman Layout = NO" "`n"
        
    txtF:= txtF "------------------------------------------------------------------------------" "`n"
        
    
    if(LS_Ctrl_Alt_V = 1)
        txtF:= txtF "Ctrl + Alt + V = Paste text without formatting by Ctrl+Alt+V" "`n"
    
    if(LS_Alt_Pause = 1)
        txtF:= txtF "Alt + Pause = change case to lower by Alt+Pause (upper Alt+Shift+Pause)" "`n"
    
    if(LS_Alt_ScrollLock = 1)
        txtF:= txtF "Alt + Scroll Lock = translit_1  (file: " LS_FileTranslit_1 ")" "`n"

    if(LS_Alt_Shift_ScrollLock = 1)
        txtF:= txtF "Alt + Shift + Scroll Lock = translit_2  (file: " LS_FileTranslit_2 ")" "`n"
    
    if(LS_Alt_Win_ScrollLock = 1)
        txtF:= txtF "Alt + Win + Scroll Lock = Special transliteration for the Alt_Win_ScrollLock.ini" "`n"
    
    if(LS_RAlt_BackSpace = 1)    
        txtF:= txtF "RAlt + BackSpace = Change the layout of already typed text" "`n"


    FileAppend, %txtF%, %FileHKName%
    Run, open %FileHKName%
return

; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
MN_HelpFile:
    if(LS_HelpFile <> "")
    {
        if FileExist(LS_HelpFile)
        {
            Run, open %LS_HelpFile% 
        }
        else
        {
            fileN := LS_FileLocalization
            fileN := SubStr(fileN, 1, StrLen(fileN)-4)
            SplitPath, LS_HelpFile, name, dir, ext, name_no_ext, drive   
            str1 := "." ext 
            str2 := "_" fileN "." ext
            StringReplace, NEW_HelpFile, LS_HelpFile, %str1%, %str2%
            if FileExist(NEW_HelpFile)
            {
                Run, open %NEW_HelpFile% 
            }
            else
            {
                fileN := "English"
                SplitPath, LS_HelpFile, name, dir, ext, name_no_ext, drive   
                str1 := "." ext 
                str2 := "_" fileN "." ext
                StringReplace, NEW_HelpFile, LS_HelpFile, %str1%, %str2%
                if FileExist(NEW_HelpFile)
                {
                    Run, open %NEW_HelpFile% 
                }
            }
        }
    }  
return


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
MN_Settings:
    Run, open %LS_SETTINGSINI%
return


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
MN_Stop_Start:

    Suspend Toggle
    if A_IsPaused 
    {
        ; allow Win+L to lock (but will be allowed with hot key LWin+L ) =ru= разрешить Win+L для блокировки ( но разрешено будет с помощью горячей клавиши LWin+L )
        SetDisableLockWorkstationRegKeyValue( 1 ) 
        ; close this script returning RAlt RWin if it is run =ru= закрыть данный скрипт возвращающий RAlt RWin если он будет запущен
        Process, Exist, RAltRWin.exe
        _pid = %ErrorLevel%
        Process, Close, %_pid%
        
        ; reset possible stuck keys =ru= сброс возможных зависших клавиш 
        SetKeyDelay -1	
        SendInput {LCtrl Up}{RCtrl Up}{LWin Up}{RWin Up}{LAlt Up}{RAlt Up}{LShift Up}{RShift Up}{vkB6 Up}{vkA9 Up}{Tab Up}
                
        Pause Toggle       

    }
    else
    {
        ; allow Win+L to lock (but will be allowed with hot key LWin+L ) =ru= разрешить Win+L для блокировки ( но разрешено будет с помощью горячей клавиши LWin+L )
        SetDisableLockWorkstationRegKeyValue( 0 ) 
        
        ; reset possible stuck keys =ru= сброс возможных зависших клавиш 
        SetKeyDelay -1	
        SendInput {LCtrl Up}{RCtrl Up}{LWin Up}{RWin Up}{LAlt Up}{RAlt Up}{LShift Up}{RShift Up}{vkB6 Up}{vkA9 Up}{Tab Up}        
        
        ; run this script returning RAlt RWin =ru= запустить данный скрипт возвращающий RAlt RWin
        Run, RAltRWin.exe 
        Pause Toggle       

    }

return


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
MN_Load_INI(MN_FILE_INI)
{
    global
    
    IniRead, var, localization\%MN_FILE_INI%, LIST, L1
    if( var <> "ERROR" )
    {
        MN_L1 := "quiet"
        Menu, MN_LVSubmenu, Rename, %MN_L1%,  %var%
        MN_L1 := var
    }
        
    IniRead, var, localization\%MN_FILE_INI%, LIST, L2
    if( var <> "ERROR" )
    {
        MN_L2 := "medium"
        Menu, MN_LVSubmenu, Rename, %MN_L2%,  %var%
        MN_L2 := var
    }
        
    IniRead, var, localization\%MN_FILE_INI%, LIST, L3
    if( var <> "ERROR" )
    {
        MN_L3 := "loudly"
        Menu, MN_LVSubmenu, Rename, %MN_L3%,  %var%
        MN_L3 := var
    }
        
    IniRead, var, localization\%MN_FILE_INI%, LIST, L4
    if( var <> "ERROR" )
        Menu, tray, Rename, Exit,  %var%   
        
    IniRead, var, localization\%MN_FILE_INI%, LIST, L5
    if( var <> "ERROR" )
        Menu, tray, Rename, Reload,  %var%    
        
    IniRead, var, localization\%MN_FILE_INI%, LIST, L6
    if( var <> "ERROR" )
    {
        MN_L6 := "Show tooltip"
        Menu, tray, Rename, %MN_L6%, %var% 
        MN_L6 := var 
    }
    
        
    IniRead, var, localization\%MN_FILE_INI%, LIST, L7
    if( var <> "ERROR" )
    {
        MN_L7 := "Sound for switching layouts"
        Menu, tray, Rename, %MN_L7%, %var%  
        MN_L7 := var
    }
    
    IniRead, var, localization\%MN_FILE_INI%, LIST, L8
    if( var <> "ERROR" )
        Menu, tray, Rename, Sound level at startup,  %var% 
        
    IniRead, var, localization\%MN_FILE_INI%, LIST, L9
    if( var <> "ERROR" )
        Menu, tray, Rename, Help file... [RAlt + F1],  %var% [RAlt + F1]
        
    IniRead, var, localization\%MN_FILE_INI%, LIST, L10
    if( var <> "ERROR" )
        Menu, tray, Rename, Stop\Start,  %var%
        
    IniRead, var, localization\%MN_FILE_INI%, LIST, L11
    if( var <> "ERROR" )
    {
        var := var " " LS_SETTINGSINI 
        Menu, tray, Rename, %MN_L11%,  %var%
        MN_L11 := var
    }
    
    IniRead, var, localization\%MN_FILE_INI%, LIST, L12
    if( var <> "ERROR" )
    {
        kbd_msg_1 := var
    }
    
    IniRead, var, localization\%MN_FILE_INI%, LIST, L13
    if( var <> "ERROR" )
    {
        kbd_msg_2 := var
    }
    
    IniRead, var, localization\%MN_FILE_INI%, LIST, L14
    if( var <> "ERROR" )
    {
        kbd_msg_3 := var
    }
    
    IniRead, var, localization\%MN_FILE_INI%, LIST, L15
    if( var <> "ERROR" )
    {        
        Menu, tray, Rename, %MN_L15%,  %var%
        MN_L15 := var
    }
}


; ==============================================================================