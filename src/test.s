bits 64

section .data
	msg db 'hello world', 10
	len equ $ - msg

section .text
	global _start

_start:
	mov rax, 1
	mov rdi, 1
	mov rsi, msg
	mov rdx, len
	syscall

	mov rax, 60
	mov rdi, 24
	syscall