@echo off
setlocal enabledelayedexpansion
reg query HKU\S-1-5-20>nul 2>nul||echo please run with administrator.&&pause>nul&&exit
cd /d %~dp0

REM Manually configure the JDK directory (< 10)
set JAVA_HOME_1=D:\java\jdk1.8.0_51
set JAVA_HOME_2=D:\java\zulu10.1+11-jdk10-win_x64
REM ...

:begin
cls
echo.
echo               version list
echo +-----+---------------------------------------+
echo.
for /L %%i in (1, 1, 9) do (
	if defined JAVA_HOME_%%i echo   [ %%i ]  !JAVA_HOME_%%i!
)
echo.
echo +-----+---------------------------------------+

:select
set /p index=please enter:
set index=%index: =%

if not defined JAVA_HOME_%index% goto error

REM wmic ENVIRONMENT where "name='JAVA_HOME'" delete
REM wmic ENVIRONMENT create name="JAVA_HOME",username="<system>",VariableValue="%TARGET_JAVA_HOME%"
wmic ENVIRONMENT where "name='JAVA_HOME' and username='<system>'" set VariableValue="!JAVA_HOME_%index%!"
call refreshEnv
:end
echo press any key to exit.
pause>nul&exit

:error
goto select