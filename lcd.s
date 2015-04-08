.include "nios_macros.s"

.data
.equ LCDBase, 0x10003050

#-----------------------------------------

.text                  # "text" section for (read-only) code

 lcdwrite:
	#send r4 as the right sentence
	#it returns nothing. It prints Lcd to the screen 
	mov r10, r4
	movia r7, LCDBase /* r7 contains base address for LCD controller */
	movia r6, 0x080
	mov r3, r6
	stbio r3,0(r7)
writeAgain: 	
	ldb r3, 0(r10)
	beq r3, r0, exitlcdwrite
	stbio r3, 1(r7) 
	addi r10, r10, 1
	br writeAgain
exitlcdwrite:
	ret

