bits 64

section .bss
	struc t_list
    	.data: resq 1
    	.next: resq 1
	endstruc
section .text
	global ft_list_sort

ft_list_sort:
	mov r12, rsi
	mov r8, [rdi + t_list.next]
	mov rbx, rdi
	xor r13, r13

.loop:
	cmp r8, 0
	je .check
	push rdi
	mov rdx, rdi
	push r8
	mov rdi, [rdx + t_list.data]
	mov rsi, [r8 + t_list.data]
	call r12
	pop rdi
	pop r8
	mov r9, r8
	mov r8, [rdi + t_list.next]
	cmp eax, 0
	je .loop
	inc r13
	mov r10, [rdi + t_list.data]
	mov r11, [r9 + t_list.data]
	mov [r9 + t_list.data], r10
	mov [rdi + t_list.data], r11
	jmp .loop

.check:
	test r13, r13
	je .done
	xor r13, r13
	mov rdi, rbx
	mov r8, [rdi + t_list.next]
	jmp .loop

.done:
	mov rax, rbx
	ret
