.include "nios_macros.s"

.data
.equ ADDR_AUDIODACFIFO, 0x10003040
#-----------------------------------------

.text                  # "text" section for (read-only) code

movementSound: 
movia r10, 0x000493E0

movementSoundLoop: 
  movia r2,ADDR_AUDIODACFIFO
  ldwio r3,8(r2)
  movia r3, 0x07000000
  stwio r3,8(r2)      /* Echo to left channel */
  stwio r3,12(r2)     /* Echo to right channel */
  
  movia r3, 0xF9000000
  stwio r3,8(r2)      /* Echo to left channel */
  stwio r3,12(r2)     /* Echo to right channel */
 subi r10, r10, 1
 beq r10, r0, movementSoundEnd
 br movementSoundLoop

movementSoundEnd:
ret







