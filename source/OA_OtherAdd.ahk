; ==============================================================================
; OTHER ADD (OA) =ru= ПРОЧЕЕ ДОБАВЛЕНИЕ (OA)
; ==============================================================================
; FileDescription: Other add =ru= Прочее добавление
; FileVersion: 2.0.3.0 2022-01-28 \\ (Major version).(Minor version).(Revision number).(Build number) (year)-(month)-(day)
; Author: kaiu@mail.ru \\ author of code changes 
; ProductName: Keybord_Assistant \\ included in the product
; OriginalFilename: OA_OtherAdd.ahk \\ What file is this code from
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−

; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; Paste text without formatting by Ctrl+Alt+V (1-yes, 0-no)
; =ru= Вставка текста без форматирования по Ctrl+Alt+V  (1-да, 0-нет) 
#if (LS_Ctrl_Alt_V = 1)
$^!sc02F::      
    Critical ; critical section of code =ru= критическая секция кода
    
    ClipSaved := ClipboardAll ; save what is in the buffer =ru= сохраняем, что есть в буфере
    Clipboard = %Clipboard%  ; remove formatting =ru= удаляем форматирование    
    SendInput ^{sc02F} ; v insert =ru= вставляем
    Sleep 200
    Clipboard := ClipSaved ; return to buffer saved =ru= возврат в буфер сохраненного
    ; clear the variable by freeing the memory =ru= очистим переменную освободив память
    ClipSaved = 



    Critical OFF ; disable critical section =ru= отключение критической секции
    Sleep -1 ; Critical definitely worked =ru= Critical точно отработал
Return



#if
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; change case to lower by Alt+Pause (upper Alt+Shift+Pause)
; =ru= изменить регистр на нижний по Alt+Pause (верхний Alt+Shift+Pause)
#if (LS_Alt_Pause = 1)


LAlt & Pause::

	Critical ; critical section of code =ru= критическая секция кода
	
	Clipboard := ""
	if not GetKeyState("Shift")
	{		
        SendInput ^{Insert}        
		ClipWait 2		
		StringLower, ClipBoard , ClipBoard
	}
	else
	{
        
		SendInput {Shift up}^{Insert}
		ClipWait 2
		StringUpper, ClipBoard , ClipBoard
	}  
    
	SendInput {Del}
	Sleep 200
	SendInput ^{sc02F}
	
	Critical OFF ; disable critical section =ru= отключение критической секции
    Sleep -1 ; Critical definitely worked =ru= Critical точно отработал

return

#if
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−





F_Hook_OnKeyDown(InputHook, VK, SC)
{
    global
    Critical
    
    if(StopHook <> 1)
    {
        WinGet, WinIDHOOL,, A
        
        if( (WinIDHOOL <> OLDWinIDHOOL) and (WinIDHOOL<>0) and (OLDWinIDHOOL<>0) )
        {            
            txtHook := ""                
        }
        
        OLDWinIDHOOL := WinIDHOOL         

        {     
        
        
            pLAlt := GetKeyState("LAlt")
            pRAlt := GetKeyState("RAlt")
            pLShift := GetKeyState("LShift")
            pRShift := GetKeyState("RShift")


            
            if( pRAlt )
            {
                if(txtHook="") 
                    txtHook := "{vka5 down}"
                else    
                    txtHook := "{vka5 down};" txtHook
            }
            
            if( pLShift )
            {
                if(txtHook="") 
                    txtHook := "{vka0 down}"
                else    
                    txtHook := "{vka0 down};" txtHook
            }
            
            if( pRShift )
            {
                if(txtHook="") 
                    txtHook := "{vka1 down}"
                else    
                    txtHook := "{vka1 down};" txtHook
            }
            
            


            if( Format("sc{:x}", SC) <> "sc38" )
            {
                if(txtHook="") 
                    txtHook := Format("sc{:x}", SC)
                else    
                    txtHook := Format("sc{:x}", SC) ";" txtHook 
            }
            
            
            
            
            
            
            if( pRAlt )
            {
                if(txtHook="") 
                    txtHook := "{vka5 up}"
                else    
                    txtHook := "{vka5 up};" txtHook
            }
            
            if( pLShift )
            {
                if(txtHook="") 
                    txtHook := "{vka0 up}"
                else    
                    txtHook := "{vka0 up};" txtHook
            }
            
            if( pRShift )
            {
                if(txtHook="") 
                    txtHook := "{vka1 up}"
                else    
                    txtHook := "{vka1 up};" txtHook
            }
            
            
        }
    }      
return
}



