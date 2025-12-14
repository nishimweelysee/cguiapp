/*
 * Product Operations Implementation
 */

#include "product.h"
#include <time.h>
#include <string.h>
#include <stdio.h>

// External references (defined in main.c)
extern Product products[MAX_PRODUCTS];
extern int product_count;
extern HistoryEntry history[MAX_HISTORY];
extern int history_count;
extern float total_sales;

// Get current timestamp as string
void get_timestamp(char* buffer, size_t size) {
    time_t now = time(NULL);
    struct tm* t = localtime(&now);
    strftime(buffer, size, "%Y-%m-%d %H:%M:%S", t);
}

// Find product by ID
Product* find_product_by_id(const char* product_id) {
    for (int i = 0; i < product_count; i++) {
        if (strcmp(products[i].product_id, product_id) == 0) {
            return &products[i];
        }
    }
    return NULL;
}

// Add a new product
int add_product(const char* id, const char* name, const char* category, 
                float price, int quantity) {
    if (product_count >= MAX_PRODUCTS) {
        return 0; // Array full
    }
    
    // Check if product ID already exists
    if (find_product_by_id(id) != NULL) {
        return -1; // Duplicate ID
    }
    
    // Create new product
    Product* p = &products[product_count];
    strncpy(p->product_id, id, MAX_ID_LENGTH - 1);
    strncpy(p->product_name, name, MAX_NAME_LENGTH - 1);
    strncpy(p->category, category, MAX_CATEGORY_LENGTH - 1);
    p->price_per_unit = price;
    p->quantity = quantity;
    
    product_count++;
    
    // Add to history
    add_history_entry("ADD", id, quantity);
    
    return 1; // Success
}

// Update stock quantity
int update_stock(const char* product_id, int additional_quantity) {
    Product* p = find_product_by_id(product_id);
    if (p == NULL) {
        return 0; // Product not found
    }
    
    p->quantity += additional_quantity;
    
    // Add to history
    add_history_entry("UPDATE", product_id, additional_quantity);
    
    return 1; // Success
}

// Sell a product
int sell_product(const char* product_id, int quantity_to_sell) {
    Product* p = find_product_by_id(product_id);
    if (p == NULL) {
        return -1; // Product not found
    }
    
    if (p->quantity < quantity_to_sell) {
        return -2; // Insufficient stock
    }
    
    p->quantity -= quantity_to_sell;
    float sale_amount = p->price_per_unit * quantity_to_sell;
    total_sales += sale_amount;
    
    // Add to history
    add_history_entry("SELL", product_id, quantity_to_sell);
    
    return (int)sale_amount; // Return sale amount
}

// Calculate total stock value
float calculate_stock_value(void) {
    float total = 0.0;
    for (int i = 0; i < product_count; i++) {
        total += products[i].quantity * products[i].price_per_unit;
    }
    return total;
}

// Remove a product
int remove_product(const char* product_id) {
    Product* p = find_product_by_id(product_id);
    if (p == NULL) {
        return 0; // Product not found
    }
    
    // Add to history before removal
    add_history_entry("REMOVE", product_id, p->quantity);
    
    // Shift array to remove product
    int index = p - products;
    for (int i = index; i < product_count - 1; i++) {
        products[i] = products[i + 1];
    }
    product_count--;
    
    return 1; // Success
}

// Add entry to history
void add_history_entry(const char* operation, const char* product_id, int quantity) {
    if (history_count >= MAX_HISTORY) {
        // Shift history (remove oldest)
        for (int i = 0; i < MAX_HISTORY - 1; i++) {
            history[i] = history[i + 1];
        }
        history_count = MAX_HISTORY - 1;
    }
    
    HistoryEntry* entry = &history[history_count];
    strncpy(entry->operation, operation, 19);
    strncpy(entry->product_id, product_id, MAX_ID_LENGTH - 1);
    entry->quantity = quantity;
    get_timestamp(entry->timestamp, sizeof(entry->timestamp));
    
    history_count++;
}

