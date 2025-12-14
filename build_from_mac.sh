#!/bin/bash
# Prepare and build Windows executable from macOS
# This script prepares everything, then you can either:
# 1. Use GitHub Actions (recommended)
# 2. Copy to Windows and build there

echo "=========================================="
echo "Building Windows Executable from macOS"
echo "=========================================="
echo ""

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "This script is for macOS. Use build_windows.bat on Windows."
    exit 1
fi

echo "Option 1: Use GitHub Actions (Recommended)"
echo "  - Push to GitHub"
echo "  - GitHub builds automatically"
echo "  - Download .exe from Actions"
echo ""
echo "Option 2: Prepare files for Windows"
echo "  - Creates WindowsBuild/ folder"
echo "  - Copy to Windows"
echo "  - Run BUILD_INSTALLER.bat"
echo ""

read -p "Choose option (1 or 2): " option

if [ "$option" = "1" ]; then
    echo ""
    echo "=========================================="
    echo "GitHub Actions Setup"
    echo "=========================================="
    echo ""
    echo "Steps:"
    echo "1. Create GitHub repository:"
    echo "   git init"
    echo "   git add ."
    echo "   git commit -m 'Initial commit'"
    echo "   git remote add origin https://github.com/yourusername/repo.git"
    echo "   git push -u origin main"
    echo ""
    echo "2. GitHub Actions will build automatically"
    echo ""
    echo "3. Download .exe from:"
    echo "   GitHub → Actions → Latest workflow → Artifacts"
    echo ""
    echo "The workflow file is already created:"
    echo "  .github/workflows/build-windows.yml"
    echo ""
    
elif [ "$option" = "2" ]; then
    echo ""
    echo "=========================================="
    echo "Preparing Files for Windows"
    echo "=========================================="
    echo ""
    
    # Create Windows build folder
    OUTPUT_DIR="WindowsBuild"
    rm -rf "$OUTPUT_DIR"
    mkdir -p "$OUTPUT_DIR"
    
    echo "[1/5] Copying source files..."
    cp -r src "$OUTPUT_DIR/"
    echo "[OK] Source files copied"
    
    echo "[2/5] Copying build scripts..."
    cp build_windows.bat "$OUTPUT_DIR/" 2>/dev/null
    cp build_standalone.bat "$OUTPUT_DIR/" 2>/dev/null
    cp bundle_dlls.bat "$OUTPUT_DIR/" 2>/dev/null
    cp BUILD_INSTALLER.bat "$OUTPUT_DIR/" 2>/dev/null
    cp create_sfx_7zip.bat "$OUTPUT_DIR/" 2>/dev/null
    cp StockManagement_Installer.iss "$OUTPUT_DIR/" 2>/dev/null
    cp Makefile.windows "$OUTPUT_DIR/" 2>/dev/null
    echo "[OK] Build scripts copied"
    
    echo "[3/5] Copying documentation..."
    cp BUILD_FOR_DISTRIBUTION.md "$OUTPUT_DIR/" 2>/dev/null
    cp INSTALLER_GUIDE.md "$OUTPUT_DIR/" 2>/dev/null
    cp QUICK_BUILD_GUIDE.txt "$OUTPUT_DIR/" 2>/dev/null
    echo "[OK] Documentation copied"
    
    echo "[4/5] Creating empty directories..."
    mkdir -p "$OUTPUT_DIR/bin"
    mkdir -p "$OUTPUT_DIR/obj"
    mkdir -p "$OUTPUT_DIR/data"
    echo "[OK] Directories created"
    
    echo "[5/5] Creating instructions..."
    cat > "$OUTPUT_DIR/README.txt" << 'EOF'
========================================
WINDOWS BUILD INSTRUCTIONS
========================================

QUICK START:
------------
1. Open MSYS2 MinGW 64-bit terminal

2. Navigate to this folder:
   cd /c/path/to/WindowsBuild

3. Run:
   ./BUILD_INSTALLER.bat

4. Wait for completion

5. Find installer:
   installer\StockManagement_Installer.exe

DETAILED STEPS:
---------------
1. Install MSYS2 (if not installed):
   Download: https://www.msys2.org/

2. Install GTK (in MSYS2 terminal):
   pacman -S mingw-w64-x86_64-gtk3
   pacman -S mingw-w64-x86_64-pkg-config

3. Install Inno Setup (for installer):
   Download: https://jrsoftware.org/isdl.php

4. Run BUILD_INSTALLER.bat

That's it!
EOF
    echo "[OK] Instructions created"
    
    echo ""
    echo "=========================================="
    echo "[SUCCESS] Files prepared!"
    echo "=========================================="
    echo ""
    echo "Output folder: $OUTPUT_DIR"
    echo ""
    echo "Next steps:"
    echo "  1. Copy '$OUTPUT_DIR' folder to Windows"
    echo "  2. On Windows, open MSYS2 MinGW terminal"
    echo "  3. Navigate to the folder"
    echo "  4. Run: ./BUILD_INSTALLER.bat"
    echo ""
    echo "Or zip it for easy transfer:"
    echo "  zip -r WindowsBuild.zip $OUTPUT_DIR"
    echo ""
    
else
    echo "Invalid option. Exiting."
    exit 1
fi
