# Installing GTK+ 3.0

## macOS Installation

### Step 1: Install Homebrew (if not already installed)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Step 2: Install GTK+ 3.0
```bash
brew install gtk+3 pkg-config
```

### Step 3: Verify Installation
```bash
pkg-config --modversion gtk+-3.0
```
You should see a version number like `3.24.xx`

### Step 4: Set up PATH (if needed)
If pkg-config is not found, add Homebrew to your PATH:
```bash
echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

## Linux Installation (Ubuntu/Debian)

```bash
sudo apt-get update
sudo apt-get install libgtk-3-dev pkg-config build-essential
```

## Windows Installation

### Option 1: Using MSYS2 (Recommended)
1. Download and install MSYS2 from https://www.msys2.org/
2. Open MSYS2 terminal and run:
```bash
pacman -S mingw-w64-x86_64-gtk3
pacman -S mingw-w64-x86_64-pkg-config
pacman -S mingw-w64-x86_64-gcc
```

### Option 2: Using vcpkg
1. Install vcpkg
2. Install GTK:
```bash
vcpkg install gtk:x64-windows
```

## Testing the Installation

After installation, test if GTK works:

```bash
# Check if GTK is detected
pkg-config --cflags --libs gtk+-3.0
```

If you see output with include and library paths, GTK is properly installed!

## Next Steps

Once GTK is installed, you can build the project:

```bash
make check-gtk  # Verify GTK installation
make            # Build the project
make run        # Run the application
```

