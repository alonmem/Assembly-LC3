.orig x3000

JSR SimpleMathQuiz


HALT

firstString  .stringz "Enter the first number: \n"
secondString .stringz "Enter the second number: \n"
correct .stringz "Correct Answer :) \n"
wrong .stringz "Error - the correct answer is: "
done1 .stringz "You have answered "
done2 .stringz " correct answers out of 5 questions \n\n"

enter .stringz "\n"
asciiNormal .fill #-48
A .stringz "a. "
B .stringz "b. "
C .stringz "c. "
asciiB .fill #-98
asciiMul .fill #-42
asciiEXP .fill #-94
asciiDiv .fill #-47
asciiMinus .fill #-45
asciiPlus .fill #-43
ascii0 .fill #48

correctAdress .fill correct
wrongAdress .fill wrong


SimpleMathQuiz

;ADD R6, R6, #-<frame size>
ADD R6, R6, #-5 ;Make space for our local vars (R7, R1, R2, R3, R4)

STR R7, R6, #0 ; saving R7
STR R1, R6, #1 ; saving R1
STR R2, R6, #2 ; saving R2
STR R3, R6, #3 ; saving R3
STR R4, R6, #4 ; saving R4

AND R4,R4,#0 		; R4 will count the number of correct answers

LEA R0, firstString	; print Enter the first number: 
PUTS	

JSR GetNum 		; get the first num


ADD R1, R0, #0 		; R1 will hold the first num a

LEA R0, enter		; print \n
PUTS

LEA R0, secondString	; print Enter the second number: 
PUTS

JSR GetNum 		; get the second num

ADD R2, R0, #0 		; R2 will hold the second num b


; first question:

LEA R0, enter		; print \n
PUTS

LD R3,asciiMul		; load operator ascii value to R3
STR R3, R6, #-3		; add operator value to the stack
STR R1, R6, #-2 	; add a to the stack
STR R2, R6, #-1		; add b to the stack
ADD R6,R6,#-3	
JSR AskQeustion 	; call the AskQuestion function       		
ADD R6,R6,#3


ADD R0,R0,#-1		; check if R0=1 (correct answer)
BRnp incorrect1
ADD R4,R4,#1		; R4+=1 (add to correct answers counter)\
incorrect1



; second question:

LD R3,asciiEXP		; load operator ascii value to R3
STR R3, R6, #-3		; add operator value to the stack
STR R1, R6, #-2 	; add a to the stack
STR R2, R6, #-1		; add b to the stack
ADD R6,R6,#-3	
JSR AskQeustion 	; call the AskQuestion function       		
ADD R6,R6,#3

ADD R0,R0,#-1		; check if R0=1 (correct answer)
BRnp incorrect2
ADD R4,R4,#1		; R4+=1 (add to correct answers counter)\
incorrect2


; third question:

LD R3,asciiDiv		; load operator ascii value to R3
STR R3, R6, #-3		; add operator value to the stack
STR R1, R6, #-2 	; add a to the stack
STR R2, R6, #-1		; add b to the stack
ADD R6,R6,#-3	
JSR AskQeustion 	; call the AskQuestion function       		
ADD R6,R6,#3

ADD R0,R0,#-1		; check if R0=1 (correct answer)
BRnp incorrect3
ADD R4,R4,#1		; R4+=1 (add to correct answers counter)\
incorrect3


; forth question:


LD R3,asciiPlus		; load operator ascii value to R3
STR R3, R6, #-3		; add operator value to the stack
STR R1, R6, #-2 	; add a to the stack
STR R2, R6, #-1		; add b to the stack
ADD R6,R6,#-3	
JSR AskQeustion 	; call the AskQuestion function       		
ADD R6,R6,#3

ADD R0,R0,#-1		; check if R0=1 (correct answer)
BRnp incorrect4
ADD R4,R4,#1		; R4+=1 (add to correct answers counter)\
incorrect4


; fifth question:

