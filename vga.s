.include "nios_macros.s"


.equ RED_LEDS, 0x10000000
.equ GREEN_LEDS, 0x10000010     
.equ ADDR_VGA, 0x08000000
.equ ADDR_CHAR, 0x09000000
.equ BACKGROUND_COLOR, 0xffdd
.equ BOX_COLOR, 0xbd74
.equ MY_COLOR, 0xffff
.equ X_LIMIT,0x01
.equ Y_LIMIT,0x01
.data                  
.align 2

plotter_color:
.hword 0
.hword 0
plotter_x_min:
.word 0 
plotter_x_max:
.word 0
plotter_y_min:
.word 0
plotter_y_max:
.word 0


#-----------------------------------------

.text                  # "text" section for (read-only) code

VGAFUNCTION: 

 movi r4, 0
 movi r5, 319
 movi r6, 0
 movi r7, 239
 movia r8, BACKGROUND_COLOR
	call setTheBox
	call makeThebox

 movi r4, 79
 movi r5, 237
 movi r6, 59
 movi r7, 217
 movia r8, BOX_COLOR
	call setTheBox
	call makeThebox

 movi r4, 83
 movi r5, 114
 movi r6, 63
 movi r7, 94
 movia r8, MY_COLOR
	call setTheBox
	call makeThebox

	 movi r4, 122
 movi r5, 153
 movi r6, 102
 movi r7, 133
 movia r8, MY_COLOR
	call setTheBox
	call makeThebox
	
	
	help:
	
	br help
	
	
	ret

makeThebox:
 movia r2, plotter_color
 ldh r4, 0(r2)
 
 movia r2, plotter_x_min
 ldw r5, 0(r2)	
 mov r9,r5
 
 movia r2, plotter_x_max
 ldw r6, 0(r2)
 
 movia r2, plotter_y_min
 ldw r7, 0(r2)	
 mov r10, r7
 
 movia r2, plotter_y_max
 ldw r8, 0(r2)
  
 #take r5 as the x min. 
 #take r6 as the x max
 #take r7 as the y min. 
 #take r8 as the y max.
 #take r9 as the x current.
 #take r10 as the y current. 
 #take r11,r12,r13 as cal1
 
 
 xcase: 
 beq r9,r6, exitXloop
	ycase: 
		beq r10,r8, exitYloop
			muli r11, r9, 2
			muli r12, r10, 1024
			add r11,r11,r12
			movia r12, ADDR_VGA
			add r13,r12,r11
			sthio r4,0(r13)
			addi r10, r10, 1
		br ycase
	br xcase
	
	exitYloop:
		movia r2, plotter_y_min
		ldw r10, 0(r2)
		addi r9, r9, 1
	br xcase
 
 exitXloop:
	#leave everything
	
ret


setTheBox: 

 #storing values:
 movia r2, plotter_x_min
 stw r4, 0(r2)
 
 movia r2, plotter_x_max
 stw r5, 0(r2)
 
 movia r2, plotter_y_min
 stw r6, 0(r2)
 
 movia r2, plotter_y_max
 movia r9, 239
 stw r7, 0(r2)

 movia r2, plotter_color	
 sth r8, 0(r2)
 
 ret



