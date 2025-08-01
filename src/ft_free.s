bits 64

section .text
	global ft_free
	extern munmap
	extern __errno_location

ft_free:
	sub rdi, 8
	mov rsi, [rdi]
	mov rax, 11
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