LD R3,asciiMinus	; load operator ascii value to R3
STR R3, R6, #-3		; add operator value to the stack
STR R1, R6, #-2 	; add a to the stack
STR R2, R6, #-1		; add b to the stack
ADD R6,R6,#-3	
JSR AskQeustion 	; call the AskQuestion function       		
ADD R6,R6,#3

ADD R0,R0,#-1		; check if R0=1 (correct answer)
BRnp incorrect5
ADD R4,R4,#1		; R4+=1 (add to correct answers counter)
incorrect5


LEA R0, enter		; print \n
PUTS


LEA R0, done1	; print: You have answered  
PUTS

LD R2, ascii0	; R2 = 48
ADD R0,R4,R2	; print the number of correct answers (+48)
OUT

LEA R0, done2	; print: correct answers out of 5 questions
PUTS


;restoring back the original values for the registers
;LDR Rx, R6, #y

LDR R7, R6, #0 ; loading R7
LDR R1, R6, #1 ; loading R1
LDR R2, R6, #2 ; loading R2
LDR R3, R6, #3 ; loading R3
LDR R4, R6, #4 ; loading R4

;popping the stack frame
;ADD R6, R6, #<frame size>
ADD R6, R6, #5 ; restoring R6 pointer

RET




AskQeustion 	; this function will get 2 registers, an acsii value and will ask a question, returns 1 if the answer is correct

;ADD R6, R6, #-<frame size>
ADD R6, R6, #-6 ;Make space for our local vars (R7, R1, R2, R3, R4)

STR R7, R6, #0 ; saving R7
STR R1, R6, #1 ; saving R1
STR R2, R6, #2 ; saving R2
STR R3, R6, #3 ; saving R3
STR R4, R6, #4 ; saving R4
STR R5, R6, #5 ; saving R4


LDR R3,R6,#6 	; R3 = ascii to print
LDR R1,R6,#7 	; R1 = a
LDR R2,R6,#8 	; R2 = b

; Print a:

LEA R0, enter		; print \n
PUTS

STR R1,R6,#-1 
ADD R6,R6,#-1
JSR PrintNum
ADD R6,R6,#1


ADD R0,R3,#0
NOT R0,R0
ADD R0,R0,#1	
OUT			; print ascii of operator

; Print b:
STR R2,R6,#-1 
ADD R6,R6,#-1
JSR PrintNum		;print b
ADD R6,R6,#1


LEA R0, enter		; print \n
PUTS

ADD R0,R3,#0		; R0=R3 (ascii of operation)
NOT R0,R0		; R0 = -R0 (positive ascii value)
ADD R0,R0,#1

LD R4, asciiMul
ADD R4,R4,R0		; if operation is Mul
BRz JSRMul		; Do Mul

LD R4, asciiEXP
ADD R4,R4,R0		; if operation is Exp
BRz JSREXP		; do Exp

LD R4, asciiDiv
ADD R4,R4,R0		; if operation is Div
BRz JSRDiv		; do Div

LD R4, asciiPlus
ADD R4,R4,R0		; if operation is Plus
BRz JSRPlus		; do Plus

LD R4, asciiMinus
ADD R4,R4,R0		; if operation is Minus
BRz JSRMinus		; do Minus



JSRMul
STR R1, R6, #-2 
STR R2, R6, #-1
ADD R6,R6,#-2
JSR Mul        		; multiply R1*R2 (a*b)
ADD R6,R6,#2
BR DoneWithOP

JSREXP
STR R1, R6, #-2 
STR R2, R6, #-1
ADD R6,R6,#-2
JSR Exp        		; R1^R2 (a^b)
ADD R6,R6,#2
BR DoneWithOP

JSRDiv
STR R1, R6, #-2 
STR R2, R6, #-1
ADD R6,R6,#-2
JSR EfficientDivFunc	; R1/R2 (a/b)
LDR R0, R6,#0		; div value is in the place of first argument
ADD R6,R6,#2
BR DoneWithOP

