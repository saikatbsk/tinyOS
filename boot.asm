[BITS 32] ; Writing a 32 bit assembly
global start
start:
mov esp, _sys_stack    ; Pointing stack to new stack area
jmp stublet

; Align the multiboot header at a 32 bit boundary
ALIGN 4
mboot:
;Multiboot macros
MULTIBOOT_PAGE_ALIGN        equ 1<<0
MULTIBOOT_MEMORY_INFO        equ 1<<1
MULTIBOOT_AOUT_KLUDGE        equ 1<<16
MULTIBOOT_HEADER_MAGIC    equ 0x1BADB002
MULTIBOOT_HEADER_FLAGS    equ MULTIBOOT_PAGE_ALIGN | MULTIBOOT_MEMORY_INFO | MULTIBOOT_AOUT_KLUDGE
MULTIBOOT_CHECKSUM        equ -(MULTIBOOT_HEADER_MAGIC + MULTIBOOT_HEADER_FLAGS)
EXTERN code, bss, end

; GRUB Multiboot Header

dd MULTIBOOT_HEADER_MAGIC
dd MULTIBOOT_HEADER_FLAGS
dd MULTIBOOT_CHECKSUM

; AOUT kludge - must be physical addresses
; Linker script fills in data for these ones 
dd mboot
dd code
dd end
dd start

; Calling external c function here
stublet:
EXTERN cmain
call cmain
jmp $

; Definition of BSS section.
SECTION .bss
resb 8192    ;Reserving 8kb memory
_sys_stack:
