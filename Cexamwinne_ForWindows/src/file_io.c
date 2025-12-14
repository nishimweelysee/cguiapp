/*
 * File I/O Implementation
 */

#include "file_io.h"
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#ifdef _WIN32
#include <direct.h>
#define mkdir _mkdir
#endif

// Create directory if it doesn't exist
void ensure_directory_exists(const char* path) {
    struct stat st = {0};
    if (stat(path, &st) == -1) {
        #ifdef _WIN32
            _mkdir(path);
        #else
            mkdir(path, 0700);
        #endif
    }
}

// Save products to file
int save_products_to_file(Product* products, int count, const char* filename) {
    // Ensure data directory exists
    char dir_path[256];
    strncpy(dir_path, filename, sizeof(dir_path));
    char* last_slash = strrchr(dir_path, '/');
    if (last_slash != NULL) {
        *last_slash = '\0';
        ensure_directory_exists(dir_path);
    }
    
    FILE* file = fopen(filename, "wb");
    if (file == NULL) {
        return 0; // Failed to open file
    }
    
    // Write product count
    fwrite(&count, sizeof(int), 1, file);
    
    // Write all products
    fwrite(products, sizeof(Product), count, file);
    
    fclose(file);
    return 1; // Success
}

// Load products from file
int load_products_from_file(Product* products, int* count, const char* filename) {
    FILE* file = fopen(filename, "rb");
    if (file == NULL) {
        *count = 0;
        return 0; // File doesn't exist or can't be opened
    }
    
    // Read product count
    int file_count;
    if (fread(&file_count, sizeof(int), 1, file) != 1) {
        fclose(file);
        *count = 0;
        return 0;
    }
    
    // Limit to available space
    if (file_count > MAX_PRODUCTS) {
        file_count = MAX_PRODUCTS;
    }
    
    // Read all products
    size_t read_count = fread(products, sizeof(Product), file_count, file);
    *count = (int)read_count;
    
    fclose(file);
    return 1; // Success
}

