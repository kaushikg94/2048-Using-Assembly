.include "nios_macros.s"

.data
.equ ADDR_AUDIODACFIFO, 0x10003040

applause: 
.incbin "applause.wav"
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

playSong:
movia r2,ADDR_AUDIODACFIFO
movia r10, 0x000a0000
movia r4, applause
checker: 
 # ldwio r3,4(r2)      /* Read fifospace register */
 # andi  r3,r3,0xff    /* Extract # of samples in Input Right Channel FIFO */
 # beq   r3,r0,main  /* If no samples in FIFO, go back to start */
  #ldwio r3,8(r2)
	
	ldwio r3,4(r2)
  andi  r3,r3,0xffff0000
  beq   r3,r0,checker
   ldwio r3, 0(r4)
	stwio r3,8(r2)      /* Echo to left channel */
  #ldwio r3,12(r2)
  stwio r3,12(r2)     /* Echo to right channel */
  
  addi r10, r10, -2
  addi r4, r4, 2
  bgt r10 ,r0 ,checker
ret





