bits 64

section .bss
	nb resb 16
section .data
	base db "0123456789abcdef"
	len equ $ - base

section .text
	global ft_putnbr_hexa

ft_putnbr_hexa:
	xor rax, rax
	mov rbx, rdi
	cmp rdi, 0
	je .done

.size:
	inc rax
	shr rdi, 4
	cmp rdi, 0
	jg .size
	mov r11, rax

.loop:
	mov r10, rbx
	and r10, 15
	shr rbx, 4
	dec rax
	mov r10b, byte [base + r10]
	mov [nb + rax], r10b
	cmp rbx, 0
	jg .loop
	mov rax, 1
	mov rdi, 2
	mov rsi, nb
	mov rdx, r11
	syscall

.done:
	ret