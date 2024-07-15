section .data
    prompt1 db 'Enter array separated by spaces'
    prompt2 db 'Enter target number'
    prompt3 db 'There is no solution'
    arrayinput db 256 dup (0)
    targetinput db 256 dup (0)
    arraybutint dw 512 dup (0)
    arraypointer1 dd 4 ;Starts at 4 for reasons I cannot legally disclose
    anothercringeoffset dd 0 ;god help me
    anotherpointer dd 0
section .text
global main
extern io_print_string, io_get_string, io_print_dec

    main:
        mov eax, prompt1 ;Move the prompt into the register this thing reads from
        call io_print_string ;Read the thing from the register
        mov eax, arrayinput ;Where in memory to put the string
        mov edx, 256 ;Input buffer so we do not get hacked by zoomers
        call io_get_string ;Get the string from the guy
        mov eax, prompt2 ;Move the other prompt into the register this thing reads from
        call io_print_string ;Read the thing from the register and put it out on the screen for your viewing pleasure
        mov eax, targetinput ;Where we need to put the string in memory, same size as the other one because I'm lazy and don't want to update the other register
        call io_get_string ;Get the string from the dude
        mov edi, arrayinput ;Put the array input into this B for parsing
        call parse_number ;Make the number into a number because computers do not know how to make numbers numbers without you holding their hand
        mov esi, anotherpointer ;Lazy programmer adds the last element outside of the loop (He is not smart enough to set a condition for the element of the array)
        mov ecx, arraybutint ;Lazy programmer adds the last element outside of the loop (He is not smart enough to set a condition for the element of the array)
        add ecx, [esi] ;Lazy programmer adds the last element outside of the loop (He is not smart enough to set a condition for the element of the array)
        mov [ecx], eax ;Lazy programmer adds the last element outside of the loop (He is not smart enough to set a condition for the element of the array)
        add dword [esi], 4 ;Lazy programmer adds the last element outside of the loop (He is not smart enough to set a condition for the element of the array)
        mov edi, targetinput ;Put the target input into this B for parsing
        call parse_number ;Function moment
        mov ecx, targetinput ;LOAD IT
        mov [ecx], eax ;LOAD IT
        xor eax, eax ;FLUSH
        xor ebx, ebx ;FLUSH
        xor ecx, ecx ;FLUSH
        xor edx, edx ;FLUSH
        xor esi, esi ;FLUSH
        xor edi, edi ;FLUSH
        jmp find_out ;Finally
        
        
    parse_number:
        xor eax, eax ;FLUSH
        xor ebx, ebx ;FLUSH IT BROTHER
        mov ebx, 1 ;For the negative numbers pleasure
        movzx ecx, byte [edi] ;Pointer to a pointer that is pointing to the array somewhere or something idk I just work here
        cmp ecx, '-' ;Negative numbers work too I guess good for them
        jne check_digit ;Do not make it negative if it innit negative chief
        mov ebx, -1 ;Make it negative if it is negative chief
        inc edi ;Increase the pointer because - is literally not even a number, I'm well researched in this.
        
    check_digit:
        xor eax, eax ;Probably don't even need this at this point TBH I don't have my BS degree yet though so I'm going to leave it here
        
    start_parsing:
        movzx ecx, byte [edi] ;Move the current byte of the pointer of the pointer to the memory address that is pointing to the array input 
        cmp ecx, ' ' ;If there is a space GET OFF MY PAIGE
        je  state_of_the_art_space_detection_system ;BEGONE
        cmp ecx, 0 ;Since I filled the space in memory with nulls if the upcoming thing is a null it's not a number
        je parse_end ;BEGONE
        cmp ecx, 10
        je parse_end
        sub ecx, '0' ;Subtract ASCII 0 from whatever ASCII number we are working with to get a numerical value equal to the actual numerical value of the number in question, if you don't understand this don't worry I don't either.
        imul eax, eax, 10 ;Multiply the result of that by 10 so that we can add 
        add eax, ecx ;Add 
        inc edi ;Increment the pointer to the pointer of the pointer by 1 so that we can point to a different part of the pointer that points to the place where the stuff is supposed to be
        jmp start_parsing

    state_of_the_art_space_detection_system:
        mov esi, anotherpointer ;Load up the pointer
        mov ecx, arraybutint ;Load up the address of the array
        add ecx, [esi] ;OFFSET IT SON
        inc edi ;Increase pointer
        imul eax, ebx ;Mult for the mult gods
        mov [ecx], eax ;Incredible play moving this number into this array at the offset of the pointer
        add dword [esi], 4 ;Add a little something something to make the offset work right
        xor eax, eax ;FLUSH
        xor ecx, ecx ;FLUSH
        xor esi, esi ;FLUSH
        jmp parse_number ;I'm basically a young Linus Torvalds for this line of code if you don't really think about it
        
    parse_end:
        imul eax, ebx ; ASKERS?
        mov ebx, 0
        ret
        
    find_out:
        mov edi, anothercringeoffset ; I've run the simulations there's literally no better way to do this
        mov ecx, [edi]
        mov edi, ecx
        mov ebx, arraypointer1 ;LOAD IT I DON'T KNOW JUST LOAD IT
        mov ecx, [ebx]
        mov ebx, ecx
        cmp ebx, edi ;ARE THEY THE SAME?
        je THEYRE_THE_SAME_BROTHER_HELP_ME
        mov ecx, arraybutint ;Load a number
        add ecx, edi ;OFF SET IT
        mov eax, [ecx] ;(Actually load a number)
        mov edi, arraypointer1 ;Load in offset
        add ecx, [edi] ;32 bit magic in the air
        mov ebx, [ecx] ;https://www.youtube.com/watch?v=w-6MDQZ9cZc
        mov ecx, targetinput ;Load a number
        mov edi, [ecx] ;(This is even funnier the second time)
        add eax, ebx ; Conceptually the hardest math you've ever seen
        cmp eax, edi ; Social comparison theory is a myth
        je ladies_and_gentlemen_we_got_him
        mov eax, anotherpointer ;https://movie-screencaps.com/wp-content/uploads/2021/07/4k-returnofking-movie-screencaps.com--1024x427.jpg
        mov edi, [ecx]
        mov ecx, edi
        mov edi, [eax]
        mov eax, edi
        cmp ecx, eax ; IF THESE ARE THE SAME WE'LL GET EM NEXT TIME CAPTAIN CHIN UP
        je resetti ; ABORT ABORT ABORT ABORT
        mov ecx, arraypointer1 ;Load that offset
        add dword [ecx], 4 ;BUMP IT UP A NOTCH
        jmp find_out
        
    THEYRE_THE_SAME_BROTHER_HELP_ME: ;Let me learn you something
        mov ecx, arraypointer1 ;Load the number we adding in the club 2nite
        add dword [ecx], 4 ;Literally fixed it.
        mov eax, anotherpointer ;Load the sheer girth of the array
        mov edi, [ecx]
        mov ecx, edi
        mov edi, [eax]
        mov eax, edi
        cmp ecx, eax ; Compare sizes with your homie
        jg dad_was_right ; :(
        jmp find_out
        
        
    resetti:
        mov eax, anothercringeoffset ;BASE OFFSET
        add dword [eax], 4 ; MORE
        mov eax, arraypointer1 ;CLEAR IT
        mov dword [eax], 0 ;LESS
        jmp find_out ;A good programmer would probably clear the registers or something idk
        
    ladies_and_gentlemen_we_got_him:
        mov edx, arraypointer1 ;Stand back I'm about to perform division
        mov eax, [edx]
        cmp eax, 0 ;Can't divide by that it's not good for you
        je we_dont_divide_by_zero_here
        mov edx, 0
        mov ecx, 4
        div ecx
        mov edx, arraypointer1 ;POINT
        mov [edx], eax ;SHOOT
    we_dont_divide_by_zero_here:
        mov edx, anothercringeoffset ;Stand back I'm about to perform division (again)
        mov eax, [edx]
        cmp eax, 0 ;Can't divide by that it's not good for you (again)
        je we_still_dont_divide_by_zero_here
        mov edx, 0
        mov ecx, 4
        div ecx
        mov edx, anothercringeoffset ;POINT (again)
        mov [edx], eax ;SHOOT (again)
    we_still_dont_divide_by_zero_here:
        call io_print_dec ;Missed opportunity to flip this shit and make this smaller but we ball
        mov edx, arraypointer1
        mov eax, [edx]
        call io_print_dec ;PRINT PRINT PRINT PRINT
        jmp finish
        
    dad_was_right:
        mov eax, prompt3 ;RIP
        call io_print_string ;RIP
        jmp finish
        
    finish:
        ret ; GG
