;**************************************
;
; |Prime numbers [Fast Method]
; |===========================
; |
; |Your Names:
; |===============
; |Ahmed Reda Morsi
; |Ahmed Noor
;
;**************************************
 
include emu8086.inc 

MAX equ 1000  ;MAX == n
 
org 100h  
         
         
         
 ;============== Range ==============        
 call TakeUserRange 

 ;============== calulate count and sum ==================
 call Calulate_Count_Sum
 
 ;============== print ============== 
 call Print_Exit


         
ret  

 
;*** don't modify *** 
DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
;******************** 


;add your own variables here
primeCount dw 0 
primeSum dw 0  
UpperLoopCounter dw 0
LowerLoopCounter dw 0  
isprime db 0
modulus dw 0  

;--------------------------------------------
Print_Exit proc
                                                                                                        
    print 'Count of prime numebrs to n = '
    mov ax, primeCount
    call print_num   
    printn
    print 'Sum of prime numebrs to n = '
    mov ax, primeSum
    call print_num   
    
      ; if cx user input is not valid
    jmp skip6
        CX_NotValid:
        printn ' not a valid number'
        jmp startAgain
    skip6:    
ret         
Print_Exit endp

       
;**************************************************************************
TakeUserRange proc

    printn 'this program enable you to know the count of prime number between 0 and the number(n).'
    startAgain:
    printn 'the number (n)= '
    call scan_num  
    
    ;-----------------------
    ; checkif n is valid or not 
    ;if cx ==1
    cmp cx,01d
    je cx_1
    
    ;if n<1 , 0
    cmp cx,00d
    je CX_NotValid
    Js CX_NotValid 
    
    
     ; ensure that that counter(n) is odd number  to aviod the even numbers
     mov bx,02d
     mov ax,cx
     div bx
     cmp dx,00d
     je notOdd
     jmp skip
      notOdd:
        sub CX,01d
        mov UpperLoopCounter,CX
        mov cx,UpperLoopCounter ; set upper loop counter 
     skip:                                   
ret
TakeUserRange endp 


;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

Calulate_Count_Sum proc
  ; this loop run  for range n ---> 3  decreased by 2
    UpperLoop:
       
       cmp cx,01d
       je CX_at_1
     
       mov UpperLoopCounter,CX       ;  save cx value before start Lower Loop
       
       mov LowerLoopCounter,CX       
       sub LowerLoopCounter,02d 
       
       mov IsPrime, 01d              ;    01 meaning yes it's prime -- 00 meaning  no it isn't
        
       ;-----------------------------------
        
       ;****** ckecking is prime or not *********
         call CheckIfPrime 
         ;-----------------------------------  
         cmp IsPrime,01d
         je calculate_Sum_Count
             
         jmp skip3
             calculate_Sum_count:
                 mov bx, UpperLoopCounter
                 add primeSum,bx
                add primeCount,01d
         skip3:
         ;-----------------------------------   
       sub UpperLoopCounter, 01d 
       mov cx,UpperLoopCounter   ; return to cx  the value of the upper loop conunter 
       
       jmp skip4
       
       CX_at_1:
        mov cx,1d       
       
       skip4:
      
    loop UpperLoop
    
    
    
     ;add prime numbers ( 2 )
    
     add primeCount,01d
     add primeSum,02d   
                      
    ; if count = 1                   
    jmp skip5
        cx_1:
        mov primeSum,00d
        mov primeCount,00d
    skip5:
           
ret   
Calulate_Count_Sum endp


;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
CheckIfPrime proc 
 ;this loop run  for range (n-2) ---> 3  decreased by 2 
 ; set counter for Lower loop 
 mov cx,LowerLoopCounter
 LowerLoop:    
         mov dx,00d      
                                   
         mov LowerLoopCounter,cx   
             
         ;---------------------------------- 
          cmp LowerLoopCounter,01d     ;avoid sequence from divide elteration 
                                           ;number by 1 which cuase that the modulus equal 0 
          je breakLoop_at_1                
             
          ;---------------------------------  
          mov ax,UpperLoopCounter
          div LowerLoopCounter
             
          cmp dx,00d            ; compare the modulus of (UpperLoopCounter/LowerLoopCounter) with 00d
          je ItIsNotPrime       ; jump if the number is not prime meaning modulus not zero
                                  
              
          sub LowerLoopCounter,01d
          mov cx ,LowerLoopCounter 
             
             
          jmp skip1             ; to do ItIsNotPrime label only if the number is not Prime  
             ItIsNotPrime:
              mov cx,01d          ; terminate the Lower Loop 
              mov IsPrime,00d  
          skip1:
                 
                 
         jmp skip2
             breakLoop_at_1:
                 mov cx,01d
         skip2:
                  
 loop LowerLoop   

ret    
   
CheckIfPrime endp 
