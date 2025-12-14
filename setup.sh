#!/bin/bash
# Setup script for Stock Management System

echo "=== Stock Management System Setup ==="
echo ""

# Check if GTK is installed
echo "Checking for GTK+ 3.0..."
if pkg-config --modversion gtk+-3.0 > /dev/null 2>&1; then
    GTK_VERSION=$(pkg-config --modversion gtk+-3.0)
    echo "✓ GTK+ 3.0 found: version $GTK_VERSION"
else
    echo "✗ GTK+ 3.0 not found!"
    echo ""
    echo "Please install GTK+ 3.0:"
    echo "  macOS:   brew install gtk+3 pkg-config"
    echo "  Linux:   sudo apt-get install libgtk-3-dev pkg-config"
    echo "  Windows: See INSTALL_GTK.md"
    echo ""
    exit 1
fi

# Check for GCC
echo "Checking for GCC compiler..."
if command -v gcc &> /dev/null; then
    GCC_VERSION=$(gcc --version | head -n1)
    echo "✓ GCC found: $GCC_VERSION"
else
    echo "✗ GCC not found! Please install a C compiler."
    exit 1
fi

# Check for make
echo "Checking for make..."
if command -v make &> /dev/null; then
    echo "✓ make found"
else
    echo "✗ make not found! Please install make."
    exit 1
fi

echo ""
echo "=== Setup Complete ==="
echo ""
echo "You can now build the project with:"
echo "  make"
echo ""
echo "Or run it directly:"
echo "  make run"
echo ""

