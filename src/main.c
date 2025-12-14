/*
 * Stock Management System - Main Entry Point
 * C Final Project - Exam D-F
 * 
 * This is a GUI-based stock management system using GTK+ 3.0
 */

#include <gtk/gtk.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "product.h"
#include "gui_main.h"
#include "file_io.h"

// Global product list
Product products[MAX_PRODUCTS];
int product_count = 0;

// Global history list
HistoryEntry history[MAX_HISTORY];
int history_count = 0;

// Total sales tracking
float total_sales = 0.0;

int main(int argc, char *argv[]) {
    // Initialize GTK
    gtk_init(&argc, &argv);
    
    // Load existing products from file
    load_products_from_file(products, &product_count, "data/products.dat");
    
    // Create and show main window
    create_main_window();
    
    // Start GTK main loop
    gtk_main();
    
    // Save products before exit
    save_products_to_file(products, product_count, "data/products.dat");
    
    return 0;
}

