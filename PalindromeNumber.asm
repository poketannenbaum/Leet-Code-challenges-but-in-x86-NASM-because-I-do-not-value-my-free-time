section .data
    prompt1 db 'Enter number',0
    prompt2 db 'Not a palindrome',0
    prompt3 db 'Palindrome',0
    basenum dd 0
    
section .text
global main
extern io_print_string, io_get_dec

    main:
    mov ebp, esp
        mov esi, 0
        mov eax, prompt1
        call io_print_string
        mov eax, basenum
        call io_get_dec
        mov ebx, basenum
        mov [ebx], eax
        cmp eax, 0
        jle negative
    readd:
        xor ebx, ebx
        xor edx, edx
        mov ebx, 10
        div ebx
        add esi, edx
        imul esi, 10
        cmp eax, 10
        jle processing
        jmp readd
    processing:
        add esi, eax
        mov ebx, basenum
        cmp [ebx], esi
        je palindrome
    negative:
        mov eax, prompt2
        call io_print_string
        jmp end
    palindrome:
        mov eax, prompt3
        call io_print_string
        jmp end
    end:
        ret 1
