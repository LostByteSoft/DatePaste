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
	SetEnv, version, Version 2017-08-06-2142
	SetEnv, Author, LostByteSoft
	Setenv, setvar, 2

	FileInstall, ico_datepaste_w.ico, ico_datepaste_w.ico, 0
	FileInstall, ico_about.ico, ico_about.ico, 0
	FileInstall, ico_lock.ico, ico_lock.ico, 0
	FileInstall, ico_shut.ico, ico_shut.ico, 0
	FileInstall, ico_HotKeys.ico, ico_HotKeys.ico, 0
	FileInstall, ico_options.ico, ico_options.ico, 0
	FileInstall, ico_datepaste_b.ico, ico_datepaste_b.ico, 0
	FileInstall, ico_clipboard.ico, ico_clipboard.ico, 0
	FileInstall, ico_time.ico, ico_time.ico, 0

	Menu, Tray, NoStandard
	Menu, tray, add, --= %title% =--, about3
	Menu, Tray, Icon, --= %title% =--, ico_datepaste_b.ico
	Menu, tray, add
	Menu, tray, add, Exit %title%, GuiClose2
	Menu, Tray, Icon, Exit %title%, ico_shut.ico, 1
	Menu, tray, add, Show logo, GuiLogo
	Menu, tray, add, Secret MsgBox, msgbox
	Menu, Tray, Icon, Secret MsgBox, ico_lock.ico
	Menu, tray, add
	Menu, tray, add, About LostByteSoft, about1 			; Creates a new menu item.
	Menu, Tray, Icon, About LostByteSoft, ico_about.ico, 1
	Menu, tray, add, %Version%, Version 				; Show version
	Menu, Tray, Icon, %Version%, ico_about.ico, 1
	Menu, tray, add
	Menu, tray, add, --= Options =--, about2
	Menu, Tray, Icon, --= Options =--, ico_options.ico
	Menu, tray, add, Set default value., msgbox2
	Menu, Tray, Icon, Set default value., ico_options.ico
	Menu, tray, add
	Menu, tray, add, Send 'Date && Time' to clip, timedate2
	Menu, Tray, Icon, Send 'Date && Time' to clip, ico_clipboard.ico, 1
	Menu, tray, add, Send 'Date' to clip, date
	Menu, Tray, Icon, Send 'Date' to clip, ico_clipboard.ico, 1
	Menu, tray, add
	Menu, tray, add,
	Menu, tray, add, Hotkey: F7 (Default), date2
	Menu, Tray, Icon, Hotkey: F7 (Default), ico_HotKeys.ico, 1
	Menu, Tray, Tip, %title% : Press F7

;;--- Software start here ---

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

;;--- Quit (escape , esc)

GuiClose2:
	ExitApp

GuiClose:
	Gui, destroy
	goto, start

;;--- Tray Bar (must be at end of file) ---

about1:
about2:
about3:
	TrayTip, %title%, %mode% by %Author%, 2, 2
	Return

Version:
	TrayTip, %title%, %version%, 2, 2
	Return

doReload:
	Reload
	Goto, start

GuiLogo:
	Gui, Add, Picture, x25 y25 w400 h400 , ico_datepaste_w.ico
	Gui, Show, w450 h450, %title% Logo
	Gui, Color, 000000
	goto, loop

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