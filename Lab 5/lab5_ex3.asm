;=================================================
; Name: Tristan Zhao
; Email: ezhao012@ucr.edu
; 
; Lab: lab 5, ex 3
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

LD R3 SUB_TO_UPPER_3800
LEA R1 ARRAY
JSRR R3

LD R3 SUB_IS_PALINDROME_3400
LEA R1 ARRAY
JSRR R3

LEA R0 STRING
PUTS
LD R3 PRINT_STRING_3600
LEA R1 ARRAY
JSRR R3

ADD R0 R4 #0
BRZ NO
BRP YES

NO
    LEA R0 ISNOT
    PUTS
    BR END
YES
    LEA R0 IS
    PUTS
    BR END
    
END
HALT

; your local data goes here
top_stack_addr .FILL xFE00 ; DO NOT MODIFY THIS LINE OF CODE
SUB_GET_STRING_3200  .FILL x3200
SUB_IS_PALINDROME_3400 .FILL x3400
PRINT_STRING_3600 .FILL x3600
SUB_TO_UPPER_3800 .FILL x3800
NEWLINE .FILL x0A
ARRAY .BLKW #100
PROMPT .STRINGZ "Enter a string of text, use 'ENTER' to end"
STRING .STRINGZ "The string \""
IS .STRINGZ "\" IS a palindrome"
ISNOT .STRINGZ "\" IS NOT a palindrome"
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
;-------------------------------------------------------------------------
; Subroutine: SUB_IS_PALINDROME
; Parameter (R1): The starting address of a null-terminated string
; Parameter (R5): The number of characters in the array.
; Postcondition: The subroutine has determined whether the string at (R1)
;		 is a palindrome or not, and returned a flag to that effect.
; Return Value: R4 {1 if the string is a palindrome, 0 otherwise}
;-------------------------------------------------------------------------
.ORIG x3400

ADD R6 R6 #-1   ;back up (because I will change the value)
STR R7 R6 #0    ;always back up r7 because it store the return address

ADD R6 R6 #-1
STR R1 R6 #0

ADD R6 R6 #-1
STR R5 R6 #0

ADD R6 R6 #-1
STR R3 R6 #0


ADD R2 R5 R1    ;ADDRESS OF THE LAST ELEMENTS
ADD R2 R2 #-1   ;ARRAY[N-1]

AND R3 R3 #0
AND R4 R4 #0

CHECK
    LDR R7 R1 #0    ;load arr[0] into r7
    LDR R5 R2 #0    ;load arr[n-1] into r5

    NOT R3 R1   
    ADD R3 R3 #1    ;negative number of r1 address
    
    NOT R7 R7
    ADD R7 R7 #1    ;negative number of r1's value
        
    ADD R1 R1 #1    ;move to next memory address
    ADD R2 R2 #-1
    
    ADD R0 R7 R5    ;check if the negative of array value add the last array value is np, 
                    ;which means it did not match, so go to stop to jump out of the loop
    BRNP STOP       
   
    ADD R0 R3 R2    ;check when will the array end(add the negative of start array address with r2
                    ;since r1 will increase and r2 will decreament to the start array addres, then we know when should we stop)
    BRZP CHECK
    
END_CHECK

MATCH
    ADD R4 R4 #1
    BR STOP
    
STOP
    LDR R3 R6 #0    ;restore the value back(in case access violation)
    ADD R6 R6 #1
    
    LDR R5 R6 #0
    ADD R6 R6 #1
    
    LDR R1 R6 #0
    ADD R6 R6 #1

    LDR R7 R6 #0
    ADD R6 R6 #1
RET

.END
;-------------------------------------------------------------------------
; Subroutine: PRINT_STRING
; Parameter (R1): The starting address of a null-terminated string
;-------------------------------------------------------------------------
.ORIG x3600
ADD R6 R6 #-1   ;back up (because I will change the value)
STR R7 R6 #0

ADD R6 R6 #-1
STR R1 R6 #0

ADD R6 R6 #-1
STR R5 R6 #0
PRINT_STRING
    LDR R0 R1 #0
    OUT
    
    ADD R1, R1, #1
    ADD R5, R5, #-1
    BRP PRINT_STRING

LDR R5 R6 #0    ;restore the value back(in case access violation)
ADD R6 R6 #1

LDR R1 R6 #0
ADD R6 R6 #1

LDR R7 R6 #0
ADD R6 R6 #1
RET
.END
;-------------------------------------------------------------------------
; Subroutine: SUB_TO_UPPER
; Parameter (R1): Starting address of a null-terminated string
; Postcondition: The subroutine has converted the string to upper-case
;     in-place i.e. the upper-case string has replaced the original string
; No return value, no output, but R1 still contains the array address, unchanged
;-------------------------------------------------------------------------

.ORIG x3800
ADD R6 R6 #-1   ;back up (because I will change the value)
STR R7 R6 #0

ADD R6 R6 #-1
STR R1 R6 #0

ADD R6 R6 #-1
STR R5 R6 #0

LD R4 BITMASK
UPPER_CASE
    LDR R0 R1 #0
    AND R0 R0 R4    ;and it with the bismask, xDF is 1101 1111, it will change the variable to upper case
                    ;A: 0100 0001
                    ;a: 0110 0001 we can see only the third bit is different 
                    ;so and it with bismask we can get the upper case
    STR R0 R1 #0    ;store the value back to the array
    
    ADD R1, R1, #1  ;move
    ADD R5, R5, #-1
    BRP UPPER_CASE

LDR R5 R6 #0    ;restore the value back(in case access violation)
ADD R6 R6 #1

LDR R1 R6 #0
ADD R6 R6 #1

LDR R7 R6 #0
ADD R6 R6 #1
RET
BITMASK .FILL XDF
.END
