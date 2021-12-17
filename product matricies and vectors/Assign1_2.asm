;**************************************
;
;  Matrix-Matrix Multiplication
;  ===============================
;
;  Your Name :
;  ==============================
;
;**************************************
 
include emu8086.inc 

SIZE equ 5  ;defines a constant 'SIZE = 5' using equ directive
 
org 100h  

printn

;===== MATRIX A =====;
call Display_Matrix_A
;=====================                     
printn                     
 
;===== MATRIX B =====;
call Display_Matrix_B
;=====================

;;========= Matrix A * Matrix B mutliplication ==========
call Matrix_Matrix_Product
;========================================================

printn
                              
;=== MATRIX C ===;
call Display_Matrix_C


                                                                                                       
  
ret  

 

;====== Procedures ======;

Display_Matrix_A proc
    printn  'Matrix A:'
    mov cx, SIZE      ; define max iterations for outer loop                              
    mov si, 0
        ROW:
        mov i, cx      ; store current value of cx in i   
        mov cx, SIZE   ; define max iterations for inner loop
        mov di, 0 
        COL: 
            ; **calculate matrix index**
            ; bx = si * SIZE + di
            mov ax, si 
            mov bl, SIZE
            mul bl
            add ax, di
            mov bx, ax
            ; ************************** 
            mov al, A[bx]
            call print_num ; print the value in al
            print ' '      ; print a space after each number 
            inc di         ; increment di for next column
        loop COL       ; loop and start from COL 
        inc si         ; incerment si for next row
        printn         ; print new line
        mov cx, i      ; restore old value of cx of the outer loop
        loop ROW       ; loop and start from ROW    
    ret
Display_Matrix_A endp  


Display_Matrix_B proc
    printn  'Matrix B:'
    mov cx, SIZE      ; define max iterations for outer loop                              
    mov si, 0
    ROW2:
    mov i, cx      ; store current value of cx in i   
    mov cx, SIZE   ; define max iterations for inner loop
    mov di, 0 
    COL2: 
    ; **calculate matrix index**
    ; bx = si * SIZE + di
    mov ax, si 
    mov bl, SIZE
    mul bl
    add ax, di
    mov bx, ax
    ; ************************** 
    mov al, B[bx]
    call print_num ; print the value in al
    print ' '      ; print a space after each number 
    inc di         ; increment di for next column
    loop COL2      ; loop and start from COL 
    inc si         ; incerment si for next row
    printn         ; print new line
    mov cx, i      ; restore old value of cx of the outer loop
    loop ROW2      ; loop and start from ROW
    ret
Display_Matrix_B endp



 
Matrix_Matrix_Product proc
    mov cx, SIZE      ; define max iterations for outer loop                               
    mov si, 0 
    mov di,0 
    mov idx_i,0
    _ROW:
        mov i, cx      ; store current value of cx in i   
        mov cx, SIZE   ; define max iterations for inner loop
        mov idx_j,0
            _COL: 
                mov j,cx ; store current value of cx in j 
                mov cx,SIZE  
                mov idx_k,0
                innerLoop:   
                    mov si,0
                    mov di,0
                    
                    ; A 
                    ; idx_A = idx_i * size + idx_k 
                    mov ax,0
                    mov bx,0   
                    mov ax,idx_i
                    mov bl,SIZE
                    mul bl 
                    add ax,idx_k
                    mov bx,ax
                    mov idx_A,bx
                                       
                    ; B
                    ; idx_B = idx_k * size + idx_j  
                    mov ax,0
                    mov bx,0  
                       
                    mov ax,idx_k
                    mov bl,SIZE
                    mul bl
                    add ax,idx_j
                    mov bx,ax
                    mov idx_B,bx 
                                    
                    ;C 
                    ; idx_C = idx_i * size + idx_j  
                    mov ax,0
                    mov bx,0
         
                    mov ax,idx_i
                    mov bl,SIZE
                    mul bl
                    add ax,idx_j
                    mov bx,ax
                    mov idx_C,bx
                    
                    ; C[idx_c] = A[idx_A ] * B[idx_B]   
                    mov ax,0
                    mov bx,0
                             
                    mov si,idx_A
                    mov di,idx_B
                    
                    mov al,A[si]
                    mul B[di]
                              
                    mov si,0
                    mov si,idx_C
                    
                    add C[si],al
                    add idx_k,1 
                loop innerLoop
                add idx_j,1         ; increment di for next column 
                mov cx,j     
        loop _COL       ; loop and start from COL
        add idx_i,1         ; incerment si for next row
        mov cx, i      ; restore old value of cx of the outer loop
    loop _ROW       ; loop and start from ROW    
    ret
Matrix_Matrix_Product endp                                         
                                         
Display_Matrix_C proc
    printn  'Matrix C:'
    mov cx, SIZE      ; define max iterations for outer loop                              
    mov si, 0
    ROW3:
        mov i, cx      ; store current value of cx in i   
        mov cx, SIZE   ; define max iterations for inner loop
        mov di, 0 
        COL3: 
            ; calculate matrix index
            ; bx = si * SIZE + di
            mov ax, si 
            mov bl, SIZE
            mul bl
            add ax, di
            mov bx, ax 
            mov al, C[bx]
            call print_num ; print the value in al
            print ' '      ; print a space after each number 
            inc di         ; increment di for next column
        loop COL3       ; loop and start from COL 
        inc si         ; incerment si for next row
        printn         ; print new line
        mov cx, i      ; restore old value of cx of the outer loop
    loop ROW3       ; loop and start from ROW      
    ret
Display_Matrix_C endp               


;*** don't modify *** 
DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
;******************** 


;*** don't modify *** 
;initialize matrix A to (5x5) random numbers 
A db 1,4,5,4,6,5,6,1,8,2,8,7,0,2,3,9,3,1,6,5,0,2,7,6,1
;initialize vector B to (5x5) random numbers       
B db 3,0,5,1,6,7,6,4,8,2,9,7,1,2,3,5,3,1,8,6,4,2,7,7,1      
i dw ?   ;outerloop idx
j dw ?   ;innerLoop idx
k dw ?   ; in innerloop idx     

idx_i dw 0
idx_j dw 0 
idx_k dw 0


idx_A dw 0
idx_B dw 0
idx_C dw 0   

C db SIZE*SIZE dup(?)  ;8-bit (5x5) empty matrix to store the result

;********************