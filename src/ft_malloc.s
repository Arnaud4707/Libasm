bits 64

section .text
	global ft_malloc
	extern mmap
	extern __errno_location

ft_malloc:
	cmp rdi, 0
	jl .negatif
	mov rax, 9
	mov rsi, rdi
	add rsi, 8 ; aoute 8 
	xor rdi, rdi
	mov rdx, 3
	mov r10, 0x22
	mov r8, -1
	xor r9, r9
	syscall

	cmp rax, 0
	jl .error

	mov [rax], rsi
	add rax, 8
	ret

.error:
	neg rax
	mov edi, eax
	call __errno_location
	mov [rax], edi
	xor rax, rax
	ret

.negatif:
	mov edi, 12
	call __errno_location
	mov [rax], edi
	xor rax, rax
	ret