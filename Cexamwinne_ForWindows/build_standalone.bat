@echo off
REM Complete build script that creates a standalone .exe with bundled DLLs
REM Run this in MSYS2 MinGW 64-bit terminal

echo ========================================
echo Building Standalone Windows .exe
echo ========================================
echo.

REM First, build the .exe
call build_windows.bat
if errorlevel 1 (
    echo.
    echo [ERROR] Build failed! Cannot create standalone package.
    pause
    exit /b 1
)

echo.
echo ========================================
echo Now bundling DLLs...
echo ========================================
echo.

REM Then bundle the DLLs
call bundle_dlls.bat

echo.
echo ========================================
echo [COMPLETE] Standalone package ready!
echo ========================================
echo.
echo Location: bin\stock_management.exe (with DLLs)
echo.
echo This package can run on any Windows machine without
echo installing GTK separately!
echo.
pause
