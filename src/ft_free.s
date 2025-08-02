bits 64

section .text
	global ft_free
	extern munmap
	extern alloc_count
	extern alloc_table
	extern __errno_location

ft_free:
	sub rdi, 8
	xor rcx, rcx

.loop:
	cmp rcx, [rel alloc_count]
	je .not_found

	mov rbx, alloc_table
	mov rsi, [rbx + rcx * 8]
	cmp rsi, rdi
	je .find
	inc rcx
	jmp .loop

.error:
	neg rax
	mov edi, eax
	call __errno_location
	mov [rax], edi
	mov rax, -1
	ret	

.find:
	dec qword [rel alloc_count]
	mov rsi, [rel alloc_count]
	mov rdx, [rbx + rsi * 8]
	mov [rbx + rcx * 8], rdx
	jmp .free

.free:
	mov rsi, [rdi]
	mov rax, 11
	syscall

	cmp rax, 0
	jl .error
	ret

.not_found:
	ret