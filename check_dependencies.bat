@echo off
REM Diagnostic script to check for missing DLLs and verify executable
echo ========================================
echo Dependency Checker for stock_management.exe
echo ========================================
echo.

set EXE_PATH=%~dp0stock_management.exe
if not exist "%EXE_PATH%" (
    echo [ERROR] stock_management.exe not found in current directory!
    echo Please run this script from the directory containing stock_management.exe
    pause
    exit /b 1
)

echo [OK] Found executable: %EXE_PATH%
echo.

echo Checking executable architecture...
dumpbin /headers "%EXE_PATH%" 2>nul | findstr /i "machine" || (
    echo [INFO] dumpbin not available, trying alternative method...
    file "%EXE_PATH%" 2>nul || echo [WARN] Could not determine architecture
)
echo.

echo Checking for required DLLs in current directory...
set MISSING_COUNT=0

REM Core GTK DLLs
for %%d in (
    libgtk-3-0.dll
    libgdk-3-0.dll
    libglib-2.0-0.dll
    libgobject-2.0-0.dll
    libgio-2.0-0.dll
    libpango-1.0-0.dll
    libcairo-2.dll
    libgdk_pixbuf-2.0-0.dll
    libatk-1.0-0.dll
    libepoxy-0.dll
) do (
    if exist "%%d" (
        echo [OK] Found: %%d
    ) else (
        echo [MISSING] %%d
        set /a MISSING_COUNT+=1
    )
)

REM System DLLs (should be in Windows)
echo.
echo Checking for system DLLs...
for %%d in (
    msvcrt.dll
    kernel32.dll
    user32.dll
    gdi32.dll
) do (
    where %%d >nul 2>&1
    if errorlevel 1 (
        echo [WARN] System DLL not found: %%d
    ) else (
        echo [OK] System DLL found: %%d
    )
)

echo.
echo ========================================
if %MISSING_COUNT% EQU 0 (
    echo [SUCCESS] All core DLLs found!
) else (
    echo [ERROR] Missing %MISSING_COUNT% DLL(s)!
    echo.
    echo Possible solutions:
    echo 1. Ensure all DLLs are in the same directory as stock_management.exe
    echo 2. Check that the installer copied all files correctly
    echo 3. Re-run the installer or copy DLLs manually
)
echo ========================================
echo.

echo Testing executable with Dependency Walker (if available)...
where depends.exe >nul 2>&1
if not errorlevel 1 (
    echo [INFO] Dependency Walker found. You can use it to check dependencies:
    echo        depends.exe "%EXE_PATH%"
) else (
    echo [INFO] Dependency Walker not found. You can download it from:
    echo        https://www.dependencywalker.com/
)

echo.
echo Checking GTK data files...
if exist "share\gtk-3.0" (
    echo [OK] GTK data files found
) else (
    echo [WARN] GTK data files (share\gtk-3.0) not found
    echo        Application may have limited functionality
)

if exist "share\glib-2.0\schemas" (
    echo [OK] GLib schemas found
    if exist "share\glib-2.0\schemas\gschemas.compiled" (
        echo [OK] Schemas compiled
    ) else (
        echo [WARN] Schemas not compiled - run glib-compile-schemas.exe
    )
) else (
    echo [WARN] GLib schemas not found
)

echo.
pause
