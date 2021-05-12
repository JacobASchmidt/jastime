CC=gcc
FLAGS=-O3 -Wall -Wextra -Idep/include
SRC=src
OBJ=obj
ASM=asm
SRCS=$(wildcard $(SRC)/*.c)
OBJS=$(patsubst $(SRC)/%.c, $(OBJ)/%.o, $(SRCS))
ASMS=$(patsubst $(SRC)/%.c, $(ASM)/%.s, $(SRCS))
BINDIR=lib
BIN=$(BINDIR)/libjaspdb.a

all: $(BINDIR) $(OBJ) $(ASM) $(BIN) asm

$(BINDIR):
	mkdir $(BINDIR)
$(OBJ):
	mkdir $(OBJ)
$(ASM):
	mkdir $(ASM)

$(BIN): $(BINDIR) $(OBJS) $(ASMS)
	ar rcs $(BIN) $(OBJS)

$(OBJ)/%.o: $(SRC)/%.c 
	$(CC) $(FLAGS) -c $< -o $@

$(ASM)/%.s: $(SRC)/%.c
	$(CC) $(FLAGS) -c -S $< -o $@

clean: 
	rm -r $(BINDIR)/* $(OBJ)/* $(ASM)/* 
	rmdir asm lib obj

install: $(BIN)
	sudo cp src/continuation.h /usr/local/lib/
	sudo cp src/fdmap.h /usr/local/lib/
	sudo cp src/jasio.h /usr/local/lib/
	sudo cp lib/* /usr/local/lib
run: $(BIN)
	./$(BIN)
