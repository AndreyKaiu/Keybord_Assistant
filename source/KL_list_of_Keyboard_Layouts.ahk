; ==============================================================================
; LIST OF KEYBOARD LAYOUTS (KL) =ru= СПИСОК КЛАВИАТУРНЫХ РАСКЛАДОК (KL)
; ==============================================================================
; FileDescription: list of keyboard layouts =ru= список клавиатурных раскладок
; FileVersion: 2.0.3.0 2023-01-28 \\ (Major version).(Minor version).(Revision number).(Build number) (year)-(month)-(day)
; Author: kaiu@mail.ru \\ author of code changes 
; ProductName: Keybord_Assistant \\ included in the product
; OriginalFilename: KL_list_of_Keyboard_Layouts.ahk \\ What file is this code from
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; initialization (required to run at the beginning)
; =ru= инициализация (требуется запустить в начале)
; KL_Count \\ number of layouts =ru= количество раскладок
; KL_HKL%A_Index%, KL_ISO%A_Index%, KL_NAME%A_Index%, KL_SOUND%A_Index%, KL_ILNAME%A_Index%, KL_LNAME%A_Index%  \\ HKL, ISO, NAME, SOUND, INPUT_LNG, LAYOUT_NAME 
; KL_ARLG1%strHKL% \\ get language by HKL =ru= получить язык по HKL
; KL_ARLG2%strHKL% \\ get language by HKL =ru= получить язык по HKL
; KL_ARHKL%LgUp% \\ get HKL by language =ru= получить HKL по языку
; KL_ARSOUND%LgUp% \\ get sound file by language =ru= получить файл звука по языку
; KL_Index%strHKL% \\ get index by HKL =ru= получить индекс по HKL 
KL_InitLNG() 
{
    global
    local HKL, Buf, KLID, NLg, Lg, LgUp, znLgUp, cntr, strHKL, l, s1, s2, idx
    
    KL_Count := DllCall("GetKeyboardLayoutList", UInt, 0, UInt, 0)
    VarSetCapacity(Buf, KL_Count*A_PtrSize)
    DllCall("GetKeyboardLayoutList", UInt, KL_Count, UInt, &Buf)
    
    SetFormat, Integer, H
    Loop, %KL_Count%
    {      
        SetFormat, Integer, D
        A_IndexINT := A_Index 
        SetFormat, Integer, H
        
        HKL := NumGet(Buf, A_PtrSize*(A_IndexINT-1), "Ptr")
        KL_ActivateKeyboardLayout(HKL)
        l := SubStr(HKL & 0xFFFF, 3)
        KLID := SubStr("00000000" l, -8)
        DllCall("GetKeyboardLayoutName", "Str", KLID:="00000000")
        NLg := SubStr(KLID, 1, 4)
        NLg := StrReplace(NLg, "0", "")
        

        if(NLg="") 
            Lg := KL_GetLocaleInfo(0x59, HKL)
        else
            Lg := KL_GetLocaleInfo(0x59, HKL) "_" NLg
        StringUpper, LgUp, Lg        
        
        ; if such a language already exists EN - USA and EN - Great Britain, then add the country
        ; =ru= если такой язык уже есть EN - США и EN - великобритания то добавим и страну
        znLgUp := ""
        znLgUp := KL_ARHKL%LgUp%
        if(znLgUp <> "")
        {
            cntr := KL_GetLocaleInfo(0x5A, HKL)
            StringLower, cntr, cntr 
            LgUp := LgUp "_" cntr
        }
                
        
        KL_ARHKL%LgUp% := KL_FormatHEX8(HKL) ; and knowing the language clearly get only HKL =ru= а зная язык четко получаем только HKL  
        KL_HKL%A_IndexINT% := KL_FormatHEX8(HKL)
        
        
        s1 := KL_GetLocaleInfo(0x59, HKL)
        s2 := KL_GetLocaleInfo(0x5A, HKL)
        KL_ISO%A_IndexINT% := s1 "_" s2
        
        
        strHKL := KL_FormatHEX8(HKL)
        KL_Index%strHKL% := A_IndexINT ; get index by HKL =ru= получить индекс по HKL 
        KL_ARLG1%strHKL% := LgUp ; so that any language can be obtained =ru= чтобы язык по любому можно было получить  
        strHKL := "0x" KLID 
        KL_ARLG2%strHKL% := LgUp ; so that any language can be obtained =ru= чтобы язык по любому можно было получить  
        KL_NAME%A_IndexINT% := LgUp
        
        
        
        SetFormat, Integer, D
        if( (mod(A_IndexINT-1, 17)) < 9) {
            KL_ARSOUND%LgUp% := "0" (1+mod(A_IndexINT-1, 17)) ".wav"
            KL_SOUND%A_IndexINT% := "0" (1+mod(A_IndexINT-1, 17)) ".wav"
        }
        else {
            KL_ARSOUND%LgUp% := (1+mod(A_IndexINT-1, 17)) ".wav"
            KL_SOUND%A_IndexINT% := (1+mod(A_IndexINT-1, 17)) ".wav"
        }
        SetFormat, Integer, H
        
        
        
        KL_ILNAME%A_IndexINT% := KL_GetLocaleInfo(0x2, HKL) 
        KL_LNAME%A_IndexINT% := KL_GetLayoutDisplayName(KLID, 0)
    }
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
KL_ActivateKeyboardLayout(HKL, flags:=0) ; 0x100=KLF_SETFORPROCESS
{
    return DllCall("ActivateKeyboardLayout", "Ptr", HKL, "UInt", flags)
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
KL_GetLocaleInfo(loc, hkl:=0)
{
    Static A_CharSize := A_IsUnicode ? 2 : 1
    hkl := hkl ? hkl : KL_GetHKL(), lcid := hkl & 0x0000FFFF
    if sz := DllCall("GetLocaleInfo"
        , "UInt", lcid
        , "UInt", loc
        , "Ptr", 0
        , "UInt", 0)
        {
            VarSetCapacity(strg, sz*A_CharSize, 0)
            DllCall("GetLocaleInfo"
                , "UInt", lcid
                , "UInt", loc
                , "Str", strg
                , "UInt", sz)
        }
    else
        strg := "Error " A_LastError " LCID: " lcid
    
    return strg
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; format number as 8 HEX characters
; =ru= форматировать число как 8 знаков HEX
KL_FormatHEX8(intX) 
{
    ret := Format("{:08x}", intX)
    
    if(StrLen(ret) = 16)
        ret := SubStr(ret, 9, 8)
        
    if(ret <> "")
        ret := "0x" ret
        
    return "" ret
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
KL_GetHKL(winT:="A")
{
    if winT is integer
        hwnd := winT
    else
        hwnd := WinExist(winT)
    r := DllCall("GetKeyboardLayout"
        , "UInt"    , DllCall("GetWindowThreadProcessId"
            , "Ptr" , hwnd
            , "Ptr" , 0)
        , "UPtr")
        
    return KL_FormatHEX8(r)
}



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
KL_SHLoadIndirectString(in) ; uses WStr for both in and out
{
    VarSetCapacity(out, 2*(sz:=256), 0)
    DllCall("shlwapi\SHLoadIndirectString", "Str", in, "Str", out, "UInt", sz, "Ptr", 0)
    return out
}

; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
KL_GetLayoutDisplayName(subkey, usemui := 1)
{
    Static key := "SYSTEM\CurrentControlSet\Control\Keyboard Layouts"
    RegRead, mui, HKLM, %key%\%subkey%, Layout Display Name
    if (!mui OR !usemui)
        RegRead, Dname, HKLM, %key%\%subkey%, Layout Text
    else
        Dname := KL_SHLoadIndirectString(mui)
    Return Dname
}

; ==============================================================================
