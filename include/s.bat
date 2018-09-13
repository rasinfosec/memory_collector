@ECHO OFF 
@TITLE Malware Forensics
@COLOR 1a
SETLOCAL

REM  ################################################
REM  #                                              #
REM  #           This script written by:            #
REM  #               Roy Shoemake                   #
REM  #                                              #
REM  #                                              #
REM  #         Used for Memory Forensics            #
REM  ################################################

REM Used for the dates
%date:~-4,4%
%date:~-7,2% 
%date:~-10,2%
REM This will look for the saved .mem file for the hash function
SET check1=.\x64\%date:~-4,4%%date:~-10,2%%date:~-7,2%.mem
SET check2=.\x86\%date:~-4,4%%date:~-10,2%%date:~-7,2%.mem
SET check3=.\..\output\%date:~-4,4%%date:~-10,2%%date:~-7,2%.mem
SET check4=.\..\analyze\%date:~-4,4%%date:~-10,2%%date:~-7,2%.mem
REM It's the message box
cscript m.vbs "Collecting System Details. Please be Patient and Wait for the Finished Message.  Sorry no status bar"  
echo =============================================================== >> .\..\output\investigation.txt
echo The date and time investigation started - after image acquired: >> .\..\output\investigation.txt
date /t && time /t >> .\..\output\investigation.txt
echo =============================================================== >> .\..\output\investigation.txt
psinfo.exe /AcceptEula >> .\..\output\SystemDetails.txt
logonsessions.exe -p /AcceptEula >> .\..\output\logonsessions.txt
echo =============================================================== >> .\..\output\network.txt
echo Network Connections and Ports: >> .\..\output\network.txt
echo =============================================================== >> .\..\output\network.txt
netstat -abo >> .\..\output\network.txt
echo =============================================================== >> .\..\output\network.txt
echo DNS Queries: >> .\..\output\network.txt
echo =============================================================== >> .\..\output\network.txt
ipconfig /displaydns >> .\..\output\network.txt
echo =============================================================== >> .\..\output\netconnections.txt
echo TCP Connections: >> .\..\output\netconnections.txt
echo =============================================================== >> .\..\output\netconnections.txt
tcpvcon /AcceptEula >> .\..\output\netconnections.txt
tasklist -V >> .\..\output\processinfo.txt
handle /AcceptEula -a >> .\..\output\processinfo_handles.txt
listdlls /AcceptEula >> .\..\output\processinfo_dlls.txt
autorunsc.exe -s /AcceptEula >> .\..\output\ServicesandDrivers.txt
autorunsc.exe -t /AcceptEula >> .\..\output\ScheduledTasks.txt
net share >> .\..\output\Shares.txt
net use >> .\..\output\Shares.txt
autorunsc.exe -f /AcceptEula >> .\..\output\FileHashes.txt
psloglist.exe /AcceptEula >> .\..\output\events.txt

IF EXIST "%check1%" GOTO :check1 
IF EXIST "%check2%" GOTO :check2
IF EXIST "%check3%" GOTO :check3 
IF EXIST "%check4%" GOTO :check4 
IF EXIST "%check5%" GOTO :check5

:check1
echo =============================================================== >> .\..\output\investigation.txt
echo Hash for Memory Dump: >> .\..\output\investigation.txt
hash.exe %check1% >> .\..\output\investigation.txt
move %check1% .\..\analyze
GOTO :hash
:check2
echo =============================================================== >> .\..\output\investigation.txt
echo Hash for Memory Dump: >> .\..\output\investigation.txt
hash.exe %check2% >> .\..\output\investigation.txt
move %check2% .\..\analyze
GOTO :hash
:check3
echo =============================================================== >> .\..\output\investigation.txt
echo Hash for Memory Dump: >> .\..\output\investigation.txt
hash.exe %check3% >> .\..\output\investigation.txt
move %check3% .\..\analyze
GOTO :hash
:check4
echo =============================================================== >> .\..\output\investigation.txt
echo Hash for Memory Dump: >> .\..\output\investigation.txt
hash.exe %check4% >> .\..\output\investigation.txt
GOTO :hash

:hash
echo =============================================================== >> .\..\output\investigation.txt
echo Hash for SystemDetails File: >> .\..\output\investigation.txt
hash.exe .\..\output\SystemDetails.txt >> .\..\output\investigation.txt
echo =============================================================== >> .\..\output\investigation.txt
echo Hash for Logon Sessions File: >> .\..\output\investigation.txt
hash.exe .\..\output\logonsessions.txt >> .\..\output\investigation.txt
echo =============================================================== >> .\..\output\investigation.txt
echo Hash for Network File: >> .\..\output\investigation.txt
hash.exe .\..\output\network.txt >> .\..\output\investigation.txt
echo =============================================================== >> .\..\output\investigation.txt
echo Hash for Process Info File: >> .\..\output\investigation.txt
hash.exe .\..\output\processinfo.txt >> .\..\output\investigation.txt
echo =============================================================== >> .\..\output\investigation.txt
echo Hash for Process Info Handles File: >> .\..\output\investigation.txt
hash.exe .\..\output\processinfo_handles.txt >> .\..\output\investigation.txt
echo =============================================================== >> .\..\output\investigation.txt
echo Hash for Process Info DLLs File: >> .\..\output\investigation.txt
hash.exe .\..\output\processinfo_dlls.txt >> .\..\output\investigation.txt
echo =============================================================== >> .\..\output\investigation.txt
echo Hash for Services and Drivers File: >> .\..\output\investigation.txt
hash.exe .\..\output\ServicesandDrivers.txt >> .\..\output\investigation.txt
echo =============================================================== >> .\..\output\investigation.txt
echo Hash for Scheduled Tasks File: >> .\..\output\investigation.txt
hash.exe .\..\output\ScheduledTasks.txt >> .\..\output\investigation.txt
echo =============================================================== >> .\..\output\investigation.txt
echo Hash for Shares File: >> .\..\output\investigation.txt
hash.exe .\..\output\Shares.txt >> .\..\output\investigation.txt
echo =============================================================== >> .\..\output\investigation.txt
echo Hash for File Hashes File: >> .\..\output\investigation.txt
hash.exe .\..\output\FileHashes.txt >> .\..\output\investigation.txt
echo =============================================================== >> .\..\output\investigation.txt
echo Hash for Events File: >> .\..\output\investigation.txt
hash.exe .\..\output\events.txt >> .\..\output\investigation.txt
echo =============================================================== >> .\..\output\investigation.txt
echo Hash for Network Connections: >> .\..\output\investigation.txt
hash.exe .\..\output\netconnections.txt >> .\..\output\investigation.txt
echo ============================================================== >> .\..\output\investigation.txt
echo The date and time the investigation ended: >> .\..\output\investigation.txt
date /t && time /t >> .\..\output\investigation.txt
cscript m.vbs "Finished Collecting System Data."  