bits 64

section .bss
	struc t_list
    	.data: resq 1
    	.next: resq 1
	endstruc

section .text
	global ft_list_size

ft_list_size:
	xor rax, rax

.loop:
	cmp rdi, 0
	je .done
	inc rax
	mov rdi, [rdi + t_list.next]
	jmp .loop

.done:
	ret