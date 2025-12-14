# Build Windows .exe from macOS

## 🎯 Goal: Everything from Mac, No Windows Needed!

You want to build the Windows `.exe` file completely from your Mac. Here are your options:

---

## Option 1: GitHub Actions (Easiest - Recommended) ⭐

**Build Windows .exe in the cloud - no Windows machine needed!**

### How It Works

- Push code to GitHub
- GitHub Actions builds on Windows automatically
- Download the `.exe` file
- Done!

### Steps

1. **Create GitHub Repository**

   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/yourusername/stock-management.git
   git push -u origin main
   ```

2. **Create GitHub Actions Workflow**

   Create `.github/workflows/build-windows.yml`:

   ```yaml
   name: Build Windows Executable

   on:
     push:
       branches: [main]
     workflow_dispatch:

   jobs:
     build:
       runs-on: windows-latest

       steps:
         - uses: actions/checkout@v3

         - name: Install MSYS2 and GTK
           run: |
             choco install msys2 -y
             refreshenv
             C:\tools\msys64\usr\bin\bash -lc "pacman -S --noconfirm mingw-w64-x86_64-gtk3 mingw-w64-x86_64-pkg-config mingw-w64-x86_64-gcc make"

         - name: Build Standalone Package
           shell: C:\tools\msys64\usr\bin\bash.exe -l {0}
           run: |
             cd ${{ github.workspace }}
             ./build_windows.sh
             ./bundle_dlls.sh

         - name: Upload Artifact
           uses: actions/upload-artifact@v3
           with:
             name: StockManagement-Windows
             path: bin/*
   ```

3. **Push to GitHub**

   ```bash
   git add .github/workflows/build-windows.yml
   git commit -m "Add Windows build workflow"
   git push
   ```

4. **Download Artifact**
   - Go to GitHub → Actions tab
   - Click on the workflow run
   - Download the artifact
   - Extract and use!

**Result:** Windows `.exe` built in the cloud! ✅

---

## Option 2: Cross-Compile from macOS (Advanced)

### Prerequisites

```bash
# Install Homebrew if not installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install MinGW-w64 cross-compiler
brew install mingw-w64

# Install GTK for Windows (complex - requires manual setup)
# See: https://www.gtk.org/docs/installations/windows/
```

### Build Script for macOS

Create `build_from_mac.sh`:

```bash
#!/bin/bash
# Build Windows .exe from macOS using cross-compilation

echo "Building Windows executable from macOS..."

# Set cross-compiler
export CC=x86_64-w64-mingw32-gcc
export PKG_CONFIG=x86_64-w64-mingw32-pkg-config

# Build
x86_64-w64-mingw32-gcc -Wall -Wextra -std=c11 -mwindows \
    -o bin/stock_management.exe \
    $(x86_64-w64-mingw32-pkg-config --cflags --libs gtk+-3.0) \
    src/*.c

echo "Done! Check bin/stock_management.exe"
```

**Note:** Cross-compilation is complex and requires GTK Windows libraries. Option 1 (GitHub Actions) is much easier!

---

## Option 3: Docker with Windows Container (Complex)

Use Docker Desktop with Windows containers. More complex setup.

---

## Option 4: macOS Scripts (Prepare, Build on Windows Later)

Create macOS scripts that prepare everything, then you just copy to Windows and run one command.

### Create `prepare_for_windows.sh`:

```bash
#!/bin/bash
# Prepare files for Windows build

echo "Preparing files for Windows build..."

# Create Windows-ready folder
mkdir -p WindowsBuild
cp -r src WindowsBuild/
cp build_windows.bat WindowsBuild/
cp build_standalone.bat WindowsBuild/
cp bundle_dlls.bat WindowsBuild/
cp BUILD_INSTALLER.bat WindowsBuild/
cp StockManagement_Installer.iss WindowsBuild/
cp Makefile.windows WindowsBuild/

# Create instructions
cat > WindowsBuild/README.txt << EOF
========================================
WINDOWS BUILD INSTRUCTIONS
========================================

1. Open MSYS2 MinGW 64-bit terminal

2. Navigate here:
   cd /c/path/to/WindowsBuild

3. Run:
   ./BUILD_INSTALLER.bat

4. Done! Installer in installer\ folder
EOF

echo "Files prepared in WindowsBuild/ folder"
echo "Copy to Windows and run BUILD_INSTALLER.bat"
```

Then:

1. Run `./prepare_for_windows.sh` on Mac
2. Copy `WindowsBuild/` folder to Windows
3. Run `BUILD_INSTALLER.bat` on Windows
4. Done!

---

## Recommended: GitHub Actions

**Why GitHub Actions?**

- ✅ Builds on real Windows machines
- ✅ No Windows license needed
- ✅ Automated - just push code
- ✅ Free for public repos
- ✅ Download ready-to-use `.exe`

**Workflow:**

1. Create GitHub repo
2. Add workflow file
3. Push code
4. Download `.exe` from Actions

---

## Quick Start: GitHub Actions

I'll create the workflow file for you. Just:

1. Create GitHub repo
2. Copy the workflow file I'll create
3. Push to GitHub
4. Download the `.exe`

Want me to create the GitHub Actions workflow file now?

---

## Summary

**Easiest (Recommended):**

- Use GitHub Actions (builds in cloud)
- No Windows needed
- Just push code, download `.exe`

**Alternative:**

- Prepare files on Mac
- Copy to Windows
- Run one command

**Advanced:**

- Cross-compile from Mac (complex)

---

**Which option do you prefer?** I recommend GitHub Actions - it's the easiest way to build Windows `.exe` from Mac! 🚀
