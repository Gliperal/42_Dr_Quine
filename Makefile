all:
	make -C C
	make -C ASM
	make -C Bash

clean:
	make -C C clean
	make -C ASM clean
	make -C Bash clean

fclean:
	make -C C fclean
	make -C ASM fclean
	make -C Bash fclean

re: fclean all

.PHONY: all clean fclean re
