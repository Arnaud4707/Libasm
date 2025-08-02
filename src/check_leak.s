bits 64

section .data
	msg_no_leak db 10, 0x1B, "[1;33m-----------No memory leak detected good!-----------", 0x1B, "[0m", 10
	len_no_leak equ $ - msg_no_leak
	msg_leak db  10, 0x1B, "[1;33m", "-----------WARNING MEMORY LEAK DETECTED-----------", 0x1B, "[0m", 10, 10
	len_leak equ $ - msg_leak
	msg_address_leak db 0x1B, "[1;33m", "Leak ------------> ", 0x1B, "[4;31m%p", 0x1B, "[0m", 10, 0x0
	color db 0x1B, "[1;33m" ; 0x1B = \033 en hexa
	len_color equ $ - color
	reset db 0x1B, "[0m"
	len_reset equ $ - reset

section .text
	global check_leak
	extern alloc_count
	extern alloc_table
	extern ft_free
	extern dprintf
	extern fflush

check_leak:
	push    rbp					; l'alignement de la stack pour les fonction variadique
	mov     rbp, rsp
	mov rax, [rel alloc_count]
	cmp rax, 0
	je .no_leak
	xor rbx, rbx

.leak:
	mov rax, 1
	mov rdi, 2
	mov rsi, msg_leak
	mov rdx, len_leak
	syscall

.nb_leak:
	cmp rbx, [rel alloc_count]
	je .leave
	inc rbx
	jmp .nb_leak
	ret

.no_leak:
	mov rax, 1
	mov rdi, 2
	mov rsi, msg_no_leak
	mov rdx, len_no_leak
	syscall
	mov     rsp, rbp
    pop     rbp
	ret

.leave:
	mov rdi, 2
	mov rsi, msg_address_leak
	mov r10, alloc_table
	dec rbx
	mov rdx, [r10 + rbx * 8]
	xor rax, rax
	call dprintf
	cmp rbx, 0
	jg .leave
	mov rdx, alloc_table
	mov rax, [rdx + rbx * 8]
	add rax, 8
	mov     rsp, rbp
    pop     rbp
	ret
