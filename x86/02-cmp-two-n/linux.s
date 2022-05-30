section .data
    txtLess:  db 'edi < esi', 0xa, 0xd
    txtBigg:  db 'edi > esi', 0xa, 0xd
    txtLike:  db 'edi = esi', 0xa, 0xd

section .text
printLess:
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; index (stdout=1)
    mov rsi, txtLess    ; address of string
    mov rdx, 11         ; size of string
    syscall             ; done
    call exit           ; go to end

printBigg:
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; index (stdout=1)
    mov rsi, txtBigg    ; address of string
    mov rdx, 11         ; size of string
    syscall             ; done
    call exit           ; go to end

printLike:
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; index (stdout=1)
    mov rsi, txtLike    ; address of string
    mov rdx, 11         ; size of string
    syscall             ; done
    call exit           ; go to end

exit:
    mov rax, 60         ; syscall: exit
    xor rdi, rdi        ; code success (small optimization to clean rdi)
    syscall             ; done

global _start:
_start:
    mov edi, 2          ; set value of edi (change it)
    mov esi, 2          ; set value of esi (change it)

    cmp edi, esi        ; comparison between edi and esi (edi minus esi)
    ja  printBigg       ; jump if edi is bigger then esi (negative)
    jb  printLess       ; jump if edi is lesser then esi (positive)
    jmp printLike       ; jump when it does not satisfy other conditions (zero)
