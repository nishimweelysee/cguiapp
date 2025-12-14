# Building Windows .exe File

## Option 1: Build on Windows (Recommended) ⭐

This is the easiest and most reliable method.

### Step 1: Install MSYS2 on Windows

1. Download MSYS2 from: https://www.msys2.org/
2. Install it (default location: `C:\msys64`)
3. Open **MSYS2 MinGW 64-bit** terminal (not MSYS2)

### Step 2: Install GTK+ 3.0 and Tools

In the MSYS2 terminal, run:

```bash
# Update package database
pacman -Syu

# Install GTK+ 3.0 and development tools
pacman -S mingw-w64-x86_64-gtk3
pacman -S mingw-w64-x86_64-pkg-config
pacman -S mingw-w64-x86_64-gcc
pacman -S make
```

### Step 3: Navigate to Project Directory

```bash
cd /c/path/to/Cexamwinne
# Example: cd /c/Users/YourName/Downloads/Cexamwinne
```

### Step 4: Build the Project

```bash
# Use the Windows Makefile
make -f Makefile.windows

# Or compile manually:
gcc -o bin/stock_management.exe -mwindows $(pkg-config --cflags --libs gtk+-3.0) src/*.c
```

### Step 5: Find Your .exe

The executable will be in: `bin/stock_management.exe`

---

## Option 2: Cross-Compile from macOS (Advanced)

This is more complex but allows building on macOS.

### Step 1: Install MinGW-w64

```bash
brew install mingw-w64
```

### Step 2: Install GTK+ for Windows

You'll need to download GTK+ Windows binaries:
1. Download from: https://github.com/tschoonj/GTK-for-Windows-Runtime-Environment-Installer
2. Or use pre-built binaries from: https://www.gtk.org/docs/installations/windows/

### Step 3: Set Up Environment

```bash
# Set paths to GTK Windows libraries
export PKG_CONFIG_PATH=/path/to/gtk-windows/lib/pkgconfig
export PATH=/path/to/gtk-windows/bin:$PATH
```

### Step 4: Cross-Compile

```bash
x86_64-w64-mingw32-gcc -o bin/stock_management.exe \
  -mwindows \
  $(x86_64-w64-mingw32-pkg-config --cflags --libs gtk+-3.0) \
  src/*.c
```

**Note:** Cross-compilation is complex. Option 1 (building on Windows) is recommended.

---

## Option 3: Use GitHub Actions (Automated)

Create `.github/workflows/build-windows.yml`:

```yaml
name: Build Windows

on: [push]

jobs:
  build:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v2
      - name: Install GTK
        run: choco install gtk-runtime
      - name: Build
        run: gcc -o stock_management.exe src/*.c $(pkg-config --cflags --libs gtk+-3.0)
      - name: Upload
        uses: actions/upload-artifact@v2
        with:
          name: stock_management.exe
          path: stock_management.exe
```

---

## Quick Build Script for Windows

Create `build_windows.bat`:

```batch
@echo off
echo Building Stock Management System for Windows...

REM Check if GTK is installed
pkg-config --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: pkg-config not found!
    echo Please install MSYS2 and GTK+ 3.0
    pause
    exit /b 1
)

REM Create directories
if not exist bin mkdir bin
if not exist obj mkdir obj
if not exist data mkdir data

REM Compile
echo Compiling...
gcc -Wall -Wextra -std=c11 -mwindows ^
    -o bin/stock_management.exe ^
    $(pkg-config --cflags --libs gtk+-3.0) ^
    src/*.c

if errorlevel 1 (
    echo Build failed!
    pause
    exit /b 1
)

echo.
echo Build successful!
echo Executable: bin\stock_management.exe
pause
```

---

## Making a Standalone .exe

To create a standalone executable that doesn't require GTK installation on target machine:

### Bundle GTK Runtime

1. Copy GTK DLLs to the same folder as your .exe
2. Required DLLs (usually in `C:\msys64\mingw64\bin`):
   - `libgtk-3-0.dll`
   - `libgdk-3-0.dll`
   - `libglib-2.0-0.dll`
   - `libgobject-2.0-0.dll`
   - `libgio-2.0-0.dll`
   - `libpango-1.0-0.dll`
   - `libcairo-2.dll`
   - And other dependencies

### Create Installer

Use tools like:
- **Inno Setup** (free, easy)
- **NSIS** (free, powerful)
- **WiX Toolset** (Microsoft's installer)

---

## Troubleshooting

### "pkg-config not found"
- Make sure you're using MSYS2 MinGW terminal, not regular Command Prompt
- Install: `pacman -S mingw-w64-x86_64-pkg-config`

### "GTK not found"
- Install: `pacman -S mingw-w64-x86_64-gtk3`
- Verify: `pkg-config --modversion gtk+-3.0`

### "DLL not found" when running .exe
- Copy required DLLs to the same folder as .exe
- Or install GTK runtime on the target machine

### Build errors
- Make sure all source files are in `src/` directory
- Check that GTK development headers are installed
- Try: `make clean` then rebuild

---

## Recommended Approach

**For the exam, use Option 1 (Build on Windows):**
1. Use a Windows machine or VM
2. Install MSYS2
3. Install GTK+ 3.0
4. Run `make -f Makefile.windows`
5. Test the .exe
6. Bundle with GTK runtime if needed

This ensures the .exe works correctly on Windows.

