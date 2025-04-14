# === CONFIGURATION ===
CC      := clang
CFLAGS  := -Wall -Wextra -std=c11 -Iinclude -MMD -MP
LDFLAGS := 
SRC_DIR := src
OBJ_DIR := build
BIN_DIR := bin
TARGET  := $(BIN_DIR)/main

# === AUTOMATIC SOURCES & OBJECTS ===
SRCS := $(wildcard $(SRC_DIR)/*.c)
OBJS := $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRCS))
DEPS := $(OBJS:.o=.d)

# === DEFAULT RULE ===
all: $(TARGET)

# === LINKING ===
$(TARGET): $(OBJS) | $(BIN_DIR)
	$(CC) $(LDFLAGS) $^ -o $@

# === COMPILATION ===
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# === DIRECTORY CREATION ===
$(OBJ_DIR) $(BIN_DIR):
	mkdir -p $@

# === CLEAN RULE ===
clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)

# === RUN & DEBUG SHORTCUTS ===
run: all
	./$(TARGET)

debug: CFLAGS += -g
debug: run

# === INCLUDE DEPENDENCIES ===
-include $(DEPS)

.PHONY: all clean run debug
