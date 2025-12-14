# Stock Management System
## C Final Project - Exam D-F

A GUI-based stock management system built with C and GTK+ 3.0.

## Features

- ✅ Add Product with validation
- ✅ View Products (table with color coding for low stock)
- ✅ Update Stock
- ✅ Sell Product with stock checking
- ✅ Check Stock Level with warnings
- ✅ Calculate Stock Value
- ✅ Apply Discount (10-20%)
- ✅ Remove Product with confirmation
- ✅ Stock History tracking
- ✅ Generate Report window

## Requirements

- C Compiler (GCC)
- GTK+ 3.0 development libraries
- pkg-config

## Installation

### macOS
```bash
brew install gtk+3 pkg-config
```

### Linux (Ubuntu/Debian)
```bash
sudo apt-get install libgtk-3-dev pkg-config
```

### Windows
Install GTK+ 3.0 via MSYS2 or vcpkg.

## Building

```bash
# Check if GTK is installed
make check-gtk

# Build the project
make

# Run the application
make run

# Or manually:
./bin/stock_management
```

## Project Structure

```
.
├── src/              # Source code files
│   ├── main.c        # Entry point
│   ├── product.c/h   # Product operations
│   ├── file_io.c/h   # File persistence
│   ├── gui_main.c/h  # Main window
│   ├── gui_dialogs.c/h # Dialog windows
│   ├── validation.c/h # Input validation
│   └── history.c/h   # History tracking
├── data/             # Data files (created at runtime)
├── obj/              # Object files (created during build)
├── bin/              # Executable (created during build)
├── Makefile          # Build configuration
└── README.md         # This file
```

## Usage

1. **Add Product**: Fill in ID, name, category, price, and quantity, then click "Add Product"
2. **View Products**: Products are displayed in the table. Low stock items (<5) appear in red
3. **Update Stock**: Enter product ID and quantity (>5) to add stock
4. **Sell Product**: Enter product ID and quantity (>5) to sell
5. **Check Stock**: Enter product ID to check current stock level
6. **Calculate Value**: Click to see total inventory value
7. **Apply Discount**: Enter discount % (10-20) and apply to sales
8. **Remove Product**: Enter product ID and confirm removal
9. **View History**: All operations are logged in the history panel
10. **Generate Report**: Click to see summary report

## Data Persistence

Product data is automatically saved to `data/products.dat` when the application closes and loaded when it starts.

## Compiling for Windows (.exe)

To create a Windows executable:

1. Use MinGW-w64 cross-compiler or compile on Windows
2. Install GTK+ 3.0 for Windows
3. Use the same Makefile or compile manually:
   ```bash
   gcc -o stock_management.exe $(pkg-config --cflags --libs gtk+-3.0) src/*.c
   ```

## Notes

- All validation rules are enforced as per exam requirements
- Products with quantity < 5 are highlighted in red
- All operations are logged in the history
- The application creates a standalone executable

## License

This is a student project for academic purposes.

