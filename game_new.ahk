CoordMode, Mouse, Screen, SetTimer, GetCompTime, 80

Is_runing := 0
BreakLoop := 0
Action_1 := 0
Action_Time_1 := 3100
Action_2 := 0
Action_Time_2 := 4100
Action_3 := 0
Action_Time_3 := 3100
Action_4 := 1
Action_Time_4 := 6100
Action_5 := 0
Action_Time_5 := 6100
Action_6 := 0
Action_Time_6 := 3100
Action_7 := 0
Action_Time_7 := 6100
Action_8 := 0
Action_Time_8 := 4500
Action_9 := 0
Action_Time_9 := 300


; ~lbutton::
    ; while getkeystate("lbutton")
    ; {
        ; mousegetpos, x, y
		; pixelgetcolor, color, %x%, %y%
		; b:=(color>>16)
		; g:=(color>>8) & 0xff
		; r:=color & 0xff
		
		; wingetactivestats, title, width, height, startx, starty
		; lifecheckx := round(0.08 * width)
		; lifechecky := round(0.825 * height)
		
		; manacheckx := round(0.9 * width)
		; manachecky := round(0.942 * height)
		
        ; tooltip, %  width " x " height " `n " manacheckx " x " manachecky " `n " x " x " y " `n " color " `nred: " r " `ngreen: " g " `nblue: " b 
        ; sleep, 10
    ; }
    ; tooltip
; return



F1::
	If WinActive("Path of Exile")
	{
		if(Is_runing = 1)
			return
		
		Is_runing := 1
		ButtonSend := 0
		T_up := 1
		
		StartTime_1 := A_TickCount
		StartTime_2 := A_TickCount
		StartTime_3 := A_TickCount
		StartTime_4 := A_TickCount
		StartTime_5 := A_TickCount
		StartTime_6 := A_TickCount
		StartTime_7 := A_TickCount
		StartTime_8 := A_TickCount
		StartTime_9 := A_TickCount

		WinGetActiveStats, Title, Width, Height, startX, startY
		
		LifeCheckX := Round(0.08 * Width)
		LifeCheckY := Round(0.825 * Height)
		
		ManacheckX := round(0.9 * width)
		ManacheckY := round(0.942 * height)
		
		printInfo()
		
		Loop, 
		{
			If WinActive("Path of Exile")
			{
				if (BreakLoop = 1)
				{
					BreakLoop := 0
					break 
				}
				
				autoLife(LifeCheckX,LifeCheckY)
				autoMana(ManacheckX,ManacheckY)
								
				if(Action_1 && A_TickCount - StartTime_1 > Action_Time_1)
				{
					StartTime_1 := A_TickCount
					Send {1 down}{1 up}
				}
				
				if(Action_2 && A_TickCount - StartTime_2 > Action_Time_2)
				{
					StartTime_2 := A_TickCount
					Send {2 down}{2 up}
				}
				
				if(Action_3 && A_TickCount - StartTime_3 > Action_Time_3)
				{
					StartTime_3 := A_TickCount
					Send {3 down}{3 up}
				}
				
				if(Action_4 && A_TickCount - StartTime_4 > Action_Time_4)
				{
					StartTime_4 := A_TickCount
					if(ButtonSend == 0)
					{
						Send {4 down}{4 up}
						ButtonSend := 1
					}
					else
					{
						Send {5 down}{5 up}
						ButtonSend := 0
					}
				} 
				
				if(Action_5 && A_TickCount - StartTime_5 > Action_Time_5)
				{
					StartTime_5 := A_TickCount
					Send {5 down}{5 up}
				}
				
				if(Action_6 && A_TickCount - StartTime_6 > Action_Time_6)
				{
					StartTime_6 := A_TickCount
					Send {w down}{w up}
					sleepTime(50, 55)
				}
				
				if(Action_7 && A_TickCount - StartTime_7 > Action_Time_7)
				{
					StartTime_7 := A_TickCount
					Send {e down}{e up}
					sleepTime(50, 55)
				}
				
				if(Action_8 && A_TickCount - StartTime_8 > Action_Time_8)
				{
					StartTime_8 := A_TickCount
					Send {r down}{r up}
					sleepTime(50, 55)
				}
				
				if(A_TickCount - StartTime_9 > Action_Time_9)
				{
					StartTime_9 := A_TickCount
					if(Action_9 = 1)
					{
						if(T_up = 1)
						{
							Send {t down}
							T_up := 0
						}
					}else
					{
						if(T_up = 0)
						{
							Send {t up}
							T_up := 1
						}
					}
				}
			}
			sleepTime(10, 15)
		}
		
		Is_runing := 0
		if(T_up = 0)
		{
			Send {t up}
			T_up := 1
		}
		ToolTip
	}
	return

