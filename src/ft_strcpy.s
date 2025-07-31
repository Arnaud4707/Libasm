bits 64

section .text
	global ft_strcpy

ft_strcpy:
	xor rax, rax

.loop:
	cmp byte[rsi + rax], 0
	je .done

	mov dl, byte[rsi + rax]
	mov byte[rdi + rax], dl
	
	inc rax
	call .loop

.done:
	mov rax, rdi
	ret

