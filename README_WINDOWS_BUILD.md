# Quick Guide: Building Windows .exe

## 🚀 Fastest Method (Recommended)

### On a Windows Machine:

1. **Install MSYS2**
   - Download: https://www.msys2.org/
   - Install it

2. **Open MSYS2 MinGW 64-bit terminal** (important: use MinGW, not MSYS2)

3. **Install GTK+ 3.0**
   ```bash
   pacman -Syu
   pacman -S mingw-w64-x86_64-gtk3 mingw-w64-x86_64-pkg-config mingw-w64-x86_64-gcc make
   ```

4. **Navigate to your project**
   ```bash
   cd /c/Users/YourName/Downloads/Cexamwinne
   ```

5. **Build**
   ```bash
   ./build_windows.sh
   # OR
   make -f Makefile.windows
   ```

6. **Find your .exe**
   - Location: `bin/stock_management.exe`

---

## 📋 Manual Build Command

If you prefer to build manually:

```bash
gcc -Wall -Wextra -std=c11 -mwindows \
    -o bin/stock_management.exe \
    $(pkg-config --cflags --libs gtk+-3.0) \
    src/*.c
```

---

## ✅ What You Get

After building, you'll have:
- `bin/stock_management.exe` - Your Windows executable

---

## 📦 Making it Standalone

To run on another Windows computer without GTK installed:

1. Copy all required DLLs from `C:\msys64\mingw64\bin\` to the same folder as your .exe
2. Or create an installer using Inno Setup or NSIS

---

## 🆘 Troubleshooting

**"pkg-config not found"**
→ Use MSYS2 MinGW terminal, not regular Command Prompt

**"GTK not found"**
→ Run: `pacman -S mingw-w64-x86_64-gtk3`

**"DLL not found" when running**
→ Copy GTK DLLs to the same folder as .exe

---

For detailed instructions, see `BUILD_WINDOWS.md`

