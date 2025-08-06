bits 64

section .bss
	struc t_list
    	.data: resq 1
    	.next: resq 1
	endstruc

section .text
	global	ft_list_push_front
	extern t_list

ft_list_push_front:
	mov rax, [rdi]
	mov [rsi + t_list.next], rax
	mov [rdi], rsi
	mov rax, rdi
	ret