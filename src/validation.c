/*
 * Input Validation Implementation
 */

#include "validation.h"

// Validate add product inputs
int validate_add_product(int quantity, float price) {
    return (quantity > 0 && price > 0);
}

// Validate update stock input
int validate_update_stock(int quantity) {
    return (quantity > 5);
}

// Validate sell product input
int validate_sell_product(int quantity) {
    return (quantity > 5);
}

// Validate discount percentage
int validate_discount(float discount) {
    return (discount >= 10.0 && discount <= 20.0);
}

