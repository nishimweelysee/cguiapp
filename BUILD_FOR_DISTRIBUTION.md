# Build Standalone Package for Distribution

## 🎯 Goal

Create a package that you can copy to ANY Windows laptop and just run - **no installation, no setup, nothing else needed!**

---

## 📋 Prerequisites

You need a **Windows machine** (or Windows VM) with:

1. **MSYS2** installed (download from https://www.msys2.org/)
2. **GTK+ 3.0** installed in MSYS2

---

## 🚀 Step-by-Step Instructions

### Step 1: Open MSYS2 MinGW 64-bit Terminal

⚠️ **IMPORTANT:** Use **MSYS2 MinGW 64-bit** terminal, NOT regular Command Prompt!

- Find it in Start Menu: `MSYS2 MinGW 64-bit`
- Or navigate to: `C:\msys64\mingw64.exe`

### Step 2: Navigate to Your Project

```bash
cd /c/path/to/Cexamwinne
# Example: cd /c/Users/YourName/Downloads/Cexamwinne
```

### Step 3: Install GTK (if not already installed)

```bash
pacman -Syu
pacman -S mingw-w64-x86_64-gtk3 mingw-w64-x86_64-pkg-config mingw-w64-x86_64-gcc make
```

### Step 4: Build Standalone Package

**Run this ONE command:**

```bash
./build_standalone.bat
```

This will:

1. ✅ Build the `.exe` file
2. ✅ Copy all required DLLs
3. ✅ Copy GTK data files
4. ✅ Create the `data` folder
5. ✅ Compile schemas

**Wait for it to complete** - it will show "READY TO USE!" when done.

---

## ✅ Verify the Package

After building, check that `bin` folder contains:

```
bin/
├── stock_management.exe    ← Main executable
├── libgtk-3-0.dll          ← GTK DLLs (many files)
├── libgdk-3-0.dll
├── (20+ more .dll files)
├── share/                   ← GTK data
│   ├── gtk-3.0/
│   └── glib-2.0/
└── data/                    ← App data folder
```

---

## 📦 Package for Distribution

### Option 1: Zip the Entire `bin` Folder

1. Right-click on the `bin` folder
2. Select "Send to" → "Compressed (zipped) folder"
3. Name it: `StockManagement_Standalone.zip`

### Option 2: Create a Distribution Folder

1. Create a new folder: `StockManagement_Standalone`
2. Copy **everything** from `bin` folder into it
3. Zip this folder

---

## 🎁 What to Give to Others

**Give them the ZIP file** containing:

- `stock_management.exe`
- All `.dll` files
- `share` folder
- `data` folder (empty, will be created automatically)

---

## 💻 On the Other Windows Laptop

**They just need to:**

1. Extract the ZIP file
2. Double-click `stock_management.exe`
3. **Done!** ✅

**No installation, no setup, nothing else!**

---

## 🧪 Test Before Distributing

**IMPORTANT:** Test on a clean Windows machine first!

1. Copy the `bin` folder to a USB drive
2. Test on another Windows machine (or VM) that **doesn't have GTK installed**
3. Double-click `stock_management.exe`
4. If it runs → ✅ Ready to distribute!
5. If it shows DLL errors → Run `bundle_dlls.bat` again

---

## 🔧 Troubleshooting

### "DLL not found" error

- Run `bundle_dlls.bat` again
- Make sure all DLLs are in the same folder as `.exe`

### "pkg-config not found"

- Make sure you're using **MSYS2 MinGW 64-bit** terminal
- Install: `pacman -S mingw-w64-x86_64-pkg-config`

### "GTK not found"

- Install: `pacman -S mingw-w64-x86_64-gtk3`

### Application doesn't start

- Check Windows Event Viewer for errors
- Make sure all files are in the same folder
- Try running as Administrator

---

## 📝 Quick Checklist

Before distributing, verify:

- [ ] `stock_management.exe` exists in `bin` folder
- [ ] At least 20+ `.dll` files are in `bin` folder
- [ ] `share` folder exists with `gtk-3.0` and `glib-2.0` subfolders
- [ ] `data` folder exists (can be empty)
- [ ] Tested on a clean Windows machine without GTK
- [ ] Application runs successfully

---

## 🎯 Summary

**To build:**

```bash
./build_standalone.bat
```

**To distribute:**

- Zip the entire `bin` folder
- Give the ZIP file to others

**They just:**

- Extract ZIP
- Double-click `.exe`
- Done! ✅

---

**That's it! Simple and straightforward!** 🚀
