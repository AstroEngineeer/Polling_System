include emu8086.inc
org 100h

jmp header
;data segement
v dw 1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,1013,1014,1015,1016,1017,1018,1019,1020,1021,1022,1023,1024,1025,?,?,?,?,?,?,?,?
n db 0 
c1 db 0    ;Candidate ONE votes
c2 db 0    ;Candidate Two Votes
c3 db 0    ;Candidate Three Votes
i dw 0
v_id dw ?
av_size= 35h
av dw  av_size dup(?) 
v1_id dw ?
vc dw 0
count dw 0
;data ends

;code segement
header:

; Author : Vignesh Ganesan
mov bx,1
start:      
                    
            mov ah,00 
            mov al,03
            int 10h 
            mov dl,10
            mov ah,02
            int 21h
            mov dl,13
            mov ah,02
            int 21h 
            print '                                       POLLING SYSTEM'            
            mov dl,10             ;new line
            mov ah,02h
            int 21h               
            mov dl,13             ;carrage return
            mov ah,02h
            int 21h
            print '1.Election Comissioner'
            mov dl,10             ;new line
            mov ah,02h
            int 21h
            mov dl,13             ;carrage return
            mov ah,02h
            int 21h
            print '2.Voters'
            mov dl,10             ;new line
            mov ah,02h
            int 21h
            print 'Enter Your Choice:::'
            mov ah,01h             ;input
            int 21h
            mov ah,0
            mov n,al               ;moving input from al to n.
            cmp n,31h              ;compare n and 31h(1)
            je admin               ;jump to admin module if input is 1
            jb wrong1              ;jump to wrong if input is less than 1
            cmp n,32h              ;compare n and 32h(2)
            je voters              ;jump to voters module if input is 2 
            ja wrong1              ;jump to wrong if input is greater than 2
wrong1:     
            mov dl,10
                mov ah,02
                int 21h
                mov dl,13
                mov ah,02
                int 21h
            print 'You HAve Entered A wrong Option'
            mov dl,10
                mov ah,02
                int 21h
                mov dl,13
                mov ah,02
                int 21h
            print 'Try Again.....'
            mov ah,00
            mov al,03
            int 10h
            jmp start            
voters:     
            mov vc,bx
            mov dl,10
            mov ah,02h
            int 21h
            print 'Enter Voter ID::'
            mov cx,04                  
            mov bl,10
            mov dx,00   
            ip:                   ;loop to get 4 digit input
                mov ax,dx
                mul bl 
                mov dx,ax   
                mov ax,0
                mov ah,1
                int 21h  
                sub al,30h 
                mov ah,0
                add dx,ax
            loop ip
            mov v_id,dx 
            mov cx,30     
            lea si,v            ; load efficitive address of v onto si
            lea di,av           ; load efficitive address of av onto di
            check:              ;loop to check if the entered voter id is registered
                mov ax,[si]                
                cmp ax,dx
                je check2
                inc si
                inc si
                mov ax,00
            loop check 
            mov dl,10
                mov ah,02
                int 21h
                mov dl,13
                mov ah,02
                int 21h
            print 'Does not Exist'
            jmp start
            check2:
            mov cx,vc           ; loop to check if the voter has already voted or not
            check1:
                mov ax,[di]
                cmp dx,ax
                je already
                inc di
                inc di
             loop check1
             ;mov cx,vc
             ;l:
;                mov dx,[di]
;                mov ah,02
;                int 21h
;                inc di
;                inc di
;             loop l
             jmp start_voting
             
already:
            mov dl,10
            mov ah,02
            int 21h
            mov dl,13
            mov ah,02
            int 21h 
            print 'Already vote is registered     '
            mov dl,10
                mov ah,02
                int 21h
                mov dl,13
                mov ah,02
                int 21h
            print 'Thank You....'
            mov ah,00
            mov al,03
            int 10h
            jmp start             
