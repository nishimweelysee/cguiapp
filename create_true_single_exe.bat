@echo off
REM Script to guide creation of TRUE single-file executable
REM Uses Enigma Virtual Box (best method for invisible extraction)

echo ========================================
echo Creating TRUE Single-File Executable
echo ========================================
echo.
echo This will guide you to create ONE .exe file
echo that users just double-click - nothing else!
echo.
pause

REM Check if standalone package exists
if not exist bin\stock_management.exe (
    echo.
    echo [STEP 1] Building standalone package first...
    call build_standalone.bat
    if errorlevel 1 (
        echo [ERROR] Build failed!
        pause
        exit /b 1
    )
) else (
    echo [OK] Standalone package already exists
)

echo.
echo ========================================
echo [STEP 2] Using Enigma Virtual Box
echo ========================================
echo.
echo To create TRUE single-file executable:
echo.
echo 1. Download Enigma Virtual Box (free):
echo    https://enigmaprotector.com/en/downloads.html
echo.
echo 2. Open Enigma Virtual Box
echo.
echo 3. Configure:
echo    - Enter Virtual Box File Name: StockManagement.exe
echo    - Files: Click "Add" ^> Select ENTIRE "bin" folder
echo    - Executable File: bin\stock_management.exe
echo    - Run Executable: CHECK THIS
echo    - Extract to Temp: CHECK THIS
echo.
echo 4. Click "Process" button
echo.
echo 5. Wait for completion
echo.
echo 6. Result: StockManagement.exe (ONE file!)
echo.
echo ========================================
echo ALTERNATIVE: 7-Zip SFX Method
echo ========================================
echo.
echo If you prefer 7-Zip method (shows brief extraction):
echo.
echo Run: ./create_sfx_7zip.bat
echo.
echo This creates: StockManagement.exe
echo (May show extraction window briefly)
echo.
echo ========================================
echo RESULT
echo ========================================
echo.
echo After using Enigma Virtual Box:
echo   - ONE file: StockManagement.exe
echo   - Users just double-click
echo   - No installation, no setup, nothing!
echo   - App runs automatically
echo.
pause
