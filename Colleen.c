#include <unistd.h>

/*
	Here we delcare an array that contains all the source code except for
	itself.
*/

const static char *g_source_code[] =
{
	"#include <unistd.h>",
	"",
	"/*",
	"	Here we delcare an array that contains all the source code except for",
	"	itself.",
	"*/",
	"",
	"const static char *g_source_code[] =",
	"{",
	"};",
	"",
	"/*",
	"	Here is the actual code part of the code.",
	"*/",
	"",
	"void ft_putstr(const char *str)",
	"{",
	"	int len = 0;",
	"	while (str[len])",
	"		len++;",
	"	write(1, str, len);",
	"}",
	"",
	"void ft_puts(const char *str)",
	"{",
	"	ft_putstr(str);",
	"	char newline = 10;",
	"	write(1, &newline, 1);",
	"}",
	"",
	"int main()",
	"{",
	"	for (int i = 0; i < 9; i++)",
	"		ft_puts(g_source_code[i]);",
	"	for (int i = 0; i < 49; i++)",
	"	{",
	"		/*",
	"			Quotes and newlines and the like cause problems because they",
	"			need to be escaped inside of string literals, so instead we",
	"			declare an array of ASCII values for [tab, quote, comma, newline]",
	"		*/",
	"		char c[] = {9, 34, 44, 10};",
	"		write(1, c, 2);",
	"		ft_putstr(g_source_code[i]);",
	"		write(1, c + 1, 3);",
	"	}",
	"	for (int i = 9; i < 49; i++)",
	"		ft_puts(g_source_code[i]);",
	"}",
};

/*
	Here is the actual code part of the code.
*/

void ft_putstr(const char *str)
{
	int len = 0;
	while (str[len])
		len++;
	write(1, str, len);
}

void ft_puts(const char *str)
{
	ft_putstr(str);
	char newline = 10;
	write(1, &newline, 1);
}

int main()
{
	for (int i = 0; i < 9; i++)
		ft_puts(g_source_code[i]);
	for (int i = 0; i < 49; i++)
	{
		/*
			Quotes and newlines and the like cause problems because they
			need to be escaped inside of string literals, so instead we
			declare an array of ASCII values for [tab, quote, comma, newline]
		*/
		char c[] = {9, 34, 44, 10};
		write(1, c, 2);
		ft_putstr(g_source_code[i]);
		write(1, c + 1, 3);
	}
	for (int i = 9; i < 49; i++)
		ft_puts(g_source_code[i]);
}