admin:
            mov dl,10
            mov ah,02h
            int 21h
            print 'Enter Master password:::'
            mov cx,04                  
            mov bl,10
            mov dx,00       ;loop to get master password
            ip1:
                mov ax,dx
                mul bl 
                mov dx,ax   
                mov ax,0
                mov ah,1
                int 21h  
                sub al,30h 
                mov ah,0
                add dx,ax
            loop ip1       
            cmp dx,0205h     ;compare the correct password with the entered password
            jz X1 
            mov dl,10
            mov ah,02
            int 21h
            mov dl,13
            mov ah,02
            int 21h            
            print 'Please Enter correct password'
            
            jmp start   
            X1:
               mov dl,10             ;new line
            mov ah,02h
            int 21h               
            mov dl,13             ;carrage return
            mov ah,02h
            int 21h
            print '1.Add Voter'
            mov dl,10             ;new line
            mov ah,02h
            int 21h
            mov dl,13             ;carrage return
            mov ah,02h
            int 21h
            print '2.View Result'
            mov dl,10             ;new line
            mov ah,02h
            int 21h
            mov dl,13             ;carrage return
            mov ah,02h
            int 21h
            print '3.List all Voters'
            mov dl,10             ;new line
            mov ah,02h
            int 21h
            mov dl,13             ;carrage return
            mov ah,02h
            int 21h
            print '4.List of already Voted'
            mov dl,10             ;new line
            mov ah,02h
            int 21h
            mov dl,13             ;carrage return
            mov ah,02h
            int 21h
            print '5.Exit'
            mov dl,10             ;new line
            mov ah,02h
            int 21h
            mov dl,13             ;carrage return
            mov ah,02h
            int 21h
            print 'Enter Your Choice:::'
            mov ah,01h             ;input
            int 21h
            mov ah,0
            mov n,al               ;moving input from al to n.
            cmp n,31h              ;compare n and 31h(1)
            je Y1                  ;jump to admin module if input is 1
            jb wrong4              ;jump to wrong if input is less than 1
            cmp n,32h              ;compare n and 32h(2)
            je Y                   ;jump to voters module if input is 2
            cmp n,33h              ;compare n and 33h(3)
            je Z
            cmp n,34h
            je Z1
            cmp n,35h
            je start                   ;jump to voters module if input is 3  
            ja wrong4              ;jump to wrong if input is greater than 3
            wrong4:
            print 'You HAve Entered A wrong Option'
            mov dl,10
                mov ah,02
                int 21h
                mov dl,13
                mov ah,02
                int 21h
            print 'Try Again.....'
            mov ah,00
            mov al,03
            int 10h
            jmp X1    
            
            Z:
                lea si,v
                mov cx,30
                printarray:
                mov dl,10
                     mov ah,02
                      int 21h
                      mov dl,13
                      mov ah,02
                     int 21h  
                 ;load the value stored  
                 
                 ; in variable d1 
                     mov ax,[si]        
                  ;print the value  
                 jmp PRINT
    
                step2:inc si
                inc si
                cmp cx,0
                je X1  
                loop printarray                        
                jmp X1    
             Z1:
                lea si,av
                mov cx,i
                printarray1:
                mov dl,10
                     mov ah,02
                      int 21h
                      mov dl,13
                      mov ah,02
                     int 21h  
                 ;load the value stored  
                 ; Author : Vignesh Ganesan
                 ; in variable d1 
                     mov ax,[si]        
                  ;print the value  
                 jmp PRINTX
    
                stepv:inc si
                inc si
                cmp cx,0
                je X1  
                loop printarray1                        
                jmp X1
PRINT:            
      
    mov count,0 
    mov dx,0 
    label1: 
        ; if ax is zero 
        cmp ax,0 
        je print1       
          
        ;initilize bx to 10 
        mov bx,10         
          
        ; extract the last digit 
        div bx                   
          
        ;push it in the stack 
        push dx               
          
        ;increment the count 
        inc count               
          
        ;set dx to 0  
        xor dx,dx 
        jmp label1 
    print1: 
        ;check if count  
        ;is greater than zero 
        cmp count,0 
        je step2
          
        ;pop the top of stack 
        pop dx 
          
        ;add 48 so that it  
        ;represents the ASCII 
        ;value of digits 
        add dx,48 
          
        ;interuppt to print a 
        ;character 
        mov ah,02h 
        int 21h 
          
        ;decrease the count 
        dec count 
        jmp print1 
                
            
