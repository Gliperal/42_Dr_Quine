AS=nasm
ASFLAGS=-f macho64
NAME=Colleen
RM=rm -rf

$(NAME): %: %.o
	ld $< -o $@

all: $(NAME)

clean:
	$(RM) $(addsuffix .o, $(NAME))

fclean: clean
	$(RM) $(NAME)

re: fclean all

.PHONY: all clean fclean re
