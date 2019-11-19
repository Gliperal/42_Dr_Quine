/*
	Grace
*/
#include <fcntl.h> // open
#include <unistd.h> // write
#include <sys/stat.h> // chmod
#define PRINT(FD, STR) for (int i = 0; STR[i]; i++) write(FD, &(STR[i]), 1);
#define PUTS(FD, STR) PRINT(FD, STR) write(FD, (char[1]){10}, 1);
#define MAIN(S) int main() { int fd = open(S[0], 514); PUTS(fd, S[1]); PUTS(fd, S[2]); PUTS(fd, S[3]); PUTS(fd, S[4]); PUTS(fd, S[5]); PUTS(fd, S[6]); PUTS(fd, S[7]); PUTS(fd, S[8]); PUTS(fd, S[9]); PRINT(fd, S[10]); PRINT(fd, #S); PUTS(fd, S[11]); close(fd); chmod(S[0], 0644); }
MAIN(((char *[]){ "Grace_kid.c", "/*", "	Grace", "*/", "#include <fcntl.h> // open", "#include <unistd.h> // write", "#include <sys/stat.h> // chmod", "#define PRINT(FD, STR) for (int i = 0; STR[i]; i++) write(FD, &(STR[i]), 1);", "#define PUTS(FD, STR) PRINT(FD, STR) write(FD, (char[1]){10}, 1);", "#define MAIN(S) int main() { int fd = open(S[0], 514); PUTS(fd, S[1]); PUTS(fd, S[2]); PUTS(fd, S[3]); PUTS(fd, S[4]); PUTS(fd, S[5]); PUTS(fd, S[6]); PUTS(fd, S[7]); PUTS(fd, S[8]); PUTS(fd, S[9]); PRINT(fd, S[10]); PRINT(fd, #S); PUTS(fd, S[11]); close(fd); chmod(S[0], 0644); }", "MAIN(", ")" }))
