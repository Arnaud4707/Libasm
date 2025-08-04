bits 64

section .bss
	nb resb 25
section .data
	base db "0123456789"
	len equ $ - base

section .text
	global ft_atoi_base
	extern ft_strlen

ft_atoi_base:
	cmp rdi, 0
	je .done
	push rdi
	push rsi
	call ft_strlen
	pop rsi
	mov rdi, rsi
	push rsi
	push rax
	call ft_strlen
	pop r11 ;len nb
	pop rsi
	pop rdi
	dec r11 
	mov r13, rax ; len base
	dec rax
	xor r10, r10
	xor r12, r12
	xor r15, r15
	xor r9, r9

.size:
	cmp r11, 0
	jl .done
	mov dl, byte [rdi + r11]
	xor r9, r9
	cmp dl, byte [rsi + r10]
	je .conv
	cmp r10, rax
	jge .done
	inc r10
	jmp .size

.conv:
	cmp r9, r12
	je .add_res
	mov rax, r13
	mul r10
	mov r10, rax
	inc r9
	jmp .conv

.add_res:
	inc r12
	add r15, r10
	xor r10, r10
	dec r11
	mov rax, r13
	dec rax
	jmp .size

;.loop:
	; mov rax, r12       ; dividende (64 bits)
	; cqo              ; étend le signe de rax dans rdx (préparation pour division signée)
	; mov rbx, r13       ; diviseur
	; idiv rbx         ; rax ← quotient, rdx ← reste
				; rdx contient maintenant a % b

.done:
	mov rax, r15
	ret