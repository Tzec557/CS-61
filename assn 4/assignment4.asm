;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Tristan Zhao
; Email: ezhao012@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 024
; TA: Karan Bhogal
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R4
;=================================================================================

.ORIG x3000		
;-------------
;Instructions
;-------------

; output intro prompt
START
    LD R0 introPromptPtr
    PUTS
    
;initalize value
    AND R0 R0 #0
    AND R3 R3 #0
    AND R4 R4 #0

; Set up flags, counters, accumulators as needed
    LD R1 COUNTER
    
; Get first character, test for '\n', '+', '-', digit/non-digit 	
    GETC 
    OUT
    
; is very first character = '\n'? if so, just quit (no message)!
    ADD R2 R0 #-10
    BRZ STOP

; is it = '+'? if so, ignore it, go get digits
    LD R2 POS
    ADD R2 R2 R0
    BRZ GET_NEXT

; is it = '-'? if so, set neg flag, go get digits
    LD R2 NEG
    ADD R2 R2 R0
    BRZ SET_NEG
    
    BR CHECK

GET_NEXT
    GETC
    OUT
    
CHECK 
    ADD R2 R0 #-10
    BRZ STOP
    
; is it < '0'? if so, it is not a digit	- o/p error message, start over
    LD R2 ZERO
    ADD R2 R2 R0
    BRN ERROR
; is it > '9'? if so, it is not a digit	- o/p error message, start over
    LD R2 NINE
    ADD R2 R2 R0
    BRP ERROR				
; if none of the above, first character is first numeric digit - convert it to number & store in target register!
    LD R2 ZERO
    ;true numeric value
    ADD R0 R0 R2 

;for add them up we need to times 10 first then add the current number
    AND R2 R2 #0
    LD R6 TEN

    MULT
    ADD R2 R2 R4
    ADD R6 R6 #-1
    BRP MULT
    ;add the current number to R4
    ADD R4 R2 R0
    
; Now get remaining digits from user in a loop (max 5), testing each to see if it is a digit, and build up number in accumulator    
    ADD R1 R1 #-1
    BRZ STOP
    BRP GET_NEXT
    
ERROR
    LD R0 NEWLINE
    OUT
    LD R0 errorMessagePtr
    PUTS
    BR START
    
SET_NEG
    ADD R3 R3 #-1
    BR GET_NEXT   
; remember to end with a newline!
STOP
AND R0 R0 #0
ADD R0 R3 #0
BRN NEG_SIGN
BRZP QUIT

NEG_SIGN
    NOT R4 R4
    ADD R4 R4 #1
    
QUIT
LD R0 NEWLINE
HALT

;---------------	
; Program Data
;---------------

introPromptPtr  .FILL xB000
errorMessagePtr .FILL xB200
COUNTER .FILL #5
NEWLINE .FILL #10
POS .FILL x-2B
NEG .FILL x-2D
ZERO .FILL x-30
NINE .FILL x-39
TEN .FILL #10
.END

;------------
; Remote data
;------------
.ORIG xB000	 ; intro prompt
.STRINGZ	 "Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"

.END					
					
.ORIG xB200	 ; error message
.STRINGZ	 "ERROR: invalid input\n"

;---------------
; END of PROGRAM
;---------------
.END

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.
