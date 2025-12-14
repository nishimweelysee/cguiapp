@echo off
REM Script to create a Windows installer .exe
REM This creates a proper installer that installs everything and runs the app

echo ========================================
echo Creating Windows Installer
echo ========================================
echo.

REM Check if standalone package exists
if not exist bin\stock_management.exe (
    echo [ERROR] stock_management.exe not found!
    echo Please run build_standalone.bat first!
    echo.
    pause
    exit /b 1
)

REM Check if Inno Setup is installed
set INNOSETUP=
if exist "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" (
    set INNOSETUP=C:\Program Files (x86)\Inno Setup 6\ISCC.exe
) else if exist "C:\Program Files\Inno Setup 6\ISCC.exe" (
    set INNOSETUP=C:\Program Files\Inno Setup 6\ISCC.exe
) else if exist "C:\Program Files (x86)\Inno Setup 5\ISCC.exe" (
    set INNOSETUP=C:\Program Files (x86)\Inno Setup 5\ISCC.exe
) else (
    echo [ERROR] Inno Setup not found!
    echo.
    echo Please install Inno Setup:
    echo   1. Download from: https://jrsoftware.org/isdl.php
    echo   2. Install it
    echo   3. Run this script again
    echo.
    echo Alternative: Use NSIS or WiX Toolset (see INSTALLER_GUIDE.md)
    echo.
    pause
    exit /b 1
)

echo [OK] Found Inno Setup at: %INNOSETUP%
echo.

REM Create installer directory
if not exist installer mkdir installer

REM Compile installer
echo [1/2] Compiling installer...
"%INNOSETUP%" StockManagement_Installer.iss
if errorlevel 1 (
    echo.
    echo [ERROR] Failed to compile installer!
    echo Check the error messages above.
    pause
    exit /b 1
)

echo.
echo [2/2] Installer created successfully!
echo.

REM Check if installer was created
if exist installer\StockManagement_Installer.exe (
    echo ========================================
    echo [SUCCESS] Installer ready!
    echo ========================================
    echo.
    echo File: installer\StockManagement_Installer.exe
    echo.
    echo This installer will:
    echo   - Install all required DLLs
    echo   - Install the application
    echo   - Create shortcuts
    echo   - Run the app after installation
    echo.
    echo Users just need to:
    echo   1. Double-click StockManagement_Installer.exe
    echo   2. Follow the installation wizard
    echo   3. App will run automatically!
    echo.
) else (
    echo [WARN] Installer file not found in expected location
    echo Check the installer\ folder
)

pause
