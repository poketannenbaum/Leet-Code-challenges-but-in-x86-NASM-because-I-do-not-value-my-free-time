section .data
    prompt1 db 'Enter array separated by spaces', 0
    prompt2 db 'True', 0
    prompt3 db 'False', 0
    arrayinput db 256 dup (0)
    arraybutint dw 512 dup (0)
    anotherpointer dd 0
section .text
global main
extern io_print_string, io_get_string, io_print_dec

    main:
        mov eax, prompt1
        call io_print_string
        mov eax, arrayinput
        mov edx, 256
        call io_get_string
        mov edi, arrayinput
        call parse_number
        mov esi, anotherpointer
        mov ecx, arraybutint
        add ecx, [esi]
        mov [ecx], eax
        add dword [esi], 4
        xor eax, eax
        xor ebx, ebx
        xor ecx, ecx
        xor edx, edx
        xor esi, esi
        xor edi, edi
        mov eax, arraybutint
        mov ebx, anotherpointer
        mov ebx, [ebx]
        jmp find_out
        
    parse_number:
        xor eax, eax
        xor ebx, ebx
        mov ebx, 1
        movzx ecx, byte [edi]
        cmp ecx, '-'
        jne check_digit
        mov ebx, -1
        inc edi
        
    check_digit:
        xor eax, eax
        
    start_parsing:
        movzx ecx, byte [edi]
        cmp ecx, ' '
        je  state_of_the_art_space_detection_system
        cmp ecx, 0
        je parse_end
        cmp ecx, 10
        je parse_end
        sub ecx, '0'
        imul eax, eax, 10
        add eax, ecx
        inc edi
        jmp start_parsing

    state_of_the_art_space_detection_system:
        mov esi, anotherpointer
        mov ecx, arraybutint
        add ecx, [esi]
        inc edi
        imul eax, ebx
        mov [ecx], eax
        add dword [esi], 4
        xor eax, eax
        xor ecx, ecx
        xor esi, esi
        jmp parse_number
        
    parse_end:
        imul eax, ebx
        mov ebx, 0
        ret
        
    find_out:
        mov eax, [eax]
        cmp eax, 0
        jle zero
        imul eax, 4
        add ecx, eax
        cmp ecx, ebx
        jge win
        mov eax, arraybutint
        add eax, ecx
        jmp find_out

    win:
        mov eax, prompt2
        call io_print_string
        jmp end

    zero:
        mov eax, prompt3
        call io_print_string
        jmp end

    end:
        ret 1
        
        
