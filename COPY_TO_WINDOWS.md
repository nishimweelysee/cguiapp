# Files to Copy to Windows

## 🎯 Quick Answer

**Copy these files/folders to Windows:**

### ✅ REQUIRED (Must Have)

```
📁 src/                    ← Entire folder with all source files
📄 build_windows.bat       ← Build script
📄 build_standalone.bat    ← Standalone package builder
📄 bundle_dlls.bat         ← DLL bundler
```

### ✅ OPTIONAL (Helpful)

```
📄 BUILD_SINGLE_EXE.bat    ← For creating single .exe
📄 create_sfx_7zip.bat     ← For 7-Zip SFX method
📄 verify_package.bat      ← To verify package
📄 Makefile.windows        ← Alternative build method
📄 Documentation files     ← Helpful guides
```

---

## 📋 Detailed List

### Source Code (REQUIRED)

**Copy the entire `src/` folder:**

- `file_io.c` / `file_io.h`
- `gui_dialogs.c` / `gui_dialogs.h`
- `gui_main.c` / `gui_main.h`
- `main.c`
- `product.c` / `product.h`
- `validation.c` / `validation.h`

### Build Scripts (REQUIRED)

**Copy these `.bat` files:**

- `build_windows.bat` - Compiles the .exe
- `build_standalone.bat` - Builds + bundles DLLs
- `bundle_dlls.bat` - Bundles GTK DLLs

### For Single .exe (OPTIONAL)

**If creating single-file executable:**

- `BUILD_SINGLE_EXE.bat` - Complete workflow
- `create_sfx_7zip.bat` - 7-Zip SFX creator

---

## 🚀 Easy Method: Use the Preparation Script

**On macOS, run:**

```bash
./prepare_for_windows.sh
```

This creates a clean `Cexamwinne_ForWindows` folder with only necessary files!

Then:

1. Copy `Cexamwinne_ForWindows` folder to Windows
2. Or zip it: `zip -r Cexamwinne_ForWindows.zip Cexamwinne_ForWindows`

---

## 📦 Manual Copy Method

### Step 1: Create Folder on Windows

Create a folder: `Cexamwinne`

### Step 2: Copy These Items

**From macOS to Windows:**

```
✅ Copy: src/ folder (entire folder)
✅ Copy: build_windows.bat
✅ Copy: build_standalone.bat
✅ Copy: bundle_dlls.bat
✅ Copy: BUILD_SINGLE_EXE.bat (optional)
✅ Copy: create_sfx_7zip.bat (optional)
```

### Step 3: Verify on Windows

After copying, your Windows folder should look like:

```
Cexamwinne/
├── src/
│   ├── file_io.c
│   ├── file_io.h
│   ├── gui_dialogs.c
│   ├── gui_dialogs.h
│   ├── gui_main.c
│   ├── gui_main.h
│   ├── main.c
│   ├── product.c
│   ├── product.h
│   ├── validation.c
│   └── validation.h
├── build_windows.bat
├── build_standalone.bat
└── bundle_dlls.bat
```

---

## ❌ DON'T Copy These

**Not needed on Windows:**

- `bin/` folder (will be created)
- `obj/` folder (will be created)
- `.DS_Store` files (macOS system files)
- `*.sh` files (Linux/Mac scripts)
- `Makefile` (Linux version - use `Makefile.windows` instead)
- PDF files
- PNG images
- Documentation (optional, but helpful)

---

## ✅ Minimum Files Checklist

Before building on Windows, verify you have:

- [ ] `src/` folder with all `.c` and `.h` files (10 files total)
- [ ] `build_windows.bat`
- [ ] `build_standalone.bat`
- [ ] `bundle_dlls.bat`

**That's the absolute minimum!**

---

## 🎯 Summary

**Easiest way:**

1. Run `./prepare_for_windows.sh` on macOS
2. Copy `Cexamwinne_ForWindows` folder to Windows
3. Done! ✅

**Manual way:**

1. Copy `src/` folder
2. Copy `build_standalone.bat`
3. Copy `build_windows.bat`
4. Copy `bundle_dlls.bat`
5. Done! ✅

---

**After copying, on Windows:**

1. Open MSYS2 MinGW terminal
2. Navigate to the folder
3. Run: `./build_standalone.bat`
4. Get your standalone package! 🎉