JSRPlus
ADD R0,R1,R2		; R0 = R1+R2 (a+b)
BR DoneWithOP

JSRMinus
NOT R2,R2		; R2 = -R2
ADD R2,R2,#1
ADD R0,R1,R2		; R0 = R1-R2 (a-b)
NOT R2,R2		; R2 = -R2 (back to original value)
ADD R2,R2,#1
BR DoneWithOP


DoneWithOP


ADD R4,R0,#-1		; R4 = R0-1 (a(OP)b-1)

LEA R0,A		; print "a. "
PUTS

STR R4,R6,#-1 
ADD R6,R6,#-1
JSR PrintNum		; print R4 (a(OP)b-1)
ADD R6,R6,#1


ADD R4,R4,#1		; R4 = R4+1 (a(OP)b)

LEA R0, enter		; print \n
PUTS

LEA R0,B		; print "b. "
PUTS

STR R4,R6,#-1 
ADD R6,R6,#-1
JSR PrintNum		; print R4 (a(OP)b)
ADD R6,R6,#1


ADD R4,R4,#1		; R4 = R4+1 (a(OP)b+1)

LEA R0, enter		; print \n
PUTS

LEA R0,C		; print "c. "
PUTS

STR R4,R6,#-1 
ADD R6,R6,#-1
JSR PrintNum		; print R4 (a(OP)b+1)
ADD R6,R6,#1

LEA R0, enter		; print \n
PUTS

GETC			; get answer
OUT			; print answer

LD R5,asciiB		; R5 = asciiB
ADD R0,R0,R5
	
BRnp incorrent		; check if answer is incorrect

LEA R0, enter		; print \n
PUTS
								
LD R0,correctAdress	; print corrent answer
PUTS
AND R0,R0,#0
ADD R0,R0,#1		; R0 = 1 (return value)
BR doneQ

incorrent
LEA R0, enter		; print \n
PUTS

LD R0,wrongAdress	; print Error
PUTS

ADD R4,R4,#-1		; R4 = R4-1 (a(OP)b)

STR R4,R6,#-1 
ADD R6,R6,#-1
JSR PrintNum		; print R4 (a(OP)b)
ADD R6,R6,#1

LEA R0,enter
PUTS

AND R0,R0,#0		; R0 = 0 (return value)

doneQ


;restoring back the original values for the registers
;LDR Rx, R6, #y

LDR R7, R6, #0 ; loading R7
LDR R1, R6, #1 ; loading R1
LDR R2, R6, #2 ; loading R2
LDR R3, R6, #3 ; loading R3
LDR R4, R6, #4 ; loading R4
LDR R5, R6, #5 ; loading R4

;popping the stack frame
;ADD R6, R6, #<frame size>
ADD R6, R6, #6 ; restoring R6 pointer

RET




GetNum

;ADD R6, R6, #-<frame size>
ADD R6, R6, #-6 ;Make space for our local vars (R7, R1, R2, R3, R4,R5)

STR R7, R6, #0 ; saving R7
STR R1, R6, #1 ; saving R1
STR R2, R6, #2 ; saving R2
STR R3, R6, #3 ; saving R3
STR R4, R6, #4 ; saving R4
STR R5, R6, #5 ; saving R5

AND R1,R1,#0 		; reset r1 will
LD R3,asciiNormal 	; load -48 into r3 ascii value of 0
ADD R4, R1, #10 	; r4 = 10 (for mul)

LOOP

GETC	       		; gets a digit as input
ADD R2,R0,#-10 		; check if ro is equal 10
BRz ENDLOOP    		; if ascii value is 10 so the number was over
OUT	       		; print the input digit
ADD R5,R0,#0   		; r5 hold the ascii value of the input

; CALLER:
STR R1, R6, #-2 
STR R4, R6, #-1
ADD R6,R6,#-2

JSR Mul        		; multiply by 10
ADD R6,R6,#2

ADD R1,R0,#0
ADD R5,R5,R3   		; the real value of the digit
ADD R1,R1,R5   		; add the input digit to %10 field
 
