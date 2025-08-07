bits 64

section .bss
	struc t_list
    	.data: resq 1
    	.next: resq 1
	endstruc

section .text
	global	ft_list_push_front
	extern ft_malloc

ft_list_push_front:
	mov r12, rdi
	mov r13, rsi
	mov rdi, 16
	call ft_malloc
	;mov r8, [r13]
	;mov [rax + t_list.data], r8
	mov [rax + t_list.data], r13
	mov rcx, [r12]
	mov [rax + t_list.next], rcx
	mov [r12], rax
	ret