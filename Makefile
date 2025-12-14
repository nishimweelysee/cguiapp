# Makefile for Stock Management System
# GTK+ 3.0 based application

CC = gcc
CFLAGS = -Wall -Wextra -std=c11
GTK_CFLAGS = $(shell pkg-config --cflags gtk+-3.0)
GTK_LIBS = $(shell pkg-config --libs gtk+-3.0)

# Directories
SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin
DATA_DIR = data

# Source files
SOURCES = $(wildcard $(SRC_DIR)/*.c)
OBJECTS = $(SOURCES:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)

# Target executable
TARGET = $(BIN_DIR)/stock_management

# Default target
all: $(TARGET)

# Create directories
$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

$(DATA_DIR):
	mkdir -p $(DATA_DIR)

# Link object files to create executable
$(TARGET): $(OBJECTS) | $(BIN_DIR) $(DATA_DIR)
	$(CC) $(OBJECTS) -o $(TARGET) $(GTK_LIBS)

# Compile source files to object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) $(GTK_CFLAGS) -c $< -o $@

# Clean build artifacts
clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)

# Install target (for packaging)
install: $(TARGET)
	@echo "Installation complete. Run: $(TARGET)"

# Run the application
run: $(TARGET)
	./$(TARGET)

# Check if GTK is installed
check-gtk:
	@pkg-config --modversion gtk+-3.0 || (echo "GTK+ 3.0 not found. Please install it first." && exit 1)

.PHONY: all clean install run check-gtk

