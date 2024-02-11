; TODO understand below
; lodsb
; L:
; stosw
; lodsb
; test al, al
; jnz L
; TODO: change parameter from ebx to esi to use lodsb

[bits 32]
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print_string_pm:
	pusha ; TODO: check use; use di and define a contract with the caller that di must be used
	mov edx, VIDEO_MEMORY ; di for using stosb
	mov ah, WHITE_ON_BLACK

; lodsb (to load es:edi to al)
print_string_pm_loop:
	; stosw (store ax at address es:edi), if edi is &video_memory
	mov al, [ebx] ; lodsb (

	test al, al
	je print_string_pm_done ; jnz string_pm_loop

	mov [edx], ax ; store character in video memory

	inc ebx
	add edx, 2

	jmp print_string_pm_loop

print_string_pm_done:
	popa
	ret

