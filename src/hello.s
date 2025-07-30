bits 64

section .text
	global hello

hello:
	mov rax, rdi
	add rax, rsi
	ret
