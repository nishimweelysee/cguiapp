/*
 * Product Data Structure and Operations
 */

#ifndef PRODUCT_H
#define PRODUCT_H

#define MAX_PRODUCTS 1000
#define MAX_HISTORY 1000
#define MAX_ID_LENGTH 50
#define MAX_NAME_LENGTH 100
#define MAX_CATEGORY_LENGTH 50

// Product structure
typedef struct {
    char product_id[MAX_ID_LENGTH];
    char product_name[MAX_NAME_LENGTH];
    char category[MAX_CATEGORY_LENGTH];
    float price_per_unit;
    int quantity;
} Product;

// History entry structure
typedef struct {
    char operation[20];      // "ADD", "SELL", "UPDATE", "REMOVE"
    char product_id[MAX_ID_LENGTH];
    int quantity;
    char timestamp[50];
} HistoryEntry;

// Function declarations
Product* find_product_by_id(const char* product_id);
int add_product(const char* id, const char* name, const char* category, 
                float price, int quantity);
int update_stock(const char* product_id, int additional_quantity);
int sell_product(const char* product_id, int quantity_to_sell);
float calculate_stock_value(void);
int remove_product(const char* product_id);
void add_history_entry(const char* operation, const char* product_id, int quantity);
void add_history_entry(const char* operation, const char* product_id, int quantity);

#endif // PRODUCT_H

