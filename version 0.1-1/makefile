LEXCFILE = lex.yy.c
LEXFILE = configReader.l
YACCSRC = y.tab.c
GRAMMARFILE = ConfigFile.y

SRC = f1.c f2.c
OBJDIR = ./obj

_OBJS = $(patsubst %.c, $(OBJDIR)/%.o, $(SRC))
YACCINC = $(YACCSRC:.c=.h)

OUT = bas
CC = gcc
LIBS = 

all: $(OUT)

$(OUT): $(LEXCFILE)
	$(CC) $(LEXCFILE) $(YACCSRC) -o $(OUT) $(LIBS)

$(LEXCFILE): $(LEXFILE) $(YACCINC) $(YACCSRC)
	lex $(LEXFILE)

$(YACCINC) $(YACCSRC): $(GRAMMARFILE)
	yacc -d $(GRAMMARFILE)

.PHONY: clean

clean:
	rm -rf *.o $(OUT) bas *~
