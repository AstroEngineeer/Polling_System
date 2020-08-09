include emu8086.inc
org 100h           

jmp start
c1 db 0
c2 db 0 

start:

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

loop LL
l:
    print 'Your vote is registered'
    loop start  
    
    
ret 
end
 





