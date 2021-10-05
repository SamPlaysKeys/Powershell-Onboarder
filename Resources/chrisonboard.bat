@echo off

:Install_Choco
echo Installing Chocolatey Package Manager
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

echo.

:seta
set /p Adobe=Install Adobe Reader? Y/N 
if "%Adobe%" == "Y" GOTO :setb
if "%Adobe%" == "N" GOTO :setb
  echo Invalid
  GOTO :seta
:setb
set /p Teams=Install Microsoft Teams? Y/N 
if "%Teams%" == "Y" GOTO :setc
if "%Teams%" == "N" GOTO :setc
  echo Invalid
  GOTO :setb
:setc
set /p Chrome=Install Google Chrome? Y/N 
if "%Chrome%" == "Y" GOTO :setd
if "%Chrome%" == "N" GOTO :setd
  echo Invalid
  GOTO :setc
:setd
set/p Other=Any others? 

:Adobe
if "%Adobe%" == "N" GOTO :Teams
choco install adobereader -y

:Teams
if "%Teams%" == "N" GOTO :Chrome
choco install microsoft-teams -y

:Chrome
if "%Chrome%" == "N" GOTO :Other
choco install googlechrome -y

:Other
if "%Other%" == "N" GOTO :NEXT
choco install %Other% -y

echo.

:NEXT
endlocal
setlocal
wmic bios get serialnumber
set /p new_name=Rename Workstation: 
powershell Rename-Computer -NewName "%new_name%"
:reboot_yn
set /p reboot_yn=Reboot? Y/N 
if "%reboot_yn%" == "Y" GOTO :reboot
if "%reboot_yn%" == "N" GOTO :end
  echo Invalid
  GOTO :reboot_yn

:reboot
shutdown /r /t 0

:end

