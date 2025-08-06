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
	call ft_strlen
	inc rax
	shl rax, 4
	mov rdi, rbx
	call ft_malloc
	pop rsi
	mov [rax + t_list.data], rsi  
    mov qword [rax + t_list.next], 0
	ret
