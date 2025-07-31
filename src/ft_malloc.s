bits 64

section .text
	global ft_malloc
	extern mmap

ft_malloc:
	mov rax, 9
	mov rsi, rdi
	xor rdi, rdi
	mov rdx, 3
	mov r10, 