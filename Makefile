# 1. Compiler and Flags
CC = gcc
CFLAGS = -Iinclude -Wall -O2

# 2. Directories and Files
SRC_DIR = src
OBJ_DIR = obj

# Automatically find all .c files in the src directory
SRCS = $(wildcard $(SRC_DIR)/*.c)

# Convert the list of .c files into .o (object) files inside the obj directory
OBJS = $(SRCS:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)

# 3. Target Executable
TARGET = filters

# Default rule
all: $(TARGET)

# Link object files into the final executable
$(TARGET): $(OBJS)
	$(CC) $(OBJS) -o $(TARGET)

# Pattern rule: Compile each .c file into a .o file
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Create the object directory if it does not exist
$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

# Clean up build files
clean:
	rm -rf $(OBJ_DIR) $(TARGET)

.PHONY: all clean
