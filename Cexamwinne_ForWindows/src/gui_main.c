/*
 * Main GUI Window Implementation
 * 
 * This file contains the main window with all buttons and the product table
 */

#include <gtk/gtk.h>
#include <stdio.h>
#include <string.h>
#include "gui_main.h"
#include "product.h"
#include "gui_dialogs.h"
#include "validation.h"

// Forward declaration (function is defined later in this file)
void refresh_history_display(void);

// External references
extern Product products[MAX_PRODUCTS];
extern int product_count;
extern HistoryEntry history[MAX_HISTORY];
extern int history_count;
extern float total_sales;

// Widget references
static GtkWidget* main_window = NULL;
static GtkWidget* product_tree_view = NULL;
static GtkWidget* history_text_view = NULL;
static GtkListStore* product_store = NULL;

// Entry fields for Add Product
static GtkWidget* entry_product_id = NULL;
static GtkWidget* entry_product_name = NULL;
static GtkWidget* entry_category = NULL;
static GtkWidget* entry_price = NULL;
static GtkWidget* entry_quantity = NULL;

// Entry fields for other operations
static GtkWidget* entry_update_id = NULL;
static GtkWidget* entry_update_qty = NULL;
static GtkWidget* entry_sell_id = NULL;
static GtkWidget* entry_sell_qty = NULL;
static GtkWidget* entry_check_id = NULL;
static GtkWidget* entry_remove_id = NULL;
static GtkWidget* entry_discount_id = NULL;
static GtkWidget* entry_discount_qty = NULL;
static GtkWidget* entry_discount_percent = NULL;

// Callback: Add Product button clicked
void on_add_product_clicked(G_GNUC_UNUSED GtkButton* button, G_GNUC_UNUSED gpointer user_data) {
    const char* id = gtk_entry_get_text(GTK_ENTRY(entry_product_id));
    const char* name = gtk_entry_get_text(GTK_ENTRY(entry_product_name));
    const char* category = gtk_entry_get_text(GTK_ENTRY(entry_category));
    const char* price_str = gtk_entry_get_text(GTK_ENTRY(entry_price));
    const char* qty_str = gtk_entry_get_text(GTK_ENTRY(entry_quantity));
    
    // Validate inputs
    if (strlen(id) == 0 || strlen(name) == 0) {
        show_error_dialog("Please fill in all fields");
        return;
    }
    
    float price = atof(price_str);
    int quantity = atoi(qty_str);
    
    if (!validate_add_product(quantity, price)) {
        show_error_dialog("Invalid input: Quantity and price must be > 0");
        return;
    }
    
    // Add product
    int result = add_product(id, name, category, price, quantity);
    if (result == -1) {
        show_error_dialog("Product ID already exists!");
        return;
    }
    
    if (result == 1) {
        show_info_dialog("Product added successfully!");
        // Clear fields
        gtk_entry_set_text(GTK_ENTRY(entry_product_id), "");
        gtk_entry_set_text(GTK_ENTRY(entry_product_name), "");
        gtk_entry_set_text(GTK_ENTRY(entry_category), "");
        gtk_entry_set_text(GTK_ENTRY(entry_price), "");
        gtk_entry_set_text(GTK_ENTRY(entry_quantity), "");
        refresh_product_table();
        refresh_history_display();
    }
}

// Callback: Update Stock button clicked
void on_update_stock_clicked(G_GNUC_UNUSED GtkButton* button, G_GNUC_UNUSED gpointer user_data) {
    const char* id = gtk_entry_get_text(GTK_ENTRY(entry_update_id));
    const char* qty_str = gtk_entry_get_text(GTK_ENTRY(entry_update_qty));
    
    if (strlen(id) == 0) {
        show_error_dialog("Please enter Product ID");
        return;
    }
    
    int qty = atoi(qty_str);
    if (!validate_update_stock(qty)) {
        show_error_dialog("Quantity to add must be > 5");
        return;
    }
    
    if (update_stock(id, qty)) {
        char msg[200];
        snprintf(msg, sizeof(msg), "Stock updated successfully! Added %d units.", qty);
        show_info_dialog(msg);
        gtk_entry_set_text(GTK_ENTRY(entry_update_id), "");
        gtk_entry_set_text(GTK_ENTRY(entry_update_qty), "");
        refresh_product_table();
        refresh_history_display();
    } else {
        show_error_dialog("Product not found!");
    }
}

