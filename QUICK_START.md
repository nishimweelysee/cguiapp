# Quick Start Guide

## 🚀 Getting Started in 3 Steps

### Step 1: Install GTK+ 3.0

**macOS:**
```bash
brew install gtk+3 pkg-config
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt-get install libgtk-3-dev pkg-config build-essential
```

**Windows:**
See `INSTALL_GTK.md` for detailed instructions.

### Step 2: Verify Setup
```bash
./setup.sh
```

This will check if all dependencies are installed correctly.

### Step 3: Build and Run
```bash
make          # Build the project
make run      # Run the application
```

Or manually:
```bash
./bin/stock_management
```

## 📁 Project Structure

```
.
├── src/              # All source code
│   ├── main.c        # Entry point
│   ├── product.c/h   # Product management
│   ├── gui_main.c/h  # Main window UI
│   ├── gui_dialogs.c/h # Dialogs & reports
│   ├── file_io.c/h   # Data persistence
│   ├── validation.c/h # Input validation
│   └── history.c/h   # Operation history
├── Makefile          # Build configuration
├── README.md         # Full documentation
└── setup.sh          # Setup verification script
```

## ✅ Features Implemented

All 10 required features are implemented:

1. ✅ **Add Product** - With validation (qty > 0, price > 0)
2. ✅ **View Products** - Table with red color for low stock (<5)
3. ✅ **Update Stock** - Add quantity (>5 required)
4. ✅ **Sell Product** - With stock availability check (>5 required)
5. ✅ **Check Stock Level** - With warning for low stock
6. ✅ **Calculate Stock Value** - Total inventory value
7. ✅ **Apply Discount** - 10-20% discount validation
8. ✅ **Remove Product** - With confirmation dialog
9. ✅ **Stock History** - Chronological operation log
10. ✅ **Generate Report** - Summary window with all metrics

## 🎨 GUI Features

- Modern GTK+ 3.0 interface
- Color-coded product table (red for low stock)
- Scrollable history panel
- Modal dialogs for confirmations
- Dedicated report window
- Input validation with error messages

## 💾 Data Persistence

- Products are automatically saved to `data/products.dat`
- Data is loaded when the application starts
- No manual save required

## 🔧 Troubleshooting

### "GTK not found" error
- Make sure GTK+ 3.0 is installed
- Run `pkg-config --modversion gtk+-3.0` to verify
- Check `INSTALL_GTK.md` for installation help

### "pkg-config not found"
- Install pkg-config: `brew install pkg-config` (macOS)
- Or: `sudo apt-get install pkg-config` (Linux)

### Build errors
- Make sure all source files are in the `src/` directory
- Check that GTK development headers are installed
- Try: `make clean && make`

## 📝 Next Steps

1. **Test the application** - Try adding products, selling, etc.
2. **Customize** - Modify colors, layout, or add features
3. **Compile for Windows** - See `GUI_FRAMEWORK_SETUP.md` for .exe creation
4. **Write Report** - Document your implementation

## 🎯 Exam Requirements Checklist

- ✅ All 10 features implemented
- ✅ GUI-based interface
- ✅ Input validation
- ✅ File persistence
- ✅ Color coding (red for low stock)
- ✅ Confirmation dialogs
- ✅ Report generation
- ✅ History tracking
- ✅ Standalone executable (after compilation)

Good luck with your exam! 🎓

