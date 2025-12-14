# GUI Framework Setup Guide

## Framework Comparison

### Option 1: GTK+ (GTK3) ⭐ **RECOMMENDED**

**Pros:**

- ✅ Cross-platform (Windows, macOS, Linux)
- ✅ Excellent documentation and examples
- ✅ All required widgets (tables, dialogs, buttons, entries)
- ✅ Active community support
- ✅ Can create Windows .exe with proper toolchain

**Cons:**

- Requires installation on development machine
- Slightly larger executable size

**Best for:** Cross-platform development, modern UI, good documentation

---

### Option 2: WinAPI 32 (Windows API)

**Pros:**

- ✅ Native Windows, no dependencies
- ✅ Small executable size
- ✅ Direct system integration

**Cons:**

- ❌ Windows-only (not suitable if you need macOS/Linux)
- ❌ More complex API
- ❌ Steeper learning curve

**Best for:** Windows-only applications, minimal dependencies

---

### Option 3: FLTK (Fast Light Toolkit)

**Pros:**

- ✅ Lightweight
- ✅ Cross-platform
- ✅ Small executable

**Cons:**

- ❌ Less common, smaller community
- ❌ Fewer examples and tutorials
- ❌ Less modern appearance

**Best for:** Simple applications, minimal resource usage

---

## Recommendation: GTK+ 3.0

**Why GTK+?**

1. Cross-platform development (you're on macOS, but need .exe for Windows)
2. All required widgets available:
   - GtkTreeView (for product table)
   - GtkDialog (for confirmations, reports)
   - GtkEntry (for input fields)
   - GtkButton (for actions)
   - GtkLabel (for displays)
3. Excellent documentation at: https://docs.gtk.org/gtk3/
4. Can create Windows executables using MinGW or MSYS2

---

## Installation Instructions

### macOS (Your Current System)

#### Method 1: Using Homebrew (Recommended)

```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install GTK+ 3.0
brew install gtk+3

# Install pkg-config (if not already installed)
brew install pkg-config
```

#### Method 2: Using MacPorts

```bash
sudo port install gtk3
```

### Verify Installation

```bash
pkg-config --modversion gtk+-3.0
# Should output something like: 3.24.xx
```

---

## Compiling for Windows (.exe)

Since the exam requires a .exe file, you have several options:

### Option A: Cross-compile from macOS

1. Install MinGW-w64 cross-compiler
2. Install GTK+ for Windows
3. Use cross-compilation toolchain

### Option B: Use Windows Machine/Virtual Machine

1. Install GTK+ on Windows (via MSYS2 or vcpkg)
2. Compile directly on Windows
3. Create standalone .exe

### Option C: Use GitHub Actions / CI/CD

- Set up automated Windows builds

**Recommended:** Use a Windows machine or VM for final compilation to ensure the .exe works correctly.

---

## Project Structure

```
stock_management/
├── src/
│   ├── main.c              # Entry point, GUI initialization
│   ├── product.c           # Product data structure & operations
│   ├── product.h
│   ├── file_io.c           # File save/load functions
│   ├── file_io.h
│   ├── history.c           # History tracking
│   ├── history.h
│   ├── gui_main.c          # Main window GUI
│   ├── gui_main.h
│   ├── gui_dialogs.c        # Dialog windows (confirmations, reports)
│   ├── gui_dialogs.h
│   ├── validation.c        # Input validation
│   ├── validation.h
│   └── report.c            # Report generation
│   └── report.h
├── data/
│   └── products.dat        # Data file (created at runtime)
├── Makefile                # Build configuration
├── README.md               # Project documentation
└── compile.sh              # Compilation script
```

---

## Basic GTK+ Program Template

See `src/main.c` for a complete starter template.

---

## Compilation Commands

### macOS/Linux:

```bash
gcc -o stock_management $(pkg-config --cflags --libs gtk+-3.0) src/*.c
```

### Windows (MinGW):

```bash
gcc -o stock_management.exe $(pkg-config --cflags --libs gtk+-3.0) src/*.c
```

### Using Makefile:

```bash
make
```

---

## Next Steps

1. Install GTK+ 3.0 on your system
2. Review the starter template code
3. Build and test the basic window
4. Start implementing features one by one
