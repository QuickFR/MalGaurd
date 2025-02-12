@echo off
chcp 65001

:: ASCII Art Title
echo ====================================
echo ███▄ ▄███▓ ▄▄▄       ██▓      ▄████  ▄▄▄       █    ██  ██▀███  ▓█████▄ 
echo ▓██▒▀█▀ ██▒▒████▄    ▓██▒     ██▒ ▀█▒▒████▄     ██  ▓██▒▓██ ▒ ██▒▒██▀ ██▌
echo ▓██    ▓██░▒██  ▀█▄  ▒██░    ▒██░▄▄▄░▒██  ▀█▄  ▓██  ▒██░▓██ ░▄█ ▒░██   █▌
echo ▒██    ▒██ ░██▄▄▄▄██ ▒██░    ░▓█  ██▓░██▄▄▄▄██ ▓▓█  ░██░▒██▀▀█▄  ░▓█▄   ▌
echo ▒██▒   ░██▒ ▓█   ▓██▒░██████▒░▒▓███▀▒ ▓█   ▓██▒▒▒█████▓ ░██▓ ▒██▒░▒████▓ 
echo ░ ▒░   ░  ░ ▒▒   ▓▒█░░ ▒░▓  ░ ░▒   ▒  ▒▒   ▓▒█░░▒▓▒ ▒ ▒ ░ ▒▓ ░▒▓░ ▒▒▓  ▒ 
echo ░  ░      ░  ▒   ▒▒ ░░ ░ ▒  ░  ░   ░   ▒   ▒▒ ░░░▒░ ░ ░   ░▒ ░ ▒░ ░ ▒  ▒ 
echo ░      ░     ░   ▒     ░ ░   ░ ░   ░   ░   ▒    ░░░ ░ ░   ░░   ░  ░ ░  ░ 
echo        ░         ░  ░    ░  ░      ░       ░  ░   ░        ░        ░    
echo                                                                  ░       
echo ====================================
echo VERSION 1.1.0

:: Set scan directory (Change this if needed)
set "SCAN_DIR=C:\Users\%USERNAME%\Documents"
set "LOG_FILE=C:\Users\%USERNAME%\OneDrive\Desktop\MalwareScanLog.txt"

:: Prompt user to start scan
echo Type "scanstart" to begin scanning:
set /p userInput=
if /i not "%userInput%"=="scanstart" (
    echo Invalid input. Exiting...
    exit /b
)

:: Clear previous log file
if exist "%LOG_FILE%" del "%LOG_FILE%"
echo Malware Scan Log - %DATE% %TIME% > "%LOG_FILE%"
echo Scanning directory: %SCAN_DIR% >> "%LOG_FILE%"

:: Scan for suspicious file types
echo Searching for suspicious files...
for %%x in (exe bat vbs scr cmd js wsf lnk dll txt) do (
    for /r "%SCAN_DIR%" %%f in (*%%x) do (
        echo Checking: %%f
        echo [SUSPICIOUS FILE] %%f >> "%LOG_FILE%"
    )
)

:: Scan for hidden/system files
echo Searching for hidden/system files...
for /r "%SCAN_DIR%" %%f in (*) do (
    echo Checking: %%f
    attrib "%%f" | find "H" >nul && echo [HIDDEN FILE] %%f >> "%LOG_FILE%"
    attrib "%%f" | find "S" >nul && echo [SYSTEM FILE] %%f >> "%LOG_FILE%"
)

:: Scan for suspicious processes
echo Searching for suspicious processes...
for /f "tokens=1*" %%a in ('tasklist') do (
    echo Checking process: %%a
    echo %%a | findstr /i "powershell.exe wscript.exe cmd.exe /c" >nul && echo [SUSPICIOUS PROCESS] %%a >> "%LOG_FILE%"
)

echo Scan complete. Results saved in "%LOG_FILE%".
pause
