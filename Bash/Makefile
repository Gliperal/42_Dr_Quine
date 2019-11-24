RM=rm -rf

all:
	@echo "Nothing to be made."

clean:
	$(RM) Grace_kid.sh
	@echo "$(RM) \"Sullies\""
	@for x in 0 1 2 3 4; do \
		$(RM) Sully_$$x.sh ; \
	done

fclean: clean

re: fclean all

.PHONY: all clean fclean re
