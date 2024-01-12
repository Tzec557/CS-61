;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Tristan Zhao
; Email: ezhao012@ucr.edu
; 
; Assignment name: Assignment 2
; Lab section: 024
; TA: 
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------

;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

;-------------------------------
;INSERT YOUR CODE here
;--------------------------------
;initialize value
AND R1, R1, #0 
AND R2, R2, #0
LD R4 DEC_48

GETC              ;get user input the first value(it is a character not number)
ADD R1, R1, R0      ;store it into R1
OUT
LD R0, newline
OUT
    
GETC              ;get user input the second value(it is a character not number)
ADD R2, R2, R0      ;store it into R1
OUT
LD R0, newline    
OUT

;print out the equation
ADD R0, R1, #0     
OUT               ;print out the first value
LD R0, space
OUT
LD R0, subtract   ;print out the symbol
OUT
LD R0, space
OUT
ADD R0, R2, #0
OUT               ;print out the second value
LD R0, space
OUT
LD R0, equal
OUT
LD R0, space
OUT

;convert the ascii(character) to number(it will convert to binary internally)
;ADD R1, R1, #-12
;ADD R1, R1, #-12
;ADD R1, R1, #-12
;ADD R1, R1, #-12
ADD R1 R1 R4

;ADD R2, R2, #-12
;ADD R2, R2, #-12
;ADD R2, R2, #-12
;ADD R2, R2, #-12
ADD R2 R2 R4

;subtract the second value so we need to turn it to negative number
Not R2,R2       ;one's complement 
ADD R2, R2, #1  ;add one to change it to two's complement 
AND R3, R3, #0
ADD R3, R1, R2
BRn negative    ;check if R3 is negative

;ADD R3, R3, #12    ;convert it back to character and print it out
;ADD R3, R3, #12
;ADD R3, R3, #12
;ADD R3, R3, #12
ADD R3 R3 R4
ADD R0, R3, #0
OUT
LD R0, newline
OUT
ADD R0, R3, #0        
BRzp end           ;check if the R0 is zero or positive

negative            ;if branch negative is negative(R3 is negative)convert it to nonnegative value
NOT R3, R3          ;one's complement
ADD R3, R3, #1      ;add one to change it to two's complement 
;ADD R3, R3, #12     ;convert it back to character and print it out
;ADD R3, R3, #12
;ADD R3, R3, #12
;ADD R3, R3, #12
ADD R3 R3 R4
LD R0, subtract     ;print out the subtract symbol first then the nonnegative value
OUT
AND R0, R0, #0
ADD R0, R3, #0
OUT
LD R0, newline
OUT



;if branch is zero or positive end the stop execution
end HALT				; Stop execution of program
;------	
;Data
;------
; String to prompt user. Note: already includes terminating newline!
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
newline .FILL x0A	; newline character - use with LD followed by OUT
subtract   .STRINGZ "-"
equal  .STRINGZ "="
space   .STRINGZ " "
DEC_48 .FILL #48
;---------------	
;END of PROGRAM
;---------------	
.END

