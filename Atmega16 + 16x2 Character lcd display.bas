'======================================================================='

' Title: LCD Display Clock * Calendar
' Last Updated :  04.2022
' Author : A.Hossein.Khalilian
' Program code  : BASCOM-AVR 2.0.8.5
' Hardware req. : Atmega16 + 16x2 Character lcd display

'======================================================================='

$regfile = "m16def.dat"
$crystal = 8000000

Config Lcd = 16 * 2
Config Lcdpin = Pin , Db7 = Porta.0 , Db6 = Porta.1 , Db5 = Porta.2 , Db4 = Porta.3 , E = Porta.4 , Rs = Porta.5

Config Debounce = 30
Config Clock = Soft
Config Date = Ymd , Separator = /
Dim T As Byte , D As Byte

T = 0
D = 0
Enable Interrupts
Time$ = "23:59:50"
Date$ = "22/12/31"

Cursor Off
Cls

'-----------------------------------------------------------

Do
Home
Lcd "Time: " ; Time$
Lowerline
Lcd "Date: " ; Date$
Debounce Pinb.0 , 0 , Menu

Repeat:
Loop
End

'-----------------------------------------------------------

Menu:
T = 0
D = 0
Cls
Lcd "1-Time Setting"
Do
Debounce Pinb.0 , 0 , Label1
Debounce Pinb.1 , 0 , Timeset
Loop

''''''''''''''''''''''''''''''

Label1:
Cls
Lcd "2-Date Setting"
Do
Debounce Pinb.0 , 0 , Repeat
Debounce Pinb.1 , 0 , Dateset
Loop

''''''''''''''''''''''''''''''

Timeset:
Cls
Incr T
Lcd "Hour: " ; _hour
Do
Debounce Pinb.1 , 0 , Inctime , Sub
Debounce Pinb.0 , 0 , Label2
Loop

''''''''''''''''''''''''''''''

Label2:
Cls
Incr T
Lcd "Min: " ; _min
Do
Debounce Pinb.1 , 0 , Inctime , Sub
Debounce Pinb.0 , 0 , Label1
Loop

''''''''''''''''''''''''''''''

Dateset:
Cls
Incr D
Lcd "Day: " ; _day
Do
Debounce Pinb.1 , 0 , Incdate , Sub
Debounce Pinb.0 , 0 , Label3
Loop

''''''''''''''''''''''''''''''

Label3:
Cls
Incr D
Lcd "Month: " ; _month
Do
Debounce Pinb.1 , 0 , Incdate , Sub
Debounce Pinb.0 , 0 , Label4
Loop

''''''''''''''''''''''''''''''

Label4:
Cls
Incr D
Lcd "Year: " ; _year
Do
Debounce Pinb.1 , 0 , Incdate , Sub
Debounce Pinb.0 , 0 , Repeat
Loop

''''''''''''''''''''''''''''''

Inctime:
If T = 1 Then
  Incr _hour
  If _hour = 24 Then
     _hour = 0
  End If
  Cls
  Lcd "Hour: " ; _hour
Else
If T = 2 Then
  Incr _min
  If _min = 60 Then
     _min = 0
  End If
  Cls
  Lcd "Min: " ; _min
End If
End If
Return

''''''''''''''''''''''''''''''

Incdate:
If D = 1 Then
  Incr _day
  If _day > 31 Then
    _day = 1
  End If
  Cls
  Lcd "Day: " ; _day
Else
If D = 2 Then
  Incr _month
  If _month > 12 Then
     _month = 1
  End If
  Cls
  Lcd "Month: " ; _month
Else
If D = 3 Then
  Incr _year
  If _year > 100 Then
     _year = 0
  End If
  Cls
  Lcd "Year: " ; _year
End If
End If
End If
Return

'-----------------------------------------------------------