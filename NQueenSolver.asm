.orig x3000


JSR NQueenSolver


HALT

enterN .stringz "please enter N\n"
this .stringz "this is the solution:\n"
enter .stringz "\n"
array .blkw #36 #-1

NQueenSolver

;ADD R6, R6, #-<frame size>
ADD R6, R6, #-5 ;Make space for our local vars (R7, R1, R2, R3, R4)

STR R7, R6, #0 ; saving R7
STR R1, R6, #1 ; saving R1
STR R2, R6, #2 ; saving R2
STR R3, R6, #3 ; saving R3
STR R4, R6, #4 ; saving R4



LEA R0, enterN	; print please enter N
PUTS
	
JSR GetNum 	; get N
ADD R1, R0, #0 	; R1 will hold N

LEA R0, enter	; print \n
PUTS

LEA R0, this	; print this is the solution
PUTS

LEA R0,array
AND R4,R4,#0

STR R1,R6,#-1	; N
STR R0,R6,#-2	; array
STR R4,R6,#-3	; y=0
ADD R6,R6,#-3	
JSR QueenHelp	; call the QueenHelp function       		
ADD R6,R6,#3


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



ArrayToPrint .fill bigArray 
FINISHED .fill #0
QueenHelp
;ADD R6, R6, #-<frame size>
ADD R6, R6, #-6 ;Make space for our local vars (R7, R1, R2, R3, R4)

STR R7, R6, #0 	; saving R7
STR R1, R6, #1 	; saving R1
STR R2, R6, #2 	; saving R2
STR R3, R6, #3 	; saving R3
STR R4, R6, #4 	; saving R4
STR R5, R6, #5 	; saving R5

LD R2, FINISHED
BRz STARTREC

;restoring back the original values for the registers
;LDR Rx, R6, #y

LDR R7, R6, #0 ; loading R7
LDR R1, R6, #1 ; loading R1
LDR R2, R6, #2 ; loading R2
LDR R3, R6, #3 ; loading R3
LDR R4, R6, #4 ; loading R4
LDR R5, R6, #5 ; loading R5

;popping the stack frame
;ADD R6, R6, #<frame size>
ADD R6, R6, #6 ; restoring R6 pointer

RET



STARTREC

LDR R1,R6,#6	; R1 = y
LDR R2,R6,#7	; R2 = array
LDR R3,R6,#8	; R3 = N


AND R4,R4,#0	; R4 = 0 = x


loopQueen

NOT R4,R4	; 2's compliment
ADD R4,R4,#1

ADD R5,R3,R4	; R5 = N-x	
BRz endLoopQueen ; if R5 == 0

NOT R4,R4	; 2's compliment
ADD R4,R4,#1


STR R2,R6,#-1	; array
STR R4,R6,#-2	; x
STR R1,R6,#-3	; y
ADD R6,R6,#-3	
JSR isSafe	; call isSafe       		
ADD R6,R6,#3

ADD R0,R0,#0	; for cc
BRz endIF 

ADD R5,R2,R1	; R5 = array+y (adress)
STR R4,R5,#0	; Array[y] = x				


ADD R5,R3,#0	; R5 = N
NOT R5,R5	; 2's compliment
ADD R5,R5,#1
ADD R5,R5,R1	; R5 = y-N
ADD R5,R5,#1	; R5 = y-N+1
BRnp else

STR R2,R6,#-1	; array
STR R3,R6,#-2	; N
ADD R6,R6,#-2	
JSR helpPrintNum ; call the helpPrintNum function		
ADD R6,R6,#2

LD R2,ArrayToPrint
STR R3,R6,#-1	; rows
STR R2,R6,#-3	; ArrayToPrint
STR R3,R6,#-2	; cols
ADD R6,R6,#-3	
JSR PrintBoard 	; call the PrintBoard function       		
ADD R6,R6,#3

AND R2,R2,#0	; if i get to here i found a solution and give indicate
ADD R2,R2,#1
ST R2,FINISHED

;restoring back the original values for the registers
;LDR Rx, R6, #y

