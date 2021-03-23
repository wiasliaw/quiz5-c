# Directory definitions
INC_DIR := include
SRC_DIR := src
OBJ_DIR := build
BIN_DIR := bin

# Compilation related flags and parameters
CC := gcc
CFLAGS := -Wall -I$(INC_DIR)

INCS_FILES = $(wildcard $(INC_DIR)/*.h)
SRCS_FILES = $(wildcard $(SRC_DIR)/*.c)
OBJS_FILES = $(SRCS_FILES:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

all: vec tinync

vec: $(OBJ_DIR)/vec.o
	@mkdir -p $(BIN_DIR)
	gcc -o $(BIN_DIR)/vec $(OBJ_DIR)/vec.o

tinync: $(OBJ_DIR)/tinync.o
	@mkdir -p $(BIN_DIR)
	gcc -o $(BIN_DIR)/tinync $(OBJ_DIR)/tinync.o

clean:
	-rm $(OBJ_DIR)/*.o $(TARGET_FILES)

valgrind: main
	@valgrind --leak-check=full $(TARGET_FILES)

cppcheck:
	cppcheck -i $(INCS_FILES) $(SRCS_FILES)
