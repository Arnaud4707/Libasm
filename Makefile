NAME= libasm.a

PROG= prog

LIB_PATH= lib/

LIB= $(addprefix $(LIB_PATH), $(NAME))

SRC_PATH= src/

FILES= ft_strlen.s ft_write.s ft_read.s ft_strcpy.s

SRC= $(addprefix $(SRC_PATH), $(FILES))

OBJ= $(SRC:.s=.o)

COMPIL= nasm -f elf64 -I./

CC= cc -Wall -Wextra -Werror
# ld pour un main en asm

%.o:%.s
	$(COMPIL) $< -o $@

$(PROG): $(LIB) main.o
	$(CC) main.o $(LIB) -o $(PROG)

$(LIB): $(OBJ)
	ar rcs -o $(LIB) $(OBJ)

main.o: main.c
	$(CC) -o main.o -c main.c

all: $(PROG)

clean:
	rm -rf $(OBJ)

fclean: clean
	rm -rf $(LIB) main.o $(PROG)

re: fclean all

.PHONY: all clean fclean re 