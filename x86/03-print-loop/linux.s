section .data
numbers:
    db "0123456789"

breakline:
    db 0xa, 0xd

section .text
global _start:
_start:
    xor r9, r9          ; reset counter
    call loop           ; start loop

loop:
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; index (stdout=1)
    mov rsi, numbers    ; pointer to text
    add rsi, r9         ; index position
    mov rdx, 1          ; size
    syscall             ; done.

    mov rax, 1          ; syscall: write
    mov rdi, 1          ; index (stdout=1)
    mov rsi, breakline  ; pointer to text
    mov rdx, 2          ; size
    syscall             ; done.

    inc r9              ; increment counter
    cmp r9, 9           ; compare with 10
    jle loop            ; go to ahead of loop

    mov rax, 60         ; syscall: exit
    xor rdi, rdi        ; code success (small optimization to clean rdi)
    syscall
