@echo off
title PC Optimization & Startup App Disabler
echo ================================================
echo      PC/Laptop Optimization & Startup Cleanup
echo ================================================
echo This script will:
echo 1. Clear temporary files and cache.
echo 2. Disable unnecessary startup programs.
echo 3. Disable telemetry and tracking.
echo 4. Optimize system performance.
echo 5. Restart Windows Explorer.
echo ================================================
echo WARNING: Some actions require administrator privileges.
echo ================================================
pause

:: ==================================================
:: Step 1: Clear Temporary Files and Cache
:: ==================================================
echo Clearing temporary files and cache...
rd /s /q "%SystemRoot%\Temp" 2>nul
md "%SystemRoot%\Temp" 2>nul
rd /s /q "%TEMP%" 2>nul
md "%TEMP%" 2>nul
echo Temporary files cleared.
echo.

:: ==================================================
:: Step 2: Disable Unnecessary Startup Programs
:: ==================================================
echo Disabling unnecessary startup programs...

:: Remove all startup apps from user registry
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /f 2>nul
:: Remove all startup apps from system registry
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /f 2>nul
:: Remove specific startup services (OneDrive, Teams, etc.)
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f 2>nul
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Microsoft Teams" /f 2>nul
echo Startup programs disabled.
echo.

:: ==================================================
:: Step 3: Disable Background Apps
:: ==================================================
echo Disabling background apps...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d 1 /f 2>nul
echo Background apps disabled.
echo.

:: ==================================================
:: Step 4: Disable Unnecessary Scheduled Tasks
:: ==================================================
echo Disabling unnecessary scheduled startup tasks...
schtasks /change /tn "OneDrive Standalone Update Task-S-1-5-21" /disable 2>nul
schtasks /change /tn "GoogleUpdateTaskMachineCore" /disable 2>nul
schtasks /change /tn "GoogleUpdateTaskMachineUA" /disable 2>nul
echo Startup scheduled tasks disabled.
echo.

:: ==================================================
:: Step 5: Disable Windows Telemetry & Tracking
:: ==================================================
echo Disabling Windows telemetry and tracking...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f 2>nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f 2>nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f 2>nul
echo Windows telemetry disabled.
echo.

:: ==================================================
:: Step 6: Optimize Power Settings
:: ==================================================
echo Optimizing power settings for performance...
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
echo Power settings optimized.
echo.

:: ==================================================
:: Step 7: Restart Windows Explorer
:: ==================================================
echo Restarting Windows Explorer...
taskkill /f /im explorer.exe 2>nul
start explorer.exe
echo Windows Explorer restarted.
echo.

:: ==================================================
:: Completion Message
:: ==================================================
echo ================================================
echo Optimization and startup cleanup completed!
echo ================================================
pause
exit
