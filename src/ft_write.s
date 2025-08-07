bits 64

section .data
	msg db "Salut", 10
	len equ $ - msg

section .text
	global ft_write
	extern __errno_location

ft_write:
	mov rax, 1
	syscall

	cmp rax, 0
	jl .error
	ret

.error:
	neg rax
	mov edi, eax
	call __errno_location
	mov [rax], edi
	
	mov rax, -1
	ret