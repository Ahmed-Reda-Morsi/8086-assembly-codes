;**************************************
;
;  Matrix-Vector Multiplication
;  ===============================
;
;  Your Name : - Ahmed Reda 
             ; - Ahmed Nour 
;  ==============================
:
;**************************************
 
include emu8086.inc 

SIZE equ 5  ;defines a constant 'SIZE = 5' using equ directive
 
org 100h  


;;========= Display Matrix A ==========
call Display_Matrix
;====================================

printn
 
;====== Display Vector B =======
call Display_Vector
;==============================  
  
;;====== Matrix-vector Dot Product Operation ====;
call Matrix_Vector_Product                       
;==============================
  
printn 

;;======== Print Result ====;
call PRINT_RESULT
;==============================

ret

;;*** don't modify *** 
DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
;******************** 


;*** don't modify *** 
;initialize matrix A to (5x5) random numbers 
A db 1,4,5,4,6,5,6,1,8,2,8,7,0,2,3,9,3,1,6,5,0,2,7,6,1
;initialize vector B to 5 random numbers       
B db 5,6,3,8,9      
i dw ?   ;rows index        
;********************

;add your own variables here

C dw 5 dup(?)  ;16-bit empty vector to store the result 
row_idx dw 1 0       

; Procedures

Display_Matrix proc
    printn  'Matrix A:'
    mov cx, SIZE      ; define max iterations for outer loop                              
    mov si, 0
    ROW:
        mov i, cx      ; store current value of cx in i   
        mov cx, SIZE   ; define max iterations for inner loop
        mov di, 0 
        COL: 
            ; calculate matrix index
            ; bx = si * SIZE + di
            mov ax, si 
            mov bl, SIZE
            mul bl
            add ax, di
            mov bx, ax 
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
Display_Matrix endp 

Display_Vector proc
    printn  'Vector B:'                
    mov cx, SIZE   ;define max iterations                 
    mov si, 0     
    disp: 
        mov al, B[si]  
        call print_num ; print the value in al
        printn         ; print new line after each number
        inc si         ; increment si
    loop disp      ; loop and start from disp
    ret
Display_Vector endp

Matrix_Vector_Product proc
    mov cx, SIZE      ; define max iterations for outer loop                              
    mov si, 0         ; define si for vector idx                         
    mov row_idx,0         ; define idx for rows            
    _ROW:
        mov i, cx      ; store current value of cx in i   
        mov cx, SIZE   ; define max iterations for inner loop
        mov di, 0 
        _COL:  
            ; calculate matrix index
            ; bx = row_idx * SIZE + di
            mov ax,row_idx 
            mov bl, SIZE
            mul bl
            add ax, di
            mov bx, ax 
            mov al, A[bx]       ;
            
            ; Multiply Matrix * Vector and save result in C vector 
            mul B[di]
            add C[si],AX
            inc di         ; increment di for next column
        loop _COL       ; loop and start from COL       
        add si,2
        add row_idx,1
        mov cx, i      ; restore old value of cx of the outer loop
    loop _ROW       ; loop and start from ROW    
ret
Matrix_Vector_Product endp


PRINT_RESULT proc
    mov cx,SIZE
    mov si,0   
    printn 'Result'
    iterate:
        mov ax,C[si]
        call print_num
        printn
        add si,2
    loop iterate
ret
PRINT_RESULT endp  

