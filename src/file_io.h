/*
 * File I/O Operations for Persistent Storage
 */

#ifndef FILE_IO_H
#define FILE_IO_H

#include "product.h"

// Save products to file
int save_products_to_file(Product* products, int count, const char* filename);

// Load products from file
int load_products_from_file(Product* products, int* count, const char* filename);

#endif // FILE_IO_H

