bits 64

section .text
	global ft_strdup
	extern strdup

ft_strdup:
	mov rdi, rdi
	call strdup
	
	jl
