/*
 * Main GUI Window Functions
 */

#ifndef GUI_MAIN_H
#define GUI_MAIN_H

#include <gtk/gtk.h>

// Create and show main window
void create_main_window(void);

// Refresh product table display
void refresh_product_table(void);

// Refresh history display
void refresh_history_display(void);

// Get reference to main window widgets (for callbacks)
GtkWidget* get_main_window(void);
GtkWidget* get_product_tree_view(void);
GtkWidget* get_history_text_view(void);

#endif // GUI_MAIN_H

