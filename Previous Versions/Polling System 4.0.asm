include emu8086.inc
org 100h

 
jmp start
;data segement
v dw 1001,1002,1003,1004,1005 
n db ? 
c1 db ?
c2 db ?

;data ends

;code segement
start:

print '                                       POLLING SYSTEM'
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
            cmp n,32h
            je voters 
            jne admin
            
voters:     mov dl,10
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
            mov cx,5     
            lea si,v
            check:
                mov ax,[si]                
                cmp ax,dx
                je start_voting
                inc si
                mov ax,00
            loop check
            print 'Doesnot Exist'
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
            print 'no' 
            jmp start
            Y:
                print 'yes'
                jmp start             

start_voting:

    mov dl,10
    mov ah,02h
    int 21h 
    mov dl,13
    mov ah,02h
    int 21h
    print 'The Candidates are :::'
    mov dl,10
    mov ah,02h
    int 21h
    mov dl,10
    mov ah,02h
    int 21h
    print '1)Simon' 
    ;mov dl,13
    ;mov ah,02h
    ;int 21h  
    mov dl,10
    mov ah,02h
    int 21h
    print '2)Vicky' 
    mov dl,10
    mov ah,02h
    int 21h
    mov dl,10
    mov ah,02h
    int 21h
    print 'Enter your Choice::'

    LL:
        mov ah,1
        int 21h
        cmp al,0Dh
        jz l        
        cmp al,1
        jz one
        add c2,1
        one:
        inc c1 
    jmp LL
    l:      
            mov dl,10
            mov ah,02h
            int 21h
           
        print '->Your Vote Is Registered' 
        mov dl,10
        mov ah,02
        int 21h  
        mov dl,13
        mov ah,02
        int 21h
    jmp start   


;code ends
ret
end