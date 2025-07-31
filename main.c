#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <limits.h>
extern int ft_strlen(char*);
extern size_t ft_write(int,void*,size_t);
extern size_t ft_read(int, void *, size_t);
extern char *ft_strcpy(char *, const char *);
//extern char *strdup(const char *s);

// extern void ft_strlen();

int	main(void)
{
	/*
		Premier test ft_strlen
	*/

	char *s= {"Hello World !"};
	//char a = 'a';
	printf("\033[1;32mFt_strlen\033[0m: %s = \033[1;32m%d\033[0m letters\n",s, ft_strlen(s));
	
	/*
		Deuxieme test ft_write
	*/
	
	s= "\033[1;32mFt_write\033[0m: this phrase is writen by \033[1;32mft_write\033[0m!";
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
	printf("\033[1;32mFt_open\033[0m: ft_open has readen \033[1;32m%zd\033[0m charactere(s) in %s. the buffer is \033[1;32m%s\033[0m\n", size, s, ar);
	close(fd);

	/*
		Quatrieme test ft_strcpy
	*/

	char dest[10];
	char *cp = {"Bonjour"};
	ft_strcpy(dest,cp);
	printf("\033[1;32mFt_strcpy\033[0m: variable cp: \033[1;32m%s\033[0m is copied in variable dest: \033[1;32m%s\033[0m\n", cp, dest);

	/*
		Cinquieme test ft_stdup
	*/

	
	//ft_write(1, "te", 2);
	perror("my msg");
	return (0);
}