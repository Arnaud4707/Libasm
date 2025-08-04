bits 64

section .bss
	nb resb 25
section .data
	base db "0123456789"
	len equ $ - base

section .text
	global ft_putnbr_hexa
	extern ft_strlen

ft_putnbr_hexa:
	xor rax, rax
	mov r12, rdi
	cmp rdi, 0
	je .done

.size:
	inc rax
	shr rdi, 4
	cmp rdi, 0
	jg .size
	mov r11, rax
	call ft_strlen
	mov r13, rax

.loop:
	mov rax, r12       ; dividende (64 bits)
	cqo              ; étend le signe de rax dans rdx (préparation pour division signée)
	mov rbx, r13       ; diviseur
	idiv rbx         ; rax ← quotient, rdx ← reste
				; rdx contient maintenant a % b
	shr r12, 4
	dec rax
	mov dl, byte [base + rdx]
	mov [nb + rax], dl
	cmp r12, 0
	jg .loop
	mov rax, 1
	mov rdi, 2
	mov rsi, nb
	mov rdx, r11
	syscall

.done:
	ret