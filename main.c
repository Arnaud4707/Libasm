#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <limits.h>
#include <string.h>
#include <stdlib.h>

extern size_t ft_strlen(char*);
extern size_t ft_write(int,void*,size_t);
extern size_t ft_read(int, void *, size_t);
extern char *ft_strcpy(char *, const char *);
extern int ft_strcmp(const char *, const char *);
extern void *ft_malloc(size_t size);
char *ft_strdup(const char *s);
extern void ft_free(void *ptr);
extern void check_leak(void);
extern size_t ft_putnbr_hexa(unsigned long);
extern size_t ft_atoi_base(const char *, const char *);

int	main(void)
{
	/*
		Premier test ft_strlen
	*/

	char *s= {"Hello World !"};
	//char a = 'a';
	printf("\033[0;32mFt_strlen\033[0m: %s = \033[0;32m%zu\033[0m letters\n",s, ft_strlen(s));
	
	/*
		Deuxieme test ft_write
	*/
	
	s= "\033[0;32mFt_write\033[0m: this phrase is writen by \033[0;32mft_write\033[0m!";
	printf(" and le nb charactere is %zd\n",ft_write(1, s, ft_strlen(s)));
	
	/*
		Troisieme test ft_read
	*/

	s= "README.md";
	char fd = open(s,O_RDONLY);
	char ar[7];
	size_t size = ft_read(fd, ar, 6);
	(void)size;
	if (size > INT_MAX)
		ar[0] = '\0';
	else 
		ar[size] = '\0';
	printf("\033[0;32mFt_open\033[0m: ft_open has readen \033[0;32m%zd\033[0m charactere(s) in %s. the buffer is \033[0;32m%s\033[0m\n", size, s, ar);
	close(fd);

	/*
		Quatrieme test ft_strcpy
	*/

	char dest[10];
	char *cp = {"Bonjour"};
	ft_strcpy(dest,cp);
	printf("\033[0;32mFt_strcpy\033[0m: variable cp: \033[0;32m%s\033[0m is copied in variable dest: \033[0;32m%s\033[0m\n", cp, dest);

	/*
		Cinquieme test ft_strcmp
	*/

	char* s1 = {"troll"}; char* s2 = {"troll"}; 
	printf("\033[0;32mFt_strcmp\033[0m: strcmp(%s, %s) = \033[0;32m%d\033[0m , \033[0;32mft_strcmp\033[0m(%s, %s) = \033[0;32m%d\033[0m\n", s1,s2,strcmp(s1,s2),s1,s2,ft_strcmp(s1,s2));
	
	/*
		Sixieme test ft_malloc
	*/
	
	char* ss = NULL;
	int i = 4;
	ss = ft_malloc((4 + 1) * sizeof(char));
	if (ss == NULL)
	{
		perror("Errno");
		return (0);
	}
	cp = "Test";
	ft_strcpy(ss,cp);
	printf("\033[0;32mFt_malloc\033[0m: ft_malloc alloced size of %d in variable s. Now s'value is \033[0;32m%s\033[0m by apply ft_strcpy on cp and s.\n", i, ss);
	
	
	/*
		septieme test ft_free
	*/

	printf("\033[0;32mFt_free\033[0m: ft_free is used each time \033[0;32mft_malloc\033[0m is used!\n");
	ft_free(ss);

	/*
		huitieme test ft_strdup
	*/

	char* test = ft_strdup("Succes!");
	//test = (test + 1);
	printf("\033[0;32mFt_strdup\033[0m: test value is \033[0;32m%s\033[0m after use ft_strdup(\"\033[0;32mSucces!\033[0m\") on test.\n", test);
	ft_free(test);

	/*
		neuvieme test check_leak
	*/

	perror("Errno");
	check_leak();
	
	/*
		dixieme test ft_atoi_base
	*/

	size_t atb = ft_atoi_base("1", "012");
	printf("%lu", atb);
	return (0);
}