// Callback: Sell Product button clicked
void on_sell_product_clicked(G_GNUC_UNUSED GtkButton* button, G_GNUC_UNUSED gpointer user_data) {
    const char* id = gtk_entry_get_text(GTK_ENTRY(entry_sell_id));
    const char* qty_str = gtk_entry_get_text(GTK_ENTRY(entry_sell_qty));
    
    if (strlen(id) == 0) {
        show_error_dialog("Please enter Product ID");
        return;
    }
    
    int qty = atoi(qty_str);
    if (!validate_sell_product(qty)) {
        show_error_dialog("Quantity to sell must be > 5");
        return;
    }
    
    int result = sell_product(id, qty);
    if (result == -1) {
        show_error_dialog("Product not found!");
    } else if (result == -2) {
        show_error_dialog("Insufficient stock!");
    } else {
        char msg[200];
        snprintf(msg, sizeof(msg), "Sale successful! Total: %.2f RWF", (float)result);
        show_info_dialog(msg);
        gtk_entry_set_text(GTK_ENTRY(entry_sell_id), "");
        gtk_entry_set_text(GTK_ENTRY(entry_sell_qty), "");
        refresh_product_table();
        refresh_history_display();
    }
}

// Callback: Check Stock Level button clicked
void on_check_stock_clicked(G_GNUC_UNUSED GtkButton* button, G_GNUC_UNUSED gpointer user_data) {
    const char* id = gtk_entry_get_text(GTK_ENTRY(entry_check_id));
    
    if (strlen(id) == 0) {
        show_error_dialog("Please enter Product ID");
        return;
    }
    
    Product* p = find_product_by_id(id);
    if (p == NULL) {
        show_error_dialog("Product not found!");
        return;
    }
    
    char msg[300];
    
    if (p->quantity < 5) {
        // Low stock warning - make it very clear
        snprintf(msg, sizeof(msg), 
                 "⚠️ LOW STOCK WARNING ⚠️\n\n"
                 "Product: %s (ID: %s)\n"
                 "Current Stock: %d units\n\n"
                 "WARNING: Stock level is below 5 units!\n"
                 "Please restock immediately.",
                 p->product_name, p->product_id, p->quantity);
        show_warning_dialog(msg);
    } else {
        // Normal stock level
        snprintf(msg, sizeof(msg), 
                 "Product: %s (ID: %s)\n"
                 "Current Stock: %d units\n\n"
                 "Stock level is adequate.",
                 p->product_name, p->product_id, p->quantity);
        show_info_dialog(msg);
    }
}

// Callback: Calculate Stock Value button clicked
void on_calculate_value_clicked(G_GNUC_UNUSED GtkButton* button, G_GNUC_UNUSED gpointer user_data) {
    float value = calculate_stock_value();
    char msg[200];
    snprintf(msg, sizeof(msg), "Total Stock Value: %.2f RWF", value);
    show_info_dialog(msg);
}