F_Hook_OnEnd(InputHook)
{
    global
    Critical
    txtHook := ""
    txtHookSC := ""
    InputHook.Start()
return    
}


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; Change the layout of already typed text (1-yes, 0-no)
; =ru= Смена раскладки уже набранного текста (1-да, 0-нет)
#if (LS_RAlt_BackSpace = 1)
vkA9 & Backspace:: 
    Critical
        
    WinGet, WinIDHOOL,, A
        
    if( (WinIDHOOL <> OLDWinIDHOOL) and (WinIDHOOL<>0) and (OLDWinIDHOOL<>0) )
    {            
        txtHook := ""  
        OLDWinIDHOOL := WinIDHOOL
        return
    }
    
    OLDWinIDHOOL := WinIDHOOL
        
    VtxtHook := txtHook

    
    if( (Trim(ih.Input) <> "") and ( Trim(txtHook) <> "" ) )
    {
        ih.Stop()        
        StopHook := 1
        
        ; save what is in the buffer =ru= сохраняем, что есть в буфере
        ClipSaved := ClipboardAll
                
        lenCl := 0                  
        Loop
        {
            SetKeyDelay -1
            ;SendInput {LShift Down}{Left Down}{Left Up}{LShift Up} ; select =ru= выделяем  
            ; select the last word =ru= выделяем последнее слово
            SendEvent {LCtrl Down}{LShift Down}{Left Down}{Left Up}{LShift Up}{LCtrl Up}
            SendEvent {LShift Down}{Left Down}{Left Up}{LShift Up}
            Sleep 8
            SendEvent {LCtrl Down}{sc2e Down}{sc2e Up}{LCtrl Up} ; copy to clipboard =ru= копируем в буфер  
            Sleep 8
            
            if (Clipboard = "" )
            {
                break
            }
            
                            
            sm := SubStr(Clipboard, 1, 1) 
            ; if a space or newline is found =ru= если обнаружен пробел или перевод строки
            if( ((sm=" ") and Trim(Clipboard) <> "") or (sm="`r") or or (sm="`n") )
            {
                ; do not select this symbol =ru= не выделяем этот символ 
                ;SendInput {LShift Down}{Right Down}{Right Up}{LShift Up} 
                SendEvent {LShift Down}{Right Down}{Right Up}{LShift Up}
                break
            }
            
            lenCl := lenCl + 1
            
            if (lenCl > 80)
                break

        }
        
        Sleep 10
        Send {Backspace Down}{Backspace Up}            
                        
        
           
        Clipboard = ; clear the buffer =ru= очистим буфер
        
        km := ""
        noSp := 0
        sce := 0
        spK := StrSplit(VtxtHook, ";")        
       
        ; MsgBox,,, %VtxtHook%
       
       
        count_vka4down := 0
        count_vka4up := 0
        oldvka4updown := -1
       
        for index, value in spK
        {
            
            if( StrLen(value) > 0 )   
            {
                if( (value = "{vka4 down}") and (oldvka4updown <> 0) )
                {
                    count_vka4down := count_vka4down + 1 
                    oldvka4updown := 0
                }
                
                if( (value = "{vka4 up}") and (oldvka4updown <> 1) )
                {
                    count_vka4up := count_vka4up + 1
                    oldvka4updown := 1
                }   
                
                if( SubStr(value, 1, 1) <> "{" )
                {
                
                    if( value="sce" )
                    {
                        sce := sce + 1
                        continue
                    }
                    else
                    {
                        if(sce > 0)
                        {
                            sce := sce - 1
                            continue
                        }
                    }
                    
                    if(noSp=1 and (value="sc39" or value="scf") ) 
                        break
                        
                    if( noSp=0 and value<>"sc39" and value<>"scf" and value<>"sc1d" and value<>"sce0" and value<>"sc38" and value<>"sc36" and value<>"sc2a" )
                        noSp := 1
                
                
                    if(km = "")
                        km := "{" value " down}" "{" value " up}"
                    else
                        km := "{" value " down}" "{" value " up}" km
                }
                else
                {
                    if(km = "")
                        km := value
                    else
                        km := value km                
                }
            }
            
            

        }
        
               
        ; Sleep 20
        
        if( count_vka4down > 0 )      
        {
            if( count_vka4down <> count_vka4up ) 
            {                
                if( oldvka4updown = 0 )
                {
                    km := km "{vka4 up}"
                    count_vka4up := count_vka4up + 1
                }    
                else
                {
                    km := km "{vka4 down}"  
                    count_vka4down := count_vka4down + 1
                }
            }
     
                
            if( Mod(count_vka4down, 2) <> 0 )
                km := km "{vka4 down}{vka4 up}"  
        }
        
        
        ; MsgBox,,, %km%
        
        StopHook := 0
        ih.Start()
                
        ; Sleep 20
        
        SetKeyDelay -1
        ;SendInput %km%
        SendEvent %km%
                
        Sleep 20
        
        
        
        Clipboard := ClipSaved ; return to buffer saved =ru= возврат в буфер сохраненного
        ; clear the variable by freeing the memory =ru= очистим переменную освободив память
        ClipSaved =
        
        
       
        Sleep 150 ; not to use often =ru= чтоб не часто пользовались   
    
    }
    
    
        
