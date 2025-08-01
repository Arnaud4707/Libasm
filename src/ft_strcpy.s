bits 64

section .text
	global ft_strcpy

ft_strcpy:
	xor rax, rax

.loop:
	mov dl, byte [rsi + rax]
	cmp byte[rsi + rax], 0
	je .done
	mov byte[rdi + rax], dl
	
	inc rax
	jmp .loop

.done:
	mov byte[rdi + rax], dl
	mov rax, rdi
	ret

