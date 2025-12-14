/*
 * Dialog Windows (Confirmations, Reports, etc.)
 */

#ifndef GUI_DIALOGS_H
#define GUI_DIALOGS_H

#include <gtk/gtk.h>

// Show information dialog
void show_info_dialog(const char* message);

// Show error dialog
void show_error_dialog(const char* message);

// Show warning dialog
void show_warning_dialog(const char* message);

// Show confirmation dialog (returns TRUE if user clicked OK/Yes)
gboolean show_confirm_dialog(const char* message);

// Show report window
void show_report_window(void);

#endif // GUI_DIALOGS_H

