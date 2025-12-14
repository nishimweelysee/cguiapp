# True Single-File Executable (Just Double-Click!)

## 🎯 Your Goal

**ONE .exe file** that:

- ✅ Users just double-click
- ✅ No installation
- ✅ No setup
- ✅ No DLLs visible
- ✅ No folders to manage
- ✅ Just works!

---

## ✅ YES, This is Possible!

You can create a **true single-file executable** using bundler tools. The file extracts everything invisibly to a temporary folder and runs.

---

## Method 1: Enigma Virtual Box (Best - True Single File)

### How It Works

- Creates ONE .exe file
- Extracts files to temp folder (invisible to user)
- Runs your app
- Cleans up when done (optional)

### Steps

1. **Download Enigma Virtual Box**

   - https://enigmaprotector.com/en/downloads.html
   - Free version available
   - No installation needed (portable)

2. **Build Standalone Package First**

   ```bash
   ./build_standalone.bat
   ```

3. **Open Enigma Virtual Box**

4. **Configure:**

   - **Enter Virtual Box File Name:** `StockManagement.exe`
   - **Files:** Click "Add" → Select **ENTIRE `bin` folder**
   - **Executable File:** `bin\stock_management.exe`
   - **Run Executable:** ✅ Check this
   - **Extract to Temp:** ✅ Check this (extracts invisibly)

5. **Click "Process"**

   - Wait for completion
   - Output: `StockManagement.exe` (single file!)

6. **Done!**
   - ONE file: `StockManagement.exe`
   - Users just double-click
   - No installation, no setup, nothing!

---

## Method 2: 7-Zip SFX (Free, But Shows Brief Extraction)

### How It Works

- Creates self-extracting archive
- Extracts files when run
- Runs your app
- May show brief extraction window

### Steps

1. **Build Standalone Package**

   ```bash
   ./build_standalone.bat
   ```

2. **Create SFX Archive**

   ```bash
   ./create_sfx_7zip.bat
   ```

3. **Result:** `StockManagement.exe`
   - Single file
   - Extracts and runs
   - May show extraction window briefly

---

## Method 3: Portable Package (Simplest, But Multiple Files)

### How It Works

- One folder with .exe + DLLs
- User double-clicks .exe
- Everything in one folder

### Steps

1. **Build Standalone Package**

   ```bash
   ./build_standalone.bat
   ```

2. **Zip the `bin` folder**

   - Right-click `bin` folder
   - Send to → Compressed folder

3. **Users:**
   - Extract ZIP
   - Double-click `stock_management.exe`
   - Done!

**Note:** User sees multiple files, but it's still simple.

---

## Comparison

| Method                 | Files User Sees | Extraction Visible? | Difficulty |
| ---------------------- | --------------- | ------------------- | ---------- |
| **Enigma Virtual Box** | 1 file          | No (invisible)      | Easy       |
| **7-Zip SFX**          | 1 file          | Yes (brief)         | Easy       |
| **Portable Package**   | Many files      | No                  | Easiest    |

---

## Recommended: Enigma Virtual Box

**Why?**

- ✅ True single-file executable
- ✅ No visible extraction
- ✅ Professional result
- ✅ Free tool
- ✅ User just double-clicks

**Result:**

- ONE file: `StockManagement.exe`
- User double-clicks → App runs
- Nothing else needed!

---

## Complete Workflow

### On Windows:

```bash
# Step 1: Build standalone package
./build_standalone.bat

# Step 2: Use Enigma Virtual Box
# - Open Enigma Virtual Box
# - Add bin folder
# - Set executable: bin\stock_management.exe
# - Process

# Step 3: Distribute
# Give users: StockManagement.exe
```

### What Users Do:

1. **Double-click** `StockManagement.exe`
2. **Done!** ✅

That's it! Nothing else!

---

## File Size

Expect: **~50-100 MB**

- Contains all DLLs and data files
- Compressed into single executable

---

## Testing

Before distributing:

1. **Test on your machine**

   - Double-click the .exe
   - Verify it runs

2. **Test on clean Windows machine**
   - Copy .exe to another PC
   - Double-click
   - Should run immediately!

---

## Summary

**To create true single-file:**

1. `./build_standalone.bat` (build package)
2. Use **Enigma Virtual Box** (create single .exe)
3. Distribute `StockManagement.exe`

**Users:**

- Double-click `.exe`
- Done! ✅

**No installation, no setup, no DLLs, no folders - just ONE file!**

---

## Alternative Tools

If Enigma Virtual Box doesn't work:

- **BoxedApp Packer** (commercial, free trial)
- **VMware ThinApp** (commercial)
- **Spoon Studio** (commercial)

But **Enigma Virtual Box** is free and works great!

---

**Result:** True single-file executable that users just double-click! 🎉
