.include "nios_macros.s"
.include "vga.s"
.include "solver.s"
.include "audio.s"
.include "lcd.s"

.data                  # "data" section for input and output lists
.align 4

#Game Array is the memory location for all the variables
gameArray: 
.word 2
.word 0
.word 0
.word 0

.word 0
.word 0
.word 0
.word 0

.word 0
.word 0
.word 0
.word 0

.word 1024
.word 0
.word 0
.word 0

points:
.word 0

lastmove: 
.word 0  

received:
.word 0

timerLimit: 
.word 0xffff

winOrNot: 
.word 0 

movementType:
.word 0

loss:
.word 0

sentenceMoveDown: 
.asciz "Last Move: Down "

sentenceMoveUp: 
.asciz "Last Move: Up   "

sentenceMoveLeft: 
.asciz "Last Move: Left "

sentenceMoveRight: 
.asciz "Last Move: Right"

sentenceYouWin:
.asciz "Congratulations!"

sentenceYouLose:
.asciz "Next Time Maybe!"


winPic:
.incbin "win.bin"

losePic: 
.incbin "lose.bin"


.equ JTAG, 0x10001000
.equ TIMER,0x10002000
.equ UART,0x10001020
.equ PERIOD_1S,0x11E1A300
.equ UART_TERMINAL,0x10001000
.equ PERIOD,0x7A120	#period of 0.10s
.equ ADDR_REDLEDS, 0x10000000
.equ ADDR_GREENLEDS, 0x10000010
#-----------------------------------------
#-----------------------------------------
#-----------------------------------------


.section .exceptions, "ax"

IHANDLER:
subi sp,sp,88
stw r2,0(sp)
stw r3,4(sp)
stw r4,8(sp)
stw r5,12(sp)
stw r6,16(sp)
stw r7,20(sp)
stw r8,24(sp)
stw r9,28(sp)
stw r10,32(sp)
stw r11,36(sp)
stw r12,40(sp)
stw r13,44(sp)
stw r14,48(sp)
stw r15,52(sp)
stw r16,56(sp)
stw r17,60(sp)
stw r18,64(sp)
stw r19,68(sp)
stw r20,72(sp)
stw r21,76(sp)
stw r22,80(sp)
stw r23,84(sp)


rdctl et,ctl4
movi r8, 0x01
beq et, r8, timer
movi r8, 0x0100
beq et, r8, uartInt
br exitHandler

uartInt:
movia et,UART_TERMINAL
ldwio r8,0(et)
andi r8,r8,0xFF
movia r10, received
stw r8,0(r10)
br exitHandler

timer: 
  movia r2,ADDR_REDLEDS
  movia r8, timerLimit
  ldw r8, 0(r8)
  beq r8, r0, interruptLoss
  stwio r8,0(r2)
  srli r8, r8, 1 
  movia r9, timerLimit
  stw r8, 0(r9)
  
movia r8,TIMER
movui r9,%lo(PERIOD_1S)
stwio r9,8(r8)
movui r9,%hi(PERIOD_1S)
stwio r9,12(r8)
stwio r0,0(r8)
movi r9,0b111
stwio r9,4(r8)
br exitHandler


interruptLoss:

movia r8,TIMER
movui r9,%lo(PERIOD_1S)
stwio r9,8(r8)
movui r9,%hi(PERIOD_1S)
stwio r9,12(r8)
stwio r0,0(r8)
movi r9,0b111
stwio r9,4(r8)

movia r5, winOrNot
movi r6, -1 
stw r6, 0(r5) 
br exitHandler


exitHandler:
ldw r2,0(sp)
ldw r3,4(sp)
ldw r4,8(sp)
ldw r5,12(sp)
ldw r6,16(sp)
ldw r7,20(sp)
ldw r8,24(sp)
ldw r9,28(sp)
ldw r10,32(sp)
ldw r11,36(sp)
ldw r12,40(sp)
ldw r13,44(sp)
ldw r14,48(sp)
ldw r15,52(sp)
ldw r16,56(sp)
ldw r17,60(sp)
ldw r18,64(sp)
ldw r19,68(sp)
ldw r20,72(sp)
ldw r21,76(sp)
ldw r22,80(sp)
ldw r23,84(sp)
addi sp, sp, 88
subi ea,ea,4
eret
#-----------------------------------------
#-----------------------------------------
#-----------------------------------------
.text                  # "text" section for (read-only) code

.global assemblyMain
.global down
.global up
.global mover
.global firstScreen
.global vgarefresher
.global movementSound
.global lcdwrite
.global makeThepic
.global playSong

assemblyMain: 

SETTING_TIMER:
movia r8,TIMER
movui r9,%lo(PERIOD_1S)
stwio r9,8(r8)
movui r9,%hi(PERIOD_1S)
stwio r9,12(r8)
stwio r0,0(r8)
movi r9,0b111
stwio r9,4(r8)

#initialization of the stack pointer 
movia sp, 0x2000

#testing call to VGAFUNCTION
call firstScreen
movia r4, gameArray
call vgarefresher

initializationOfValues: 
movia r8, gameArray
#Poll for the values here

initializationOfInterrupts: 
SETTING_UART:
movia r8,UART_TERMINAL

movi r9,0x01
stwio r9,4(r8)

#sets IRQ for both Timer, JTAG-UART
ENABLING_IRQ_LINES:
movi r8,0x0101
wrctl ctl3,r8

ENABLING_PIE_BIT:
movi r8,0x1
wrctl ctl0,r8

here:
infiniteLoopForInterruptHere: 
movia r13, ADDR_GREENLEDS
movi r14, 0x01
stw r14,0(r13)
movia r10, received
ldw r12,0(r10)
beq r12, r0, infiniteLoopForInterruptHere


