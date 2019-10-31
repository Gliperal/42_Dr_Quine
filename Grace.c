/*
	Grace
*/
#include <fcntl.h> // open
#include <unistd.h> // write
#define PRINT(FD, STR) for (int i = 0; STR[i]; i++) write(FD, &(STR[i]), 1);
#define PUTS(FD, STR) PRINT(FD, STR) write(FD, (char[1]){10}, 1);
#define MAIN(S) int main() { \
	int fd = open("Grace_kid.c", 514); \
	PUTS(fd, S[0]); \
	PUTS(fd, S[1]); \
	PUTS(fd, S[2]); \
	PUTS(fd, S[3]); \
	PUTS(fd, S[4]); \
	PUTS(fd, S[5]); \
	PUTS(fd, S[6]); \
	PUTS(fd, S[7]); \
	PRINT(fd, S[8]); \
	PRINT(fd, #S); \
	PUTS(fd, S[9]); \
	close(fd); \
}
MAIN(((char *[10]){ \
		"/*", \
		"	Grace", \
		"*/", \
		"#include <fcntl.h> // open", \
		"#include <unistd.h> // write", \
		"#define PRINT(FD, STR) for (int i = 0; STR[i]; i++) write(FD, &(STR[i]), 1);", \
		"#define PUTS(FD, STR) PRINT(FD, STR) write(FD, (char[1]){10}, 1);", \
		"#define MAIN(S) int main() { int fd = open(Grace_kid.c, 514); PUTS(fd, S[0]); PUTS(fd, S[1]); PUTS(fd, S[2]); PUTS(fd, S[3]); PUTS(fd, S[4]); PUTS(fd, S[5]); PUTS(fd, S[6]); PUTS(fd, S[7]); PRINT(fd, S[8]); PRINT(fd, #S); PUTS(fd, S[9]); close(fd); }", \
		"MAIN(", \
		")"
}))
