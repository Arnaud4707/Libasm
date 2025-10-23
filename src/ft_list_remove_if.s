bits 64

section .bss
	struc t_list
    	.data: resq 1
    	.next: resq 1
	endstruc

section .data
    msg_debug db "stop", 10
    len_debug equ $ - msg_debug
    msg_printf db "pre -> %p | curr -> %p", 10
    len_debug_printf equ $ - msg_printf

section .text
	global ft_list_remove_if
	extern ft_free
    extern printf

ft_list_remove_if:
    push rbp
    mov rbp, rsp
	sub	rsp, 64
	mov [rsp + 0], rdi ; heap
	mov	rbx, [rsp + 0]
	mov rax, [rbx]
	xor r8, r8
	mov [rsp + 8], rsi
	mov [rsp + 16], rdx ; func
	mov [rsp + 24], r8 ; prev
	mov [rsp + 32], rax ; curr

.loop:
	test rax, rax
	je .done
	mov rdi, [rax + t_list.data]
	mov rsi, [rsp + 8]
	mov r8, [rsp + 16]
	sub rsp, 8
	call r8
	add rsp, 8
	test rax, rax
	je .replace
	mov r8, [rsp + 32]
	mov [rsp + 24], r8
	mov rax, [r8 + t_list.next]
	mov [rsp + 32], rax
	jmp .loop

.replace:
	mov rax, [rsp + 24]
	test rax, rax
	je .replace_head
	mov rdi, [rsp + 32]
	mov r10, [rdi + t_list.next]
	sub rsp, 8
	call ft_free
	add rsp, 8
	mov [rsp + 32], r10
	mov rax, [rsp + 24]
	mov [rax + t_list.next], r10
	mov rax, r10
	jmp .loop

.replace_head:
	mov rdi, [rsp + 32]
	mov r10, [rdi + t_list.next]
	sub rsp, 8
	call ft_free
	add rsp, 8
	mov [rsp + 32], r10
	mov rbx, [rsp + 0]
	mov [rbx], r10
	mov rax, r10
	jmp .loop

.debug_printf:
    mov rdi, msg_printf
    mov rsi, [rsp + 24]
    mov rdx, [rsp + 32]
	push rdx
	push rsi
	call printf
	pop rsi
	pop rdi
    ret

.done:
	mov rsp, rbp
	pop rbp
	ret
