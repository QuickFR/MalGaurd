@echo off
title Custom Malware Detector
color 0A
echo.
echo ============================================
echo        Custom Malware & Spyware Detector
echo ============================================
echo.

:: Ensure the script is running as Administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Please run this script as Administrator!
    pause
    exit
)

:: Automatically detect the Desktop path
for /f "tokens=2 delims=:" %%A in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop') do set DESKTOP=%%A
set LOG_FILE=%DESKTOP%\MalwareScanLog.txt

:: Normalize path (remove quotes if any)
set LOG_FILE=%LOG_FILE:"=%

:: Create or clear the log file
echo Malware Scan Report - %date% %time% > "%LOG_FILE%"
echo ------------------------------------------ >> "%LOG_FILE%"

:: Define scan paths (change this if needed)
set SCAN_DIR=C:\Users\%USERNAME%\Documents

:: 3-second delay before each process
echo Scanning system files for suspicious activity...
timeout /t 3 /nobreak >nul

:: Scan for suspicious file types
echo Searching for suspicious file types...
echo Searching for suspicious file types... >> "%LOG_FILE%"
timeout /t 3 /nobreak >nul
for %%x in (exe bat vbs scr cmd js wsf lnk dll) do (
    echo Checking for *.%%x files...
    dir /s /b "%SCAN_DIR%\*.%%x" >> "%LOG_FILE%"
)

:: Scan for known malicious strings inside files (basic)
echo Searching for known malware patterns...
echo Searching for known malware patterns... >> "%LOG_FILE%"
timeout /t 3 /nobreak >nul
for %%x in (exe bat vbs cmd) do (
    for /r "%SCAN_DIR%" %%f in (*.%%x) do (
        findstr /I /C:"powershell -NoP -NonI -W Hidden" "%%f" >> "%LOG_FILE%"
        findstr /I /C:"cmd.exe /c" "%%f" >> "%LOG_FILE%"
        findstr /I /C:"wscript.exe" "%%f" >> "%LOG_FILE%"
        findstr /I /C:"mshta.exe" "%%f" >> "%LOG_FILE%"
    )
)

:: List hidden and system files
echo Searching for hidden/system files...
echo Searching for hidden/system files... >> "%LOG_FILE%"
timeout /t 3 /nobreak >nul
attrib /s /d /h /s "%SCAN_DIR%" >> "%LOG_FILE%"

:: List running processes (basic check)
echo Checking for suspicious running processes...
echo Checking for suspicious running processes... >> "%LOG_FILE%"
timeout /t 3 /nobreak >nul
tasklist | findstr /I /C:"powershell.exe" /C:"cmd.exe" /C:"wscript.exe" /C:"mshta.exe" >> "%LOG_FILE%"

:: End scan
echo Scan complete. Log saved at: %LOG_FILE%
pause
exit
