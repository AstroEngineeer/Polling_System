include emu8086.inc
org 100h

 
jmp header
;data segement
v dw 1001,1002,1003,1004,1005 
n db ? 
c1 db ?
c2 db ?
v_id dw ?
av dw ?
vc dw 1
;data ends

;code segement
header:

print '                                       POLLING SYSTEM'
mov bx,1
start:
            mov vc,bx
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
            mov v_id,dx 
            mov cx,5     
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
            print 'Doesnot Exist'
            check2:
            mov cx,vc
            check1: 
                lea di,av
                mov ax,[di]
                cmp dx,ax
                je already
                inc di
                inc di
             loop check1
             ;mov cx,vc
             ;l:
             ;   mov dx,[di]
             ;   mov ah,02
             ;   int 21h
             ;   inc di
             ;   inc di
             ;loop l
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
                print 'The final Votes are'
                mov dl,c1 
                mov ah,02h
                int 21h
                print ' '
                mov dl,c2 
                mov ah,02h
                int 21h 
            jmp start             

start_voting:
    
    add vc,1
    ;mov ax,vc
    mov bx,vc
    ;mov ah,02
    ;int 21h  
    mov [di],dx
   
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
        mov ah,1
        int 21h        
        cmp al,1
        jz one
        add c2,1
        one:
        inc c1       
        mov dl,10
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
    mov dx,[di]
    jmp start   


;code ends
ret
end