PRINTX:            
      
    mov count,0 
    mov dx,0 
    label1X: 
        ; if ax is zero 
        cmp ax,0 
        je print1X       
          
        ;initilize bx to 10 
        mov bx,10         
          
        ; extract the last digit 
        div bx                   
          
        ;push it in the stack 
        push dx               
          
        ;increment the count 
        inc count               
          
        ;set dx to 0  
        xor dx,dx 
        jmp label1X 
    print1X: 
        ;check if count  
        ;is greater than zero 
        cmp count,0 
        je stepv
          ; Author : Vignesh Ganesan
        ;pop the top of stack 
        pop dx 
          
        ;add 48 so that it  
        ;represents the ASCII 
        ;value of digits 
        add dx,48 
          
        ;interuppt to print a 
        ;character 
        mov ah,02h 
        int 21h 
          
        ;decrease the count 
        dec count 
        jmp print1X            
           
           
            Y1:
                 
            mov dl,10
            mov ah,02h
            int 21h
            print 'Enter Voter ID::'
            mov cx,04                  
            mov bl,10
            mov dx,00   
            ip2:                   ;loop to get 4 digit input
                mov ax,dx
                mul bl 
                mov dx,ax   
                mov ax,0
                mov ah,1
                int 21h  
                sub al,30h 
                mov ah,0
                add dx,ax
            loop ip2
            mov v1_id,dx 
            mov cx,30     
            lea si,v            ; load efficitive address of v onto si
            checki:              ;loop to check if the entered voter id is registered
                mov ax,[si]                
                cmp ax,dx
                je printexists
                inc si
                inc si
                mov ax,00
            loop checki
            lea si,v
            mov cx,30
            arrloop:
                mov ax,[si]
                cmp ax,0h
                je insert
                inc si
                inc si
                mov ax,00
            loop arrloop 
            mov dl,10
                mov ah,02
                int 21h
                mov dl,13
                mov ah,02
                int 21h
            print 'array full '
            
            insert:
                mov ax,v1_id
                mov [si],ax 
                mov dl,10
                mov ah,02
                int 21h
                mov dl,13
                mov ah,02
                int 21h
                print 'successfully inserted'  
                mov dl,10
                mov ah,02
                int 21h
                mov dl,13
                mov ah,02
                int 21h
                print 'Press Any Key to exit..'
                mov ah,01
                int 21h        
                mov ah,00 
                mov al,03
                int 10h
                jmp start   
                
            printexists:  
                mov dl,10
                mov ah,02
                int 21h
                mov dl,13
                mov ah,02
                int 21h
                print 'Exist' 
                jmp X1   
                
            Y:                 ;display the final votes 
                mov ah,00h
                mov al,03h
                int 10h
                mov dl,10
                mov ah,02
                int 21h
                mov dl,13
                mov ah,02
                int 21h
                print 'The final Votes are'
                mov dl,10
                mov ah,02
                int 21h
                mov dl,13
                mov ah,02
                int 21h  
                print '1.Doraemon'
                mov dl,9
                mov ah,02
                int 21h 
                mov dl,9
                mov ah,02
                int 21h
                
                mov ax,0               
                mov al,c1
                div bl   
         
                mov bh,ah         
                mov dl,al
                add dl,30h
                mov ah,02
                INT 21h
          
                mov dl,bh
                add dl,30h
                mov ah,02
                INT 21h       
                mov dl,10
                mov ah,02h
                int 21h         
                mov dl,13
                mov ah,02
                int 21h
                
                print '2.Shin Chan'
                mov dl,9
                mov ah,02
                int 21h
                mov dl,9
                mov ah,02
                int 21h
                mov ax,0               
                mov al,c2
                div bl   
         
                mov bh,ah         
                mov dl,al
                add dl,30h
                mov ah,02
                INT 21h
          
                mov dl,bh
                add dl,30h
                mov ah,02
                INT 21h
                mov dl,10
                mov ah,02h
                int 21h         
                mov dl,13
                mov ah,02
                int 21h
                print '3.Ninja Hattori'
                mov dl,9
                mov ah,02
                int 21h
                mov dl,9
                mov ah,02
                int 21h
                mov ax,0               
                mov al,c3
                div bl   
         
                mov bh,ah         
                mov dl,al
                add dl,30h
                mov ah,02
                INT 21h
          
                mov dl,bh
                add dl,30h
                mov ah,02
                INT 21h
                mov dl,10
                mov ah,02h
                int 21h 
                jmp winner    