F2::
	if(Is_runing = 0)
		return
	BreakLoop := 1
	return

; F3::
	; changeActionStatus(Action_3)
	; return

F4::
	changeActionStatus(Action_4)
	return
	
F5::
	changeActionStatus(Action_5)
	return

F6::
	changeActionStatus(Action_6)
	return
	
F7::
	changeActionStatus(Action_7)
	return
	
F8::
	changeActionStatus(Action_8)
	return
	
F9::
	changeActionStatus(Action_9)
	return
`::
	changeActionStatus(Action_9)
	return
	
F10::
	changeActionStatus(Action_2)
	return

F11::
	changeActionStatus(Action_3)
	return



autoLife(x1, y1)
{
	global Action_2

	PixelGetColor, colorLife, x1, y1
	Life_B:=(colorLife>>16)
	Life_G:=(colorLife>>8) & 0xFF
	Life_R:=colorLife & 0xFF
	if(Life_R > 100 && Life_B < 50 && Life_G < 50)
	{
		if( Action_2 = 1 )
		{
			Action_2 := 0
			printInfo()
		}
	}
	else if(Action_2 = 0)
	{
		if( Action_2 = 0 )
		{
			Action_2 := 1
			printInfo()
		}
	}
	return
}

autoMana(x2, y2)
{
	global Action_3

	PixelGetColor, colorMana, x2, y2
	Mana_B:=(colorMana>>16)
	if( Mana_B > 100)
	{
		if( Action_3 = 1)
		{
			Action_3 := 0
			printInfo()
		}
	}
	else
	{
		if( Action_3 = 0)
		{
			Action_3 := 1
			printInfo()
		}
	}
	return
}

sleepTime(s,e)
{
	Random, time, s, e
	Sleep, time
	return
}

changeActionStatus(ByRef action)
{
	global Is_runing
	if(Is_runing = 0)
		return
	if(action = 0)
		action :=1
	else
		action :=0
	printInfo()
	return
}

printInfo()
{
	global Action_1,Action_2,Action_3,Action_4,Action_5,Action_6,Action_7,Action_8,Action_9
	Msgdt := "F1 - RUN | F2: EXIT "

	
	if(Action_4 = 1)         
		Msgdt = % Msgdt . "| F4 - 4 "
	if(Action_5 = 1)         
		Msgdt = % Msgdt . "| F5 - 5 "
	if(Action_6 = 1)         
		Msgdt = % Msgdt . "| F6 - W "
	if(Action_7 = 1)         
		Msgdt = % Msgdt . "| F7 - E "
	if(Action_8 = 1)         
		Msgdt = % Msgdt . "| F8 - R "
	if(Action_9 = 1)            
		Msgdt = % Msgdt . "| F9 - T "
	; if(Action_1 = 1)         
		; Msgdt = % Msgdt . "| F10 - 1 "
	if(Action_2 = 1)         
		Msgdt = % Msgdt . "| LIFE"	
	if(Action_3 = 1)       
		Msgdt = % Msgdt . "| MANA"
	ToolTip % Msgdt  , 0, 0
	return
}

