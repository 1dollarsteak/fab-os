; TODO: draw memory map
; TODO: create BPB
; TODO: boot_drive issue, save dl with pusha
; DONE.
[org 0x7c00]
[bits 16]

start:
JMP 0x0000:flushcs

flushcs:
xor ax, ax
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x7c00 

mov [BOOT_DRIVE], dl

mov bx, MSG_REAL_MODE
call print_string

call load_kernel

%include "tools/print_string.asm"
%include "tools/disk_load.asm"
%include "tools/gdt.asm"
%include "tools/print_string_pm.asm"
%include "tools/switch_to_pm.asm"

[bits 16]
load_kernel:
  mov bx, MSG_LOAD_KERNEL
  call print_string

  mov bx, KERNEL_OFFSET
  mov dh, 15
  mov dl, [BOOT_DRIVE]
  call disk_load
  call switch_to_pm
  ret

[bits 32]
BEGIN_PM:
  mov ebx, MSG_PROT_MODE
  call print_string_pm

  call KERNEL_OFFSET
  mov ebx, MSG_RET_KERNEL
  call print_string_pm
  jmp $

BOOT_DRIVE db 0
MSG_REAL_MODE db "Started in 16-bit real mode", 0
MSG_PROT_MODE db "Successfully landed in 32-bit protected mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory.", 0
MSG_RET_KERNEL db "Returned from kernel.", 0

times 510-($-$$) db 0
dw 0xaa55

KERNEL_OFFSET:
incbin "kernel/kernel.bin"
