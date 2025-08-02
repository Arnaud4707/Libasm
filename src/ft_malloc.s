bits 64

section .bss
	global alloc_count
	global alloc_table
	alloc_table resq 1024
	alloc_count resq 1
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
	mov r10, 0x22 ; 34
	mov r8, -1
	xor r9, r9
	syscall

	cmp rax, 0
	jl .error

	mov [rax], rsi
	
	mov rcx, [rel alloc_count]
	shl rcx, 3 ; rcx << 3
	mov rdx, alloc_table
	mov [rdx + rcx], rax
	inc qword [rel alloc_count]

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