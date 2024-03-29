; ==============================================================================
; LOADING SETTINGS (LS) =ru= ЗАГРУЗКА НАСТРОЕК (LS)
; ==============================================================================
; FileDescription: loading settings from the settings.ini file =ru= загрузка настроек с файла settings.ini
; FileVersion: 2.0.3.0 2023-01-28 \\ (Major version).(Minor version).(Revision number).(Build number) (year)-(month)-(day)
; Author: kaiu@mail.ru \\ author of code changes 
; ProductName: Keybord_Assistant \\ included in the product
; OriginalFilename: LS_Loading_Settings.ahk \\ What file is this code from
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−

; file from which settings are loaded
; =ru= файл с которого производится загрузка настроек
LS_SETTINGSINI := "settings.ini"

; the first command line parameter can be the name of a settings file
; =ru= первый параметр командной строки может быть именем файла настроек
if( A_Args[1] <> "" )
{
    LS_SETTINGSINI := A_Args[1]
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−− 
ToTxtFromIniTxt(txt)
{   
    srtxt := "\\"
    rptxt := "#$//$#"
    StringReplace, txt, txt, %srtxt%, %rptxt%, All
    
    srtxt := "\s"
    rptxt := " "
    StringReplace, txt, txt, %srtxt%, %rptxt%, All
    
    srtxt := "\c"
    rptxt := ","
    StringReplace, txt, txt, %srtxt%, %rptxt%, All
    
    srtxt := "\e"
    rptxt := "="
    StringReplace, txt, txt, %srtxt%, %rptxt%, All
    
    srtxt := "\n"
    rptxt := "`n"
    StringReplace, txt, txt, %srtxt%, %rptxt%, All
    
    srtxt := "\t"
    rptxt := "`t"
    StringReplace, txt, txt, %srtxt%, %rptxt%, All
    
    srtxt := "\r"
    rptxt := "`r"
    StringReplace, txt, txt, %srtxt%, %rptxt%, All
    
    srtxt := "#$//$#"
    rptxt := "\"
    StringReplace, txt, txt, %srtxt%, %rptxt%, All
    
    return txt
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; localization file from "localization" directory (program language)
; =ru= файл локализации из каталога "localization" (язык программы)
LS_FileLocalization=Russian.ini
IniRead, var, %LS_SETTINGSINI%, MAIN, FileLocalization
if( var <> "ERROR" )
{
    LS_FileLocalization := var
}
else 
{    
    IniWrite, %LS_FileLocalization%, %LS_SETTINGSINI%, MAIN, FileLocalization
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; Help file (*.jpg or *.txt or *.pdf or ...) NAME.EXT (if not found, search by NAME_FileLocalization.EXT or by NAME_English.EXT)
; =ru= Файл справки (*.jpg or *.txt or *.pdf or ...) NAME.EXT (если не найдет, то поиск по NAME_FileLocalization.EXT или по NAME_English.EXT) 
LS_HelpFile := ""
IniRead, var, %LS_SETTINGSINI%, MAIN, HelpFile
if( var <> "ERROR" )
{
    LS_HelpFile := var
}
else 
{    
    IniWrite, %LS_HelpFile%, %LS_SETTINGSINI%, MAIN, HelpFile
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; all your layouts in the system (on each line there is one entry like: HKL, ISO, Name, Sound, INPUT_LNG, LAYOUT_NAME)
; =ru= все ваши раскладки в системе (на каждой строке одна запись вида: HKL, ISO, Name, Sound, INPUT_LNG, LAYOUT_NAME)
LS_ALLkeyboards := ""
IniRead, var, %LS_SETTINGSINI%, KEYBOARDS
if( (var <> "ERROR") and (var <> "") )
{    
    var := StrSplit(var, "`n")
    
    SetFormat, Integer, D
    Loop, % var.Count()
    {
        valN := var[A_Index]
        valMas := StrSplit(valN, ", ")
        valHKL := valMas[1]
        LgUp := valMas[3] ; Name
        KL_ARSOUND%LgUp% := valMas[4] ; Sound 
        KL_ARLG1%valHKL% := LgUp
        KL_ARHKL%LgUp% := valHKL 
        if(valN <> "")
        {   
            idx := Format("{:d}", KL_Index%valHKL%)
            if(idx <> "")
            {
                KL_NAME%idx% := LgUp   
                KL_SOUND%idx% := valMas[4] ; Sound               
            }
        }
    }
    
    IniDelete %LS_SETTINGSINI%, KEYBOARDS
    IniWrite, [KEYBOARDS], %LS_SETTINGSINI%, PLACE_FOR_SECTION_KEYBOARDS
    
    sp := "" 
    SetFormat, Integer, D    
    Loop, %KL_Count%
    {
        if(sp<>"") 
            sp := sp "`n"
        sp := sp KL_HKL%A_Index% ", " KL_ISO%A_Index% ", " KL_NAME%A_Index%      
        sp := sp ", " KL_SOUND%A_Index%
        sp := sp ", " KL_ILNAME%A_Index% ", " KL_LNAME%A_Index%
    }
    IniWrite, %sp%, %LS_SETTINGSINI%, KEYBOARDS
}
else
{   
    sp := ""    
    SetFormat, Integer, D 
    Loop, %KL_Count%
    {
        if(sp<>"") 
            sp := sp "`n"
        sp := sp KL_HKL%A_Index% ", " KL_ISO%A_Index% ", " KL_NAME%A_Index%    
        sp := sp ", " KL_SOUND%A_Index%
        sp := sp ", " KL_ILNAME%A_Index% ", " KL_LNAME%A_Index%
    }
    IniWrite, %sp%, %LS_SETTINGSINI%, KEYBOARDS
}



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; Is language tooltip allowed (1-yes, 0-no)
; =ru= Разрешена ли всплывающая подсказка по языку (1-да, 0-нет)
LS_ShowToolTip := 1
IniRead, var, %LS_SETTINGSINI%, MAIN, ShowToolTip
if( var <> "ERROR" )
{
    LS_ShowToolTip := var
}
else 
{    
    IniWrite, %LS_ShowToolTip%, %LS_SETTINGSINI%, MAIN, ShowToolTip
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; Is it allowed to play the layout switching sound
; =ru= Разрешено ли проигрывать звук переключения раскладки
LS_PlaySound := 0
IniRead, var, %LS_SETTINGSINI%, MAIN, PlaySound
if( var <> "ERROR" )
{
    LS_PlaySound := var
}
else 
{    
    IniWrite, %LS_PlaySound%, %LS_SETTINGSINI%, MAIN, PlaySound
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; Sound level at startup =ru= Уровень звука при запуске
; =1 or 2 or 3
LS_SoundLevelAtStartup:=1
IniRead, var, %LS_SETTINGSINI%, MAIN, SoundLevelAtStartup
if( var <> "ERROR" )
{
    LS_SoundLevelAtStartup := var
}
else 
{    
    IniWrite, %LS_SoundLevelAtStartup%, %LS_SETTINGSINI%, MAIN, SoundLevelAtStartup
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; time to switch layout [ms] (200 ... 500)
; =ru= время на переключение раскладки [mS] (200 ... 500)
LS_TimeSwitchLayout := 500
IniRead, var, %LS_SETTINGSINI%, MAIN, TimeSwitchLayout
if( var <> "ERROR" )
{
    LS_TimeSwitchLayout := var
}
else 
{    
    IniWrite, %LS_TimeSwitchLayout%, %LS_SETTINGSINI%, MAIN, TimeSwitchLayout
}



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; Toggle CapsLock by simultaneously pressing LShift + RShift (1-yes, 0-no)
; =ru= Переключать CapsLock одновременным нажатием LShift + RShift (1-да, 0-нет)
LS_LShift_RShift_CapsLock = 1
IniRead, var, %LS_SETTINGSINI%, MAIN, LShift_RShift_CapsLock
if( var <> "ERROR" )
{
    LS_LShift_RShift_CapsLock := var
}
else 
{    
    IniWrite, %LS_LShift_RShift_CapsLock%, %LS_SETTINGSINI%, MAIN, LShift_RShift_CapsLock
}

; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; time to switch CapsLock [ms] (300 ... 500)
; =ru= время на переключение CapsLock [mS] (300 ... 500)
LS_TimeSwitchCapsLock := 500
IniRead, var, %LS_SETTINGSINI%, MAIN, TimeSwitchCapsLock
if( var <> "ERROR" )
{
    LS_TimeSwitchCapsLock := var
}
else 
{    
    IniWrite, %LS_TimeSwitchCapsLock%, %LS_SETTINGSINI%, MAIN, TimeSwitchCapsLock
}

; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; sound files for voicing CapsLock switching
; =ru= звуковые файлы для озвучивания переключения CapsLock 
LS_FileSoundCapsLockON := "CapsLockON.wav"
LS_FileSoundCapsLockOFF := "CapsLockOFF.wav"
IniRead, var, %LS_SETTINGSINI%, MAIN, FileSoundCapsLockON
if( var <> "ERROR" )
{
    LS_FileSoundCapsLockON := var
}
else 
{    
    IniWrite, %LS_FileSoundCapsLockON%, %LS_SETTINGSINI%, MAIN, FileSoundCapsLockON
}
IniRead, var, %LS_SETTINGSINI%, MAIN, FileSoundCapsLockOFF
if( var <> "ERROR" )
{
    LS_FileSoundCapsLockOFF := var
}
else 
{    
    IniWrite, %LS_FileSoundCapsLockOFF%, %LS_SETTINGSINI%, MAIN, FileSoundCapsLockOFF
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; sound files to sound sticky mouse (in the catalog "sound")
; =ru= звуковые файлы для озвучивания залипания мыши (в каталоге "sound")
LS_FileSoundMouseStuckOFF := "StuckOFF.wav"
LS_FileSoundMouseStuckON := "StuckON.wav"
IniRead, var, %LS_SETTINGSINI%, MAIN, FileSoundMouseStuckOFF
if( var <> "ERROR" )
{
    LS_FileSoundMouseStuckOFF := var
}
else 
{    
    IniWrite, %LS_FileSoundMouseStuckOFF%, %LS_SETTINGSINI%, MAIN, FileSoundMouseStuckOFF
}
IniRead, var, %LS_SETTINGSINI%, MAIN, FileSoundMouseStuckON
if( var <> "ERROR" )
{
    LS_FileSoundMouseStuckON := var
}
else 
{    
    IniWrite, %LS_FileSoundMouseStuckON%, %LS_SETTINGSINI%, MAIN, FileSoundMouseStuckON
}



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; test mode (1-yes, 0-no) (*F12 - show sticky keys, RWin+F1 = ListHotkeys)
; =ru= режим тестирования (1-да, 0-нет) (*F12 - показ залипших клавиш, RWin+F1 = ListHotkeys)
LS_TestMode := 0
IniRead, var, %LS_SETTINGSINI%, MAIN, TestMode
if( var <> "ERROR" )
{
    LS_TestMode := var
}
else 
{    
    IniWrite, %LS_TestMode%, %LS_SETTINGSINI%, MAIN, TestMode
}



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; Alternative 1 list of layouts (one entry per line: HKL, ISO)
; =ru= Альтернативный 1 список раскладок  (на каждой строке одна запись вида: HKL, ISO)
LS_ListL1 := ""
LS_ListL1_Count := 0
LS_ListL1_N := 0
IniRead, var, %LS_SETTINGSINI%, LAYOUT_LIST_1
if( (var <> "ERROR") and (var <> "") )
{
    var := StrSplit(var, "`n")
    LS_ListL1_Count := var.Count()
    Loop, %LS_ListL1_Count%
    {        
        valN := var[A_Index]
        valMas := StrSplit(valN, ", ")
        valN := valMas[1]
        
        if(valN <> "")
        {
            if(LS_ListL1 <> "")
                LS_ListL1 := LS_ListL1 ";"
            LS_ListL1 := LS_ListL1 valN
        }
    }
    LS_ListL1 := StrSplit(LS_ListL1, ";")
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; Alternative 2 list of layouts (one entry per line: HKL, ISO)
; =ru= Альтернативный 2 список раскладок  (на каждой строке одна запись вида: HKL, ISO)
LS_ListL2 := ""
LS_ListL2_Count := 0
LS_ListL2_N := 0
IniRead, var, %LS_SETTINGSINI%, LAYOUT_LIST_2
if( (var <> "ERROR") and (var <> "") )
{
    var := StrSplit(var, "`n")
    LS_ListL2_Count := var.Count()
    Loop, %LS_ListL2_Count%
    {        
        valN := var[A_Index]
        valMas := StrSplit(valN, ", ")
        valN := valMas[1]
        
        if(valN <> "")
        {
            if(LS_ListL2 <> "")
                LS_ListL2 := LS_ListL2 ";"
            LS_ListL2 := LS_ListL2 valN
        }
    }
    LS_ListL2 := StrSplit(LS_ListL2, ";")
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; Alternative 3 list of layouts (one entry per line: HKL, ISO)
; =ru= Альтернативный 3 список раскладок  (на каждой строке одна запись вида: HKL, ISO)
LS_ListL3 := ""
LS_ListL3_Count := 0
LS_ListL3_N := 0
IniRead, var, %LS_SETTINGSINI%, LAYOUT_LIST_3
if( (var <> "ERROR") and (var <> "") )
{
    var := StrSplit(var, "`n")
    LS_ListL3_Count := var.Count()
    Loop, %LS_ListL3_Count%
    {        
        valN := var[A_Index]
        valMas := StrSplit(valN, ", ")
        valN := valMas[1]
        
        if(valN <> "")
        {
            if(LS_ListL3 <> "")
                LS_ListL3 := LS_ListL3 ";"
            LS_ListL3 := LS_ListL3 valN
        }
    }
    LS_ListL3 := StrSplit(LS_ListL3, ";")
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; Alternative 1 list of layouts (one entry per line: HKL, ISO)
; =ru= Альтернативный 1 список раскладок  (на каждой строке одна запись вида: HKL, ISO)
LS_ListL4 := ""
LS_ListL4_Count := 0
LS_ListL4_N := 0
IniRead, var, %LS_SETTINGSINI%, LAYOUT_LIST_4
if( (var <> "ERROR") and (var <> "") )
{
    var := StrSplit(var, "`n")
    LS_ListL4_Count := var.Count()
    Loop, %LS_ListL4_Count%
    {        
        valN := var[A_Index]
        valMas := StrSplit(valN, ", ")
        valN := valMas[1]
        
        if(valN <> "")
        {
            if(LS_ListL4 <> "")
                LS_ListL4 := LS_ListL4 ";"
            LS_ListL4 := LS_ListL4 valN
        }
    }
    LS_ListL4 := StrSplit(LS_ListL4, ";")
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; Alternative 1 list of layouts (one entry per line: HKL, ISO)
; =ru= Альтернативный 1 список раскладок  (на каждой строке одна запись вида: HKL, ISO)
LS_ListL5 := ""
LS_ListL5_Count := 0
LS_ListL5_N := 0
IniRead, var, %LS_SETTINGSINI%, LAYOUT_LIST_5
if( (var <> "ERROR") and (var <> "") )
{
    var := StrSplit(var, "`n")
    LS_ListL5_Count := var.Count()
    Loop, %LS_ListL5_Count%
    {        
        valN := var[A_Index]
        valMas := StrSplit(valN, ", ")
        valN := valMas[1]
        
        if(valN <> "")
        {
            if(LS_ListL5 <> "")
                LS_ListL5 := LS_ListL5 ";"
            LS_ListL5 := LS_ListL5 valN
        }
    }
    LS_ListL5 := StrSplit(LS_ListL5, ";")
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; Alternative 1 list of layouts (one entry per line: HKL, ISO)
; =ru= Альтернативный 1 список раскладок  (на каждой строке одна запись вида: HKL, ISO)
LS_ListL6 := ""
LS_ListL6_Count := 0
LS_ListL6_N := 0
IniRead, var, %LS_SETTINGSINI%, LAYOUT_LIST_6
if( (var <> "ERROR") and (var <> "") )
{
    var := StrSplit(var, "`n")
    LS_ListL6_Count := var.Count()
    Loop, %LS_ListL6_Count%
    {        
        valN := var[A_Index]
        valMas := StrSplit(valN, ", ")
        valN := valMas[1]
        
        if(valN <> "")
        {
            if(LS_ListL6 <> "")
                LS_ListL6 := LS_ListL6 ";"
            LS_ListL6 := LS_ListL6 valN
        }
    }
    LS_ListL6 := StrSplit(LS_ListL6, ";")
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; Alternative 1 list of layouts (one entry per line: HKL, ISO)
; =ru= Альтернативный 1 список раскладок  (на каждой строке одна запись вида: HKL, ISO)
LS_ListL7 := ""
LS_ListL7_Count := 0
LS_ListL7_N := 0
IniRead, var, %LS_SETTINGSINI%, LAYOUT_LIST_7
if( (var <> "ERROR") and (var <> "") )
{
    var := StrSplit(var, "`n")
    LS_ListL7_Count := var.Count()
    Loop, %LS_ListL7_Count%
    {        
        valN := var[A_Index]
        valMas := StrSplit(valN, ", ")
        valN := valMas[1]
        
        if(valN <> "")
        {
            if(LS_ListL7 <> "")
                LS_ListL7 := LS_ListL7 ";"
            LS_ListL7 := LS_ListL7 valN
        }
    }
    LS_ListL7 := StrSplit(LS_ListL7, ";")
}



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; Alternative 8 list of layouts (one entry per line: HKL, ISO)
; =ru= Альтернативный 8 список раскладок  (на каждой строке одна запись вида: HKL, ISO)
LS_ListL8 := ""
LS_ListL8_Count := 0
LS_ListL8_N := 0
IniRead, var, %LS_SETTINGSINI%, LAYOUT_LIST_8
if( (var <> "ERROR") and (var <> "") )
{
    var := StrSplit(var, "`n")
    LS_ListL8_Count := var.Count()
    Loop, %LS_ListL8_Count%
    {        
        valN := var[A_Index]
        valMas := StrSplit(valN, ", ")
        valN := valMas[1]
        
        if(valN <> "")
        {
            if(LS_ListL8 <> "")
                LS_ListL8 := LS_ListL8 ";"
            LS_ListL8 := LS_ListL8 valN
        }
    }
    LS_ListL8 := StrSplit(LS_ListL8, ";")
}






; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; Ability to change the default behavior of CapsLock
; (in any case, you can switch by pressing Alt + CapsLock)
; Can only take one of the following values:
; =ru= Возможность изменить стандартное поведение CapsLock
; =ru= (в любом случае, вы можете переключить нажав Alt + CapsLock)
; =ru= Может принимать только одно из значений:

; =    - empty or do not change (CapsLockOption will be Disable) =ru= пустое или не менять (CapsLockOption буден отключен)
; =Disable - disable =ru=  отключить
; =LCtrl - like LCtrl =ru=  как LCtrl
; =LShift - like LShift =ru=  как LShift
; =Tab - like Tab (CapsLockOption will be Disable) =ru=  как Tab (CapsLockOption буден отключен)
LS_CapsLockReassign := "LCtrl"
IniRead, var, %LS_SETTINGSINI%, CAPSLOCK_OPTIONS, CapsLockReassign
if( var <> "ERROR" )
{
    LS_CapsLockReassign := var
}
else 
{    
    IniWrite, %LS_CapsLockReassign%, %LS_SETTINGSINI%, CAPSLOCK_OPTIONS, CapsLockReassign
}


if( (LS_CapsLockReassign = "Tab") OR (Trim(LS_CapsLockReassign) = "") )
{
    LS_CapsLockOption := "Disable"
    IniWrite, %LS_CapsLockOption%, %LS_SETTINGSINI%, CAPSLOCK_OPTIONS, CapsLockOption
}
else
{
    ; =Disable - disable =ru=  отключить
    ; =AllLayouts - switch all layouts =ru= переключать все раскладки
    ; =1 or 2 ... 8 (LAYOUT_LIST_1 or LAYOUT_LIST_2...LAYOUT_LIST_8)  switching from an alternative list of layouts =ru= переключение из альтернативного списка раскладок
    LS_CapsLockOption := "Disable"
    IniRead, var, %LS_SETTINGSINI%, CAPSLOCK_OPTIONS, CapsLockOption
    if( var <> "ERROR" )
    {
        LS_CapsLockOption := var
    }
    else 
    {    
        IniWrite, %LS_CapsLockOption%, %LS_SETTINGSINI%, CAPSLOCK_OPTIONS, CapsLockOption
    }
}



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−   
; Ability to change the default behavior of LShift
; Can only take one of the following values:
; =ru= Возможность изменить стандартное поведение LShift
; =ru= Может принимать только одно из значений:

; =    - empty or do not change =ru= пустое или не менять
; =AllLayouts - switch all layouts =ru= переключать все раскладки
; =1 or 2 ... 8 (LAYOUT_LIST_1 or LAYOUT_LIST_2...LAYOUT_LIST_8)  switching from an alternative list of layouts =ru= переключение из альтернативного списка раскладок
LS_LShiftOption := 1
IniRead, var, %LS_SETTINGSINI%, LSHIFT_OPTIONS, LShiftOption
if( var <> "ERROR" )
{
    LS_LShiftOption := var
}
else 
{    
    IniWrite, %LS_LShiftOption%, %LS_SETTINGSINI%, LSHIFT_OPTIONS, LShiftOption
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−   
; Ability to change the default behavior of RShift
; Can only take one of the following values:
; =ru= Возможность изменить стандартное поведение RShift
; =ru= Может принимать только одно из значений:

; =    - empty or do not change =ru= пустое или не менять
; =AllLayouts - switch all layouts =ru= переключать все раскладки
; =1 or 2 ... 8 (LAYOUT_LIST_1 or LAYOUT_LIST_2...LAYOUT_LIST_8)  switching from an alternative list of layouts =ru= переключение из альтернативного списка раскладок
LS_RShiftOption := 2
IniRead, var, %LS_SETTINGSINI%, RSHIFT_OPTIONS, RShiftOption
if( var <> "ERROR" )
{
    LS_RShiftOption := var
}
else 
{    
    IniWrite, %LS_RShiftOption%, %LS_SETTINGSINI%, RSHIFT_OPTIONS, RShiftOption
}



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−   
; Ability to change the default behavior of LCtrl
; Can only take one of the following values:
; =ru= Возможность изменить стандартное поведение LCtrl
; =ru= Может принимать только одно из значений:

; =    - empty or do not change =ru= пустое или не менять
; =Disable - disable =ru=  отключить
; =AllLayouts - switch all layouts =ru= переключать все раскладки
; =1 or 2 ... 8 (LAYOUT_LIST_1 or LAYOUT_LIST_2...LAYOUT_LIST_8)  switching from an alternative list of layouts =ru= переключение из альтернативного списка раскладок

LS_LCtrlOption := ""
IniRead, var, %LS_SETTINGSINI%, LCTRL_OPTIONS, LCtrlOption
if( var <> "ERROR" )
{
    LS_LCtrlOption := var
}
else 
{    
    IniWrite, %LS_LCtrlOption%, %LS_SETTINGSINI%, LCTRL_OPTIONS, LCtrlOption
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−   
; Ability to change the default behavior of RCtrl
; Can only take one of the following values:
; =ru= Возможность изменить стандартное поведение RCtrl
; =ru= Может принимать только одно из значений:

; =    - empty or do not change =ru= пустое или не менять
; =Disable - disable =ru=  отключить
; =RAlt - like RAlt =ru=  как RAlt
; =RShift - like RShift =ru=  как RShift
LS_RCtrlReassign := "RAlt"
IniRead, var, %LS_SETTINGSINI%, RCTRL_OPTIONS, RCtrlReassign
if( var <> "ERROR" )
{
    LS_RCtrlReassign := var
}
else 
{    
    IniWrite, %LS_RCtrlReassign%, %LS_SETTINGSINI%, RCTRL_OPTIONS, RCtrlReassign
}

; =Disable - disable =ru=  отключить
; =AllLayouts - switch all layouts =ru= переключать все раскладки
; =1 or 2 ... 8 (LAYOUT_LIST_1 or LAYOUT_LIST_2...LAYOUT_LIST_8)  switching from an alternative list of layouts =ru= переключение из альтернативного списка раскладок
LS_RCtrlOption := ""
IniRead, var, %LS_SETTINGSINI%, RCTRL_OPTIONS, RCtrlOption
if( var <> "ERROR" )
{
    LS_RCtrlOption := var
}
else 
{    
    IniWrite, %LS_RCtrlOption%, %LS_SETTINGSINI%, RCTRL_OPTIONS, RCtrlOption
}



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−  
; Ability to change the default behavior of LAlt + Space
; Can only take one of the following values:
; =ru= Возможность изменить стандартное поведение LAlt + Space
; =ru= Может принимать только одно из значений:

; =    - empty or do not change =ru= пустое или не менять
; =AllLayouts - switch all layouts =ru= переключать все раскладки
; =1 or 2 ... 8 (LAYOUT_LIST_1 or LAYOUT_LIST_2...LAYOUT_LIST_8)  switching from an alternative list of layouts =ru= переключение из альтернативного списка раскладок
LS_LAltSpaceOption := "AllLayouts"
IniRead, var, %LS_SETTINGSINI%, LALT_SPACE_OPTIONS, LAltSpaceOption
if( var <> "ERROR" )
{
    LS_LAltSpaceOption := var
}
else 
{    
    IniWrite, %LS_LAltSpaceOption%, %LS_SETTINGSINI%, LALT_SPACE_OPTIONS, LAltSpaceOption
}




; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−− 
; Ability to change the default behavior of RWin (actually it's Launch_App1)
; Can only take one of the following values:
; =ru= Возможность изменить стандартное поведение RWin (в реальности это Launch_App1)
; =ru= Может принимать только одно из значений:

; =Disable - disable =ru=  отключить
; =RWin - like RWin =ru=  как RWin
; =RAlt - like RAlt =ru=  как RAlt
; =RCtrl - like RCtrl =ru=  как RCtrl
LS_RWinReassign := "Disable"
IniRead, var, %LS_SETTINGSINI%, RWIN_OPTIONS, RWinReassign
if( var <> "ERROR" )
{
    LS_RWinReassign := var
}
else 
{    
    IniWrite, %LS_RWinReassign%, %LS_SETTINGSINI%, RWIN_OPTIONS, RWinReassign
}


; =Disable - disable =ru=  отключить
; =AllLayouts - switch all layouts =ru= переключать все раскладки
; =1 or 2 ... 8 (LAYOUT_LIST_1 or LAYOUT_LIST_2...LAYOUT_LIST_8)  switching from an alternative list of layouts =ru= переключение из альтернативного списка раскладок
LS_RWinOption := "Disable"
IniRead, var, %LS_SETTINGSINI%, RWIN_OPTIONS, RWinOption
if( var <> "ERROR" )
{
    LS_RWinOption := var
}
else 
{    
    IniWrite, %LS_RWinOption%, %LS_SETTINGSINI%, RWIN_OPTIONS, RWinOption
}
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−− 
; only for RWinReassign = Disable
; =ru= только для RWinReassign = Disable
; whether Birman Layout is allowed (1-yes, 0-no; only for AllLayouts or 1...8)
; =ru= разрешена ли Раскладка Бирмана (1-да, 0-нет; только для AllLayouts или 1...8)
LS_RWinBirmanLayout := 1
IniRead, var, %LS_SETTINGSINI%, RWIN_OPTIONS, RWinBirmanLayout
if( var <> "ERROR" )
{
    LS_RWinBirmanLayout := var
}
else 
{    
    IniWrite, %LS_RWinBirmanLayout%, %LS_SETTINGSINI%, RWIN_OPTIONS, RWinBirmanLayout
}


LS_RWin_Space:="Disable"
LS_RWin_Shift_Space:="Disable"
IniRead, var, %LS_SETTINGSINI%, RWIN_OPTIONS, RWin_Space
if( var <> "ERROR" )
    LS_RWin_Space := ToTxtFromIniTxt(var)      
IniRead, var, %LS_SETTINGSINI%, RWIN_OPTIONS, RWin_Shift_Space
if( var <> "ERROR" )
    LS_RWin_Shift_Space := ToTxtFromIniTxt(var) 



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−− 
LS_LAlt13_Enable := 0
LS_LAlt0 := "Disable"
LS_LAlt1 := "Disable"
LS_LAlt2 := "Disable"
LS_LAlt3 := "Disable"
LS_LAlt4 := "Disable"
LS_LAlt5 := "Disable"
LS_LAlt6 := "Disable"
LS_LAlt7 := "Disable"
LS_LAlt8 := "Disable"
LS_LAlt9 := "Disable"
LS_LAlt10 := "Disable"
LS_LAlt11 := "Disable"
LS_LAlt12 := "Disable"
LS_LAlt13 := "Disable"

IniRead, var, %LS_SETTINGSINI%, LALT13, LAlt13_Enable
if( var <> "ERROR" )
    LS_LAlt13_Enable := var
    
if( LS_LAlt13_Enable = 1 )    
{    
    IniRead, var, %LS_SETTINGSINI%, LALT13, LAlt0
    if( var <> "ERROR" )
        LS_LAlt0 := ToTxtFromIniTxt(var)
    IniRead, var, %LS_SETTINGSINI%, LALT13, LAlt1
    if( var <> "ERROR" )
        LS_LAlt1 := ToTxtFromIniTxt(var)
    IniRead, var, %LS_SETTINGSINI%, LALT13, LAlt2
    if( var <> "ERROR" )
        LS_LAlt2 := ToTxtFromIniTxt(var)  
    IniRead, var, %LS_SETTINGSINI%, LALT13, LAlt3
    if( var <> "ERROR" )
        LS_LAlt3 := ToTxtFromIniTxt(var)
    IniRead, var, %LS_SETTINGSINI%, LALT13, LAlt4
    if( var <> "ERROR" )
        LS_LAlt4 := ToTxtFromIniTxt(var)
    IniRead, var, %LS_SETTINGSINI%, LALT13, LAlt5
    if( var <> "ERROR" )
        LS_LAlt5 := ToTxtFromIniTxt(var)
    IniRead, var, %LS_SETTINGSINI%, LALT13, LAlt6
    if( var <> "ERROR" )
        LS_LAlt6 := ToTxtFromIniTxt(var)
    IniRead, var, %LS_SETTINGSINI%, LALT13, LAlt7
    if( var <> "ERROR" )
        LS_LAlt7 := ToTxtFromIniTxt(var)
    IniRead, var, %LS_SETTINGSINI%, LALT13, LAlt8
    if( var <> "ERROR" )
        LS_LAlt8 := ToTxtFromIniTxt(var)
    IniRead, var, %LS_SETTINGSINI%, LALT13, LAlt9
    if( var <> "ERROR" )
        LS_LAlt9 := ToTxtFromIniTxt(var)
    IniRead, var, %LS_SETTINGSINI%, LALT13, LAlt10
    if( var <> "ERROR" )
        LS_LAlt10 := ToTxtFromIniTxt(var)
    IniRead, var, %LS_SETTINGSINI%, LALT13, LAlt11
    if( var <> "ERROR" )
        LS_LAlt11 := ToTxtFromIniTxt(var)
    IniRead, var, %LS_SETTINGSINI%, LALT13, LAlt12
    if( var <> "ERROR" )
        LS_LAlt12 := ToTxtFromIniTxt(var)
    IniRead, var, %LS_SETTINGSINI%, LALT13, LAlt13
    if( var <> "ERROR" )
        LS_LAlt13 := ToTxtFromIniTxt(var)    
}




; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−− 
LS_LAltAdd14_Enable := 0
LS_LAltAdd0 := "Disable"
LS_LAltAdd00 := "Disable"
LS_LAltAdd1 := "Disable"
LS_LAltAdd11 := "Disable"
LS_LAltAdd2 := "Disable"
LS_LAltAdd22 := "Disable"
LS_LAltAdd3 := "Disable"
LS_LAltAdd33 := "Disable"
LS_LAltAdd4 := "Disable"
LS_LAltAdd44 := "Disable"
LS_LAltAdd5 := "Disable"
LS_LAltAdd55 := "Disable"
LS_LAltAdd6 := "Disable"
LS_LAltAdd66 := "Disable"


IniRead, var, %LS_SETTINGSINI%, LALTADD14, LAltAdd14_Enable
if( var <> "ERROR" )
    LS_LAltAdd14_Enable := var
    
if( LS_LAltAdd14_Enable = 1 )    
{    
    IniRead, var, %LS_SETTINGSINI%, LALTADD14, LAltAdd0
    if( var <> "ERROR" )
        LS_LAltAdd0 := ToTxtFromIniTxt(var)
    IniRead, var, %LS_SETTINGSINI%, LALTADD14, LAltAdd00
    if( var <> "ERROR" )
        LS_LAltAdd00 := ToTxtFromIniTxt(var)    
    
    IniRead, var, %LS_SETTINGSINI%, LALTADD14, LAltAdd1
    if( var <> "ERROR" )
        LS_LAltAdd1 := ToTxtFromIniTxt(var)
    IniRead, var, %LS_SETTINGSINI%, LALTADD14, LAltAdd11
    if( var <> "ERROR" )
        LS_LAltAdd11 := ToTxtFromIniTxt(var) 
    
    IniRead, var, %LS_SETTINGSINI%, LALTADD14, LAltAdd2
    if( var <> "ERROR" )
        LS_LAltAdd2 := ToTxtFromIniTxt(var)
    IniRead, var, %LS_SETTINGSINI%, LALTADD14, LAltAdd22
    if( var <> "ERROR" )
        LS_LAltAdd22 := ToTxtFromIniTxt(var) 
    
    IniRead, var, %LS_SETTINGSINI%, LALTADD14, LAltAdd3
    if( var <> "ERROR" )
        LS_LAltAdd3 := ToTxtFromIniTxt(var)
    IniRead, var, %LS_SETTINGSINI%, LALTADD14, LAltAdd33
    if( var <> "ERROR" )
        LS_LAltAdd33 := ToTxtFromIniTxt(var) 
    
    IniRead, var, %LS_SETTINGSINI%, LALTADD14, LAltAdd4
    if( var <> "ERROR" )
        LS_LAltAdd4 := ToTxtFromIniTxt(var)
    IniRead, var, %LS_SETTINGSINI%, LALTADD14, LAltAdd44
    if( var <> "ERROR" )
        LS_LAltAdd44 := ToTxtFromIniTxt(var) 
        
    IniRead, var, %LS_SETTINGSINI%, LALTADD14, LAltAdd5
    if( var <> "ERROR" )
        LS_LAltAdd5 := ToTxtFromIniTxt(var)
    IniRead, var, %LS_SETTINGSINI%, LALTADD14, LAltAdd55
    if( var <> "ERROR" )
        LS_LAltAdd55 := ToTxtFromIniTxt(var) 
        
    IniRead, var, %LS_SETTINGSINI%, LALTADD14, LAltAdd6
    if( var <> "ERROR" )
        LS_LAltAdd6 := ToTxtFromIniTxt(var)
    IniRead, var, %LS_SETTINGSINI%, LALTADD14, LAltAdd66
    if( var <> "ERROR" )
        LS_LAltAdd66 := ToTxtFromIniTxt(var)   
}



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−   
; Ability to change the default behavior of RAlt (actually it's Browser_Stop)
; Can only take one of the following values:
; =ru= Возможность изменить стандартное поведение RAlt (в реальности это Browser_Stop)
; =ru= Может принимать только одно из значений:

; =Disable - disable =ru=  отключить
; =RAlt - like RAlt =ru=  как RAlt
; =RCtrl - like RCtrl =ru=  как RCtrl
LS_RAltReassign := "Disable"
IniRead, var, %LS_SETTINGSINI%, RALT_OPTIONS, RAltReassign
if( var <> "ERROR" )
{
    LS_RAltReassign := var
}
else 
{    
    IniWrite, %LS_RAltReassign%, %LS_SETTINGSINI%, RALT_OPTIONS, RAltReassign
}

; =Disable - disable =ru=  отключить
; =AllLayouts - switch all layouts =ru= переключать все раскладки
; =1 or 2 ... 8 (LAYOUT_LIST_1 or LAYOUT_LIST_2...LAYOUT_LIST_8)  switching from an alternative list of layouts =ru= переключение из альтернативного списка раскладок
LS_RAltOption := 3
IniRead, var, %LS_SETTINGSINI%, RALT_OPTIONS, RAltOption
if( var <> "ERROR" )
{
    LS_RAltOption := var
}
else 
{    
    IniWrite, %LS_RAltOption%, %LS_SETTINGSINI%, RALT_OPTIONS, RAltOption
}

; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−− 
; Are additional functionality extensions allowed? (1-yes, 0-no; only for AllLayouts or 1...8)
; cursor control, mouse control, additional characters ( RAlt+Q (RAlt+Shift+Q) ... )
; =ru= разрешены ли дополнительные расширения функционала? (1-да, 0-нет; только для AllLayouts или 1...8) 
; =ru= управление курсором, управлению мышью, дополнительные символы ( RAlt+Q (RAlt+Shift+Q) ... )
LS_RAltAddCursor := 1
IniRead, var, %LS_SETTINGSINI%, RALT_OPTIONS, RAltAddCursor
if( var <> "ERROR" )
{
    LS_RAltAddCursor := var
}
else 
{    
    IniWrite, %LS_RAltAddCursor%, %LS_SETTINGSINI%, RALT_OPTIONS, RAltAddCursor
}

LS_RAltAddMouse := 1
IniRead, var, %LS_SETTINGSINI%, RALT_OPTIONS, RAltAddMouse
if( var <> "ERROR" )
{
    LS_RAltAddMouse := var
}
else 
{    
    IniWrite, %LS_RAltAddMouse%, %LS_SETTINGSINI%, RALT_OPTIONS, RAltAddMouse
}

LS_RAltAddChars := 1
IniRead, var, %LS_SETTINGSINI%, RALT_OPTIONS, RAltAddChars
if( var <> "ERROR" )
{
    LS_RAltAddChars := var
}
else 
{    
    IniWrite, %LS_RAltAddChars%, %LS_SETTINGSINI%, RALT_OPTIONS, RAltAddChars
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−− 
; hot combinations for RAlt+Q (RAlt+Shift+Q) ... generating text (=Disable - disable)
; =ru= горячие комбинации для RAlt+Q (RAlt+Shift+Q) ... генерирующие текст (=Disable - отключить)
LS_RAlt_Shift_1:="Disable"
LS_RAlt_Shift_2:="Disable"
LS_RAlt_Shift_3:="Disable"
LS_RAlt_Q:="Disable"
LS_RAlt_Shift_Q:="Disable"
LS_RAlt_W:="Disable"
LS_RAlt_Shift_W:="Disable"
LS_RAlt_A:="Disable"
LS_RAlt_Shift_A:="Disable"
LS_RAlt_Z:="Disable"
LS_RAlt_Shift_Z:="Disable"
LS_RAlt_X:="Disable"
LS_RAlt_Shift_X:="Disable"
LS_RAlt_C:="Disable"
LS_RAlt_Shift_C:="Disable"
LS_RAlt_B:="Disable"
LS_RAlt_Shift_B:="Disable"
LS_RAlt_Space:="Disable"
LS_RAlt_Shift_Space:="Disable"

if( LS_RAltAddChars = 1 )
{
    IniRead, var, %LS_SETTINGSINI%, RALT_OPTIONS, RAlt_Shift_1
    if( var <> "ERROR" )
        LS_RAlt_Shift_1 := ToTxtFromIniTxt(var)
    IniRead, var, %LS_SETTINGSINI%, RALT_OPTIONS, RAlt_Shift_2
    if( var <> "ERROR" )
        LS_RAlt_Shift_2 := ToTxtFromIniTxt(var)
    IniRead, var, %LS_SETTINGSINI%, RALT_OPTIONS, RAlt_Shift_3
    if( var <> "ERROR" )
        LS_RAlt_Shift_3 := ToTxtFromIniTxt(var) 
        
    IniRead, var, %LS_SETTINGSINI%, RALT_OPTIONS, RAlt_Q
    if( var <> "ERROR" )
        LS_RAlt_Q := ToTxtFromIniTxt(var)   
    IniRead, var, %LS_SETTINGSINI%, RALT_OPTIONS, RAlt_Shift_Q
    if( var <> "ERROR" )
        LS_RAlt_Shift_Q := ToTxtFromIniTxt(var)    
    
    IniRead, var, %LS_SETTINGSINI%, RALT_OPTIONS, RAlt_W
    if( var <> "ERROR" )
        LS_RAlt_W := ToTxtFromIniTxt(var)   
    IniRead, var, %LS_SETTINGSINI%, RALT_OPTIONS, RAlt_Shift_W
    if( var <> "ERROR" )
        LS_RAlt_Shift_W := ToTxtFromIniTxt(var)    
    
    IniRead, var, %LS_SETTINGSINI%, RALT_OPTIONS, RAlt_A
    if( var <> "ERROR" )
        LS_RAlt_A := ToTxtFromIniTxt(var)   
    IniRead, var, %LS_SETTINGSINI%, RALT_OPTIONS, RAlt_Shift_A
    if( var <> "ERROR" )
        LS_RAlt_Shift_A := ToTxtFromIniTxt(var)    
    
    IniRead, var, %LS_SETTINGSINI%, RALT_OPTIONS, RAlt_Z
    if( var <> "ERROR" )
        LS_RAlt_Z := ToTxtFromIniTxt(var)   
    IniRead, var, %LS_SETTINGSINI%, RALT_OPTIONS, RAlt_Shift_Z
    if( var <> "ERROR" )
        LS_RAlt_Shift_Z := ToTxtFromIniTxt(var)    
    
    IniRead, var, %LS_SETTINGSINI%, RALT_OPTIONS, RAlt_X
    if( var <> "ERROR" )
        LS_RAlt_X := ToTxtFromIniTxt(var)   
    IniRead, var, %LS_SETTINGSINI%, RALT_OPTIONS, RAlt_Shift_X
    if( var <> "ERROR" )
        LS_RAlt_Shift_X := ToTxtFromIniTxt(var)    
    
    IniRead, var, %LS_SETTINGSINI%, RALT_OPTIONS, RAlt_C
    if( var <> "ERROR" )
        LS_RAlt_C := ToTxtFromIniTxt(var)   
    IniRead, var, %LS_SETTINGSINI%, RALT_OPTIONS, RAlt_Shift_C
    if( var <> "ERROR" )
        LS_RAlt_Shift_C := ToTxtFromIniTxt(var)    
    
    IniRead, var, %LS_SETTINGSINI%, RALT_OPTIONS, RAlt_B
    if( var <> "ERROR" )
        LS_RAlt_B := ToTxtFromIniTxt(var)   
    IniRead, var, %LS_SETTINGSINI%, RALT_OPTIONS, RAlt_Shift_B
    if( var <> "ERROR" )
        LS_RAlt_Shift_B := ToTxtFromIniTxt(var)    
        
        
    IniRead, var, %LS_SETTINGSINI%, RALT_OPTIONS, RAlt_Space
    if( var <> "ERROR" )
        LS_RAlt_Space := ToTxtFromIniTxt(var)      
    IniRead, var, %LS_SETTINGSINI%, RALT_OPTIONS, RAlt_Shift_Space
    if( var <> "ERROR" )
        LS_RAlt_Shift_Space := ToTxtFromIniTxt(var)    
}



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−− 
; ADDITIONALLY
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−− 
; Paste text without formatting by Ctrl+Alt+V (1-yes, 0-no)
; =ru= Вставка текста без форматирования по Ctrl+Alt+V  (1-да, 0-нет) 
LS_Ctrl_Alt_V := 1
IniRead, var, %LS_SETTINGSINI%, ADDITIONALLY, Ctrl_Alt_V
if( var <> "ERROR" )
{
    LS_Ctrl_Alt_V := var
}
else 
{    
    IniWrite, %LS_Ctrl_Alt_V%, %LS_SETTINGSINI%, ADDITIONALLY, Ctrl_Alt_V
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−− 
; change case to lower by Alt+Pause (upper Alt+Shift+Pause)
; =ru= изменить регистр на нижний по Alt+Pause (верхний Alt+Shift+Pause)
LS_Alt_Pause := 1
IniRead, var, %LS_SETTINGSINI%, ADDITIONALLY, Alt_Pause
if( var <> "ERROR" )
{
    LS_Alt_Pause := var
}
else 
{    
    IniWrite, %LS_Alt_Pause%, %LS_SETTINGSINI%, ADDITIONALLY, Alt_Pause
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−− 
; translit_1 (highlighted text) (1-yes, 0-no)
; =ru= транслит_1 (выделенный текст) (1-да, 0-нет) 
LS_Alt_ScrollLock := 1
IniRead, var, %LS_SETTINGSINI%, ADDITIONALLY, Alt_ScrollLock
if( var <> "ERROR" )
{
    LS_Alt_ScrollLock := var
}
else 
{    
    IniWrite, %LS_Alt_ScrollLock%, %LS_SETTINGSINI%, ADDITIONALLY, Alt_ScrollLock
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−− 
; translit_2 (highlighted text). Usually into valid filenames (1-yes, 0-no)
; =ru= транслит_2 (выделенный текст). Обычно в допустимые имена файлов (1-да, 0-нет) 
LS_Alt_Shift_ScrollLock := 1
IniRead, var, %LS_SETTINGSINI%, ADDITIONALLY, Alt_Shift_ScrollLock
if( var <> "ERROR" )
{
    LS_Alt_Shift_ScrollLock := var
}
else 
{    
    IniWrite, %LS_Alt_Shift_ScrollLock%, %LS_SETTINGSINI%, ADDITIONALLY, Alt_Shift_ScrollLock
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−− 
; transliteration file from "translit_1" directory
; =ru= файл транслитерации из каталога "translit_1"
LS_FileTranslit_1 := "Cyr_to_Eng.ini"
IniRead, var, %LS_SETTINGSINI%, ADDITIONALLY, FileTranslit_1
if( var <> "ERROR" )
{
    LS_FileTranslit_1 := var
}
else 
{    
    IniWrite, %LS_FileTranslit_1%, %LS_SETTINGSINI%, ADDITIONALLY, FileTranslit_1
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−− 
; transliteration file from "translit_2" directory
; =ru= файл транслитерации из каталога "translit_2"
LS_FileTranslit_2 := "Cyr_to_FileNameEng.ini"
IniRead, var, %LS_SETTINGSINI%, ADDITIONALLY, FileTranslit_2
if( var <> "ERROR" )
{
    LS_FileTranslit_2 := var
}
else 
{    
    IniWrite, %LS_FileTranslit_2%, %LS_SETTINGSINI%, ADDITIONALLY, FileTranslit_2
}



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−− 
; Special transliteration for the Alt_Win_ScrollLock.ini file in the folder "translit_2" (1-yes, 0-no)
; =ru= Специальная транслитерация файла Alt_Win_ScrollLock.ini в папке "translit_2" (1-да, 0-нет)
LS_Alt_Win_ScrollLock := 0
IniRead, var, %LS_SETTINGSINI%, ADDITIONALLY, Alt_Win_ScrollLock
if( var <> "ERROR" )
{
    LS_Alt_Win_ScrollLock := var
}
else 
{    
    IniWrite, %LS_Alt_Win_ScrollLock%, %LS_SETTINGSINI%, ADDITIONALLY, Alt_Win_ScrollLock
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−− 
; Change the layout of already typed text (1-yes, 0-no)
; =ru= Смена раскладки уже набранного текста (1-да, 0-нет)
LS_RAlt_BackSpace := 0
IniRead, var, %LS_SETTINGSINI%, ADDITIONALLY, RAlt_BackSpace
if( var <> "ERROR" )
{
    LS_RAlt_BackSpace := var
}
else 
{    
    IniWrite, %LS_RAlt_BackSpace%, %LS_SETTINGSINI%, ADDITIONALLY, RAlt_BackSpace
}





; ==============================================================================
