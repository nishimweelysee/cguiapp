# Create a Single .exe File

## 🎯 Goal

Create **ONE single .exe file** that contains everything - no DLLs, no folders, just one file!

---

## ⚠️ Important Note

GTK+ 3.0 applications **cannot** be statically linked into a true single-file executable. However, we can create a **self-extracting executable** that:

- Extracts files to a temporary folder when run
- Runs the application
- Cleans up when done (optional)

**Result:** User sees only ONE .exe file, but it extracts files temporarily when running.

---

## Method 1: Using 7-Zip SFX (Free, Recommended)

### Prerequisites

1. Install 7-Zip: https://www.7-zip.org/
2. Build standalone package first: `./build_standalone.bat`

### Steps

#### Step 1: Prepare the Package

```bash
./build_standalone.bat
```

#### Step 2: Create SFX Archive

**Option A: Using 7-Zip GUI**

1. Open 7-Zip File Manager
2. Navigate to `bin` folder
3. Select ALL files and folders (Ctrl+A)
4. Click "Add" → Choose "7z" format
5. Name it: `package.7z`
6. Go to Tools → Convert to SFX
7. Rename to: `StockManagement.exe`

**Option B: Using Command Line**

```bash
# Create archive
"C:\Program Files\7-Zip\7z.exe" a -sfx package.7z bin\*

# Rename
ren package.7z StockManagement.exe
```

---

## Method 2: Using Enigma Virtual Box (Best Option)

### Why This Method?

- ✅ Creates true single-file executable
- ✅ No extraction visible to user
- ✅ Professional result
- ✅ Free tool

### Steps

1. **Download Enigma Virtual Box**

   - https://enigmaprotector.com/en/downloads.html
   - Free version available

2. **Build Standalone Package**

   ```bash
   ./build_standalone.bat
   ```

3. **Open Enigma Virtual Box**

4. **Configure:**

   - **Enter Virtual Box File Name:** `StockManagement.exe`
   - **Files:** Add entire `bin` folder contents
   - **Executable File:** `bin\stock_management.exe`
   - **Run Executable:** Check this option

5. **Build**

   - Click "Process" button
   - Wait for completion
   - Output: `StockManagement.exe` (single file!)

6. **Test**
   - Copy `StockManagement.exe` to another Windows machine
   - Double-click to run
   - ✅ Works!

---

## Method 3: Using WinRAR SFX (If You Have WinRAR)

1. Select all files in `bin` folder
2. Right-click → "Add to archive"
3. Check "Create SFX archive"
4. Go to "Advanced" tab → "SFX options"
5. Set "Run after extraction" to: `stock_management.exe`
6. Create archive
7. Rename `.exe` to `StockManagement.exe`

---

## Method 4: Using IExpress (Built into Windows)

### Steps

1. **Open IExpress**

   - Press `Win+R`
   - Type: `iexpress`
   - Press Enter

2. **Create Self Extracting Directive**

   - Choose "Create new Self Extraction Directive file"
   - Click Next

3. **Package Title**

   - Enter: "Stock Management System"
   - Click Next

4. **Confirmation Prompt**

   - Choose "No prompt"
   - Click Next

5. **License Agreement**

   - Choose "Do not display a license"
   - Click Next

6. **Packaged Files**

   - Click "Add"
   - Select ALL files from `bin` folder
   - Click Next

7. **Install Program**

   - Install Program: `stock_management.exe`
   - Post Install Command: (leave empty)
   - Click Next

8. **Show Window**

   - Choose "Default"
   - Click Next

9. **Finished Message**

   - Choose "No message"
   - Click Next

10. **Package Name and Options**

    - Package name: `StockManagement.exe`
    - Choose "Store files using Long File Name inside Package"
    - Click Next

11. **Configure Restart**

    - Choose "No restart"
    - Click Next

12. **Save Self Extraction Directive**

    - Save as: `StockManagement.sed`
    - Click Next

13. **Create Package**
    - Click Next
    - Wait for completion
    - Done! ✅

---

## Method 5: Custom Launcher (Advanced)

Create a simple C launcher that:

1. Extracts embedded resources
2. Runs the main executable
3. Optionally cleans up

See `launcher_source.c` for example code.

---

## Recommended Approach

**For best results, use Method 2 (Enigma Virtual Box):**

- Professional single-file executable
- No visible extraction
- Works seamlessly
- Free tool

**For quick solution, use Method 1 (7-Zip SFX):**

- Fast and easy
- Free tool
- May show brief extraction

---

## Testing

After creating the single .exe:

1. **Copy to clean Windows machine** (no GTK installed)
2. **Double-click the .exe**
3. **Verify it runs correctly**
4. **Check that only ONE file exists** (the .exe)

---

## File Size

Expect the single .exe to be:

- **~50-100 MB** (contains all DLLs and data files)
- Compressed, so smaller than the original `bin` folder

---

## Summary

**Quick Method:**

1. `./build_standalone.bat`
2. Use 7-Zip to create SFX archive
3. Done!

**Best Method:**

1. `./build_standalone.bat`
2. Use Enigma Virtual Box
3. Create single .exe
4. Done!

---

**Result:** ONE single .exe file that runs on any Windows machine! 🎉
