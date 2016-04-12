@echo off
setlocal enabledelayedexpansion
ECHO.

REM *************************************
REM *************************************

:: BatchGotAdmin Request
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

IF NOT EXIST C:\Cellaxa_1.0.0a\backend\uninstall-postgresql.exe (goto NOTEXISTS)

REM ****************************************
REM ****************************************

call Uninstall_banner

cls
echo *********************************************
ECHO Uninstalling Cellaxa frontend.
echo *********************************************

TYPE NUL > C:\Cellaxa_1.0.0a/frontend/logs/metadata_uninstall.txt"

REM C:\Cellaxa_1.0.0a\backend/bin/psql.exe -h localhost -U postgres -d postgres -p 5432 -W   -f  c:REM \Cellaxa_download/INSTALLER/uninstall_script.sql -a -L c:\Cellaxa_1.0.0a/frontend/logs/metadata_uninstall.txt"

cls

Pause

cls
echo.
echo *************************************************************************************************
echo Gathering information and uninstalling backend. It may take a few minutes. Wait...
echo *************************************************************************************************
c:\Cellaxa_1.0.0a\backend\uninstall-postgreSQL.exe --mode unattended

cls
echo **************************************************************************************************
echo Uninstalling Cellaxa Frontend. This process will start in 20 sec. 
echo Backend server cleaning should be completed. Wait for 20 seconds.
echo **************************************************************************************************

timeout /T 20

rd c:\cellaxa_1.0.0a /S /Q

cls

echo *************************************************
echo *************************************************
echo  Cellaxa uninstalled.
call timer
echo *************************************************
echo *************************************************

pause
exit

:NOTEXISTS
cls
echo.
echo ************************************************
echo ************************************************
echo  ATTENTION!
echo  Cellaxa is not installed.
call timer
echo ************************************************
echo ************************************************
pause