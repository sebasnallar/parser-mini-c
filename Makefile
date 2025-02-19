CC = gcc
FLEX = flex
BISON = bison
CFLAGS = -Wall -Wextra -g -Wno-sign-compare

all: parser

parser.tab.c parser.tab.h: parser.y
	$(BISON) -d -v parser.y

lex.yy.c: scanner.l parser.tab.h
	$(FLEX) scanner.l

parser: lex.yy.c parser.tab.c main.c
	$(CC) $(CFLAGS) -o parser main.c parser.tab.c lex.yy.c

clean:
	rm -f parser lex.yy.c parser.tab.c parser.tab.h parser.output *.o