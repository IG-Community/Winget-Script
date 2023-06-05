<# : batch script
@echo off
cd /D "%~dp0"
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
setlocal
cd %~dp0
powershell -executionpolicy remotesigned -Command "Invoke-Expression $([System.IO.File]::ReadAllText('%~f0'))" 
endlocal
goto:eof
#>
# here write your powershell commands...
