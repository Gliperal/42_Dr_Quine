AS=nasm
ASFLAGS=-f macho64
NAME=Colleen Grace Sully
RM=rm -rf

all: $(NAME)

$(NAME): %: %.o
	ld $< -o $@

Grace.o: Grace.s
	$(AS) -f macho32 Grace.s

clean:
	$(RM) $(addsuffix .o, $(NAME))
	$(RM) Grace_kid.s
	@echo "$(RM) \"Sullies\""
	@for x in 0 1 2 3 4; do \
		$(RM) Sully_$$x.s ; \
		$(RM) Sully_$$x.o ; \
		$(RM) Sully_$$x ; \
	done

fclean: clean

fclean: clean
	$(RM) $(NAME)

re: fclean all

.PHONY: all clean fclean re