afterinterrupt:
movia r13, ADDR_GREENLEDS
movi r14, 0x00
stw r14,0(r13)
mov r4, r12
movia r10, received
mov r12, r0
stw r12, 0(r10)


mov r4, r4
call mover


movia r4, gameArray
movia r5, movementType
ldw r5, 0(r5)
movia r6, loss 
call randomNumberHandler 


movia r4, gameArray
call vgarefresher
call movementSound

movia r4, gameArray
movia r5, winOrNot
call victoryCheck
movia r2, winOrNot
ldw r2, 0(r2)
movi r3, 1
beq r2, r3, victoryLap1
movi r3, -1
beq r2, r3, lossOfAllTime


br LOOP_FOREVER


LOOP_FOREVER:
    br infiniteLoopForInterruptHere     

	
victoryLap1: 
movia r4, winPic
call makeThepic
movia r4, sentenceYouWin
call lcdwrite
call playSong
br infinite

lossOfAllTime:
movia r4, losePic
call makeThepic
movia r4, sentenceYouLose
call lcdwrite
br infinite	

infinite:
br infinite	
	


#------------------------------------------------------------
#------------------------------------------------------------
randomNumberHandler:

subi sp,sp,88
stw r2,0(sp)
stw r3,4(sp)
stw r4,8(sp)
stw r5,12(sp)
stw r6,16(sp)
stw r7,20(sp)
stw r8,24(sp)
stw r9,28(sp)
stw r10,32(sp)
stw r11,36(sp)
stw r12,40(sp)
stw r13,44(sp)
stw r14,48(sp)
stw r15,52(sp)
stw r16,56(sp)
stw r17,60(sp)
stw r18,64(sp)
stw r19,68(sp)
stw r20,72(sp)
stw r21,76(sp)
stw r22,80(sp)
stw r23,84(sp)


addi sp, sp, -4
stw ra, 0(sp)


call randomNumberAdder
	

ldw ra, 0(sp)
addi sp, sp, 4

ldw r2,0(sp)
ldw r3,4(sp)
ldw r4,8(sp)
ldw r5,12(sp)
ldw r6,16(sp)
ldw r7,20(sp)
ldw r8,24(sp)
ldw r9,28(sp)
ldw r10,32(sp)
ldw r11,36(sp)
ldw r12,40(sp)
ldw r13,44(sp)
ldw r14,48(sp)
ldw r15,52(sp)
ldw r16,56(sp)
ldw r17,60(sp)
ldw r18,64(sp)
ldw r19,68(sp)
ldw r20,72(sp)
ldw r21,76(sp)
ldw r22,80(sp)
ldw r23,84(sp)
addi sp, sp, 88
	
	
	
	ret
#------------------------------------------------------------	
#------------------------------------------------------------		
#------------------------------------------------------------
mover:
#This function calls another function. 
#This function requres parameter r4 indicating 
#direction of movement. It then calls the appropriate function.
#It stores its own return address also. 
#It does not manipulate any values. 

subi sp,sp,88
stw r2,0(sp)
stw r3,4(sp)
stw r4,8(sp)
stw r5,12(sp)
stw r6,16(sp)
stw r7,20(sp)
stw r8,24(sp)
stw r9,28(sp)
stw r10,32(sp)
stw r11,36(sp)
stw r12,40(sp)
stw r13,44(sp)
stw r14,48(sp)
stw r15,52(sp)
stw r16,56(sp)
stw r17,60(sp)
stw r18,64(sp)
stw r19,68(sp)
stw r20,72(sp)
stw r21,76(sp)
stw r22,80(sp)
stw r23,84(sp)


addi sp, sp, -4
stw ra, 0(sp)

movi r16, 0x073
beq r16, r4, moveDown

movi r16, 0x077
beq r16, r4, moveUp

movi r16, 0x061
beq r16, r4, moveLeft

movi r16, 0x064
beq r16, r4, moveRight

moveDown:
movia r4, sentenceMoveDown
call lcdwrite
movia r4, gameArray
movia r5, points
call down
movia r5, movementType
movi r6, 1
stw r6, 0(r5)
br endOfMover

moveUp:
movia r4, sentenceMoveUp
call lcdwrite
movia r4, gameArray
movia r5, points
call up
movia r5, movementType
movi r6, 2
stw r6, 0(r5)
br endOfMover

moveLeft:
movia r4, sentenceMoveLeft
call lcdwrite
movia r4, gameArray
movia r5, points
call left
movia r5, movementType
movi r6, 3
stw r6, 0(r5)
br endOfMover

moveRight:
movia r4, sentenceMoveRight
call lcdwrite
movia r4, gameArray
movia r5, points
call right
movia r5, movementType
movi r6, 4
stw r6, 0(r5)
br endOfMover

endOfMover:
movia r4, gameArray
movia r5, points


ldw ra, 0(sp)
addi sp, sp, 4

ldw r2,0(sp)
ldw r3,4(sp)
ldw r4,8(sp)
ldw r5,12(sp)
ldw r6,16(sp)
ldw r7,20(sp)
ldw r8,24(sp)
ldw r9,28(sp)
ldw r10,32(sp)
ldw r11,36(sp)
ldw r12,40(sp)
ldw r13,44(sp)
ldw r14,48(sp)
ldw r15,52(sp)
ldw r16,56(sp)
ldw r17,60(sp)
ldw r18,64(sp)
ldw r19,68(sp)
ldw r20,72(sp)
ldw r21,76(sp)
ldw r22,80(sp)
ldw r23,84(sp)
addi sp, sp, 88

ret


#------------------------------------------------------------
#------------------------------------------------------------
#------------------------------------------------------------
#------------------------------------------------------------



