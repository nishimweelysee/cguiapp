/*
 * Dialog Windows Implementation
 */

#include <gtk/gtk.h>
#include <pango/pango.h>
#include <stdio.h>
#include <string.h>
#include "gui_dialogs.h"
#include "product.h"

// External references
extern Product products[MAX_PRODUCTS];
extern int product_count;
extern HistoryEntry history[MAX_HISTORY];
extern int history_count;
extern float total_sales;

// Show information dialog
void show_info_dialog(const char* message) {
    GtkWidget* dialog = gtk_message_dialog_new(NULL,
                                                GTK_DIALOG_MODAL,
                                                GTK_MESSAGE_INFO,
                                                GTK_BUTTONS_OK,
                                                "%s", message);
    gtk_dialog_run(GTK_DIALOG(dialog));
    gtk_widget_destroy(dialog);
}

// Show error dialog
void show_error_dialog(const char* message) {
    GtkWidget* dialog = gtk_message_dialog_new(NULL,
                                                GTK_DIALOG_MODAL,
                                                GTK_MESSAGE_ERROR,
                                                GTK_BUTTONS_OK,
                                                "%s", message);
    gtk_dialog_run(GTK_DIALOG(dialog));
    gtk_widget_destroy(dialog);
}

// Show warning dialog
void show_warning_dialog(const char* message) {
    GtkWidget* dialog = gtk_message_dialog_new(NULL,
                                                GTK_DIALOG_MODAL,
                                                GTK_MESSAGE_WARNING,
                                                GTK_BUTTONS_OK,
                                                "%s", message);
    gtk_window_set_title(GTK_WINDOW(dialog), "Low Stock Warning");
    gtk_dialog_run(GTK_DIALOG(dialog));
    gtk_widget_destroy(dialog);
}

// Show confirmation dialog
gboolean show_confirm_dialog(const char* message) {
    GtkWidget* dialog = gtk_message_dialog_new(NULL,
                                                GTK_DIALOG_MODAL,
                                                GTK_MESSAGE_QUESTION,
                                                GTK_BUTTONS_YES_NO,
                                                "%s", message);
    gint response = gtk_dialog_run(GTK_DIALOG(dialog));
    gtk_widget_destroy(dialog);
    return (response == GTK_RESPONSE_YES);
}

// Find most active product (highest sales quantity)
void find_most_active_product(char* product_id, char* product_name, int* total_sold) {
    // Count sales per product from history
    int max_sold = 0;
    char most_active_id[MAX_ID_LENGTH] = "";
    char most_active_name[MAX_NAME_LENGTH] = "";
    
    for (int i = 0; i < product_count; i++) {
        int sold = 0;
        for (int j = 0; j < history_count; j++) {
            if (strcmp(history[j].product_id, products[i].product_id) == 0 &&
                strcmp(history[j].operation, "SELL") == 0) {
                sold += history[j].quantity;
            }
        }
        if (sold > max_sold) {
            max_sold = sold;
            strncpy(most_active_id, products[i].product_id, MAX_ID_LENGTH - 1);
            strncpy(most_active_name, products[i].product_name, MAX_NAME_LENGTH - 1);
        }
    }
    
    strncpy(product_id, most_active_id, MAX_ID_LENGTH - 1);
    strncpy(product_name, most_active_name, MAX_NAME_LENGTH - 1);
    *total_sold = max_sold;
}

// Show report window
void show_report_window(void) {
    // Calculate metrics
    int total_products = product_count;
    float stock_value = calculate_stock_value();
    
    // Calculate total stock sold
    int total_stock_sold = 0;
    for (int i = 0; i < history_count; i++) {
        if (strcmp(history[i].operation, "SELL") == 0) {
            total_stock_sold += history[i].quantity;
        }
    }
    
    // Find most active product
    char most_active_id[MAX_ID_LENGTH] = "N/A";
    char most_active_name[MAX_NAME_LENGTH] = "N/A";
    int most_active_sold = 0;
    find_most_active_product(most_active_id, most_active_name, &most_active_sold);
    
    // Create report window
    GtkWidget* report_window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
    gtk_window_set_title(GTK_WINDOW(report_window), "Stock Management Report");
    gtk_window_set_default_size(GTK_WINDOW(report_window), 500, 400);
    gtk_window_set_modal(GTK_WINDOW(report_window), TRUE);
    
    GtkWidget* vbox = gtk_box_new(GTK_ORIENTATION_VERTICAL, 10);
    gtk_container_add(GTK_CONTAINER(report_window), vbox);
    gtk_container_set_border_width(GTK_CONTAINER(vbox), 20);
    
    GtkWidget* label_title = gtk_label_new("STOCK MANAGEMENT REPORT");
    // Set font using Pango attributes (alternative to deprecated override_font)
    PangoFontDescription* font_desc = pango_font_description_from_string("Bold 16");
    PangoAttribute* attr = pango_attr_font_desc_new(font_desc);
    PangoAttrList* attr_list = pango_attr_list_new();
    pango_attr_list_insert(attr_list, attr);
    gtk_label_set_attributes(GTK_LABEL(label_title), attr_list);
    pango_font_description_free(font_desc);
    pango_attr_list_unref(attr_list);
    gtk_box_pack_start(GTK_BOX(vbox), label_title, FALSE, FALSE, 10);
    
    // Report content
    char report_text[1000];
    snprintf(report_text, sizeof(report_text),
             "Total Products: %d\n\n"
             "Total Stock Value: %.2f RWF\n\n"
             "Total Stock Sold: %d units\n\n"
             "Most Active Product:\n"
             "  ID: %s\n"
             "  Name: %s\n"
             "  Units Sold: %d",
             total_products,
             stock_value,
             total_stock_sold,
             most_active_id,
             most_active_name,
             most_active_sold);
    
    GtkWidget* label_report = gtk_label_new(report_text);
    gtk_label_set_line_wrap(GTK_LABEL(label_report), TRUE);
    gtk_label_set_selectable(GTK_LABEL(label_report), TRUE);
    gtk_box_pack_start(GTK_BOX(vbox), label_report, TRUE, TRUE, 10);
    
    GtkWidget* button_close = gtk_button_new_with_label("Close");
    g_signal_connect_swapped(button_close, "clicked", G_CALLBACK(gtk_widget_destroy), report_window);
    gtk_box_pack_start(GTK_BOX(vbox), button_close, FALSE, FALSE, 10);
    
    gtk_widget_show_all(report_window);
}

