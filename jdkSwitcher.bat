@echo off
setlocal enabledelayedexpansion
title jdk switcher    -- made by Abe
reg query HKU\S-1-5-20>nul 2>nul||echo please run with administrator.&&pause>nul&&exit
cd /d %~dp0

:begin
cls
set index=0
echo current: %JAVA_HOME%
echo.
echo.                  versionlist
echo +-----+---------------------------------------+
echo.
for /d %%i in (D:\java\jdk\*) do (
	set /a index=!index!+1
	echo   [ !index! ]  %%i
	set JAVA_HOME_!index!=%%i
)
echo.
echo +-----+---------------------------------------+

:select
set index=
set /p index=please choice:
set index=%index: =%

if not defined JAVA_HOME_%index% goto error

wmic ENVIRONMENT where "name='JAVA_HOME' and username='<system>'" set VariableValue="!JAVA_HOME_%index%!"
call refreshEnv

:end
echo press any key to exit.
pause>nul&exit

:error
goto select