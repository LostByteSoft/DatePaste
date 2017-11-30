;;--- Head --- Informations --- AHK ---

;;	Compatibility: Windows
;;	All files must be in same folder. Where you want.
;;	64 bit AHK version : 1.1.24.2 64 bit Unicode

;;--- Softwares Var , files , options ---

	#NoEnv
	#SingleInstance Force
	#Persistent
	SetWorkingDir, %A_ScriptDir%

	SetEnv, title, Date Paste
	SetEnv, mode, Press F7 to write actual date and time.
	SetEnv, version, Version 2017-11-23-1439
	SetEnv, Author, LostByteSoft
	Setenv, setvar, 2
	SetEnv, icofolder, C:\Program Files\Common Files
	Setenv, logoicon, ico_datepaste_b.ico
	SetEnv, pause, 0

	FileInstall, ico_datepaste_w.ico, %icofolder%\ico_datepaste_w.ico, 0
	FileInstall, ico_about.ico, %icofolder%\ico_about.ico, 0
	FileInstall, ico_lock.ico, %icofolder%\ico_lock.ico, 0
	FileInstall, ico_shut.ico, %icofolder%\ico_shut.ico, 0
	FileInstall, ico_HotKeys.ico, %icofolder%\ico_HotKeys.ico, 0
	FileInstall, ico_options.ico, %icofolder%\ico_options.ico, 0
	FileInstall, ico_datepaste_b.ico, %icofolder%\ico_datepaste_b.ico, 0
	FileInstall, ico_clipboard.ico, %icofolder%\ico_clipboard.ico, 0
	FileInstall, ico_time.ico, %icofolder%\ico_time.ico, 0
	FileInstall, ico_pause.ico, %icofolder%\ico_pause.ico, 0
	FileInstall, ico_reboot.ico, %icofolder%\ico_reboot.ico, 0
	FileInstall, ico_debug.ico, %icofolder%\ico_debug.ico, 0

	Menu, Tray, NoStandard
	Menu, tray, add, ---=== %title% ===---, about
	Menu, Tray, Icon, ---=== %title% ===---, %icofolder%\%logoicon%
	Menu, tray, add, Show logo, GuiLogo
	Menu, tray, add, Secret MsgBox, secret					; Secret MsgBox, just show all options and variables of the program
	Menu, Tray, Icon, Secret MsgBox, %icofolder%\ico_lock.ico
	Menu, tray, add, About && ReadMe, author
	Menu, Tray, Icon, About && ReadMe, %icofolder%\ico_about.ico
	Menu, tray, add, Author %author%, about
	menu, tray, disable, Author %author%
	Menu, tray, add, %version%, about
	menu, tray, disable, %version%
	Menu, tray, add,
	Menu, tray, add, --= Control =--, about
	Menu, Tray, Icon, --= Control =--, %icofolder%\ico_options.ico
	Menu, tray, add, Exit %title%, Close				; Close exit program
	Menu, Tray, Icon, Exit %title%, %icofolder%\ico_shut.ico
	Menu, tray, add, Refresh (ini mod), doReload 		; Reload the script.
	Menu, Tray, Icon, Refresh (ini mod), %icofolder%\ico_reboot.ico
	Menu, tray, add, Set Debug (Toggle), debug
	Menu, Tray, Icon, Set Debug (Toggle), %icofolder%\ico_debug.ico
	Menu, tray, add, Pause (Toggle), pause
	Menu, Tray, Icon, Pause (Toggle), %icofolder%\ico_pause.ico
	Menu, tray, add,
	Menu, tray, add, --= Options =--, about
	Menu, Tray, Icon, --= Options =--, %icofolder%\ico_options.ico
	Menu, tray, add, Set default value., msgbox2
	Menu, Tray, Icon, Set default value., %icofolder%\ico_options.ico
	Menu, tray, add, Send 'Date && Time' to clip, timedate2
	Menu, Tray, Icon, Send 'Date && Time' to clip, %icofolder%\ico_clipboard.ico, 1
	Menu, tray, add, Send 'Date' to clip, date
	Menu, Tray, Icon, Send 'Date' to clip, %icofolder%\ico_clipboard.ico, 1
	Menu, tray, add, Hotkey: F7 (Default), date2
	Menu, Tray, Icon, Hotkey: F7 (Default), %icofolder%\ico_HotKeys.ico, 1
	Menu, tray, add,
	Menu, Tray, Tip, %title% : Press F7

;;--- Software start here ---

	Menu, Tray, Icon, %icofolder%\ico_datepaste_w.ico

loop:
start:
	sleep, 500
	KeyWait, F7 , D
	Ifequal, setvar, 1, Goto, date
	Ifequal, setvar, 2, Goto, timedate
	Goto, date

timedate:
	;;; t_TimeFormat := "yyyy-MM-dd-HH-mm-ss"
	t_TimeFormat := "yyyy-MM-dd-HHmm"
	FormatTime t_NowTime, , %t_TimeFormat%  			; Empty time = A_Now
	clipboard = %t_NowTime%
	;TrayTip, %title%, Sending to 'clipboard' %t_NowTime%, 2, 1
	Send, %t_NowTime%
	goto, start

date:
	t_TimeFormat := "yyyy-MM-dd"
	FormatTime t_NowTime, , %t_TimeFormat%  			; Empty time = A_Now
	clipboard = %t_NowTime%
	;TrayTip, %title%, Sending to 'clipboard' %t_NowTime%, 2, 1
	Send, %t_NowTime%
	goto, start

