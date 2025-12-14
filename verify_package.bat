@echo off
REM Script to verify that the standalone package is complete
REM Run this after building to check if everything is ready for distribution

echo ========================================
echo Verifying Standalone Package
echo ========================================
echo.

set ERRORS=0
set WARNINGS=0

REM Check if .exe exists
if not exist bin\stock_management.exe (
    echo [ERROR] stock_management.exe not found!
    set /a ERRORS+=1
) else (
    echo [OK] stock_management.exe found
)

REM Check for essential DLLs
echo.
echo Checking essential DLLs...
set ESSENTIAL_DLLS=libgtk-3-0.dll libgdk-3-0.dll libglib-2.0-0.dll libgobject-2.0-0.dll libgio-2.0-0.dll libpango-1.0-0.dll libcairo-2.dll

for %%d in (%ESSENTIAL_DLLS%) do (
    if exist bin\%%d (
        echo [OK] %%d found
    ) else (
        echo [ERROR] %%d missing!
        set /a ERRORS+=1
    )
)

REM Count total DLLs
echo.
echo Counting DLL files...
set DLL_COUNT=0
for %%f in (bin\*.dll) do (
    set /a DLL_COUNT+=1
)

if %DLL_COUNT% LSS 15 (
    echo [WARN] Only %DLL_COUNT% DLL files found (expected ~20+)
    set /a WARNINGS+=1
) else (
    echo [OK] Found %DLL_COUNT% DLL files
)

REM Check for share folder
echo.
if exist bin\share (
    echo [OK] share\ folder exists
    
    if exist bin\share\gtk-3.0 (
        echo [OK] share\gtk-3.0\ exists
    ) else (
        echo [WARN] share\gtk-3.0\ missing
        set /a WARNINGS+=1
    )
    
    if exist bin\share\glib-2.0\schemas (
        echo [OK] share\glib-2.0\schemas\ exists
        
        REM Check for compiled schemas
        if exist bin\share\glib-2.0\schemas\gschemas.compiled (
            echo [OK] Schemas are compiled
        ) else (
            echo [WARN] Schemas not compiled (may still work)
            set /a WARNINGS+=1
        )
    ) else (
        echo [WARN] share\glib-2.0\schemas\ missing
        set /a WARNINGS+=1
    )
) else (
    echo [WARN] share\ folder missing
    set /a WARNINGS+=1
)

REM Check for data folder
echo.
if exist bin\data (
    echo [OK] data\ folder exists
) else (
    echo [INFO] data\ folder will be created automatically
)

REM Calculate package size
echo.
echo Package size:
for /f "tokens=3" %%a in ('dir bin /-c ^| find "bytes"') do set SIZE=%%a
echo   Total size: %SIZE% bytes

REM Final summary
echo.
echo ========================================
echo Verification Summary
echo ========================================
echo.

if %ERRORS% EQU 0 (
    echo [SUCCESS] No critical errors found!
    echo.
    if %WARNINGS% EQU 0 (
        echo [PERFECT] Package is complete and ready for distribution!
    ) else (
        echo [WARNING] Package has %WARNINGS% warning(s) but should work
        echo           Consider running bundle_dlls.bat again
    )
    echo.
    echo Package is ready to distribute!
    echo.
    echo Next steps:
    echo   1. Zip the entire 'bin' folder
    echo   2. Test on a clean Windows machine
    echo   3. Distribute the ZIP file
    echo.
) else (
    echo [ERROR] Found %ERRORS% critical error(s)!
    echo.
    echo Package is NOT ready for distribution.
    echo.
    echo Please:
    echo   1. Run build_standalone.bat to rebuild
    echo   2. Or run bundle_dlls.bat if .exe already exists
    echo   3. Run this verification again
    echo.
)

pause
