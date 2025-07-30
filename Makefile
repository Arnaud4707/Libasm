NAME= libasm.a

PROG= prog

SRC_PATH= src/

FILES= hello.s

SRC= $(addprefix $(SRC_PATH), $(FILES))

OBJ= $(SRC:.s=.o)

COMPIL= nasm -f elf64 -I./

CC= cc -Wall -Wextra -Werror

%.o:%.s
	$(COMPIL) $< -o $@

$(NAME): $(OBJ)
	ar rcs -o $(NAME) $(OBJ)

main.o: main.c
	$(CC) -o main.o -c main.c

$(PROG): $(NAME) main.o
	$(CC) main.o -L. -l asm -o $(PROG)

all: $(PROG)

clean:
	rm -rf $(OBJ)

fclean: clean
	rm -rf $(NAME) main.o $(PROG)

re: fclean all

.PHONY: all clean fclean re 