BR LOOP


ENDLOOP

ADD R0,R1,#0

;restoring back the original values for the registers
;LDR Rx, R6, #y

LDR R7, R6, #0 ; loading R7
LDR R1, R6, #1 ; loading R1
LDR R2, R6, #2 ; loading R2
LDR R3, R6, #3 ; loading R3
LDR R4, R6, #4 ; loading R4
LDR R5, R6, #5 ; loading R4

;popping the stack frame
;ADD R6, R6, #<frame size>
ADD R6, R6, #6 ; restoring R6 pointer

RET




Mul

;ADD R6, R6, #-<frame size>
ADD R6, R6, #-6 ;Make space for our local vars (R7, R1, R2, R3, R4,)

STR R1, R6, #0 ; saving R1
STR R2, R6, #1 ; saving R2
STR R7, R6, #2 ; saving R7
STR R3, R6, #3 ; saving R3
STR R4, R6, #4 ; saving R4
STR R5, R6, #5 ; saving R5


LDR R0,R6,#6 ; first argument into R0
LDR R1,R6,#7 ; second argument into R1


AND R2,R2,#0 	; reset r2

ADD R0,R0,#0 	; check if first num equal 0
BRz ENDMUL	; if R0 = 0, we return 0

ADD R1,R1,#0 	; check if second num equal 0
BRz ENDMUL	; if R1 = 0, we return 0

ADD R0,R0,#0 	; add to change cc
BRp AFTERNEG1	; if first num positive, we can proceed

ADD R2,R2,#-1   ; if negative return -1 in sum
BR ENDMUL 
AFTERNEG1

ADD R1,R1,#0 	; add to change cc
BRp AFTERNEG2	; if second num positive, we can proceed

ADD R2,R2,#-1   ; if negative return -1 in sum
BR ENDMUL 
AFTERNEG2

ADD R2,R2,#1
AND R4,R4,#0    ; reset r4, will be index i of the for loop

FORLOOP

ADD R5,R4,#-16  ; for condition i<16
BRz ENDMUL      ; if i=16 exit the loop

ADD R2,R2,R2    ; c = c + c

ADD R0,R0,#0    ; add to change cc
BRzp AFTERCHECK ; if a >= 0 don't get into the if condition
ADD R2,R2,R1    ; if a < 0: c = c + b

AFTERCHECK

ADD R0,R0,R0    ; a = a + a
ADD R4,R4,#1    ; i++

BR FORLOOP

ENDMUL

ADD R0,R2,#0 		; R0 = return value (was in R2)

;restoring back the original values for the registers
;LDR Rx, R6, #y

LDR R1, R6, #0 ; loading R1
LDR R2, R6, #1 ; loading R2
LDR R7, R6, #2 ; loading R7
LDR R3, R6, #3 ; loading R3
LDR R4, R6, #4 ; loading R4
LDR R5, R6, #5 ; loading R5

;popping the stack frame
;ADD R6, R6, #<frame size>
ADD R6, R6, #6 ; restoring R6 pointer

RET




Exp

;ADD R6, R6, #-<frame size>
ADD R6, R6, #-6 ;Make space for our local vars (R7, R1, R2, R3, R4,)

STR R1, R6, #0 ; saving R1
STR R2, R6, #1 ; saving R2
STR R7, R6, #2 ; saving R7
STR R4, R6, #3 ; saving R4
STR R5, R6, #4 ; saving R5
STR R3, R6, #5 ; saving R3


LDR R0,R6,#6 ; first argument into R0
LDR R1,R6,#7 ; second argument into R1


AND R2,R2,#0 	; reset r2

ADD R0,R0,#0 	; check if first num equal 0
BRz ENDEXP	; if R0 = 0, we return 0

ADD R0,R0,#0 	; add to change cc
BRp AFTERNG1	; if first num positive, we can proceed

ADD R2,R2,#-1   ; if negative return -1 in sum
BR ENDEXP
AFTERNG1

