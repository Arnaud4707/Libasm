bits 64

section .data
	msg_error db "Error: write fail to open file descriptor!"
	len equ	$ - msg_error
	errno db 0

section .text
	global ft_write
	extern __errno_location

ft_write:
	mov rax, 1
	mov rdi, rdi
	mov	rsi, rsi
	mov rdx, rdx
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