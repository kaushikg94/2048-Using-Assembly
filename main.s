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

.equ JTAG, 0x10001000

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

POLL:
  movia r10, JTAG /* r10 now contains the base address */
  ldwio r11, 0(r10) /* Load from the JTAG */
  andi  r12, r11, 0x8000 /* Mask other bits */
  beq   r12, r0, POLL /* If this is 0 (branch true), data is not valid */
VALID: 
  andi r11, r11, 0x00FF
  

  
  
movi r4, 4
call mover

LOOP_FOREVER:
    br LOOP_FOREVER     



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




