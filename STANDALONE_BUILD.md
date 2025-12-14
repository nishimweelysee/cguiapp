# Creating a Standalone Windows .exe

## The Problem

By default, your `.exe` file is **dynamically linked** to GTK+ 3.0 libraries. This means:

❌ **It will NOT run on Windows machines without GTK installed**

The executable requires GTK runtime DLLs to be present on the target system.

---

## Solution: Bundle GTK DLLs

To create a **standalone** `.exe` that runs on any Windows machine:

### Option 1: Use the Automated Script (Recommended)

1. **Build the .exe:**

   ```bash
   ./build_windows.bat
   ```

2. **Bundle DLLs:**

   ```bash
   ./bundle_dlls.bat
   ```

   OR do both at once:

   ```bash
   ./build_standalone.bat
   ```

3. **Distribute the entire `bin` folder** - it now contains:
   - `stock_management.exe`
   - All required GTK DLLs
   - GTK data files (themes, icons)

### Option 2: Manual Bundling

1. After building, copy these DLLs from `C:\msys64\mingw64\bin\` to your `bin\` folder:

   **Core GTK DLLs:**

   - `libgtk-3-0.dll`
   - `libgdk-3-0.dll`
   - `libglib-2.0-0.dll`
   - `libgobject-2.0-0.dll`
   - `libgio-2.0-0.dll`
   - `libpango-1.0-0.dll`
   - `libcairo-2.dll`
   - `libpangoft2-1.0-0.dll`
   - `libpangocairo-1.0-0.dll`
   - `libgdk_pixbuf-2.0-0.dll`
   - `libatk-1.0-0.dll`
   - `libepoxy-0.dll`

   **Additional dependencies:**

   - `libintl-8.dll`
   - `libiconv-2.dll`
   - `libwinpthread-1.dll`
   - `libffi-8.dll`
   - `libbz2-1.dll`
   - `libharfbuzz-0.dll`
   - `libfreetype-6.dll`
   - `libfontconfig-1.dll`
   - `libpng16-16.dll`
   - `libjpeg-8.dll`
   - `libtiff-5.dll`
   - `libpixman-1-0.dll`
   - `libexpat-1.dll`

2. Copy GTK data files:
   - Copy `C:\msys64\mingw64\share\gtk-3.0\` → `bin\share\gtk-3.0\`
   - Copy `C:\msys64\mingw64\share\glib-2.0\schemas\` → `bin\share\glib-2.0\schemas\`

---

## Distribution

### For Single User:

- Zip the entire `bin` folder
- User extracts and runs `stock_management.exe`

### For Multiple Users:

- Create an installer using:
  - **Inno Setup** (free, recommended)
  - **NSIS** (free)
  - **WiX Toolset** (Microsoft)

The installer should:

1. Install `stock_management.exe` to Program Files
2. Install DLLs to the same directory
3. Install GTK data files to `share\` subdirectory
4. Create a desktop shortcut

---

## Testing

Before distributing:

1. **Test on the build machine** (should work)
2. **Test on a clean Windows VM** (no GTK installed) - this is crucial!
3. Verify all features work correctly

---

## File Size

Expect the bundled package to be:

- **~50-100 MB** (includes all GTK runtime files)
- Much larger than the .exe alone (~500 KB)

This is normal for GUI applications with bundled frameworks.

---

## Alternative: Static Linking (Advanced)

For a truly single-file executable, you'd need to:

1. Statically link GTK (complex, not officially supported)
2. Use a different GUI framework (WinAPI, FLTK)
3. Use a tool like UPX to compress the final package

**Note:** Static linking GTK is not recommended and may violate GTK's LGPL license terms.

---

## Summary

✅ **Current state:** `.exe` requires GTK installation on target machine  
✅ **After bundling:** `.exe` runs standalone (DLLs in same folder)  
✅ **Best practice:** Bundle DLLs + create installer for distribution