LDR R7, R6, #0 ; loading R7
LDR R1, R6, #1 ; loading R1
LDR R2, R6, #2 ; loading R2
LDR R3, R6, #3 ; loading R3
LDR R4, R6, #4 ; loading R4
LDR R5, R6, #5 ; loading R5

;popping the stack frame
;ADD R6, R6, #<frame size>
ADD R6, R6, #6 ; restoring R6 pointer

RET

else
ADD R1,R1,#1
STR R3,R6,#-1	; N
STR R2,R6,#-2	; array
STR R1,R6,#-3	; y+1
ADD R6,R6,#-3	
JSR QueenHelp	; call the QueenHelp function       		
ADD R6,R6,#3
ADD R1,R1,#-1

endIF 

ADD R4,R4,#1
BR loopQueen

endLoopQueen


;restoring back the original values for the registers
;LDR Rx, R6, #y

LDR R7, R6, #0 ; loading R7
LDR R1, R6, #1 ; loading R1
LDR R2, R6, #2 ; loading R2
LDR R3, R6, #3 ; loading R3
LDR R4, R6, #4 ; loading R4
LDR R5, R6, #5 ; loading R5

;popping the stack frame
;ADD R6, R6, #<frame size>
ADD R6, R6, #6 ; restoring R6 pointer

RET




isSafe
;ADD R6, R6, #-<frame size>
ADD R6, R6, #-6 ;Make space for our local vars (R7, R1, R2, R3, R4)

STR R7, R6, #0 	; saving R7
STR R1, R6, #1 	; saving R1
STR R2, R6, #2 	; saving R2
STR R3, R6, #3 	; saving R3
STR R4, R6, #4 	; saving R4
STR R5, R6, #5 	; saving R5


LDR R1,R6,#8	; R1 = array
LDR R2,R6,#7	; R2 = x
LDR R3,R6,#6	; R3 = y


BRz True	; if y == 0

AND R4,R4,#0	; i=0


loopSafe

NOT R4,R4	; i=-i
ADD R4,R4,#1
ADD R5,R4,R3	; R5 = y-i

BRz True

NOT R4,R4	; i=-i
ADD R4,R4,#1

ADD R5,R1,R4	; R5  = array + i
LDR R7,R5,#0	; R7 = array[i]
NOT R2,R2	; x = -x
ADD R2,R2,#1
ADD R7,R7,R2	; R7 = array[i] - x
BRz False 


NOT R3,R3	; y = -y
ADD R3,R3,#1	; x is already -x
LDR R7,R5,#0	; R7 = array[i]
ADD R7,R7,R4	; array[i] += i
ADD R7,R7,R2	; array[i] -= x
ADD R7,R7,R3	; array[i] -= y
; array[i] - x - y + i
BRz False


LDR R7,R5,#0	; R7 = array[i]
NOT R3,R3	; -y = y
ADD R3,R3,#1
NOT R4,R4	; i = -i
ADD R4,R4,#1
ADD R7,R7,R4	; array[i] -= i
ADD R7,R7,R2	; array[i] -= x
ADD R7,R7,R3	; array[i] += y
; array[i] - x + y - i
BRz False

NOT R4,R4	; -i = i
ADD R4,R4,#1

NOT R2,R2	; -x = x
ADD R2,R2,#1

ADD R4,R4,#1
BR loopSafe


True		; R0 = 1
AND R0,R0,#0
ADD R0,R0,#1
BR doneSafe

False		; R0 = 0
AND R0,R0,#0


doneSafe

LDR R7, R6, #0 ; loading R7
LDR R1, R6, #1 ; loading R1
LDR R2, R6, #2 ; loading R2
LDR R3, R6, #3 ; loading R3
LDR R4, R6, #4 ; loading R4
LDR R5, R6, #5 ; loading R5

;popping the stack frame
;ADD R6, R6, #<frame size>
ADD R6, R6, #6 ; restoring R6 pointer

RET




asciiX .fill #120

PrintBoard

ADD R6, R6, #-6 ;Make space for our local vars (R7, R1, R2, R3, R4, R5)

