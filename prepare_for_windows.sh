#!/bin/bash
# Script to prepare files for copying to Windows
# Creates a clean folder with only necessary files

echo "=========================================="
echo "Preparing Files for Windows Transfer"
echo "=========================================="
echo ""

# Create output directory
OUTPUT_DIR="Cexamwinne_ForWindows"
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

echo "[1/5] Copying source files..."
cp -r src "$OUTPUT_DIR/"
echo "[OK] Source files copied"

echo "[2/5] Copying build scripts..."
cp build_windows.bat "$OUTPUT_DIR/" 2>/dev/null
cp build_standalone.bat "$OUTPUT_DIR/" 2>/dev/null
cp bundle_dlls.bat "$OUTPUT_DIR/" 2>/dev/null
cp BUILD_SINGLE_EXE.bat "$OUTPUT_DIR/" 2>/dev/null
cp create_sfx_7zip.bat "$OUTPUT_DIR/" 2>/dev/null
cp verify_package.bat "$OUTPUT_DIR/" 2>/dev/null
echo "[OK] Build scripts copied"

echo "[3/5] Copying Makefile..."
cp Makefile.windows "$OUTPUT_DIR/" 2>/dev/null
echo "[OK] Makefile copied"

echo "[4/5] Copying documentation..."
cp FILES_TO_COPY_TO_WINDOWS.txt "$OUTPUT_DIR/" 2>/dev/null
cp QUICK_BUILD_GUIDE.txt "$OUTPUT_DIR/" 2>/dev/null
cp SINGLE_EXE_GUIDE.md "$OUTPUT_DIR/" 2>/dev/null
cp BUILD_FOR_DISTRIBUTION.md "$OUTPUT_DIR/" 2>/dev/null
echo "[OK] Documentation copied"

echo "[5/5] Creating empty directories..."
mkdir -p "$OUTPUT_DIR/bin"
mkdir -p "$OUTPUT_DIR/obj"
mkdir -p "$OUTPUT_DIR/data"
echo "[OK] Directories created"

echo ""
echo "=========================================="
echo "[SUCCESS] Files prepared!"
echo "=========================================="
echo ""
echo "Output folder: $OUTPUT_DIR"
echo ""
echo "This folder contains only what you need for Windows."
echo ""
echo "Next steps:"
echo "  1. Copy '$OUTPUT_DIR' folder to Windows"
echo "  2. On Windows, open MSYS2 MinGW terminal"
echo "  3. Navigate to the folder"
echo "  4. Run: ./build_standalone.bat"
echo ""
echo "Or zip it:"
echo "  zip -r Cexamwinne_ForWindows.zip $OUTPUT_DIR"
echo ""
