;=================================================
; Name: Tristan Zhao
; Email: ezhao012@ucr.edu
; 
; Lab: lab 5, ex 1
; Lab section: 024
; TA: 
; 
;=================================================
.orig x3000
; Initialize the stack. Don't worry about what that means for now.
ld r6, top_stack_addr ; DO NOT MODIFY, AND DON'T USE R6, OTHER THAN FOR BACKUP/RESTORE

; your code goes here
LD R3 SUB_GET_STRING_3200
LEA R0 PROMPT
PUTS

LD R0 NEWLINE
OUT

LEA R1 ARRAY
JSRR R3

HALT

; your local data goes here

top_stack_addr .FILL xFE00 ; DO NOT MODIFY THIS LINE OF CODE
SUB_GET_STRING_3200  .FILL x3200
PROMPT .STRINGZ "Enter a string of text, use 'ENTER' to end"
NEWLINE .FILL x0A
ARRAY .BLKW #100
.END

; your subroutines go below here
;------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameter (R1): The starting address of the character array
; Postcondition: The subroutine has prompted the user to input a string,
;	terminated by the [ENTER] key (the "sentinel"), and has stored 
;	the received characters in an array of characters starting at (R1).
;	the array is NULL-terminated; the sentinel character is NOT stored.
; Return Value (R5): The number of non-sentinel chars read from the user.
;	R1 contains the starting address of the array unchanged.
;-------------------------------------------------------------------------

.ORIG x3200
ADD R6 R6 #-1   ;back up (because I will change the value)
STR R7 R6 #0

ADD R6 R6 #-1
STR R1 R6 #0

AND R5 R5 #0
LOOP
    GETC
    OUT
    
    ADD R7 R0 #-10  ;IF IT MATCH TO ENTER KEY QUIT
    BRz QUIT
    
    STR R0 R1 #0    ;store the user input into the array address
    ADD R1 R1 #1    ;move to next array address
    ADD R5 R5 #1    ;counter
    BR LOOP

QUIT

LDR R1 R6 #0    ;restore the value back(in case access violation)
ADD R6 R6 #1

LDR R7 R6 #0
ADD R6 R6 #1

RET
.END