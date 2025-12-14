# Create Windows Installer (.exe)

## 🎯 Goal

Create a **single installer .exe** that:

- ✅ Installs everything needed (DLLs, data files)
- ✅ Installs the application
- ✅ Creates shortcuts
- ✅ Runs the app automatically
- ✅ **No scripts or .bat files needed!**

Users just double-click the installer and everything is done!

---

## Method 1: Using Inno Setup (Recommended - Free & Easy)

### Step 1: Install Inno Setup

1. Download: https://jrsoftware.org/isdl.php
2. Install it (free, no registration needed)

### Step 2: Build Standalone Package

```bash
./build_standalone.bat
```

This creates the `bin` folder with all files.

### Step 3: Create Installer

**Option A: Using the Script (Easiest)**

```bash
./create_installer.bat
```

**Option B: Using Inno Setup GUI**

1. Open Inno Setup Compiler
2. File → Open → Select `StockManagement_Installer.iss`
3. Build → Compile
4. Done! Installer is in `installer\` folder

### Step 4: Distribute

Give users: `installer\StockManagement_Installer.exe`

**They just:**

1. Double-click the installer
2. Click "Next" through the wizard
3. App installs and runs automatically! ✅

---

## Method 2: Using NSIS (Free Alternative)

### Step 1: Install NSIS

1. Download: https://nsis.sourceforge.io/Download
2. Install it

### Step 2: Create NSIS Script

Create `StockManagement_Installer.nsi`:

```nsis
!define APP_NAME "Stock Management System"
!define APP_VERSION "1.0"
!define APP_PUBLISHER "Your Company"
!define APP_EXE "stock_management.exe"

Name "${APP_NAME}"
OutFile "StockManagement_Installer.exe"
InstallDir "$PROGRAMFILES\StockManagement"
RequestExecutionLevel admin

Page directory
Page instfiles

Section "Install"
    SetOutPath "$INSTDIR"

    ; Copy application
    File "bin\stock_management.exe"

    ; Copy all DLLs
    File "bin\*.dll"

    ; Copy share folder
    File /r "bin\share"

    ; Create data folder
    CreateDirectory "$INSTDIR\data"

    ; Create shortcuts
    CreateShortcut "$SMPROGRAMS\${APP_NAME}.lnk" "$INSTDIR\${APP_EXE}"
    CreateShortcut "$DESKTOP\${APP_NAME}.lnk" "$INSTDIR\${APP_EXE}"

    ; Run application
    Exec "$INSTDIR\${APP_EXE}"
SectionEnd
```

### Step 3: Compile

1. Open NSIS
2. File → Load Script → Select `.nsi` file
3. Compile → Compile NSIS Script
4. Done!

---

## Method 3: Using WiX Toolset (Advanced)

WiX is Microsoft's installer toolset. More complex but very powerful.

See: https://wixtoolset.org/

---

## Complete Workflow

### On Windows Machine:

```bash
# Step 1: Build standalone package
./build_standalone.bat

# Step 2: Create installer
./create_installer.bat

# Step 3: Distribute installer
# Give users: installer\StockManagement_Installer.exe
```

### What Users Do:

1. **Double-click** `StockManagement_Installer.exe`
2. Click **"Next"** through installation wizard
3. App **installs and runs automatically** ✅
4. Shortcut created on desktop
5. Can run from Start Menu anytime

---

## Installer Features

The installer will:

✅ **Install Application**

- Copies `stock_management.exe` to Program Files
- Copies all required DLLs
- Copies GTK data files

✅ **Create Shortcuts**

- Desktop shortcut
- Start Menu shortcut
- Quick Launch (optional)

✅ **Run After Installation**

- Automatically launches the app
- User can uncheck if they don't want to run immediately

✅ **Uninstaller**

- Creates uninstaller in Control Panel
- Users can remove via "Add/Remove Programs"

---

## File Structure After Installation

```
C:\Program Files\StockManagement\
├── stock_management.exe
├── libgtk-3-0.dll
├── (all other DLLs)
├── share\
│   ├── gtk-3.0\
│   └── glib-2.0\
└── data\
    └── products.dat (created when app runs)
```

---

## Customization

Edit `StockManagement_Installer.iss` to customize:

- **App Name:** Change `AppName`
- **Version:** Change `AppVersion`
- **Publisher:** Change `AppPublisher`
- **Install Location:** Change `DefaultDirName`
- **Icon:** Add `SetupIconFile` path
- **License:** Add `LicenseFile` path

---

## Testing

Before distributing:

1. **Test on your machine:**

   - Run installer
   - Verify app runs
   - Check shortcuts work

2. **Test on clean Windows machine:**
   - Copy installer to another Windows PC
   - Run installer
   - Verify everything works
   - Test uninstaller

---

## Summary

**To create installer:**

1. `./build_standalone.bat` (build package)
2. `./create_installer.bat` (create installer)
3. Distribute `installer\StockManagement_Installer.exe`

**Users just:**

- Double-click installer
- Click Next
- Done! ✅

**No scripts, no .bat files, no manual steps!**

---

## Troubleshooting

### "Inno Setup not found"

- Install Inno Setup from https://jrsoftware.org/isdl.php
- Or use NSIS alternative

### "bin folder not found"

- Run `./build_standalone.bat` first

### Installer doesn't run app

- Check `[Run]` section in `.iss` file
- Verify `stock_management.exe` exists in `bin` folder

---

**Result:** Professional Windows installer that installs everything and runs the app! 🎉