return


#if
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; translit_1 (highlighted text) (1-yes, 0-no)
; =ru= транслит_1 (выделенный текст) (1-да, 0-нет) 
#if (LS_Alt_ScrollLock = 1)

!sc046::	
    
	Critical ; критическая секция кода
	
	Clipboard := ""
    
    
    SendInput ^{Insert}
    ClipWait 2
    fileN := A_WorkingDir "\translit_1\" LS_FileTranslit_1
    Clipboard := StringReplaceParrIni( Clipboard, fileN )
    SendInput {Del}
	Sleep 200
	SendInput ^{sc02F}
    
	Critical OFF ; отключение критической секции
	Sleep -1 ; Critical точно отработал
	
return
#if
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; translit_2 (highlighted text). Usually into valid filenames (1-yes, 0-no)
; =ru= транслит_2 (выделенный текст). Обычно в допустимые имена файлов (1-да, 0-нет) 
#if (LS_Alt_Shift_ScrollLock = 1)

+!sc046::	
    
	Critical ; критическая секция кода
	
	Clipboard := ""
    
    
    SendInput ^{Insert}
    ClipWait 2
    fileN := A_WorkingDir "\translit_2\" LS_FileTranslit_2
    Clipboard := StringReplaceParrIni( Clipboard, fileN )
    SendInput {Del}
	Sleep 200
	SendInput ^{sc02F}
    
	Critical OFF ; отключение критической секции
	Sleep -1 ; Critical точно отработал
	
return
#if
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−


; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; Special transliteration for the Alt_Win_ScrollLock.ini file in the folder "translit_2" (1-yes, 0-no)
; Initially, this file implements the translation of the Moldovan Cyrillic alphabet into the Romanian Latin alphabet
; But you can change to your preference.
; =ru= Специальная транслитерация файла Alt_Win_ScrollLock.ini в папке "translit_2" (1-да, 0-нет)
; =ru= Изначально этот файл реализует перевод молдавской кириллицы в румынскую латиницу.
; =ru= Но вы можете изменить на своё усмотрение.
#if (LS_Alt_Win_ScrollLock = 1)

!#sc046::	
    
	Critical ; критическая секция кода
	
	Clipboard := ""
    
    
    Send ^{Insert}
    ClipWait 2
    fileN := A_WorkingDir "\translit_2\Alt_Win_ScrollLock.ini"
    Clipboard := StringReplaceParrIni( Clipboard, fileN )
    Send {Del}
	Sleep 200
	Send ^{sc02F}
    
	Critical OFF ; отключение критической секции
	Sleep -1 ; Critical точно отработал
	
return
#if
; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−



; −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
; replacement in the text according to the parameters from the INI file
; =ru= замена в тексте согласно параметров из INI файла
StringReplaceParrIni(x, fileINI)
{
    IniRead, var, %fileINI%, STRINGREPLACE
    if( (var <> "ERROR") and (var <> "") )
    {    
        var := StrSplit(var, "`n")
        Loop, % var.Count()
        {
            valN := var[A_Index]
            valN := ToTxtFromIniTxt(valN)
            valMas := StrSplit(valN, ", ")
            cntM := valMas.Count()
            cmd := valMas[1]
            p1 := valMas[2]
            p2 := valMas[3]
            if(cmd="sr")
            {
                if(cntM >= 4)
                {
                    
                    StringReplace, x,x,%p1%,%p2%, All
                }
                else 
                {
                    if(cntM >= 3)
                        StringReplace, x,x,%p1%,%p2%
                }
            } 
            else
            {
                if(cmd="rr")
                {
                    if(cntM >= 3)
                        x := RegExReplace(x, p1, p2) 
                }
                else
                {
                    if(cmd="loopsr")
                    {
                        Loop
                        {
                            StringReplace, x,x,%p1%,%p2%, UseErrorLevel
                            if (ErrorLevel = 0) 
                                break
                        }
                    }                
                }                
            }
        }
    }
    
    return x
}





; ==============================================================================