// Callback: Apply Discount button clicked
void on_apply_discount_clicked(G_GNUC_UNUSED GtkButton* button, G_GNUC_UNUSED gpointer user_data) {
    const char* id = gtk_entry_get_text(GTK_ENTRY(entry_discount_id));
    const char* qty_str = gtk_entry_get_text(GTK_ENTRY(entry_discount_qty));
    const char* percent_str = gtk_entry_get_text(GTK_ENTRY(entry_discount_percent));
    
    // Validate inputs
    if (strlen(id) == 0) {
        show_error_dialog("Please enter Product ID");
        return;
    }
    
    float discount_percent = atof(percent_str);
    if (!validate_discount(discount_percent)) {
        show_error_dialog("Discount must be between 10% and 20%");
        return;
    }
    
    // Find the product first
    Product* p = find_product_by_id(id);
    if (p == NULL) {
        show_error_dialog("Product not found!");
        return;
    }
    
    // Quantity is optional - if not provided, apply discount to unit price only
    int quantity = 0;
    int has_quantity = 0;
    
    if (strlen(qty_str) > 0) {
        quantity = atoi(qty_str);
        if (quantity <= 0) {
            show_error_dialog("Quantity must be greater than 0");
            return;
        }
        has_quantity = 1;
        
        // Check stock availability if quantity is specified
        if (p->quantity < quantity) {
            show_error_dialog("Insufficient stock!");
            return;
        }
    }
    
    // Calculate prices based on whether quantity is provided
    float original_price = p->price_per_unit;
    char msg[500];
    
    if (has_quantity) {
        // Apply discount to total sale amount
        float original_total = original_price * quantity;
        float discount_amount = original_total * (discount_percent / 100.0);
        float discounted_total = original_total - discount_amount;
        float discounted_price_per_unit = discounted_total / quantity;
        
        snprintf(msg, sizeof(msg),
                 "DISCOUNT APPLIED TO SALE\n\n"
                 "Product: %s (ID: %s)\n"
                 "Quantity: %d units\n\n"
                 "Original Price per Unit: %.2f RWF\n"
                 "Original Total: %.2f RWF\n\n"
                 "Discount: %.1f%%\n"
                 "Discount Amount: %.2f RWF\n\n"
                 "Discounted Total: %.2f RWF\n"
                 "Discounted Price per Unit: %.2f RWF",
                 p->product_name, p->product_id, quantity,
                 original_price, original_total,
                 discount_percent, discount_amount,
                 discounted_total, discounted_price_per_unit);
    } else {
        // Apply discount to unit price only
        float discount_amount = original_price * (discount_percent / 100.0);
        float discounted_price = original_price - discount_amount;
        
        snprintf(msg, sizeof(msg),
                 "DISCOUNT APPLIED TO UNIT PRICE\n\n"
                 "Product: %s (ID: %s)\n\n"
                 "Original Price per Unit: %.2f RWF\n\n"
                 "Discount: %.1f%%\n"
                 "Discount Amount: %.2f RWF\n\n"
                 "Discounted Price per Unit: %.2f RWF",
                 p->product_name, p->product_id,
                 original_price,
                 discount_percent, discount_amount,
                 discounted_price);
    }
    
    show_info_dialog(msg);
    
    // Optionally apply the discount to the sale (reduce stock and record)
    // Uncomment the following lines if you want to automatically process the sale:
    /*
    if (show_confirm_dialog("Do you want to complete this discounted sale?")) {
        sell_product(id, quantity);
        // Note: The sell_product function doesn't apply discount, so we'd need to
        // modify it or create a separate discounted_sell_product function
        refresh_product_table();
        refresh_history_display();
    }
    */
}

// Callback: Remove Product button clicked
void on_remove_product_clicked(G_GNUC_UNUSED GtkButton* button, G_GNUC_UNUSED gpointer user_data) {
    const char* id = gtk_entry_get_text(GTK_ENTRY(entry_remove_id));
    
    if (strlen(id) == 0) {
        show_error_dialog("Please enter Product ID");
        return;
    }
    
    Product* p = find_product_by_id(id);
    if (p == NULL) {
        show_error_dialog("Product not found!");
        return;
    }
    
    // Show confirmation dialog
    if (show_confirm_dialog("Are you sure you want to remove this product?")) {
        if (remove_product(id)) {
            show_info_dialog("Product removed successfully!");
            gtk_entry_set_text(GTK_ENTRY(entry_remove_id), "");
            refresh_product_table();
            refresh_history_display();
        }
    }
}

// Callback: Generate Report button clicked
void on_generate_report_clicked(G_GNUC_UNUSED GtkButton* button, G_GNUC_UNUSED gpointer user_data) {
    show_report_window();
}

// Refresh the product table display
void refresh_product_table(void) {
    if (product_store == NULL) return;
    
    // Clear existing data
    gtk_list_store_clear(product_store);
    
    // Add all products
    for (int i = 0; i < product_count; i++) {
        GtkTreeIter iter;
        gtk_list_store_append(product_store, &iter);
        
        char price_str[50], qty_str[50];
        snprintf(price_str, sizeof(price_str), "%.2f", products[i].price_per_unit);
        snprintf(qty_str, sizeof(qty_str), "%d", products[i].quantity);
        
        // Set color based on quantity
        const char* color = (products[i].quantity < 5) ? "red" : "black";
        
        gtk_list_store_set(product_store, &iter,
                          0, products[i].product_id,
                          1, products[i].product_name,
                          2, products[i].category,
                          3, qty_str,
                          4, price_str,
                          5, color,  // Color for foreground
                          -1);
    }
}

