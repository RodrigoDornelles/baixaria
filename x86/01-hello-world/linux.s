section .data
message:
    db "Hello world!", 0xa, 0xd

section .text
global _start:
_start:
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; index (stdout=1)
    mov rsi, message    ; address of string
    mov rdx, 13         ; size of string
    syscall             ; done

    mov rax, 60         ; syscall: exit
    mov rdi, 0          ; code success
    syscall             ; done
    