ADD R1,R1,#0 	; add to change cc
BRzp AFTERNG2	; if second num positive or zero, we can proceed

ADD R2,R2,#-1   ; if negative return -1 in sum
BR ENDEXP
AFTERNG2

ADD R1,R1,#0 	; check if second num equal 0
BRp AFTERZERO	

ADD R2,R2,#1    ; if we get here it means r0 is positive, so if positive^0 we return 1
BR ENDEXP
AFTERZERO 

ADD R4,R0,#0    ; move data of r0 to r4 in order to use efficient mul with r0 and don't lose data
ADD R5,R1,#0	; move data of r1 to r5 in order to use efficient mul with r1 and don't lose data

ADD R2,R0,#0    ; reset the result to r0^1

ADD R5,R5,#-1   ; add to change cc
WHILELOOP

BRz ENDEXP	; if R5 that holds the number of times we need to mul by itself is 0 we return the result

ADD R0,R2,#0    ; R0 = current result
ADD R1,R4,#0    ; R1 = the number we multiply by itself r5 times


ADD R3,R0,#0	; R3 = R0 (remember R0)


STR R3, R6, #-2 
STR R1, R6, #-1
ADD R6,R6,#-2
JSR Mul		; R0 = R0*R1 (R3*R1)  		
ADD R6,R6,#2 	
ADD R2,R0,#0	; R2 = R0 (R3*R1)
ADD R0,R3,#0	; R0 = R3 (original R0)

ADD R5,R5,#-1	; r5--
BR WHILELOOP

ENDEXP
ADD R1,R1,#0	; check if 0^0
BRnp FINISHSHH
AND R2,R2,#0
ADD R2,R2,#1

FINISHSHH

ADD R0,R2,#0	; R0 = R2 (return value)

;restoring back the original values for the registers
;LDR Rx, R6, #y

LDR R1, R6, #0 ; loading R1
LDR R2, R6, #1 ; loading R2
LDR R7, R6, #2 ; loading R7
LDR R4, R6, #3 ; loading R4
LDR R5, R6, #4 ; loading R5

;popping the stack frame
;ADD R6, R6, #<frame size>
ADD R6, R6, #6 ; restoring R6 pointer

RET




ASCIIva .fill #48
MinusAscii .fill #45
Array .blkw #5,#0

PrintNum

;ADD R6, R6, #-<frame size>
ADD R6, R6, #-6 ;Make space for our local vars (R7, R1, R2, R3, R4,)

STR R1, R6, #0 	; saving R1
STR R2, R6, #1 	; saving R2
STR R7, R6, #2 	; saving R7
STR R3, R6, #3 	; saving R3
STR R4, R6, #4 	; saving R4
STR R5, R6, #5 	; saving R5

LDR R5,R6,#6	; load the num we want to print

ADD R5,R5,#0	
BRz Zero	; if num == 0

LEA R3, Array	; R3 = Array

AND R4,R4,#0
ADD R1,R5,#0	; div = num
ADD R2,R5,#0	; mod = num


ADD R5,R5,#0
BRp LOOPW	; if num>0

NOT R5,R5	; R5 = -R5 (num = -num)
ADD R5,R5,#1
LD R0, MinusAscii 
OUT		; print "-" (minus)


LOOPW
BRz ENDREV

AND R7,R7,#0
ADD R7,R7,#10
STR R5, R6, #-2 
STR R7, R6, #-1
ADD R6,R6,#-2
JSR EfficientDivFunc	; R5/R4 (num/10)

LDR R1, R6,#0		; div value is in the place of first argument
LDR R2, R6,#1		; mod value is in the place of second argument

ADD R6,R6,#2		

STR R2,R3,#0		; Array[current] = mod
ADD R3,R3,#1		; *Array++
ADD R4,R4,#1		; R4++

ADD R5,R1,#0		; num = div

BR LOOPW


ENDREV
ADD R3,R3,#-1		; *Array--
ADD R4,R4,#-1		; R7--


