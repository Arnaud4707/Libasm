bits 64

section .bss
	struc t_list
    	.data: resq 1
    	.next: resq 1
	endstruc

section .data
    msg_debug db "stop", 10
    len_debug equ $ - msg_debug

section .text
	global ft_list_remove_if
	extern ft_free

ft_list_remove_if:
    push    rbp
    mov     rbp, rsp

    push    rbx             ; callee-saved
    push    r12
    push    r13

    mov rbx, rdi
    xor r13, r13
    mov r12, [rbx]
    mov r14, rsi
    mov r15, rdx

.loop:
    test r12, r12
    je .done
    mov rdi, [r12 + t_list.data]
    mov rsi, r14
    sub rsp, 8
	call r15
    add rsp, 8
    test rax, rax
    je .replace
    mov r13, r12
    mov r9, [r12 + t_list.next]
    mov r12, r9
    jmp .loop

.replace:
    test r13, r13
    je .replace_head
    mov rdi, r12
    mov r9, [r12 + t_list.next]
	mov r12, r9
    sub rsp, 8
	call ft_free
    add rsp, 8
    mov [r13 + t_list.next], r12
	jmp .loop

.replace_head:
    mov r9, [r12 + t_list.next]
	mov [rbx], r9
    mov rdi, r12
    push r9
    sub rsp, 8
	call ft_free
    add rsp, 8
    pop r12
    xor r13, r13
    jmp .loop

.done:
    pop     r13
    pop     r12
    pop     rbx
    mov rsp, rbp
    pop rbp
    ret

.debug:
    mov rax, 1
    mov rdi, 2
    mov rsi, msg_debug
    mov rdx, len_debug
    syscall

    mov rax, 60
    mov rdi, 4
    syscall
    jmp .done

