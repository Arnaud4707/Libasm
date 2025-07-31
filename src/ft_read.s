bits 64

section .text
	global ft_read
	extern __errno_location

ft_read:
	mov rax, 0
	mov rdi, rdi
	mov rsi, rsi
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
	
