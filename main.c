#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <limits.h>
#include <string.h>
#include <stdlib.h>

typedef struct s_list
{
void *data;
struct s_list *next;
} t_list;

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
extern t_list* ft_create_list(void*);
extern void ft_list_push_front(t_list **lst, void *data);
extern int	ft_list_size(t_list*);
extern t_list* ft_list_clear(t_list*);
extern t_list* ft_list_sort(t_list *lst, int (*cmp)());
extern void ft_list_remove_if(t_list **begin_list, void *content_ref, int (*cmp)());

int f(void* a, void* b)
{
	if (*(int*)(a) > *(int*)(b))
		return (1);
	return (0);
}

int g(void* a, void* b)
{
	if (*(int*)(a) != *(int*)(b))
		return (1);
	return (0);
}

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
	char *nb_atb = {"10000000000"};
	size_t atb = ft_atoi_base(nb_atb, "01");
	printf("\033[0;32mFt_atoi_base\033[0m: \033[0;32m%s\033[0m in binary is \033[0;32m%lu\033[0m in hexa.\n", nb_atb, atb);

	/*
		onzieme test ft_create_list
	*/

	t_list *tt = ft_create_list("Bonjour ");
	printf("\033[0;32mFt_create_list\033[0m: \033[0;32m%s\033[0m is the data of the list.\n", (char *)tt->data);
	char *tp = {"tout le monde"};

	/*
		douxieme test ft_list_push_front
	*/

	ft_list_push_front(&tt, (void*)tp);
	//exit(0);
	t_list *tmp = tt;
	tt = tt->next;
	printf("\033[0;32mFt_list_push_front\033[0m: \033[0;32m%s\033[0m is data's of the 1st node \033[0;32m%s\033[0m is data's of the 2nd node.\n", (char *)(tmp->data), (char *)tt->data);

	/*
		trezieme test ft_list_size
	*/

	int lt = ft_list_size(tmp);
	printf("\033[0;32mFt_list_size\033[0m: \033[0;32m%d\033[0m is the size of the list.\n", lt);

	/*
		quatorzieme test ft_list_clear
	*/

	printf("\033[0;32mFt_list_clear\033[0m: ft_list_clear is used each time \033[0;32mft_create_list\033[0m is used!\n");
	ft_list_clear(tmp);

	check_leak();

	/*
		quinzieme test ft_list_sort
	*/

	int var = 6;
	int var2 = 1;
	int var3 = 1;
	int var4 = 2;
	int var5 = 2;
	int var6 = 1;
	t_list* l1 = ft_create_list(&var);
	ft_list_push_front(&l1, &var2);
	ft_list_push_front(&l1, &var3);
	ft_list_push_front(&l1, &var4);
	ft_list_push_front(&l1, &var5);
	ft_list_push_front(&l1, &var6);

	printf("\033[0;32mFt_list_sort\033[0m: this list is not sort.\n");
	tmp = l1;
	i = 1;
	while (tmp)
	{
		printf("\t\t%d node is \033[0;32m%d\033[0m;\n", i, *(int*)(tmp->data));
		i++;
		tmp = tmp->next;
	}
	int var_test = 1;
	ft_list_remove_if(&l1, &var_test, &g);
	tmp = l1;
	//exit(0);
	//ft_list_sort(tmp, &f);
	printf("\033[0;32mFt_list_sort\033[0m: this list is sorted.\n");
	i = 1;
	while (tmp)
	{
		printf("\t\t%d node is \033[0;32m%d\033[0m;\n",i, *(int*)(tmp->data));
		i++;
		tmp = tmp->next;
	}
	// var_test = 2;
	// ft_list_remove_if(&l1, &var_test, &g);
	//exit(0);
	tmp = l1;
	i = 1;
	while (tmp)
	{
		printf("%d node is \033[0;32m%d\033[0m;\n",i, *(int*)(tmp->data));
		i++;
		tmp = tmp->next;
	}

	ft_list_clear(l1);

	check_leak();

	return (0);
}