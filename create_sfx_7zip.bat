@echo off
REM Simple script to create SFX using 7-Zip
REM Run this AFTER build_standalone.bat

echo ========================================
echo Creating Single-File Executable with 7-Zip
echo ========================================
echo.

REM Check if standalone package exists
if not exist bin\stock_management.exe (
    echo [ERROR] Please run build_standalone.bat first!
    pause
    exit /b 1
)

REM Find 7-Zip
set SEVENZIP=
if exist "C:\Program Files\7-Zip\7z.exe" (
    set SEVENZIP=C:\Program Files\7-Zip\7z.exe
    set SFXMODULE=C:\Program Files\7-Zip\7z.sfx
) else if exist "C:\Program Files (x86)\7-Zip\7z.exe" (
    set SEVENZIP=C:\Program Files (x86)\7-Zip\7z.exe
    set SFXMODULE=C:\Program Files (x86)\7-Zip\7z.sfx
) else (
    echo [ERROR] 7-Zip not found!
    echo Please install from: https://www.7-zip.org/
    pause
    exit /b 1
)

echo [OK] Found 7-Zip
echo.

REM Create SFX config
echo [1/4] Creating SFX configuration...
(
echo @echo off
echo echo Extracting Stock Management System...
echo "%~dp0"7z.exe x -y "%%~f0" ^> nul 2^>^&1
echo if errorlevel 1 ^(
echo     echo Error: Failed to extract files!
echo     pause
echo     exit /b 1
echo ^)
echo cd /d "%%~dp0"
echo echo Starting application...
echo start "" /wait stock_management.exe
echo exit
) > sfx_config.txt
echo [OK] Config created

REM Create archive
echo [2/4] Creating archive...
"%SEVENZIP%" a -tzip -mx=9 package.zip bin\* >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Failed to create archive!
    del sfx_config.txt 2>nul
    pause
    exit /b 1
)
echo [OK] Archive created

REM Check for SFX module
if not exist "%SFXMODULE%" (
    echo.
    echo [WARN] 7z.sfx module not found!
    echo.
    echo Please copy 7z.sfx from 7-Zip folder to this directory.
    echo Location: %SFXMODULE%
    echo.
    echo Then run this script again.
    echo.
    pause
    exit /b 1
)

REM Combine SFX module + config + archive
echo [3/4] Creating self-extracting executable...
copy /b "%SFXMODULE%" + sfx_config.txt + package.zip StockManagement.exe >nul
if errorlevel 1 (
    echo [ERROR] Failed to create executable!
    pause
    exit /b 1
)
echo [OK] Executable created

REM Cleanup
echo [4/4] Cleaning up...
del sfx_config.txt 2>nul
del package.zip 2>nul
echo [OK] Cleanup done

echo.
echo ========================================
echo [SUCCESS] Single-file executable created!
echo ========================================
echo.
echo File: StockManagement.exe
echo Size: 
for %%A in (StockManagement.exe) do echo   %%~zA bytes
echo.
echo This single .exe file contains everything!
echo You can copy it to any Windows machine and run it.
echo.
echo Test it:
echo   1. Copy StockManagement.exe to another folder
echo   2. Double-click it
echo   3. It should extract and run automatically
echo.
pause
