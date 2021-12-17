;**************************************
;
; |Prime numbers [Brute Force]
; |===========================
; |
; | Your Names :
; |===============
; - Ahmed Reda Morsi
; - Ahmed Noor
;
;**************************************
 
include emu8086.inc 

MAX equ 150  ;MAX == n
 
org 100h  
          
          
          
 ;============== take user input ->Range<- ==============        
 call TakeUserRange ; program can handle if range is 0 or 1 , less (n<0)
 
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

;******************* take user range and ckeck if is valid or not ***************************
TakeUserRange proc

    printn 'this program enable you to know the count of prime number between 0 and the number(n).'
    startAgain:
    printn 'the number (n)= '
    call scan_num  
    
    ;-----------------------
    ; checkif n is valid or not
    ;if n<1 , 0
    cmp cx,00d
    je CX_NotValid
    Js CX_NotValid 
    
                                 
ret
TakeUserRange endp 


;&&&&&&&&&&&&&&& calculate the prime numbers counter and their sum &&&&&&&&&&&&&&&&&&&&&&&&&&&&

Calulate_Count_Sum proc
  ; this loop run  for range n ---> 3
  ;if user input is 1
   cmp cx,01d
   je cx_1
  UpperLoop:
       cmp cx,02d    ; skip number 2 from eletrations
       je numberIs_2 
       ;--------------------------------------------------------
       mov UpperLoopCounter,CX       ;  save cx value before start Lower Loop
       mov LowerLoopCounter,CX       
       sub LowerLoopCounter,01d 
       mov IsPrime, 01d
       ;-----------------------------------
       
       ;****** ckecking is prime or not *********
        call CheckIfPrime 
        ;-----------------------------------  
         
       cmp IsPrime,01d
       je calculate_Sum_Count
         
       jmp skip2
           calculate_Sum_count:
             mov bx, UpperLoopCounter
             add primeSum,bx
             add primeCount,01d
      skip2: 
      ;-----------------------------------   
    
      mov cx,UpperLoopCounter   ; return to cx  the value of the upper loop conunter 
   
     jmp skip3
          numberIs_2:       
          mov cx,01d            
     skip3:
      
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


;$$$$$$$$$$$$$$$$$$$ check if number is prime or not $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
CheckIfPrime proc 
 ;this loop run  for range (n-1) ---> 2   
 ; set counter for Lower loop 
 mov cx,LowerLoopCounter   
     
     LowerLoop:
          mov dx,0000h             
          mov LowerLoopCounter,cx   
             
          ;---------------------------------- 
          cmp LowerLoopCounter,01d     ;avoid sequence from divide elteration 
                                         ;number by 1 which cuase that the modulus equal 0 
          je break_at_1       
             
          ;---------------------------------  
          mov ax,UpperLoopCounter
          div LowerLoopCounter
         
          cmp dx,00d             ; compare the modulus
          je ItIsNotPrime       ; jump if the number is not prime meaning modulus not zero
          
          jmp skip             ; to do ItIsNotPrime label only if the number is not Prime  
             
            ItIsNotPrime:
                mov cx,01d            ;mov LowerLoopCounter,01d
                mov IsPrime,00d  
           
          skip:
                                    
          ;--------------------------------  
          jmp skip1
             
             break_at_1:
                mov cx,01d
          skip1:   
          
             
     loop LowerLoop   

ret    
   
CheckIfPrime endp 





















  


 

        ;*****************************************************   
         
        ;******************************************** 
       
  





