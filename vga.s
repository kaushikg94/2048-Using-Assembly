.include "nios_macros.s"

.equ RED_LEDS, 0x10000000
.equ GREEN_LEDS, 0x10000010     
.equ ADDR_VGA, 0x08000000
.equ ADDR_CHAR, 0x09000000
.equ BACKGROUND_COLOR, 0xffdd
.equ BOX_COLOR, 0xbd74
.equ MY_COLOR, 0xcE16
.equ Y_LIMIT,0x01
.equ X_LIMIT,0x01
.data

.align 4
numberBasedColors: 
.hword 0
.hword 0
.hword 0
.hword 0
.hword 0
.hword 0
.hword 0
.hword 0
.hword 0
.hword 0
.hword 0
               
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
char_x:
.word 0
char_y:
.word 0

#-----------------------------------------

.text                  # "text" section for (read-only) code
#-------------------------------------------------------------------
refreshScreen: 
addi sp, sp, -4
stw ra, 0(sp)

ldw ra, 0(sp)
addi sp, sp, 4	
ret


#-------------------------------------------------------------------
firstScreen: 
addi sp, sp, -4
stw ra, 0(sp)


#Full Screen Color
 movi r4, 0
 movi r5, 319
 movi r6, 0
 movi r7, 239
 movia r8, BACKGROUND_COLOR
	call setTheBox
	call makeThebox

#Overall Box
 movi r4, 79
 movi r5, 237
 movi r6, 59
 movi r7, 217
 movia r8, BOX_COLOR
	call setTheBox
	call makeThebox

#Little Boxes
#box 1
 movi r4, 83
 movi r5, 114
 movi r6, 63
 movi r7, 94
 movia r8, MY_COLOR
	call setTheBox
	call makeThebox

#box 5	
 movi r4, 83
 movi r5, 114
 movi r6, 102
 movi r7, 133
 movia r8, MY_COLOR
	call setTheBox
	call makeThebox	

#box 9
 movi r4, 83
 movi r5, 114
 movi r6, 141
 movi r7, 172
 movia r8, MY_COLOR
	call setTheBox
	call makeThebox	

#box 13	
 movi r4, 83
 movi r5, 114
 movi r6, 180
 movi r7, 211
 movia r8, MY_COLOR
	call setTheBox
	call makeThebox	

#box 2	
 movi r4, 122
 movi r5, 153
 movi r6, 62
 movi r7, 94
 movia r8, MY_COLOR
	call setTheBox
	call makeThebox	

#box 6
 movi r4, 122
 movi r5, 153
 movi r6, 102
 movi r7, 133
 movia r8, MY_COLOR
	call setTheBox
	call makeThebox	

#box 10
 movi r4, 122
 movi r5, 153
 movi r6, 141
 movi r7, 172
 movia r8, MY_COLOR
	call setTheBox
	call makeThebox	

#box 14
 movi r4, 122
 movi r5, 153
 movi r6, 180
 movi r7, 211
 movia r8, MY_COLOR
	call setTheBox
	call makeThebox

#box 3
 movi r4, 161
 movi r5, 192
 movi r6, 63
 movi r7, 94
 movia r8, MY_COLOR
	call setTheBox
	call makeThebox	

#box 7
 movi r4, 161
 movi r5, 192
 movi r6, 102
 movi r7, 133
 movia r8, MY_COLOR
	call setTheBox
	call makeThebox	

#box 11
 movi r4, 161
 movi r5, 192
 movi r6, 141
 movi r7, 172
 movia r8, MY_COLOR
	call setTheBox
	call makeThebox	
	
#box 15	
 movi r4, 161
 movi r5, 192
 movi r6, 180
 movi r7, 211
 movia r8, MY_COLOR
	call setTheBox
	call makeThebox	

#box 4	
 movi r4, 200
 movi r5, 231
 movi r6, 63
 movi r7, 94
 movia r8, MY_COLOR
	call setTheBox
	call makeThebox		
	
#box 8	
 movi r4, 200
 movi r5, 231
 movi r6, 102
 movi r7, 133
 movia r8, MY_COLOR
	call setTheBox
	call makeThebox			
	
#box 12
 movi r4, 200
 movi r5, 231
 movi r6, 141
 movi r7, 172
 movia r8, MY_COLOR
	call setTheBox
	call makeThebox			
	
#box 16	
 movi r4, 200
 movi r5, 231
 movi r6, 180
 movi r7, 211
 movia r8, MY_COLOR
	call setTheBox
	call makeThebox			
	
#need to make a return to r4. 	
ldw ra, 0(sp)
addi sp, sp, 4	
	
	ret
#-------------------------------------------------------------------
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

#-------------------------------------------------------------------
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
#-------------------------------------------------------------------
setChar: 
movia r9, char_x
stw r4, 0(r9)

movia r9, char_y
stw r5, 0(r9)
ret

writeChar: 
movia r9, char_x
ldw r9, 0(r9)
movia r8, char_y
ldw r8, 0(r8)
muli r9,r9, 1
muli r8,r8, 128
add r9,r9,r8
movia r8, ADDR_CHAR
add r9, r9, r8
stbio r4, 0(r9)
ret 
#-------------------------------------------------------------------
vgaRefresh:
addi sp, sp, -4
stw ra, 0(sp)
iterate: 
muli r8, r8, 1




ldw ra, 0(sp)
addi sp, sp, 4
ret




