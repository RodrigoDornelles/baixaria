section .data
message:
    db "Hello world!", 0xa, 0xd

section .text

%macro msg 2
    mov rax, 0x2000004  ; syscall: write
    mov rdi, 1          ; index (stdout=1)
    mov rsi, %1         ; address of string (arg1)
    mov rdx, %2         ; size of string (arg2)
    syscall             ; done
%endmacro

global start:
start:
    msg message, 14     ; expand macro

    mov rax, 0x2000001  ; syscall: exit
    mov rdi, 0          ; code success
    syscall             ; done
    