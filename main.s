.include "nios_macros.s"
.include "vga.s"
.include "solver.s"
.data                  # "data" section for input and output lists
.align 4

gameArray: 
.word 4
.word 2
.word 0
.word 2

.word 2
.word 4
.word 0
.word 2

.word 2
.word 2
.word 0
.word 2

.word 0
.word 2
.word 2
.word 2

points:
.word 0

lastmove: 
.word 0  

received:
.word 0 

.equ JTAG, 0x10001000
.equ TIMER,0x10002000
.equ UART,0x10001020
.equ PERIOD_1S,0x2FAF080
.equ UART_TERMINAL,0x10001000
.equ PERIOD,0x7A120	#period of 0.10s

#-----------------------------------------

.text                  # "text" section for (read-only) code

.global main
.global down
.global up
.global mover
main: 

initializationOfValues: 
movia r8, gameArray
#Poll for the values here

initializationOfInterrupts: 
SETTING_UART:
movia r8,UART_TERMINAL

movi r9,0x01
stwio r9,4(r8)

ENABLING_IRQ_LINES:
movi r8,0x0100
wrctl ctl3,r8

ENABLING_PIE_BIT:
movi r8,0x1
wrctl ctl0,r8

here:
infiniteLoopForInterruptHere: 
movia r13,0x10000010
movi r14, 0x01
stw r14,0(r13)
movia r10, received
ldw r12,0(r10)
beq r12, r0, infiniteLoopForInterruptHere

afterinterrupt:
movia r13,0x10000010
movi r14, 0x00
stw r14,0(r13)
mov r4, r12
movia r10, received
mov r12, r0
stw r12, 0(r10)

  
#movi r4, 4
#call mover

LOOP_FOREVER:
    br infiniteLoopForInterruptHere     



#------------------------------------------------------------
mover:
addi sp, sp, -4
stw ra, 0(sp)

movi r16, 1 
beq r16, r4, moveDown

addi r16,r16,1
beq r16, r4, moveUp

addi r16,r16,1
beq r16, r4, moveLeft

addi r16,r16,1
beq r16, r4, moveRight

moveDown:
movia r4, gameArray
movia r5, points
call down
br endOfMover

moveUp:
movia r4, gameArray
movia r5, points
call up
br endOfMover

moveLeft:
movia r4, gameArray
movia r5, points
call left
br endOfMover

moveRight:
movia r4, gameArray
movia r5, points
call right
br endOfMover

endOfMover:
movia r4, gameArray
movia r5, points
ldw ra, 0(sp)
addi sp, sp, 4

ret
#------------------------------------------------------------
	
left:
ret

#------------------------------------------------------------
#------------------------------------------------------------
#------------------------------------------------------------
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
andi r8,et,0x10000000
beq r8,r0,UART_INTERRUPT

UART_INTERRUPT:
movia et,UART_TERMINAL
ldwio r8,0(et)
andi r8,r8,0xFF
movia r10, received
stw r8,0(r10)
br EXIT_IHANDLER

EXIT_IHANDLER:
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