; Author : Vignesh Ganesan
start_voting:
    add vc,1    ;inc the no. of voters voted  
    inc i
    inc i
    mov bx,vc  
    mov [di],dx
    mov dx,[di]
   ; mov ah,02
    ;int 21h
    mov dl,10
    mov ah,02h
    int 21h 
    mov dl,13
    mov ah,02h
    int 21h
    C:print 'The Candidates are :::'
    mov dl,10
    mov ah,02h
    int 21h
    mov dl,13
    mov ah,02h
    int 21h
    print '1)Doraemon'  
    mov dl,10
    mov ah,02h
    int 21h 
    mov dl,13
    mov ah,02
    int 21h
    print '2)Shin Chan' 
    mov dl,10
    mov ah,02h
    int 21h
    mov dl,13
    mov ah,02
    int 21h 
    print '3)Ninja Hattori'
    mov dl,10
    mov ah,02h
    int 21h 
    mov dl,13
    mov ah,02
    int 21h
    print 'Enter your Choice::'
        mov ah,1
        int 21h        
        cmp al,31h       ;compare input and 31h(1)
        je one       ;jmp if al and 31h are equal
        jb wrong     ;jmp if input is less than 1
        cmp al,32h       ;compare inpit and 32h(2)
        je two       ;jmp if al and 32h are equal
        cmp al,33h       ;compare inpit and 33h(3)
        je three     ;jmp if al and 33h are equal
        ja wrong     ;jmp if input is greated than 3
        
        one:
            inc c1       ; increment vote for candidate 1
            jmp X
        two:
            inc c2        ; increment vote for candidate 2
            jmp X
        three:
            inc c3       ; increment vote for candidate 3
            jmp X
        wrong:
            print 'Enter a correct Value'
            jmp C
               
        X:
        mov dl,10
        mov ah,02h
        int 21h
         
        mov dl,13
        mov ah,02
        int 21h 
        print 'Your Vote Is Registered Successfully' 
        mov dl,10
        mov ah,02
        int 21h  
        mov dl,13
        mov ah,02
        int 21h
        print 'Thank You For Voting...'
        mov dl,10
        mov ah,02
        int 21h  
        mov dl,13
        mov ah,02
        int 21h
        print 'Press Any Key to exit..'
        mov ah,01
        int 21h        
        mov ah,00 
        mov al,03
        int 10h
        jmp start   
; Author : Vignesh Ganesan
winner: 
    mov al,c1
    mov bl,c2
    mov dl,c3
    cmp al,bl   ;compare al and bl
    jg cc       ;jump if al is greater than bl
    jl cc1      ;jump if al is less than bl
    je cc2      ;jump if al is equal to bl
    cc:
        cmp al,dl
        jg msg     ;jump if al is greater than dl
        jl msg2    ;jump if al is less than dl
        je msg5    ;jump if al is equal to dl
    cc1:
        cmp bl,dl
        jg msg1    ;jump if bl is greater than dl
        jl msg2    ;jump if bl is less than dl
        je msg4    ;jump if bl is equal  than dl
    cc2:
        cmp al,dl
        jg msg3    ;jump if al is greater than dl
        jl msg2     ;jump if al is less than dl
        je msg6    ;jump if al is equal to dl
msg:                                          
    print 'Doraemon is the Winner'
    ret
msg1:
    print 'ShinChan Nohara is the Winner'
    ret
msg2:
    print 'Ninja Hattori is the Winner'
    ret
msg3:
    print 'Doraemon and ShinChan Are Winners'
    ret
msg4:
    print 'ShinChan Nohara and NInja Hattori are the Winner'
    ret
msg5:
    print 'Doraemon and Ninja Hattori are the Winner'
    ret
msg6:
    print 'Doraemon,Ninja Hattori and ShinChan Nohara are the Winner'
    ret
ret
end