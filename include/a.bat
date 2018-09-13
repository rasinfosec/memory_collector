@ECHO OFF 
@TITLE Malware Forensics
@COLOR 1a
SETLOCAL enableextensions enabledelayedexpansion

REM  ################################################
REM  #                                              #
REM  #           This script written by:            #
REM  #               Roy Shoemake                   #
REM  #                                              #
REM  #                                              #
REM  #         Used for Memory Forensics            #
REM  ################################################

ECHO Ensuring the proper working directory
%~d0
cd %~dp0

REM Verify the files exist
SET agent64=.\x64\RamCapture64.exe
SET agent32=.\x86\RamCapture.exe
SET outputdir=.\..\output
SET bitness=%PROCESSOR_ARCHITECTURE%

IF NOT EXIST "%agent64%" GOTO :failed
IF NOT EXIST "%agent32%" GOTO :failed

IF "%1"=="" GOTO :usedefault
SET outputdir=%1

:usedefault
SET agent=%agent32%
IF "%bitness%"=="x86" GOTO :agentset
IF "%bitness%"=="IA64" GOTO :unsupported
SET agent=%agent64%

:agentset
ECHO %agent% %args%
call %agent% %args%
REM After the above runs then we do the following.  
CALL s.bat
GOTO :end

:failed
ECHO.
ECHO.
ECHO Failure Encountered:
ECHO Agent not found.
GOTO :end

:unsupported
ECHO.
ECHO.
ECHO Failure Encountered:
ECHO This Operating System is not supported
GOTO :end

:auditfail
ECHO.
ECHO.
ECHO Failure Encountered
ECHO %errorlevel% return from "%lastcmd%"
IF EXIST "%buildlog%" START notepad "%buildlog%"
GOTO :end

:end

ENDLOCAL
@ECHO on