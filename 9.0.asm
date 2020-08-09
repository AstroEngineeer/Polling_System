include emu8086.inc
org 100h

 
jmp header
;data segement
v dw 1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,1013,1014,1015,1016,1017,1018,1019,1020,1021,1022,1023,1024,1025
n db ? 
c1 db 0
c2 db 0   
c3 db 0
v_id dw ?
av_size= 25h
av dw  av_size dup(?)
vc dw 0
;data ends

;code segement
header:

print '                                       POLLING SYSTEM'
mov bx,1
start:      
            
            mov dl,10
            mov ah,02h
            int 21h 
            mov dl,13
            mov ah,02h
            int 21h
            print '1.Election Comissioner'
            mov dl,10
            mov ah,02h
            int 21h
            mov dl,13
            mov ah,02h
            int 21h
            print '2.Voters'
            mov dl,10
            mov ah,02h
            int 21h
            print 'Enter Your Choice:::'
            mov ah,01h
            int 21h
            mov ah,0
            mov n,al   ;moving option from al to n.
            cmp n,31h
            je admin
            jb wrong1
            cmp n,32h
            je voters 
            ja wrong1
wrong1:
            print 'You HAve Entered A wrong Option'
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
            ip:
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
            mov cx,25     
            lea si,v
            lea di,av
            check:
                mov ax,[si]                
                cmp ax,dx
                je check2
                inc si
                inc si
                mov ax,00
            loop check
            print 'Does not Exist'
            jmp start
            check2:
            mov cx,vc
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
    print 'Already vote is registered'
    jmp start             
admin:
            mov dl,10
            mov ah,02h
            int 21h
            print 'Enter Master password:::'
            mov cx,03                  
            mov bl,10
            mov dx,00    
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
            cmp dx,123
            jz Y             
            print 'Please Enter correct password' 
            jmp start
            Y:  
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
                print '1.Doraemon'
                mov dl,9
                mov ah,02
                int 21h 
                mov dl,9
                mov ah,02
                int 21h
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
                print '2.Shin Chan'
                mov dl,9
                mov ah,02
                int 21h
                mov dl,9
                mov ah,02
                int 21h
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
                print '3.Ninja Hattori'
                mov dl,9
                mov ah,02
                int 21h
                mov dl,9
                mov ah,02
                int 21h
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

start_voting:
    add vc,1
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
    mov dl,10
    mov ah,02h
    int 21h
    print '1)Doraemon'  
    mov dl,10
    mov ah,02h
    int 21h
    print '2)Shin Chan' 
    mov dl,10
    mov ah,02h
    int 21h 
    print '3)Ninja Hattori'
    mov dl,10
    mov ah,02h
    int 21h
    print 'Enter your Choice::'
        mov ah,1
        int 21h        
        cmp al,31h
            je one
            jb wrong 
        cmp al,32h
            je two
        cmp al,33h
            je three
            ja wrong
        
        
        one:
            inc c1
            jmp X
        two:
            inc c2
            jmp X
        three:
            inc c3
            jmp X
        wrong:print 'Enter a correct Value'
              jmp C
        
               
        X:mov dl,10
        mov ah,02h
        int 21h
           
        mov dx,v_id
        mov ah,02h
        int 21h
        print '-Your Vote Is Registered' 
        mov dl,10
        mov ah,02
        int 21h  
        mov dl,13
        mov ah,02
        int 21h
    jmp start   


winner: 
    mov al,c1
    mov bl,c2
    mov dl,c3
    cmp al,bl
    jg cc
    jl cc1
    je cc2
    cc:
    cmp al,dl
     jg msg
     jl msg2
     je msg5
    cc1:
        cmp bl,dl
        jg msg1
        jl msg2
        je msg4
    cc2:
        cmp al,dl
        jg msg3
        jl msg
        je msg5
msg:
    print 'Doraemon is the Winner'
    ret
msg1:
    print 'Shin Chan is the Winner'
    ret
msg2:
    print 'Ninja Hattori is the Winner'
    ret
msg3:
    print 'Doraemon and ShinChan Are Winners'
    ret
msg4:
    print 'Shin Chan and NInja Hattori are the Winner'
    ret
msg5:
    print 'Doraemon and Ninja Hattori are the Winner'
    ret



ret
end