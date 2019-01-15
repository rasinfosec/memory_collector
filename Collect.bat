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

SET elevate=.\include\elevate.cmd
SET audit=.\include\a.bat
SET sys=.\include\s.bat
SET args=%1

IF NOT EXIST "%elevate%" goto :failed
IF NOT EXIST "%audit%" goto :failed
IF NOT EXIST "%sys%" goto :failed

IF NOT EXIST "%output%" mkdir .\output

For /f "tokens=2 delims=[]" %%G in ('ver') Do (set _version=%%G) 
For /f "tokens=2,3,4 delims=. " %%G in ('echo %_version%') Do (set _major=%%G& set _minor=%%H& set _build=%%I) 
Echo Major version: %_major%  Minor Version: %_minor%.%_build%

if "%_major%"=="5" goto sub5
if "%_major%"=="6" goto sub6

Echo unsupported OS version
goto:eof

:sub5
call %audit% %args%
GOTO :end

:sub6
ECHO Requesting elevation
call %elevate% %audit% %args%
GOTO :end

:failed
ECHO.
ECHO.
ECHO Failure Encountered:
ECHO A file was not found.  Please ensure all files are in the toolkit.  
GOTO :end

:end
ENDLOCAL
@ECHO on
