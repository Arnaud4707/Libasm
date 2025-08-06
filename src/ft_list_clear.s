bits 64

section .bss
	struc t_list
    	.data: resq 1
    	.next: resq 1
	endstruc

section .text
	global ft_list_clear
	extern ft_free

ft_list_clear:

.loop:
	cmp rdi, 0
	jle .done
	mov rbx, [rdi + t_list.next]
	push rbx
	call ft_free
	pop rdi
	jmp .loop

.done:
	ret
