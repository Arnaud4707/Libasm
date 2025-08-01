bits 64

section .text
	global ft_strdup
	extern ft_strlen
	extern ft_malloc
	extern ft_strcpy

ft_strdup:
	mov rbx, rdi ; rbx registre non volatile car rdx se fait exraser par ft_malloc
	call ft_strlen
	add rax, 1
	mov rdi, rax
	call ft_malloc
	cmp rax, 0 ; test (rax == 0) plus rapide que cmp
	jle .error ; jz = si vrai, jle peut le remplacer avc cmp
	mov rsi, rbx
	mov rdi, rax
	call ft_strcpy
	ret

.error:
	xor rax, rax
	ret