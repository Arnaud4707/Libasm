bits 64

section .data
	msg_no_leak db "-----------No leak detected good!-----------"
	len_no_leak equ $ - msg_no_leak
	msg_leak db "-----------WARNING LEAK DETECTED-----------"
	len_leak equ $ - msg_leak
	hex_digits db "0123456789ABCDEF"
	buf db "0000000000000000", 0xA

section .text
	global check_leak
	extern alloc_count
	extern alloc_table
	extern ft_free

check_leak:
	mov rax, [rel alloc_count]
	cmp rax, 0
	je .no_leak
	xor rbx, rbx

.leak:
	cmp rbx, [rel alloc_count]
	je .leave
	mov rax, 1
	mov rdi, 2
	mov rsi, msg_leak
	mov rdx, len_leak
	syscall
	inc rbx
	jmp .leak
	ret

.no_leak:
	mov rax, 1
	mov rdi, 2
	mov rsi, msg_no_leak
	mov rdx, len_no_leak
	syscall
	ret

.leave:
	mov rdx, alloc_table
	dec rbx
	mov rax, [rdx + rbx * 8]
	
	mov rbp, rax
	mov rcx, 16               ; nombre de chiffres
    mov rsi, buf + 15         ; position de fin (juste avant \n)
.convert_loop:
    mov rbx, rax
    and rbx, 0xF              ; isole 4 bits (1 digit)
    mov bl, [hex_digits + rbx]
    mov [rsi], bl
    dec rsi
    shr rax, 4
    dec rcx
    jnz .convert_loop

    ; écrire le buffer
    mov rax, 1                ; write syscall
    mov rdi, 2                ; stdout
    mov rsi, buf
    mov rdx, 17               ; 16 digits + newline
    syscall
	mov rax, rbp
	
	add rax, 8
	ret
