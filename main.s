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


#-----------------------------------------

.text                  # "text" section for (read-only) code

.global main
.global down
main: 

initializationOfValues: 
movia r8, gameArray
#movi r9, 2
#stw r9, 0(r8)

#Poll for the values here


movi r4, 1
call mover

LOOP_FOREVER:
    br LOOP_FOREVER     




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




left:
ret

right: 
ret




