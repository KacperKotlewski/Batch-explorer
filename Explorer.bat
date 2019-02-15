@echo off
chcp 437
title CHOP_org code:exp v:0.0.7
SETLOCAL EnableDelayedExpansion 
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do     rem"') do (
  set "DEL=%%a"
)
set /a actpx=0
set /a devm=0
set wlig=0
set cd = %cd%


:loop
if %wlig% == 0 goto loopfold
if %wlig% == 1 goto loopfile
set wlig=0
goto loop

:sinfo
cls
echo [help]
echo e - exit
echo r - refresh
echo o - file/folder up
echo p - file/folder down
echo b - in folder view direction back
echo k - in folder view inside folder
echo s - settings
echo c - change file and folder view
echo h - help
echo m - mode
pause>nul
goto loop

:mode
cls
echo [mode]
echo back - to back
echo help - to get help
echo.
:mode2
set /p "prompt=: "
if "%prompt%" == "back" (
	goto loop
) else if "%prompt%" == "help" (
	echo back - to back
	echo sudo dev=[true/false]
	echo.
) else if "%prompt:~0,9%" == "sudo dev=" (
if "%prompt:~9%" == "true" (
		echo dev mode activated
		echo.
		set /a devm=1
	) else (
		echo dev mode deactivated
		echo.
		set /a devm=0
	)
) else (
	echo incorect command: %prompt%
)
goto mode2


:loopfold
for /l %%x in (0,1,50) do (
set "ofc%%x="
)
cls
echo %cd%
set /a x = 0
set /a y = 0
for /f "delims=" %%D in ('dir /b /a:d /o') do (
	set ofc!x!=%%~D
	set /a x=!x!+1
)
set /a maxx=%x%-2
set /a maxy=%x%-1
set /a maxv=%x%-1
if /i %maxv% LEQ 0 set /a maxv=0
if /i %maxv% GEQ 4 set /a maxv=4
goto loopedfold

:loopedfold
for /l %%x in (0,1,%maxv%) do (
set "roz=false"
	set /a y=%%x+%actpx%
	if /i !y! GTR %maxy% set /a y=!y!-%maxy%-1
	call set "aofc=%%ofc!y!%%"
	
	if %devm% == 1 echo !y!
	
	if not "!aofc!" == "" (
		
			if %%x == 0 (
				call :colorEcho 0a "#" & echo. ÜÜ
				call :colorEcho 0a "#" & echo. ÛÛ !aofc!
				call :colorEcho 0a "#" & echo.  ß
				set sofc=!aofc!
			) else (
				echo. ÜÜ
				echo. ÛÛ !aofc!
				echo.  ß
			)
	) else (
		if %%x == 0 (
			call :colorEcho 0a "#" & echo. 
			call :colorEcho 0a "#" & echo. NEW
			call :colorEcho 0a "#" & echo. 
			set cofc=1
		)	else (
			echo. 
			echo. ÞÝ ?EMPTY?
			echo. 
		)			
	)
)

if %devm% == 1 echo maxy=%maxy% maxx=%maxx% maxv=%maxv% actpx=%actpx%

goto menu



:loopfile
for /l %%x in (0,1,50) do (
set "ofc%%x="
)
cls
echo %cd%
set /a x = 0
set /a y = 0
for /f "delims=" %%D in ('dir /b /a-d /o') do (
	set ofc!x!=%%~D
	set /a x=!x!+1
)
set /a maxx=%x%-2
set /a maxy=%x%-1
set /a maxv=%x%-1
if /i %maxv% LEQ 0 set /a maxv=0
if /i %maxv% GEQ 4 set /a maxv=4
goto loopedfile

:loopedfile
for /l %%x in (0,1,%maxv%) do (
set "roz=false"
	set /a y=%%x+%actpx%
	if /i !y! GTR %maxy% set /a y=!y!-%maxy%-1
	call set "aofc=%%ofc!y!%%"
	
	if not "!aofc!" == "" (
		
		
		if %devm% == 1 echo %%x / !y! ok !roz!
		
		if %%x == 0 (
			call :colorEcho 0a "#" & echo. ÜÜ
			call :colorEcho 0a "#" & echo. ÝÞ !aofc!
			call :colorEcho 0a "#" & echo. ßß
			set sofc=!aofc!
		) else (
			echo. ÜÜ
			echo. ÝÞ !aofc!
			echo. ßß
		)
	) else (
		if %%x == 0 (
			call :colorEcho 0a "#" & echo. 
			call :colorEcho 0a "#" & echo. NEW
			call :colorEcho 0a "#" & echo. 
			set cofc=1
		)	else (
			echo. 
			echo. ÞÝ ?EMPTY?
			echo. 
		)			
	)
	
	if %devm% == 1 echo !y!
)

if %devm% == 1 echo maxy=%maxy% maxx=%maxx% maxv=%maxv% actpx=%actpx%

goto menu


:menu
::new menu[
CHOICE /C eropbkschm /n /m "H - show help"
if %ERRORLEVEL% == 1 exit
if %ERRORLEVEL% == 2 goto loop
if %ERRORLEVEL% == 3 set /a actpx=%actpx%-1 & if /I %actpx% LEQ 0 set /a actpx=%maxx%+1
if %ERRORLEVEL% == 4 set /a actpx=%actpx%+1 & if /I %actpx% Geq %maxy% set /a actpx=0
if %ERRORLEVEL% == 5 if %wlig% == 0 (cd.. & set cd = %cd%)
if %ERRORLEVEL% == 6 if %wlig% == 0 (
	set /a actpx=0
	call set got=%%ofc%actpx%%%
	cd "%cd%\!got!"
	set cd = %cd%
) else if %wlig% == 1 (
	call set got=%%ofc%actpx%%%
	start "" "!got!"
)
if %ERRORLEVEL% == 7 echo SETTINGS & pause>nul
if %ERRORLEVEL% == 8 if %wlig% == 0 ( set /a wlig=1 & goto loop ) else if %wlig% == 1 ( set /a wlig=0 & goto loop )
if %ERRORLEVEL% == 9 goto sinfo
if %ERRORLEVEL% == 10 goto mode
goto loop
::]

:: old menu[
set /p "cho=: "
if "%cho%"=="e" exit
if "%cho%"=="r" goto loop
if "%cho%"=="c" echo.>>%ofca:~0,-5%%x%.txt & goto loop
if "%cho:~0,3%"=="del" del %cho:~3% & goto loop
if "%cho%"=="0" cd.. & set cd = %cd% & goto loop
call set got=%%ofc%cho%%%
if "%got:~-4,1%"=="." (
if "%got:~-4%"==".txt" start "" "Notepad.exe" "%got%" & goto loop
if "%got:~-4%"==".bat" start "" "%got%" & goto loop
goto loop
)
cd "%cd%\%got%"
set cd = %cd%
goto loop
pause
::]





::color text
call :colorEcho 0e "Hello "
call :colorEcho 0a " World"
:col
set col = %aofc%
call :colorEcho 0c "%col%"
goto :eof
:colorEcho
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1i
goto :eof