print_string:
	pusha
	mov ah, 0x0e
	mov si, 0x0

print_loop:
	mov al, [bx+si]
	cmp al, 0
	je end_if
	add si, 0x1
	int 0x10
	jmp print_loop

end_if:
	mov al, 0x0a
	int 0x10
	mov al, 0x0d
	int 0x10
	popa
	ret
