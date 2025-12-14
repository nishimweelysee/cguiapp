#!/bin/bash
# Build script for Windows .exe (run in MSYS2 MinGW terminal)

echo "========================================"
echo "Stock Management System - Windows Build"
echo "========================================"
echo ""

# Check if pkg-config exists
if ! command -v pkg-config &> /dev/null; then
    echo "[ERROR] pkg-config not found!"
    echo "Please install: pacman -S mingw-w64-x86_64-pkg-config"
    exit 1
fi

# Check if GTK is installed
if ! pkg-config --modversion gtk+-3.0 &> /dev/null; then
    echo "[ERROR] GTK+ 3.0 not found!"
    echo "Please install: pacman -S mingw-w64-x86_64-gtk3"
    exit 1
fi

echo "[OK] GTK+ 3.0 found: $(pkg-config --modversion gtk+-3.0)"
echo ""

# Create directories
echo "Creating directories..."
mkdir -p bin obj data
echo "[OK] Directories created"
echo ""

# Compile
echo "Compiling source files..."
gcc -Wall -Wextra -std=c11 -mwindows \
    -o bin/stock_management.exe \
    $(pkg-config --cflags --libs gtk+-3.0) \
    src/*.c

if [ $? -ne 0 ]; then
    echo ""
    echo "[ERROR] Build failed!"
    echo "Check the error messages above."
    exit 1
fi

echo ""
echo "========================================"
echo "[SUCCESS] Build completed!"
echo "========================================"
echo ""
echo "Executable: bin/stock_management.exe"
echo ""
echo "To run: ./bin/stock_management.exe"
echo ""

