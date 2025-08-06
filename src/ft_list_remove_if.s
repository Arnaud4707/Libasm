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
    mov rbx, rdi
    xor r13, r13
    mov r9, [rbx]
    mov r14, rsi
    mov r15, rdx

.loop:
    test r9, r9
    je .done
    mov r12, r9
    mov rdi, [r9 + t_list.data]
    mov rsi, r14
    call r15
    test rax, rax
    je .replace
    mov r13, r12
    mov r9, [r12 + t_list.next]
    jmp .loop

.replace:
    test r13, r13
    je .replace_head
    mov r9, [r12 + t_list.next]
    push r9
	mov rdi, r12
	call ft_free
    pop r9
    mov [r13 + t_list.next], r9
	jmp .loop

.replace_head:
    mov r9, [r12 + t_list.next]
    push r9
	mov [rbx], r9
    mov rdi, r12
    call ft_free
    pop r9
    xor r13, r13
    jmp .loop

.done:
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

	; mov rbx, rdi
	; mov r11, [rbx]
	; mov r12, r11
	; mov r8, rsi
	; mov r9, rdx

; .loop_head:
; 	mov r11, r12
; 	test r11, r11
; 	je .done
; 	mov r12, [r11 + t_list.next]
; 	mov rdi, [r11 + t_list.data]
; 	mov rsi, r8
; 	call r9
; 	test rax, rax
; 	je .replace_head

; .loop_current:
; 	test r12, r12
; 	je .done
; 	mov rdi, [r12 + t_list.data]
; 	mov rsi, r8
; 	call r9
; 	mov rcx, r12
; 	mov r12, [rcx + t_list.next]
; 	test rax, rax
; 	je .replace_node
; 	mov r11, rcx
; 	jmp .loop_current

; .replace_node:
; 	mov [r11 + t_list.next], r12
; 	mov rdi, rcx
; 	call ft_free
; 	jmp .loop_current

; .replace_head:
; 	mov [rbx], r12
; 	mov rdi, r11
; 	call ft_free
; 	jmp .loop_head

; .done:
; 	ret
	
; .loop:
; 	test rdi, rdi
; 	je .done

; 	push rdi
; 	mov rdx, [rdi + t_list.data]
; 	mov rdi, rdx
; 	mov rsi, r8
; 	call r9
; 	pop r10
; 	mov rdi, [r10 + t_list.next] 
; 	cmp rax, rax
; 	jne .loop
; 	cmp r10, [rbx]
; 	je .replace_head
; 	push rdi
; 	mov rdi, r10
; 	call ft_free
; 	pop rdi

