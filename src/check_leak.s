bits 64

section .data
	msg_no_leak db 10, 0x1B, "[1;33m-----------No memory leak detected good!-----------", 0x1B, "[0m", 10, 10 ; 0x1B = \033 en hexa
	len_no_leak equ $ - msg_no_leak
	msg_leak db  10, 0x1B, "[1;33m", "-----------WARNING MEMORY LEAK DETECTED-----------", 0x1B, "[0m", 10, 10
	len_leak equ $ - msg_leak
	msg_address_leak_colored db 0x1B, "[1;33m", "Leak ------------> ", 0x1B, "[4;31m0x"
	len_msg_leak equ $ - msg_address_leak_colored
	reset db 0x1B, "[0m", 10
	len_reset equ $ - reset

section .text
	global check_leak
	extern alloc_count
	extern alloc_table
	extern ft_free
	extern dprintf
	extern fflush
	extern ft_putnbr_hexa

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
	jae .done
	mov rax, 1
	mov rdi, 2
	mov rsi, msg_address_leak_colored
	mov rdx, len_msg_leak
	syscall
	mov r10, alloc_table
	mov rdi, [r10 + rbx * 8]
	add rdi, 8
	push rbx
	call ft_putnbr_hexa
	pop rbx
	mov rax, 1
	mov rdi, 2
	mov rsi, reset
	mov rdx, len_reset
	syscall
	inc rbx
	jmp .nb_leak

.no_leak:
	mov rax, 1
	mov rdi, 2
	mov rsi, msg_no_leak
	mov rdx, len_no_leak
	syscall
	mov     rsp, rbp
    pop     rbp
	ret

.done:
	mov     rsp, rbp
    pop     rbp
	ret
