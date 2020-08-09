include emu8086.inc
org 100h           
    
;.model small
;.stack 100h
;.data

buff        db  26        ;MAX NUMBER OF CHARACTERS ALLOWED (25).
            db  ?         ;NUMBER OF CHARACTERS ENTERED BY USER.
            db  26 dup(0) ;CHARACTERS ENTERED BY USER.
      
jmp start
c1 db 0
c2 db 0
n db ?
         
;.code
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
            cmp n,32
            je voters 
            jne admin
            
voters:
            mov dl,10
            mov ah,02h
            int 21h
            print 'Enter Voter ID::'
            mov ax, @data
            mov ds, ax              

            ;CAPTURE STRING FROM KEYBOARD.                                    
            mov ah, 0Ah ;SERVICE TO CAPTURE STRING FROM KEYBOARD.
            mov dx, offset buff
            int 21h                 
            
            ;CHANGE CHR(13) BY '$'.
            mov si, offset buff + 1 ;NUMBER OF CHARACTERS ENTERED.
            mov cl, [si] ;MOVE LENGTH TO CL.
            mov ch, 0      ;CLEAR CH TO USE CX. 
            inc cx ;TO REACH CHR(13).
            add si, cx ;NOW SI POINTS TO CHR(13).
            mov al, '$'
            mov [ si ], al ;REPLACE CHR(13) BY '$'.
            jmp start_voting  
admin:
            mov dl,10
            mov ah,02h
            int 21h
            print 'Enter Master password:::'
            
             mov cx,03                  
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
    print 'Enter your choice::'

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
            ;DISPLAY STRING.                   
            mov ah, 9 ;SERVICE TO DISPLAY STRING.
            mov dx, offset buff + 2 ;MUST END WITH '$'.
            int 21h
        print '->Your vote is registered'
    jmp start  
ret 
end
 





