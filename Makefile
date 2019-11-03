CC=clang
CFLAGS=-Wall -Wextra -Werror
RM=rm -rf
NAME=Colleen Grace Sully
SULLIES=

all: $(NAME)

$(NAME): %: %.c
	$(CC) $(CFLAGS) -o $@ $<

clean:
	$(RM) Grace_kid.c
	@echo "$(RM) \"Sullies\""
	@for x in 0 1 2 3 4; do \
		$(RM) Sully_$$x.c ; \
		$(RM) Sully_$$x ; \
	done

fclean: clean
	$(RM) $(NAME)

re: fclean all

.PHONY: all clean fclean re
