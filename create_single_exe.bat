@echo off
REM Script to create a SINGLE .exe file that contains everything
REM This creates a self-extracting archive using 7-Zip SFX

echo ========================================
echo Creating Single-File Executable
echo ========================================
echo.

REM Check if standalone package exists
if not exist bin\stock_management.exe (
    echo [ERROR] stock_management.exe not found!
    echo Please run build_standalone.bat first!
    pause
    exit /b 1
)

REM Check if 7-Zip is available
set SEVENZIP=
if exist "C:\Program Files\7-Zip\7z.exe" (
    set SEVENZIP=C:\Program Files\7-Zip\7z.exe
) else if exist "C:\Program Files (x86)\7-Zip\7z.exe" (
    set SEVENZIP=C:\Program Files (x86)\7-Zip\7z.exe
) else (
    echo [ERROR] 7-Zip not found!
    echo.
    echo Please install 7-Zip from: https://www.7-zip.org/
    echo Or use the alternative method (see SINGLE_EXE_GUIDE.md)
    echo.
    pause
    exit /b 1
)

echo [OK] Found 7-Zip at: %SEVENZIP%
echo.

REM Create temporary directory for packaging
set TEMP_DIR=%TEMP%\stock_mgmt_package_%RANDOM%
mkdir "%TEMP_DIR%"

echo [1/4] Copying files to temporary directory...
xcopy /E /I /Y bin\* "%TEMP_DIR%\" >nul
echo [OK] Files copied

echo [2/4] Creating archive...
"%SEVENZIP%" a -tzip "%TEMP_DIR%\package.zip" "%TEMP_DIR%\*" -mx=9 >nul
if errorlevel 1 (
    echo [ERROR] Failed to create archive!
    rmdir /s /q "%TEMP_DIR%"
    pause
    exit /b 1
)
echo [OK] Archive created

echo [3/4] Creating SFX config...
REM Create SFX config file
(
echo @echo off
echo echo Extracting files...
echo "%~dp0"7z.exe x -y "%%~f0" ^> nul
echo if errorlevel 1 ^(
echo     echo Error extracting files!
echo     pause
echo     exit /b 1
echo ^)
echo cd /d "%%~dp0"
echo start "" stock_management.exe
echo exit
) > "%TEMP_DIR%\config.txt"

REM Download 7-Zip SFX module (or use local copy)
echo [4/4] Creating self-extracting executable...
copy /Y "%TEMP_DIR%\package.zip" "StockManagement_Single.exe" >nul

REM Note: We need the 7z.sfx module. Let user know.
echo.
echo ========================================
echo [INFO] Manual Step Required
echo ========================================
echo.
echo To complete the single .exe creation:
echo.
echo Option 1: Use 7-Zip SFX module
echo   1. Copy 7z.sfx from 7-Zip installation to this folder
echo   2. Run: copy /b 7z.sfx + config.txt + package.zip StockManagement_Single.exe
echo.
echo Option 2: Use Enigma Virtual Box (Recommended - see SINGLE_EXE_GUIDE.md)
echo.
echo Option 3: Use WinRAR SFX (if installed)
echo.

REM Cleanup
rmdir /s /q "%TEMP_DIR%"

echo Package files prepared. See SINGLE_EXE_GUIDE.md for complete instructions.
pause
