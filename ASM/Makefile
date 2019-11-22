AS=nasm
ASFLAGS=-f macho64
NAME=Colleen Grace
RM=rm -rf

all: $(NAME)

$(NAME): %: %.o
	ld $< -o $@

clean:
	$(RM) $(addsuffix .o, $(NAME))

fclean: clean
	$(RM) $(NAME)

re: fclean all

.PHONY: all clean fclean re
