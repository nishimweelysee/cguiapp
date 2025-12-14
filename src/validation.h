/*
 * Input Validation Functions
 */

#ifndef VALIDATION_H
#define VALIDATION_H

// Validate add product inputs
int validate_add_product(int quantity, float price);

// Validate update stock input
int validate_update_stock(int quantity);

// Validate sell product input
int validate_sell_product(int quantity);

// Validate discount percentage
int validate_discount(float discount);

#endif // VALIDATION_H

