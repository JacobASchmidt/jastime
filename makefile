CC=gcc
FLAGS=-O3 -Wall -Wextra -Idep/include
SRC=src
OBJ=obj
ASM=asm
TEST=test/main.c
SRCS=$(wildcard $(SRC)/*.c)
OBJS=$(patsubst $(SRC)/%.c, $(OBJ)/%.o, $(SRCS))
ASMS=$(patsubst $(SRC)/%.c, $(ASM)/%.s, $(SRCS))
BINDIR=lib
BIN=$(BINDIR)/libjastime.a

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

/usr/local/include/jastime:
	mkdir /usr/local/include/jastime
	
install: $(BIN) /usr/local/include/jastime
	sudo cp src/jastime.h /usr/local/include/jastime/
	sudo cp lib/* /usr/local/lib
run: $(BIN)
	./$(BIN)



test: FORCE
	$(CC) $(FLAGS) $(TEST) -o test/main -ljasio -ljastime
	./test/main
FORCE: ;
