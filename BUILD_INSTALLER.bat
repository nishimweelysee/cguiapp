@echo off
REM Complete workflow: Build standalone package AND create installer
REM This is the MAIN script - run this to create the installer .exe

echo ========================================
echo BUILDING WINDOWS INSTALLER
echo ========================================
echo.
echo This will:
echo   1. Build the application
echo   2. Bundle all DLLs
echo   3. Create Windows installer .exe
echo.
echo Result: StockManagement_Installer.exe
echo         (Users just double-click to install and run!)
echo.
pause

REM Step 1: Build standalone
echo.
echo ========================================
echo STEP 1: Building Standalone Package
echo ========================================
echo.
call build_standalone.bat
if errorlevel 1 (
    echo.
    echo [ERROR] Build failed! Cannot create installer
    pause
    exit /b 1
)

REM Step 2: Create installer
echo.
echo ========================================
echo STEP 2: Creating Windows Installer
echo ========================================
echo.
call create_installer.bat
if errorlevel 1 (
    echo.
    echo [ERROR] Installer creation failed!
    echo.
    echo Please:
    echo   1. Install Inno Setup from: https://jrsoftware.org/isdl.php
    echo   2. Run this script again
    echo.
    echo Or see INSTALLER_GUIDE.md for alternatives
    pause
    exit /b 1
)

echo.
echo ========================================
echo [SUCCESS] Installer Created!
echo ========================================
echo.
echo Your installer is ready:
echo   installer\StockManagement_Installer.exe
echo.
echo This installer will:
echo   - Install all required files
echo   - Create shortcuts
echo   - Run the app automatically
echo.
echo Users just need to:
echo   1. Double-click StockManagement_Installer.exe
echo   2. Click Next through the wizard
echo   3. App installs and runs!
echo.
echo No scripts or .bat files needed! ✅
echo.
pause
