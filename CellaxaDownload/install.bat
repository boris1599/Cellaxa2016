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

REM ****************************************
REM ****************************************

cls
call install_banner
cls
echo ******************************************************************
ECHO Registration.
echo *
echo All the requested parameters can be accepted with default values.
echo ******************************************************************
ECHO.

set home_directory=C:\Cellaxa_1.0.0a
SET /P home_directory= "Type Cellaxa system Home Directory or accept [%home_directory%] and press ENTER: "
echo.

set gen_admin_name=cellaxa
SET /P gen_admin_name= "Type Cellaxa General Admin Name or accept [%gen_admin_name%] and press ENTER: "
echo.

set gen_admin_pass=cellaxa
SET /P gen_admin_pass= "Type Cellaxa General Password or accept [%gen_admin_pass%] and press ENTER: "
echo.


set gen_password=SYS


cmd /c "exit /b 0"


IF EXIST %home_directory%\backend\uninstall-postgresql.exe (goto EXISTS)




ECHO.

pause

cls

echo **************************************
echo **************************************
ECHO Step 1. Installing Cellaxa Backend.
echo **************************************
echo **************************************
echo.

set prefix_in="%home_directory%\backend"

set datadir_in="%home_directory%\backend\data"

pause

cls
echo. 
echo *************************************************************************************
echo Gathering Information and Installing. It may take a few minutes. Wait ...
echo *************************************************************************************
echo.

postgresql-9.5.1-1-windows-x64.exe --mode unattended --install_runtimes 0  --disable-stackbuilder 1 --prefix %prefix_in% --datadir %datadir_in% --superpassword "%gen_password%"

cls
echo *********************************************************************************************
echo *********************************************************************************************
echo Cellaxa Backend Installed. Log File: %home_directory%/frontend/logs/metadata_install.txt
echo *********************************************************************************************
echo *********************************************************************************************
pause
cls

echo ****************************************************************
ECHO Step 2. Cellaxa Directories Set Up. Loading Application components
echo ****************************************************************
echo

REM cd\
REM cd %home_directory%

md %home_directory%\frontend
md %home_directory%\frontend\cellaxa_meta_data
md %home_directory%\frontend\bin
md %home_directory%\frontend\java
md %home_directory%\frontend\scripts
md %home_directory%\frontend\SQL
md %home_directory%\frontend\doc
md %home_directory%\frontend\installer
md %home_directory%\frontend\logs
md %home_directory%\frontend\server

REM md frontend
REM cd frontend
REM md cellaxa_meta_data
REM md bin
REM md java
REM md scripts
REM md SQL
REM md doc
REM md installer
REM md logs
REM md server

echo *********************************


REM cd %source%/INSTALLER
 
copy install_script.sql %home_directory%\frontend\scripts

pause

REM cd %home_directory%
cls

REM echo **********************************************
REM ECHO The following is the cellaxa directory tree.
REM echo **********************************************
echo.
pause


cls 

echo *****************************************
echo Step 3. Loading Meta Data. 
echo *
echo You must use General Password (SYS).
echo ***************************************** 
echo.
pause

SET server=localhost
SET database=postgres
SET port=5432
SET username=postgres

TYPE NUL > %home_directory%/frontend/logs/metadata_install.txt"

ECHO ***********************************************   >  %home_directory%/frontend/logs/metadata_install.txt
ECHO    Local Time %ldt% >>  %home_directory%/frontend/logs/metadata_install.txt
ECHO    cellaxa Version 1.0.0 (Alpha) MetaData Installation Into BackEnd  >> %home_directory%/frontend/logs/metadata_install.txt
ECHO ***********************************************   >>  %home_directory%/frontend/logs/metadata_install.txt

%home_directory%/backend/bin/psql.exe -h localhost -U postgres -d postgres -p 5432 -W -q  -f  %home_directory%/frontend/scripts/install_script.sql -a -e -L %home_directory%/frontend/logs/metadata_install.txt"  

echo.

echo.
ECHO ***********************************************   >  %home_directory%/frontend/cellaxa.CONFIG
ECHO    Local Time %ldt% >>  %home_directory%/frontend/cellaxa.CONFIG
ECHO    cellaxa Version 1.0.0 (Alpha) Configuration  >> %home_directory%/frontend/cellaxa.CONFIG
ECHO ***********************************************   >>  %home_directory%/frontend/cellaxa.CONFIG
ECHO REGISTRATION: >>  %home_directory%/frontend/cellaxa.CONFIG
ECHO ***  >>  %home_directory%/frontend/cellaxa.CONFIG
ECHO FIRST_NAME=%f_name% >>  %home_directory%/frontend/cellaxa.CONFIG
ECHO LAST_NAME=%l_name% >>  %home_directory%/frontend/cellaxa.CONFIG
ECHO E_MAIL=%e_mail% >>  %home_directory%/frontend/cellaxa.CONFIG
ECHO GEN_ADMIN_NAME= %gen_admin_name% >>  %home_directory%/frontend/cellaxa.CONFIG
ECHO GEN_PASSWORD=%gen_password% >>  %home_directory%/frontend/cellaxa.CONFIG
ECHO ***   >>  %home_directory%/frontend/cellaxa.CONFIG
ECHO FRONT END:  >>  %home_directory%/frontend/cellaxa.CONFIG
ECHO *** >>  %home_directory%/frontend/cellaxa.CONFIG
ECHO HOME_DIRECTORY= %home_directory% >> %home_directory%/frontend/cellaxa.CONFIG    
echo.
ECHO *** >> %home_directory%/frontend/cellaxa.CONFIG   
ECHO BACK END: >> %home_directory%/frontend/cellaxa.CONFIG   
ECHO *** >> %home_directory%/frontend/cellaxa.CONFIG   
ECHO BACK_END_SYSTEM=PostgreSQL >> %home_directory%/frontend/cellaxa.CONFIG   
echo.
ECHO SERVER=%server% >> %home_directory%/frontend/cellaxa.CONFIG   
echo.
ECHO DATABASE=%database% >> %home_directory%/frontend/cellaxa.CONFIG   
echo.
ECHO PORT=%port% >> %home_directory%/frontend/cellaxa.CONFIG   
echo.
ECHO BACK_END_ADMIN_USER=%username% >> %home_directory%/frontend/cellaxa.CONFIG   
echo.


cls

echo **************************************************************
echo **************************************************************
echo. 
echo  Cellaxa is installed.
echo  Installation Config File: %home_directory%\frontend\cellaxa.CONFIG  
echo.
call timer
echo **************************************************************
echo **************************************************************

pause
exit

:EXISTS
cls
echo.
echo *****************************************************
echo *****************************************************
echo ATTENTION!
echo Cellaxa is installed already.
echo *****************************************************
echo *****************************************************
pause