// Refresh history display
void refresh_history_display(void) {
    if (history_text_view == NULL) return;
    
    GtkTextBuffer* buffer = gtk_text_view_get_buffer(GTK_TEXT_VIEW(history_text_view));
    gtk_text_buffer_set_text(buffer, "", -1);
    
    GtkTextIter iter;
    gtk_text_buffer_get_start_iter(buffer, &iter);
    
    for (int i = 0; i < history_count; i++) {
        char line[200];
        snprintf(line, sizeof(line), "[%s] %s - Product: %s, Qty: %d\n",
                 history[i].timestamp, history[i].operation, 
                 history[i].product_id, history[i].quantity);
        gtk_text_buffer_insert(buffer, &iter, line, -1);
    }
}

// Create main window
void create_main_window(void) {
    GtkWidget* vbox_main, *hbox_bottom;
    GtkWidget* frame_add, *frame_operations, *frame_table, *frame_history;
    GtkWidget* label, *button;
    GtkWidget* scrolled_window;
    
    // Main window
    main_window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
    gtk_window_set_title(GTK_WINDOW(main_window), "Stock Management System");
    gtk_window_set_default_size(GTK_WINDOW(main_window), 1200, 800);
    g_signal_connect(main_window, "destroy", G_CALLBACK(gtk_main_quit), NULL);
    
    vbox_main = gtk_box_new(GTK_ORIENTATION_VERTICAL, 5);
    gtk_container_add(GTK_CONTAINER(main_window), vbox_main);
    
    // === ADD PRODUCT SECTION ===
    frame_add = gtk_frame_new("Add New Product");
    gtk_box_pack_start(GTK_BOX(vbox_main), frame_add, FALSE, FALSE, 5);
    
    GtkWidget* hbox_add = gtk_box_new(GTK_ORIENTATION_HORIZONTAL, 5);
    gtk_container_add(GTK_CONTAINER(frame_add), hbox_add);
    
    // Add product fields
    label = gtk_label_new("ID:");
    gtk_box_pack_start(GTK_BOX(hbox_add), label, FALSE, FALSE, 5);
    entry_product_id = gtk_entry_new();
    gtk_box_pack_start(GTK_BOX(hbox_add), entry_product_id, FALSE, FALSE, 5);
    
    label = gtk_label_new("Name:");
    gtk_box_pack_start(GTK_BOX(hbox_add), label, FALSE, FALSE, 5);
    entry_product_name = gtk_entry_new();
    gtk_box_pack_start(GTK_BOX(hbox_add), entry_product_name, FALSE, FALSE, 5);
    
    label = gtk_label_new("Category:");
    gtk_box_pack_start(GTK_BOX(hbox_add), label, FALSE, FALSE, 5);
    entry_category = gtk_entry_new();
    gtk_box_pack_start(GTK_BOX(hbox_add), entry_category, FALSE, FALSE, 5);
    
    label = gtk_label_new("Price:");
    gtk_box_pack_start(GTK_BOX(hbox_add), label, FALSE, FALSE, 5);
    entry_price = gtk_entry_new();
    gtk_box_pack_start(GTK_BOX(hbox_add), entry_price, FALSE, FALSE, 5);
    
    label = gtk_label_new("Quantity:");
    gtk_box_pack_start(GTK_BOX(hbox_add), label, FALSE, FALSE, 5);
    entry_quantity = gtk_entry_new();
    gtk_box_pack_start(GTK_BOX(hbox_add), entry_quantity, FALSE, FALSE, 5);
    
    button = gtk_button_new_with_label("Add Product");
    g_signal_connect(button, "clicked", G_CALLBACK(on_add_product_clicked), NULL);
    gtk_box_pack_start(GTK_BOX(hbox_add), button, FALSE, FALSE, 5);
    
    // === OPERATIONS SECTION ===
    frame_operations = gtk_frame_new("Operations");
    gtk_box_pack_start(GTK_BOX(vbox_main), frame_operations, FALSE, FALSE, 5);
    
    GtkWidget* grid_ops = gtk_grid_new();
    gtk_container_add(GTK_CONTAINER(frame_operations), grid_ops);
    gtk_grid_set_column_spacing(GTK_GRID(grid_ops), 5);
    gtk_grid_set_row_spacing(GTK_GRID(grid_ops), 5);
    
    // Update Stock
    label = gtk_label_new("Update Stock - ID:");
    gtk_grid_attach(GTK_GRID(grid_ops), label, 0, 0, 1, 1);
    entry_update_id = gtk_entry_new();
    gtk_grid_attach(GTK_GRID(grid_ops), entry_update_id, 1, 0, 1, 1);
    label = gtk_label_new("Qty (>5):");
    gtk_grid_attach(GTK_GRID(grid_ops), label, 2, 0, 1, 1);
    entry_update_qty = gtk_entry_new();
    gtk_grid_attach(GTK_GRID(grid_ops), entry_update_qty, 3, 0, 1, 1);
    button = gtk_button_new_with_label("Update Stock");
    g_signal_connect(button, "clicked", G_CALLBACK(on_update_stock_clicked), NULL);
    gtk_grid_attach(GTK_GRID(grid_ops), button, 4, 0, 1, 1);
    
    // Sell Product
    label = gtk_label_new("Sell Product - ID:");
    gtk_grid_attach(GTK_GRID(grid_ops), label, 0, 1, 1, 1);
    entry_sell_id = gtk_entry_new();
    gtk_grid_attach(GTK_GRID(grid_ops), entry_sell_id, 1, 1, 1, 1);
    label = gtk_label_new("Qty (>5):");
    gtk_grid_attach(GTK_GRID(grid_ops), label, 2, 1, 1, 1);
    entry_sell_qty = gtk_entry_new();
    gtk_grid_attach(GTK_GRID(grid_ops), entry_sell_qty, 3, 1, 1, 1);
    button = gtk_button_new_with_label("Sell Product");
    g_signal_connect(button, "clicked", G_CALLBACK(on_sell_product_clicked), NULL);
    gtk_grid_attach(GTK_GRID(grid_ops), button, 4, 1, 1, 1);
    
    // Check Stock
    label = gtk_label_new("Check Stock - ID:");
    gtk_grid_attach(GTK_GRID(grid_ops), label, 0, 2, 1, 1);
    entry_check_id = gtk_entry_new();
    gtk_grid_attach(GTK_GRID(grid_ops), entry_check_id, 1, 2, 1, 1);
    button = gtk_button_new_with_label("Check Stock Level");
    g_signal_connect(button, "clicked", G_CALLBACK(on_check_stock_clicked), NULL);
    gtk_grid_attach(GTK_GRID(grid_ops), button, 2, 2, 1, 1);
    
    // Calculate Value
    button = gtk_button_new_with_label("Calculate Stock Value");
    g_signal_connect(button, "clicked", G_CALLBACK(on_calculate_value_clicked), NULL);
    gtk_grid_attach(GTK_GRID(grid_ops), button, 3, 2, 1, 1);
    
    // Apply Discount
    label = gtk_label_new("Apply Discount - ID:");
    gtk_grid_attach(GTK_GRID(grid_ops), label, 0, 3, 1, 1);
    entry_discount_id = gtk_entry_new();
    gtk_grid_attach(GTK_GRID(grid_ops), entry_discount_id, 1, 3, 1, 1);
    label = gtk_label_new("Qty (optional):");
    gtk_grid_attach(GTK_GRID(grid_ops), label, 2, 3, 1, 1);
    entry_discount_qty = gtk_entry_new();
    gtk_grid_attach(GTK_GRID(grid_ops), entry_discount_qty, 3, 3, 1, 1);
    label = gtk_label_new("Discount % (10-20):");
    gtk_grid_attach(GTK_GRID(grid_ops), label, 0, 4, 1, 1);
    entry_discount_percent = gtk_entry_new();
    gtk_grid_attach(GTK_GRID(grid_ops), entry_discount_percent, 1, 4, 1, 1);
    button = gtk_button_new_with_label("Apply Discount");
    g_signal_connect(button, "clicked", G_CALLBACK(on_apply_discount_clicked), NULL);
    gtk_grid_attach(GTK_GRID(grid_ops), button, 2, 4, 1, 1);
    
    // Remove Product
    label = gtk_label_new("Remove Product - ID:");
    gtk_grid_attach(GTK_GRID(grid_ops), label, 0, 5, 1, 1);
    entry_remove_id = gtk_entry_new();
    gtk_grid_attach(GTK_GRID(grid_ops), entry_remove_id, 1, 5, 1, 1);
    button = gtk_button_new_with_label("Remove Product");
    g_signal_connect(button, "clicked", G_CALLBACK(on_remove_product_clicked), NULL);
    gtk_grid_attach(GTK_GRID(grid_ops), button, 2, 5, 1, 1);
    
    // Generate Report
    button = gtk_button_new_with_label("Generate Report");
    g_signal_connect(button, "clicked", G_CALLBACK(on_generate_report_clicked), NULL);
    gtk_grid_attach(GTK_GRID(grid_ops), button, 3, 5, 1, 1);
    
    // === PRODUCT TABLE ===
    hbox_bottom = gtk_box_new(GTK_ORIENTATION_HORIZONTAL, 5);
    gtk_box_pack_start(GTK_BOX(vbox_main), hbox_bottom, TRUE, TRUE, 5);
    
    frame_table = gtk_frame_new("Products");
    gtk_box_pack_start(GTK_BOX(hbox_bottom), frame_table, TRUE, TRUE, 5);
    
    // Create tree view for products (6 columns: 5 data + 1 color)
    product_store = gtk_list_store_new(6, G_TYPE_STRING, G_TYPE_STRING, G_TYPE_STRING, G_TYPE_STRING, G_TYPE_STRING, G_TYPE_STRING);
    product_tree_view = gtk_tree_view_new_with_model(GTK_TREE_MODEL(product_store));
    
    // Add columns with cell renderers
    GtkCellRenderer* renderer;
    
    renderer = gtk_cell_renderer_text_new();
    gtk_tree_view_insert_column_with_attributes(GTK_TREE_VIEW(product_tree_view), -1, "ID", renderer, "text", 0, "foreground", 5, NULL);
    
    renderer = gtk_cell_renderer_text_new();
    gtk_tree_view_insert_column_with_attributes(GTK_TREE_VIEW(product_tree_view), -1, "Name", renderer, "text", 1, "foreground", 5, NULL);
    
    renderer = gtk_cell_renderer_text_new();
    gtk_tree_view_insert_column_with_attributes(GTK_TREE_VIEW(product_tree_view), -1, "Category", renderer, "text", 2, "foreground", 5, NULL);
    
    renderer = gtk_cell_renderer_text_new();
    gtk_tree_view_insert_column_with_attributes(GTK_TREE_VIEW(product_tree_view), -1, "Quantity", renderer, "text", 3, "foreground", 5, NULL);
    
    renderer = gtk_cell_renderer_text_new();
    gtk_tree_view_insert_column_with_attributes(GTK_TREE_VIEW(product_tree_view), -1, "Price", renderer, "text", 4, "foreground", 5, NULL);
    
    scrolled_window = gtk_scrolled_window_new(NULL, NULL);
    gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scrolled_window), GTK_POLICY_AUTOMATIC, GTK_POLICY_AUTOMATIC);
    gtk_container_add(GTK_CONTAINER(scrolled_window), product_tree_view);
    gtk_container_add(GTK_CONTAINER(frame_table), scrolled_window);
    
    // === HISTORY ===
    frame_history = gtk_frame_new("Stock History");
    gtk_box_pack_start(GTK_BOX(hbox_bottom), frame_history, TRUE, TRUE, 5);
    
    history_text_view = gtk_text_view_new();
    gtk_text_view_set_editable(GTK_TEXT_VIEW(history_text_view), FALSE);
    gtk_text_view_set_wrap_mode(GTK_TEXT_VIEW(history_text_view), GTK_WRAP_WORD);
    
    scrolled_window = gtk_scrolled_window_new(NULL, NULL);
    gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scrolled_window), GTK_POLICY_AUTOMATIC, GTK_POLICY_AUTOMATIC);
    gtk_container_add(GTK_CONTAINER(scrolled_window), history_text_view);
    gtk_container_add(GTK_CONTAINER(frame_history), scrolled_window);
    
    // Show window
    gtk_widget_show_all(main_window);
    
    // Initial refresh
    refresh_product_table();
    refresh_history_display();
}

// Getter functions
GtkWidget* get_main_window(void) { return main_window; }
GtkWidget* get_product_tree_view(void) { return product_tree_view; }
GtkWidget* get_history_text_view(void) { return history_text_view; }

