; print_hex(dx)
; parameters: dx (16bit hex digit / address)
; modifies:   bx (ascii string of hex digit)
print_hex:
	pusha
	mov si, 0x5
	mov bx, ASCII_TABLE
parse_string_loop:
	mov ax, dx
	and ax, 0x000f
	xlat
	mov byte [HEX_OUT+si], al
	sub si, 0x1
	shr dx, 4
	cmp si, 1
	jne parse_string_loop
end_func:
	popa
	mov bx, HEX_OUT
	call print_string
	ret

HEX_OUT: db "0x0000", 0
ASCII_TABLE: db "0123456789abcdef", 0
