@echo off
REM Complete workflow: Build standalone package AND create single .exe
REM This is the MAIN script to run

echo ========================================
echo BUILD SINGLE-FILE EXECUTABLE
echo ========================================
echo.
echo This will:
echo   1. Build the application
echo   2. Bundle all DLLs
echo   3. Create a single .exe file
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
    echo [ERROR] Build failed! Cannot create single .exe
    pause
    exit /b 1
)

REM Step 2: Create single .exe
echo.
echo ========================================
echo STEP 2: Creating Single-File Executable
echo ========================================
echo.

REM Try 7-Zip method first
if exist "C:\Program Files\7-Zip\7z.exe" (
    echo Using 7-Zip method...
    call create_sfx_7zip.bat
    goto :done
) else if exist "C:\Program Files (x86)\7-Zip\7z.exe" (
    echo Using 7-Zip method...
    call create_sfx_7zip.bat
    goto :done
)

REM If 7-Zip not found, use IExpress
echo 7-Zip not found. Using Windows IExpress instead...
echo.
echo ========================================
echo Creating IExpress Package
echo ========================================
echo.
echo Please follow these steps:
echo.
echo 1. Press Win+R
echo 2. Type: iexpress
echo 3. Press Enter
echo 4. Follow the wizard:
echo    - Choose "Create new Self Extraction Directive"
echo    - Add ALL files from 'bin' folder
echo    - Install program: stock_management.exe
echo    - Package name: StockManagement.exe
echo.
echo OR use Enigma Virtual Box (see SINGLE_EXE_GUIDE.md)
echo.
pause
goto :done

:done
echo.
echo ========================================
echo BUILD COMPLETE
echo ========================================
echo.
echo Check for: StockManagement.exe
echo.
echo This single file contains everything!
echo Copy it to any Windows machine and run.
echo.
pause
