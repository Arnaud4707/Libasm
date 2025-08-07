bits 64

section .bss
	struc t_list
    	.data: resq 1
    	.next: resq 1
	endstruc
section .text
	global ft_create_list
	extern ft_malloc
	extern ft_strlen

ft_create_list:
	push rdi
	mov rdi, 16
	call ft_malloc
	pop rsi
	mov [rax + t_list.data], rsi   ; offset 0
	mov qword[rax + t_list.next], 0     ; offset 8
	ret