timedate2:
	;;; t_TimeFormat := "yyyy-MM-dd-HH-mm-ss"
	t_TimeFormat := "yyyy-MM-dd-HHmm"
	FormatTime t_NowTime, , %t_TimeFormat%  			; Empty time = A_Now
	clipboard = %t_NowTime%
	TrayTip, %title%, Sending to 'clipboard' %t_NowTime%, 2, 1
	;Send, %t_NowTime%
	goto, start

date2:
	t_TimeFormat := "yyyy-MM-dd"
	FormatTime t_NowTime, , %t_TimeFormat%  			; Empty time = A_Now
	clipboard = %t_NowTime%
	TrayTip, %title%, Sending to 'clipboard' %t_NowTime%, 2, 1
	;Send, %t_NowTime%
	goto, start

msgbox:
	;;; t_TimeFormat1 := "yyyy-MM-dd-HH-mm-ss"
	t_TimeFormat1 := "yyyy-MM-dd-HHmm"
	FormatTime t_NowTime1, , %t_TimeFormat1%  			; Empty time = A_Now
	t_TimeFormat2 := "yyyy-MM-dd"
	FormatTime t_NowTime2, , %t_TimeFormat2%  			; Empty time = A_Now
	msgbox, 0, %title% %mode%, Press F7 to paste actual date and time.: " %t_NowTime1% ".`n`nPress F7 to paste actual date.: " %t_NowTime2% ".
	goto, start

msgbox2:
	;;; t_TimeFormat1 := "yyyy-MM-dd-HH-mm-ss"
	t_TimeFormat1 := "yyyy-MM-dd-HHmm"
	FormatTime t_NowTime1, , %t_TimeFormat1%			; Empty time = A_Now
	t_TimeFormat2 := "yyyy-MM-dd"
	FormatTime t_NowTime2, , %t_TimeFormat2%			; Empty time = A_Now
	Ifequal, setvar, 1, setenv, setvar1, Date and Time : %t_NowTime1%
	Ifequal, setvar, 2, setenv, setvar1, Date : %t_NowTime2%
	Gui, Add, Text, x5 y5 w400 h98 , Press 'Set_Date_and_Time' to paste actual date and time.: " %t_NowTime1% ".`n`nPress 'Set_Date' to paste actual time.: " %t_NowTime2% ".`n`nAt start default is DateTime.
	Gui, Add, Button, x60 y130 w110 h50 , Set_Date_and_Time
	Gui, Add, Button, x250 y130 w110 h50 , Set_Date
	Gui, Show, x1095 y420 h200 w425, %title% %mode%
	Return

	ButtonSet_Date_and_Time:
		Gui, destroy
		Setenv, setvar, 2
		goto, start

	ButtonSet_Date:
		Gui, destroy
		Setenv, setvar, 1
		goto, start

Debug:
	IfEqual, debug, 0, goto, enable
	IfEqual, debug, 1, goto, disable
	enable:
	SetEnv, debug, 1
	Goto, loop
	disable:
	SetEnv, debug, 0
	Goto, loop

pause:
	Ifequal, pause, 0, goto, paused
	Ifequal, pause, 1, goto, unpaused

	paused:
	Menu, Tray, Icon, %icofolder%\ico_pause.ico
	SetEnv, pause, 1
	goto, loop

	unpaused:	
	Menu, Tray, Icon, %icofolder%\ico_time_w.ico
	SetEnv, pause, 0
	Goto, loop

;;--- Quit (escape , esc)

GuiClose:
	Gui, destroy
	goto, start

GuiClose2:
Close:
	ExitApp

; Escape::		; Debug purpose
	ExitApp

doReload:
	Reload
	sleep, 100
	goto, Close

;;--- Tray Bar (must be at end of file) ---

about:
about1:
about2:
about3:
	TrayTip, %title%, %mode% by %Author%, 2, 2
	Return

author:
	MsgBox, 64, %title%, %title% %mode% %version% %author%. This software is usefull for paste date anywhere with a shortkey.`n`n`tGo to https://github.com/LostByteSoft
	Return

secret:
	msgbox, 49, %title%, title=%title% mode=%mode% version=%version% author=%author% logoicon=%logoicon% A_ScriptDir=%A_ScriptDir%`n`nsetvar=%setvar%
	Return

Version:
	TrayTip, %title%, %version%, 2, 2
	Return

GuiLogo:
	Gui, 4:Add, Picture, x25 y25 w400 h400, %icofolder%\%logoicon%
	Gui, 4:Show, w450 h450, %title% Logo
	;;Gui, 4:Color, 000000
	Sleep, 500
	Return

	4GuiClose:
	Gui 4:Cancel
	return

;;--- End of script ---
;
;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;   Version 3.14159265358979323846264338327950288419716939937510582
;                          March 2017
;
; Everyone is permitted to copy and distribute verbatim or modified
; copies of this license document, and changing it is allowed as long
; as the name is changed.
;
;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
;
;              You just DO WHAT THE FUCK YOU WANT TO.
;
;		     NO FUCKING WARRANTY AT ALL
;
;      The warranty is not included. Look carefully you
;             might miss all theses small characters.
;
;	As is customary and in compliance with current global and
;	interplanetary regulations, the author of these pages disclaims
;	all liability for the consequences of the advice given here,
;	in particular in the event of partial or total destruction of
;	the material, Loss of rights to the manufacturer's warranty,
;	electrocution, drowning, divorce, civil war, the effects of
;	radiation due to atomic fission, unexpected tax recalls or
;	    encounters with extraterrestrial beings 'elsewhere.
;
;              LostByteSoft no copyright or copyleft.
;
;	If you are unhappy with this software i do not care.
;
;;--- End of file ---  