LOOPW2
BRn DONEPRINT

LDR R2,R3,#0

LD R0, ASCIIva		; load 48 into R0
ADD R0,R0,R2		; R0 hold the ascii value of the digit in mod
OUT			; print the value in mod

ADD R3,R3,#-1
ADD R4,R4,#-1

BR LOOPW2


Zero
LD R0, ASCIIva	; R0 = 48
OUT		; print 0


DONEPRINT


LDR R1, R6, #0 	; saving R1
LDR R2, R6, #1 	; saving R2
LDR R7, R6, #2 	; saving R7
LDR R3, R6, #3 	; saving R3
LDR R4, R6, #4 	; saving R4
LDR R5, R6, #5 	; saving R5

ADD R6, R6, #6 ;Make space for our local vars (R7, R1, R2, R3, R4,)


RET


EfficientDivFunc

;ADD R6, R6, #-<frame size>
ADD R6, R6, #-6 ;Make space for our local vars (R7, R1, R2, R3, R4,)

STR R1, R6, #0 	; saving R1
STR R2, R6, #1 	; saving R2
STR R7, R6, #2 	; saving R7
STR R3, R6, #3 	; saving R3
STR R4, R6, #4 	; saving R4
STR R5, R6, #5 	; saving R5

LDR R0,R6,#6	; first argument into R0 - m
LDR R1,R6,#7 	; second argument into R1 - n

ADD R7,R1,#0	; store value of n

AND R2,R2,#0    ; reset r2, will hold div
AND R3,R3,#0	; reser r3, will hold res

ADD R0,R0,#0 	; check if first num is negative 
BRzp AFTERCHECK1; if R0 >= 0, proceed

ADD R2,R2,#-1 	; return div = -1
ADD R3,R3,#-1	; return res = -1
BR ENDDIV

AFTERCHECK1
ADD R1,R1,#0 	; check if second num is <=0
BRp AFTERCHECK2	; if R1 > 0, proceed

ADD R2,R2,#-1 	; return div = -1
ADD R3,R3,#-1	; return res = -1
BR ENDDIV

AFTERCHECK2 	; now we have two positive nums
		; div = 0
ADD R3,R0,#0	; res = m

WHILE

ADD R4,R7,#0 	; r4 = n
NOT R4,R4
ADD R4,R4,#1	; r4 = -n
ADD R4,R4,R3	; r4 = res-n

BRn ENDDIV	; if res < n end while

AND R0,R0,#0
ADD R0,R0,#1	; t1 = 1

ADD R1,R7,#0	; t2 = n

ADD R5,R7,#0	; t3 = n
ADD R5,R5,R5	; t3 = t3+t3 = n << 1

WHILECHECK

ADD R4,R3,#0 	; r4 = res
NOT R4,R4
ADD R4,R4,#1	; r4 = -res
ADD R4,R4,R5	; r4 = t3 - res

BRzp AFTERWHILE ; if t3 >= res end while

ADD R0,R0,R0	; t1 <<= 1
ADD R1,R1,R1	; t2 <<= 1
ADD R5,R5,R5	; t3 <<= 1

BR WHILECHECK

AFTERWHILE

ADD R2,R2,R0	; div += t1

ADD R4,R1,#0	; r4 = t2
NOT R4,R4
ADD R4,R4,#1	; r4 = - t2
ADD R4,R4,R3	; r4 = res - t2
ADD R3,R4,#0	; res = res - t2 , res-=t2

BR WHILE

ENDDIV

STR R2,R6,#6	; save div in the place of first argument
STR R3,R6,#7 	; save res in the place of second argument

LDR R1, R6, #0 	; saving R1
LDR R2, R6, #1 	; saving R2
LDR R7, R6, #2 	; saving R7
LDR R3, R6, #3 	; saving R3
LDR R4, R6, #4 	; saving R4
LDR R5, R6, #5 	; saving R5

ADD R6, R6, #6 ;Make space for our local vars (R7, R1, R2, R3, R4,)

RET

.end