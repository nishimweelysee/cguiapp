@echo off
REM Comprehensive verification script for installed application
echo ========================================
echo Stock Management - Installation Verifier
echo ========================================
echo.

set APP_DIR=C:\Program Files\StockManagement
set EXE_PATH=%APP_DIR%\stock_management.exe

echo Checking installation directory: %APP_DIR%
echo.

if not exist "%APP_DIR%" (
    echo [ERROR] Installation directory not found!
    echo Expected: %APP_DIR%
    echo.
    echo Please ensure the application is installed.
    pause
    exit /b 1
)

echo [OK] Installation directory exists
echo.

REM Check executable
if not exist "%EXE_PATH%" (
    echo [ERROR] stock_management.exe not found!
    pause
    exit /b 1
)

echo [OK] Executable found: %EXE_PATH%
echo.

REM Check file size
echo File information:
dir "%EXE_PATH%" | findstr /i "stock_management.exe"
echo.

REM Check PE format (MZ header)
echo Checking PE format...
powershell -Command "$bytes = Get-Content '%EXE_PATH%' -TotalCount 2 -Encoding Byte; $magic = ($bytes[0] -shl 8) -bor $bytes[1]; if ($magic -eq 0x5A4D -or $magic -eq 0x4D5A) { Write-Host '[OK] Valid PE format (MZ header found)' } else { Write-Host '[ERROR] Invalid PE format! Magic: 0x' + ('{0:X4}' -f $magic) }"
echo.

REM Check architecture using PowerShell
echo Checking executable architecture...
powershell -Command "$bytes = [System.IO.File]::ReadAllBytes('%EXE_PATH%'); $peOffset = [BitConverter]::ToInt32($bytes, 0x3C); $machine = [BitConverter]::ToUInt16($bytes, $peOffset + 4); if ($machine -eq 0x8664) { Write-Host '[OK] 64-bit executable (PE32+)' } elseif ($machine -eq 0x014C) { Write-Host '[ERROR] 32-bit executable detected! This will not work on 64-bit Windows.' } else { Write-Host '[WARN] Unknown architecture: 0x' + ('{0:X4}' -f $machine) }"
echo.

REM Count DLLs
echo Checking DLL files...
set DLL_COUNT=0
for %%f in ("%APP_DIR%\*.dll") do set /a DLL_COUNT+=1
echo Found %DLL_COUNT% DLL files

if %DLL_COUNT% LSS 20 (
    echo [WARNING] Expected at least 20 DLLs, found only %DLL_COUNT%
    echo This may cause runtime errors.
) else (
    echo [OK] Sufficient DLLs found
)
echo.

REM Check critical DLLs (including MinGW runtime and Cairo)
echo Checking critical DLLs...
set MISSING=0
for %%d in (
    libgcc_s_dw2-1.dll
    libwinpthread-1.dll
    libgtk-3-0.dll
    libglib-2.0-0.dll
    libgobject-2.0-0.dll
    libgdk-3-0.dll
    libcairo-2.dll
    libcairo-gobject-2.dll
) do (
    if exist "%APP_DIR%\%%d" (
        echo [OK] Found: %%d
    ) else (
        echo [MISSING] %%d
        set /a MISSING+=1
    )
)

if %MISSING% GTR 0 (
    echo.
    echo [ERROR] Missing %MISSING% critical DLL(s)!
    echo The application will not run without these DLLs.
) else (
    echo.
    echo [OK] All critical DLLs present
)
echo.

REM Check GTK data files
echo Checking GTK data files...
if exist "%APP_DIR%\share\gtk-3.0" (
    echo [OK] GTK data files found
) else (
    echo [WARNING] GTK data files not found
    echo Application may have limited functionality
)

if exist "%APP_DIR%\share\glib-2.0\schemas\gschemas.compiled" (
    echo [OK] GLib schemas compiled
) else (
    echo [WARNING] GLib schemas not compiled
)
echo.

REM Try to get detailed error if executable fails
echo ========================================
echo Testing executable load...
echo ========================================
echo.

REM Use PowerShell to try loading the executable and capture any errors
powershell -Command "try { $proc = Start-Process -FilePath '%EXE_PATH%' -PassThru -Wait -NoNewWindow -ErrorAction Stop; Write-Host '[OK] Executable started successfully (exit code: ' + $proc.ExitCode + ')' } catch { Write-Host '[ERROR] Failed to start executable:' ; Write-Host $_.Exception.Message }"
echo.

REM Check Windows Event Viewer for recent errors
echo Checking Windows Event Viewer for recent errors...
powershell -Command "$events = Get-WinEvent -FilterHashtable @{LogName='Application'; Level=2,3; StartTime=(Get-Date).AddMinutes(-5)} -ErrorAction SilentlyContinue | Where-Object {$_.Message -like '*stock_management*' -or $_.Message -like '*StockManagement*'}; if ($events) { Write-Host 'Found recent errors:' ; $events | Select-Object -First 3 | ForEach-Object { Write-Host ('  ' + $_.TimeCreated + ': ' + $_.Message.Substring(0, [Math]::Min(100, $_.Message.Length))) } } else { Write-Host '[OK] No recent errors found in Event Viewer' }"
echo.

echo ========================================
echo Verification Complete
echo ========================================
echo.
echo If you see any errors above, please:
echo 1. Reinstall the application
echo 2. Check that you're running 64-bit Windows
echo 3. Run check_dependencies.bat for more details
echo.
pause
