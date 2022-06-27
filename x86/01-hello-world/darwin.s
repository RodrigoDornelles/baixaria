section .data                        ; fixed and immutable bytes
message: db "Hello world!", 0xa, 0xd ; db is like a const data
size: equ $ - message                ; equ is like a macro 'defines'

section .text                        ; where does the program start
global start:                        ; entry point exposure
start:                               ; program entry point
    mov rax, 0x2000004  ; syscall: write
    mov rdi, 1          ; index (stdout=1)
    mov rsi, message    ; address of string
    mov rdx, size       ; size of string
    syscall             ; done

    mov rax, 0x2000001  ; syscall: exit
    mov rdi, 0          ; code success
    syscall             ; done
    