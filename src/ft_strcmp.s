bits 64

section .text
	global ft_strcmp

ft_strcmp:
	xor rax, rax
	
.loop:
	mov dl, byte[rdi + rax]
	mov cl, byte[rsi + rax]

	cmp dl, 0
	je .no_s1

	cmp cl, 0
	je .no_s2

	cmp dl, cl
	je .egale
	
	cmp dl, cl
	jl .negative

	cmp dl, cl
	jg .positive

.no_s1:
	movsx rax, cl ; forcer un 8 bit a rentrer dans un 64 bite
	neg rax
	ret

.no_s2:
	movsx rax, dl
	ret

.positive:
	neg cl
	add dl, cl
	mov al, dl
	ret 

.negative:
	movsx rdx, dl
	movsx rcx, cl 
	sub rdx, rcx
	mov rax, rdx
	ret

.egale:
	inc rax
	jmp .loop