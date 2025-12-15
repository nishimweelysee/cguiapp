# Troubleshooting Guide

## Error 216: ERROR_BAD_EXE_FORMAT

If you see the error:
```
Unable to execute file: C:\Program Files\StockManagement\stock_management.exe
CreateProcess failed; code 216.
This version of %1 is not compatible with the version of Windows you're running.
```

This error typically indicates one of the following issues:

### 1. Missing DLLs (Most Common)

**Symptoms:**
- Error 216 when trying to run the executable
- Executable exists but won't start

**Solution:**
- Ensure all DLL files are in the same directory as `stock_management.exe`
- Run `check_dependencies.bat` in the installation directory to verify all DLLs are present
- If DLLs are missing, reinstall the application or manually copy DLLs from the installer

**To check manually:**
1. Navigate to `C:\Program Files\StockManagement\`
2. Verify that you see many `.dll` files (at least 20-30 files)
3. If DLLs are missing, re-run the installer

### 2. Architecture Mismatch

**Symptoms:**
- Error 216 on 64-bit Windows
- Executable was built for wrong architecture

**Solution:**
- The installer should automatically install the correct 64-bit version
- If you're on 32-bit Windows, you'll need a 32-bit build (not currently provided)
- Verify your Windows architecture: Right-click "This PC" → Properties → Check "System type"

### 3. Corrupted Executable

**Symptoms:**
- Error 216 even with all DLLs present
- File size seems incorrect

**Solution:**
- Re-download and reinstall the application
- Check that the installer completed successfully
- Verify file size matches expected size

### 4. Missing System DLLs

**Symptoms:**
- Error 216
- Other Windows applications also failing

**Solution:**
- Run Windows Update
- Install Visual C++ Redistributables (though MinGW apps typically don't need them)
- Check Windows system files: `sfc /scannow` in Command Prompt (as Administrator)

## Diagnostic Steps

1. **Run the diagnostic script:**
   ```batch
   cd "C:\Program Files\StockManagement"
   check_dependencies.bat
   ```

2. **Check DLL count:**
   ```batch
   dir *.dll | find /c ".dll"
   ```
   Should show at least 20-30 DLL files

3. **Verify executable exists:**
   ```batch
   dir stock_management.exe
   ```

4. **Check file permissions:**
   - Right-click `stock_management.exe` → Properties
   - Ensure "Unblock" is available (if present, click it)
   - Check that you have read/execute permissions

5. **Try running from Command Prompt:**
   ```batch
   cd "C:\Program Files\StockManagement"
   stock_management.exe
   ```
   This may show more detailed error messages

## Common Fixes

### Fix 1: Reinstall the Application
1. Uninstall through Control Panel
2. Download fresh installer
3. Run installer as Administrator
4. Ensure installation completes without errors

### Fix 2: Manual DLL Copy
If DLLs are missing:
1. Extract the installer (or use 7-Zip to open it)
2. Copy all `.dll` files to `C:\Program Files\StockManagement\`
3. Ensure `share` folder is also copied

### Fix 3: Check Antivirus
Some antivirus software may block DLL loading:
1. Temporarily disable antivirus
2. Try running the application
3. If it works, add exception for the application folder

### Fix 4: Run as Administrator
1. Right-click `stock_management.exe`
2. Select "Run as administrator"
3. Check if this resolves the issue

## Getting Help

If none of these solutions work:
1. Run `check_dependencies.bat` and save the output
2. Check Windows Event Viewer for detailed error messages:
   - Press Win+R, type `eventvwr.msc`
   - Navigate to Windows Logs → Application
   - Look for errors related to `stock_management.exe`
3. Provide the following information:
   - Windows version (Win+R → `winver`)
   - System architecture (32-bit or 64-bit)
   - Output from `check_dependencies.bat`
   - Any error messages from Event Viewer
