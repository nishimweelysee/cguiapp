@echo off
REM Build script for Windows .exe
REM Run this in MSYS2 MinGW 64-bit terminal

echo ========================================
echo Stock Management System - Windows Build
echo ========================================
echo.

REM Check if pkg-config exists
where pkg-config >nul 2>&1
if errorlevel 1 (
    echo [ERROR] pkg-config not found!
    echo Please install MSYS2 and run: pacman -S mingw-w64-x86_64-pkg-config
    pause
    exit /b 1
)

REM Check if GTK is installed
pkg-config --modversion gtk+-3.0 >nul 2>&1
if errorlevel 1 (
    echo [ERROR] GTK+ 3.0 not found!
    echo Please install: pacman -S mingw-w64-x86_64-gtk3
    pause
    exit /b 1
)

echo [OK] GTK+ 3.0 found: 
pkg-config --modversion gtk+-3.0
echo.

REM Create directories
echo Creating directories...
if not exist bin mkdir bin
if not exist obj mkdir obj
if not exist data mkdir data
echo [OK] Directories created
echo.

REM Compile
echo Compiling source files...
gcc -Wall -Wextra -std=c11 -mwindows ^
    -o bin/stock_management.exe ^
    $(pkg-config --cflags --libs gtk+-3.0) ^
    src/*.c

if errorlevel 1 (
    echo.
    echo [ERROR] Build failed!
    echo Check the error messages above.
    pause
    exit /b 1
)

echo.
echo ========================================
echo [SUCCESS] Build completed!
echo ========================================
echo.
echo Executable: bin\stock_management.exe
echo.
echo To run: bin\stock_management.exe
echo.
pause

