@echo off
REM Script to bundle GTK DLLs with the .exe for standalone distribution
REM Run this AFTER building the .exe

echo ========================================
echo Bundling GTK DLLs for Standalone .exe
echo ========================================
echo.

REM Check if .exe exists
if not exist bin\stock_management.exe (
    echo [ERROR] stock_management.exe not found!
    echo Please build the project first using build_windows.bat
    pause
    exit /b 1
)

REM Find MSYS2 installation (common locations)
set MSYS2_BIN=
if exist C:\msys64\mingw64\bin\libgtk-3-0.dll (
    set MSYS2_BIN=C:\msys64\mingw64\bin
) else if exist C:\msys32\mingw64\bin\libgtk-3-0.dll (
    set MSYS2_BIN=C:\msys32\mingw64\bin
) else (
    echo [ERROR] Could not find MSYS2 GTK installation!
    echo Please specify the path to MSYS2 mingw64\bin directory:
    set /p MSYS2_BIN="Enter path (e.g., C:\msys64\mingw64\bin): "
    if not exist "%MSYS2_BIN%\libgtk-3-0.dll" (
        echo [ERROR] Invalid path or GTK not found!
        pause
        exit /b 1
    )
)

echo [OK] Found GTK at: %MSYS2_BIN%
echo.

REM List of required GTK DLLs (core ones)
set DLLS=libgtk-3-0.dll libgdk-3-0.dll libglib-2.0-0.dll libgobject-2.0-0.dll libgio-2.0-0.dll libpango-1.0-0.dll libcairo-2.dll libpangoft2-1.0-0.dll libpangocairo-1.0-0.dll libgdk_pixbuf-2.0-0.dll libatk-1.0-0.dll libepoxy-0.dll

REM Copy DLLs
echo Copying GTK DLLs...
set COPY_COUNT=0
for %%d in (%DLLS%) do (
    if exist "%MSYS2_BIN%\%%d" (
        copy /Y "%MSYS2_BIN%\%%d" bin\ >nul 2>&1
        if errorlevel 1 (
            echo [WARN] Failed to copy %%d
        ) else (
            echo [OK] Copied %%d
            set /a COPY_COUNT+=1
        )
    ) else (
        echo [WARN] %%d not found, skipping...
    )
)

REM Copy additional dependencies that GTK might need
echo.
echo Copying additional dependencies...
for %%d in (libintl-8.dll libiconv-2.dll libwinpthread-1.dll libffi-8.dll libbz2-1.dll libharfbuzz-0.dll libfreetype-6.dll libfontconfig-1.dll libpng16-16.dll libjpeg-8.dll libtiff-5.dll libpixman-1-0.dll libexpat-1.dll) do (
    if exist "%MSYS2_BIN%\%%d" (
        copy /Y "%MSYS2_BIN%\%%d" bin\ >nul 2>&1
        if errorlevel 1 (
            echo [WARN] Failed to copy %%d
        ) else (
            echo [OK] Copied %%d
            set /a COPY_COUNT+=1
        )
    )
)

REM Copy GTK data files (themes, icons, etc.)
if exist "%MSYS2_BIN%\..\share\gtk-3.0" (
    echo.
    echo Copying GTK data files...
    if not exist bin\share mkdir bin\share
    if not exist bin\share\gtk-3.0 mkdir bin\share\gtk-3.0
    xcopy /E /I /Y "%MSYS2_BIN%\..\share\gtk-3.0\*" bin\share\gtk-3.0\ >nul 2>&1
    echo [OK] Copied GTK data files
)

REM Copy schemas
if exist "%MSYS2_BIN%\..\share\glib-2.0\schemas" (
    if not exist bin\share\glib-2.0 mkdir bin\share\glib-2.0
    if not exist bin\share\glib-2.0\schemas mkdir bin\share\glib-2.0\schemas
    xcopy /E /I /Y "%MSYS2_BIN%\..\share\glib-2.0\schemas\*" bin\share\glib-2.0\schemas\ >nul 2>&1
    echo [OK] Copied GLib schemas
)

REM Create data folder for application data
if not exist bin\data mkdir bin\data
echo [OK] Created data folder for application files

REM Compile schemas (required for GTK to work properly)
if exist bin\share\glib-2.0\schemas (
    echo.
    echo Compiling GLib schemas...
    if exist "%MSYS2_BIN%\glib-compile-schemas.exe" (
        "%MSYS2_BIN%\glib-compile-schemas.exe" bin\share\glib-2.0\schemas
        echo [OK] Schemas compiled
    ) else (
        echo [WARN] glib-compile-schemas.exe not found - schemas may not work
        echo        Application should still run, but some GTK features may be limited
    )
)

echo.
echo ========================================
echo [SUCCESS] Bundling completed!
echo ========================================
echo.
echo Copied %COPY_COUNT% DLL files to bin\ directory
echo.
echo Your standalone package is ready in: bin\
echo.
echo ========================================
echo READY TO USE!
echo ========================================
echo.
echo You can now:
echo   - Double-click bin\stock_management.exe to run
echo   - Copy the entire 'bin' folder to any Windows machine
echo   - The .exe will work without installing GTK separately
echo.
echo Package contents:
echo   - stock_management.exe (your application)
echo   - *.dll files (GTK runtime libraries)
echo   - share\ folder (GTK themes and data)
echo   - data\ folder (for application data files)
echo.
pause
