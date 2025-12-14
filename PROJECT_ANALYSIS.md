# C Final Project - Stock Management System Analysis

## Exam Overview
- **Total Marks:** 40
  - 25 marks: Application Functionality
  - 8 marks: Project Report
  - 7 marks: Innovation & Creativity

## Project Type
**GUI-Based Stock Management System** using C programming language

## Key Requirements Summary

### 1. Technology Stack
- **Language:** C (mandatory)
- **GUI Framework:** Any (GTK, WinAPI 32, FLTK, etc.)
- **Storage:** Persistent file storage required

### 2. Deliverables
- Written report explaining the project in detail
- All source code files
- Compiled .exe application (standalone, no additional setup needed)
- **Critical:** Each submission must be unique (plagiarism = 0 marks)

---

## Functional Requirements Breakdown (25 marks)

### 1. Add Product (3 marks)
**Requirements:**
- Button: "Add Product"
- Input fields: Product name, ID, price per unit, initial quantity
- Validation:
  - Quantity > 0
  - Price > 0
- Output: Confirmation dialog

**Implementation Notes:**
- Need GUI form with text fields
- Input validation logic
- Product data structure (ID, name, category, quantity, price)
- Store in data structure (array/linked list)

### 2. View Products (2 marks)
**Requirements:**
- Display all products in GUI table
- Columns: ID, name, category, quantity, price
- **Visual:** Products with quantity < 5 displayed in RED color

**Implementation Notes:**
- Table widget (GTK: GtkTreeView, WinAPI: ListView)
- Color coding logic
- Refresh mechanism

### 3. Update Stock (2 marks)
**Requirements:**
- Input: Product ID + additional quantity
- Validation: Quantity to add must be > 5
- Action: Update stock, refresh table

**Implementation Notes:**
- Search by Product ID
- Validation check
- Update quantity field
- Refresh display

### 4. Sell Product (3 marks)
**Requirements:**
- Input: Product ID + quantity to sell
- Validation: Quantity must be > 5
- Logic:
  - Check stock availability
  - If sufficient → reduce quantity, calculate total sales
- Output: Confirmation or error dialog

**Implementation Notes:**
- Stock availability check
- Quantity reduction
- Sales calculation (quantity × price)
- Error handling for insufficient stock

### 5. Check Stock Level (2 marks)
**Requirements:**
- Input: Product ID
- Output: Current stock level in message dialog
- Special: If stock < 5, display warning dialog

**Implementation Notes:**
- Search functionality
- Conditional dialog (normal vs warning)

### 6. Calculate Stock Value (2 marks)
**Requirements:**
- Formula: Σ(quantity × unit price) for all products
- Display: Result in modal popup

**Implementation Notes:**
- Iterate through all products
- Sum calculation
- Modal dialog display

### 7. Apply Discount (3 marks)
**Requirements:**
- Input: Discount percentage (10-20%)
- Action: Apply to selected item sale
- Output: Show discounted amount

**Implementation Notes:**
- Discount validation (10-20% range)
- Discount calculation: original_price × (1 - discount/100)
- Display original and discounted prices

### 8. Remove Product (2 marks)
**Requirements:**
- Input: Product ID
- Confirmation: GUI confirmation dialog
- Action: Remove from list, refresh display

**Implementation Notes:**
- Search by ID
- Confirmation dialog (Yes/No)
- Deletion from data structure
- UI refresh

### 9. Stock History (2 marks)
**Requirements:**
- Record all operations: add, sell, update, remove
- Display: Chronological history in scrollable list widget

**Implementation Notes:**
- History data structure (array/list)
- Log each operation with timestamp/details
- Scrollable list widget
- Chronological ordering

### 10. Generate Report (4 marks)
**Requirements:**
- Display summary in dedicated GUI window/popup:
  - Total products
  - Stock value
  - Stock sold
  - Most active product

**Implementation Notes:**
- Calculate metrics:
  - Count total products
  - Calculate total stock value (same as requirement #6)
  - Track total stock sold (sum of all sales)
  - Identify most active product (highest sales quantity)
- Dedicated report window

---

## Data Structure Design

### Product Structure
```c
typedef struct {
    char product_id[50];
    char product_name[100];
    char category[50];
    float price_per_unit;
    int quantity;
} Product;
```

### History Entry Structure
```c
typedef struct {
    char operation[20];  // "ADD", "SELL", "UPDATE", "REMOVE"
    char product_id[50];
    int quantity;
    char timestamp[50];
} HistoryEntry;
```

### Global Data
- Array/Linked list of Products
- Array/Linked list of History entries
- Total sales tracking
- File for persistent storage

---

## File Storage Requirements
- Save products to file (on exit or periodically)
- Load products from file (on startup)
- Format: Text file (CSV) or binary file

---

## GUI Framework Recommendations

### Option 1: GTK+ (Cross-platform)
- **Pros:** Cross-platform, modern, good documentation
- **Cons:** Requires GTK installation
- **Widgets:** GtkWindow, GtkEntry, GtkButton, GtkTreeView, GtkDialog

### Option 2: WinAPI 32 (Windows only)
- **Pros:** Native Windows, no dependencies
- **Cons:** Windows-only, more complex
- **Widgets:** CreateWindow, Edit controls, ListView, MessageBox

### Option 3: FLTK (Fast Light Toolkit)
- **Pros:** Lightweight, cross-platform
- **Cons:** Less common, smaller community

---

## Implementation Checklist

### Core Functionality
- [ ] Product data structure
- [ ] Add Product with validation
- [ ] View Products table with color coding
- [ ] Update Stock
- [ ] Sell Product with stock check
- [ ] Check Stock Level with warning
- [ ] Calculate Stock Value
- [ ] Apply Discount (10-20%)
- [ ] Remove Product with confirmation
- [ ] Stock History logging and display
- [ ] Generate Report window

### Technical Requirements
- [ ] File I/O for persistence
- [ ] Input validation throughout
- [ ] Error handling
- [ ] GUI responsiveness
- [ ] Standalone executable

### Documentation
- [ ] Written report
- [ ] Code comments
- [ ] User instructions

---

## Critical Points

1. **Validation Requirements:**
   - Add Product: quantity > 0, price > 0
   - Update Stock: quantity to add > 5
   - Sell Product: quantity to sell > 5
   - Discount: 10-20% range

2. **Visual Requirements:**
   - Products with quantity < 5 in RED
   - Confirmation dialogs for critical operations
   - Modal popups for reports

3. **Data Persistence:**
   - Must save/load from file
   - Application should remember data between runs

4. **Standalone Executable:**
   - Must run without additional setup
   - All dependencies bundled or statically linked

---

## Suggested Project Structure

```
project/
├── main.c              # Entry point, GUI setup
├── product.c/.h        # Product data structure and operations
├── file_io.c/.h        # File save/load functions
├── history.c/.h        # History tracking
├── gui_*.c/.h          # GUI-specific functions
├── validation.c/.h     # Input validation functions
├── report.c/.h         # Report generation
├── Makefile            # Build configuration
└── README.md           # Documentation
```

---

## Marking Distribution Reminder

- **Application Functionality:** 25 marks (detailed above)
- **Project Report:** 8 marks (written documentation)
- **Innovation & Creativity:** 7 marks (extra features, UI design, etc.)

---

## Next Steps

1. Choose GUI framework
2. Design data structures
3. Implement core product management
4. Add GUI components
5. Implement file I/O
6. Add history tracking
7. Create report generation
8. Testing and refinement
9. Write project report
10. Create standalone executable

