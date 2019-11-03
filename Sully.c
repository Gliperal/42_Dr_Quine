#include <stdio.h> // fopen, fprintf, fputs, fwrite, fclose
#include <stdlib.h> // system
#include <string.h> // strchr

const static char *source[] =
{
	"#include <stdio.h> // fopen, fprintf, fputs, fwrite, fclose",
	"#include <stdlib.h> // system",
	"#include <string.h> // strchr",
	"",
	"const static char *source[] =",
	"{",
	"};",
	"",
	"",
	"void fput_comment_line(FILE *fp, const char *str)",
	"{",
	"	fputs(\"\\t\\\"\", fp);",
	"	for (; *str; str++)",
	"	{",
	"		if (strchr(\"\\\"\\\\\", *str))",
	"			fputs(\"\\\\\", fp);",
	"		fwrite(str, 1, 1, fp);",
	"	}",
	"	fputs(\"\\\",\\n\", fp);",
	"}",
	"",
	"#define FPUT_LINES(FP, X, Y) for(int n = X; n <= Y; n++) { fputs(source[n], FP); fputs(\"\\n\", FP); }",
	"#define SYSTEMF(CMD, ...) sprintf(str, CMD, __VA_ARGS__); system(str);",
	"",
	"int main()",
	"{",
	"	FILE *fp;",
	"	char str[1024];",
	"	int j = i - 1;",
	"",
	"	if (i <= 0) return 0;",
	"	sprintf(str, \"Sully_%d.c\", j);",
	"	fp = fopen(str, \"w\");",
	"	FPUT_LINES(fp, 0, 5);",
	"	for (int n = 0; n < 43; n++)",
	"		fput_comment_line(fp, source[n]);",
	"	FPUT_LINES(fp, 6, 7);",
	"	fprintf(fp, \"int i = %d;\\n\", j);",
	"	FPUT_LINES(fp, 8, 42);",
	"	fclose(fp);",
	"	SYSTEMF(\"clang -Wall -Wextra -Werror -o Sully_%d Sully_%d.c\", j, j);",
	"	SYSTEMF(\"./Sully_%d\", j);",
	"}",
};

int i = 5;

void fput_comment_line(FILE *fp, const char *str)
{
	fputs("\t\"", fp);
	for (; *str; str++)
	{
		if (strchr("\"\\", *str))
			fputs("\\", fp);
		fwrite(str, 1, 1, fp);
	}
	fputs("\",\n", fp);
}

#define FPUT_LINES(FP, X, Y) for(int n = X; n <= Y; n++) { fputs(source[n], FP); fputs("\n", FP); }
#define SYSTEMF(CMD, ...) sprintf(str, CMD, __VA_ARGS__); system(str);

int main()
{
	FILE *fp;
	char str[1024];
	int j = i - 1;

	if (i <= 0) return 0;
	sprintf(str, "Sully_%d.c", j);
	fp = fopen(str, "w");
	FPUT_LINES(fp, 0, 5);
	for (int n = 0; n < 43; n++)
		fput_comment_line(fp, source[n]);
	FPUT_LINES(fp, 6, 7);
	fprintf(fp, "int i = %d;\n", j);
	FPUT_LINES(fp, 8, 42);
	fclose(fp);
	SYSTEMF("clang -Wall -Wextra -Werror -o Sully_%d Sully_%d.c", j, j);
	SYSTEMF("./Sully_%d", j);
}