STR R1, R6, #0 	; saving R1
STR R2, R6, #1 	; saving R2
STR R7, R6, #2 	; saving R7
STR R3, R6, #3 	; saving R3
STR R4, R6, #4 	; saving R4
STR R5, R6, #5 	; saving R5

LDR R3,R6,#6	; R3 = array
LDR R1,R6,#7 	; R1 = cols
LDR R2,R6,#8 	; R2 = rows

ADD R5,R1,#0	; save number of cols

loopRow		; loop on number of rows
BRz endRow	; if row=0 (finished)
ADD R1,R5,#0	; save R5 value

loopCol		; loop on number of cols
BRz endCol	; if col=0 (finished)

LDR R4,R3,#0	; get number from array

ADD R4,R4,#1	; check if num to print is -1
BRnp notX

LD R0,asciiX	; print x
OUT
BR afterPrintX

notX		; num not -1

ADD R4,R4,#-1
STR R4,R6,#-1	; store R4 in the new stack 
ADD R6,R6,#-1
JSR PrintNum	; call PrintNum
ADD R6,R6,#1

afterPrintX	; printed x, skipped PrintNum

ADD R3,R3,#1	; add array offset

ADD R1,R1,#-1
BR loopCol

endCol

; print "\n"
AND R0,R0,#0
ADD R0,R0,#10
OUT

ADD R2,R2,#-1
BR loopRow

endRow



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


ASCIIva .fill #48
MinusAscii .fill #45
Array .blkw #5,#0
asciiNormal .fill #-48


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




helpPrintNum

;ADD R6, R6, #-<frame size>
ADD R6, R6, #-6 ;Make space for our local vars (R7, R1, R2, R3, R4)

STR R1, R6, #0 	; saving R1
STR R2, R6, #1 	; saving R2
STR R7, R6, #2 	; saving R7
STR R3, R6, #3 	; saving R3
STR R4, R6, #4 	; saving R4
STR R5, R6, #5 	; saving R5


LDR R1,R6,#6	; R1 = N
LDR R2,R6,#7	; R2 = array
LEA R5,bigArray	; R5 = newArray

AND R3,R3,#0	; i=0
AND R4,R4,#0	; j=0
AND R7,R7,#0 	; cur = 0

loopI
ADD R0,R1,#0	; R0 = N
NOT R0,R0	; R0 =-N
ADD R0,R0,#1
ADD R0,R3,R0	; i-N == 0 (?)
BRz doneI

loopJ
ADD R0,R1,#0	; R0 = N
NOT R0,R0	; R0 =-N
ADD R0,R0,#1

ADD R0,R4,R0	; j-N == 0 (?)
BRz doneJ

ADD R0,R4,R2	; R0 = array+j (adress)
LDR R0,R0,#0	; R0 = array[j] (value)

NOT R3,R3	; i = -i
ADD R3,R3,#1
ADD R0,R0,R3	; R0 = array[j]-i
BRnp elseX

NOT R3,R3	; i is now positive
ADD R3,R3,#1
ADD R0,R3,#1
STR R0,R5,#0	; newArray[cur] = i+1

ADD R5,R5,#1	; newArray++
ADD R4,R4,#1	; j++
BR loopJ

elseX
NOT R3,R3	; i is now positive
ADD R3,R3,#1

LD R0,asciiMinus1	; R0 = -1
STR R0,R5,#0	; newArray[cur] = -1

ADD R5,R5,#1	; newArray++
ADD R4,R4,#1	; j++
BR loopJ

doneJ

ADD R3,R3,#1	; i++
AND R4,R4,#0
BR loopI

doneI


LDR R1, R6, #0 	; saving R1
LDR R2, R6, #1 	; saving R2
LDR R7, R6, #2 	; saving R7
LDR R3, R6, #3 	; saving R3
LDR R4, R6, #4 	; saving R4
LDR R5, R6, #5 	; saving R5

ADD R6, R6, #6 ;Make space for our local vars (R7, R1, R2, R3, R4)

RET

asciiMinus1 .fill #-1
bigArray .blkw #1296 #0



.END