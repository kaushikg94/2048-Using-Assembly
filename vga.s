.include "nios_macros.s"

.equ RED_LEDS, 0x10000000
.equ GREEN_LEDS, 0x10000010     
.equ ADDR_VGA, 0x08000000
.equ ADDR_CHAR, 0x09000000
.equ BACKGROUND_COLOR_ACTUAL, 0xffdd
.equ BACKGROUND_COLOR, 0xffdd
.equ BOX_COLOR, 0xbd74

.equ COLOR_2, 0xef3b
.equ COLOR_4, 0xef19
.equ COLOR_8, 0xf587
.equ COLOR_16, 0xf4ac
.equ COLOR_32, 0xf3eb
.equ COLOR_64, 0xf2e7
.equ COLOR_128, 0xee6e
.equ COLOR_256, 0xee6c
.equ COLOR_512, 0xee4a
.equ COLOR_1024, 0xee27
.equ COLOR_2048, 0xee05

.equ MY_COLOR, 0xcE16
.equ Y_LIMIT,0x01
.equ X_LIMIT,0x01
.data

.align 4
numberBasedColors: 
.hword 
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
#-------------------------------------------------------------------
firstScreen: 
#This function initializes the entire VGA screen. 
#It is technically redundant but it is called as it was the 
#first version of the VGA writing function. 
#As it takes no values, it has no parameter requirements. 
#It just writes to VGA
#It calls other functions and stores its own return address


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
#It takes in no parameters but it needs to be called AFTER calling setthebox 
#function. 
#it returns nothing. 
#It draws a box on the VGA screen
#It uses pointers and manipulates registers(almost all) 
#since it does this, all registers are callee stored in the stack for safety. 


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

#-------------------------------------------------------------------
setTheBox: 
#It sets the box parameters for the makethebox function.
#It returns nothing. 
#It takes in parameters r4, r5, r6, r7 and r8 as xmin,max,ymin,max respectively. 
#r8 stores the color for what to plot.

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
#positions the place where the character should be written. 
#Returns nothing
#Takes in parameters r4,r5 as char position x axis and y axis respectively

movia r2, char_x
stw r4, 0(r2)

movia r2, char_y
stw r5, 0(r2)
ret

writeChar:
#writes the char position based on positions sent to SETCHAR
#call setchar before calling writechar
#takes in parameter r4 as the character value to be written to the pre-assigned location.


movia r2, char_x
ldw r2, 0(r2)
movia r3, char_y
ldw r3, 0(r3)
muli r2,r2, 1
muli r3,r3, 128
add r2,r2,r3
movia r3, ADDR_CHAR
add r2, r2, r3
stbio r4, 0(r2)
ret 
#-------------------------------------------------------------------
vgarefresher:
mov r10, r4

addi sp, sp, -4
stw ra, 0(sp)

#box 1
	mov r4, r10
	call colorpicker

 movi r4, 83
 movi r5, 114
 movi r6, 63
 movi r7, 94
	call setTheBox
	call makeThebox
mov r4,r10 
movi r5, 24
movi r6, 19
call numberpicker
	addi r10,r10, 4
	
#box 2	
	mov r4, r10
	call colorpicker


 movi r4, 122
 movi r5, 153
 movi r6, 62
 movi r7, 94
	call setTheBox
	call makeThebox
mov r4,r10 
movi r5, 34
movi r6, 19
call numberpicker
		addi r10,r10, 4
	
	
#box 3

	mov r4, r10
	call colorpicker

 movi r4, 161
 movi r5, 192
 movi r6, 63
 movi r7, 94
	call setTheBox
	call makeThebox
mov r4,r10 
movi r5, 44
movi r6, 19
call numberpicker
		addi r10,r10, 4
	
	#box 4
	mov r4, r10
	call colorpicker

 movi r4, 200
 movi r5, 231
 movi r6, 63
 movi r7, 94

	call setTheBox
	call makeThebox	
mov r4,r10 
movi r5, 53
movi r6, 19
call numberpicker
			addi r10,r10, 4	
	
	
	
#box 5
	mov r4, r10
	call colorpicker

 movi r4, 83
 movi r5, 114
 movi r6, 102
 movi r7, 133
	call setTheBox
	call makeThebox	
mov r4,r10 
movi r5, 24
movi r6, 29
call numberpicker
			addi r10,r10, 4
	
#box 6

	mov r4, r10
	call colorpicker

 movi r4, 122
 movi r5, 153
 movi r6, 102
 movi r7, 133
	call setTheBox
	call makeThebox	
	mov r4,r10 
movi r5, 34
movi r6, 29
call numberpicker
	addi r10,r10, 4

#box 7
	mov r4, r10
	call colorpicker

 movi r4, 161
 movi r5, 192
 movi r6, 102
 movi r7, 133
	call setTheBox
	call makeThebox
	mov r4,r10 
movi r5, 44
movi r6, 29
call numberpicker
		addi r10,r10, 4

	
#box 8	
	mov r4, r10
	call colorpicker

 movi r4, 200
 movi r5, 231
 movi r6, 102
 movi r7, 133
	call setTheBox
	call makeThebox
	mov r4,r10 	
movi r5, 53
movi r6, 29
call numberpicker	
		addi r10,r10, 4
	
#box 9
	mov r4, r10
	call colorpicker
 movi r4, 83
 movi r5, 114
 movi r6, 141
 movi r7, 172
	call setTheBox
	call makeThebox	
		mov r4,r10 
movi r5, 24
movi r6, 39
call numberpicker
		addi r10,r10, 4
	

#box 10
	mov r4, r10
	call colorpicker

 movi r4, 122
 movi r5, 153
 movi r6, 141
 movi r7, 172

	call setTheBox
	call makeThebox	
mov r4,r10 
movi r5, 34
movi r6, 39
call numberpicker
		addi r10,r10, 4
	
	
	#box 11
		mov r4, r10
	call colorpicker
 movi r4, 161
 movi r5, 192
 movi r6, 141
 movi r7, 172
	call setTheBox
	call makeThebox	
	mov r4,r10 
movi r5, 44
movi r6, 39
call numberpicker
		addi r10,r10, 4
	
	
	#box 12
		mov r4, r10
	call colorpicker
 movi r4, 200
 movi r5, 231
 movi r6, 141
 movi r7, 172
	call setTheBox
	call makeThebox
mov r4,r10 
movi r5, 53
movi r6, 39
call numberpicker	
		addi r10,r10, 4
#box 13	

	mov r4, r10
	call colorpicker

 movi r4, 83
 movi r5, 114
 movi r6, 180
 movi r7, 211
	call setTheBox
	call makeThebox
	mov r4,r10 
movi r5, 24
movi r6, 48
call numberpicker
	addi r10,r10, 4

#box 14

	mov r4, r10
	call colorpicker

 movi r4, 122
 movi r5, 153
 movi r6, 180
 movi r7, 211
	call setTheBox
	call makeThebox
	
mov r4,r10 
movi r5, 34
movi r6, 48
call numberpicker
	addi r10,r10, 4
	#box 15	
	
		mov r4, r10
	call colorpicker

 movi r4, 161
 movi r5, 192
 movi r6, 180
 movi r7, 211
	call setTheBox
	call makeThebox	
	mov r4,r10 
movi r5, 44
movi r6, 48
call numberpicker
	addi r10,r10, 4

#box 16	
	mov r4, r10
	call colorpicker

 movi r4, 200
 movi r5, 231
 movi r6, 180
 movi r7, 211
	call setTheBox
	call makeThebox	
mov r4,r10 
movi r5, 53
movi r6, 48
call numberpicker	
	addi r10,r10, 4
	
#need to make a return to r4. 	
ldw ra, 0(sp)
addi sp, sp, 4	
	
	ret
#-------------------------------------------------------------------
#-------------------------------------------------------------------
colorpicker:
#r4 must be the game address Point only (with offset). 1 parameter only.
#returns value in r8. That contains the color.
addi sp, sp, -4
stw r13, 0(sp)

ldw r13,0(r4)
movi r2, 0 
beq r2, r13, case0
movi r2, 2 
beq r2, r13, case2
movi r2, 4 
beq r2, r13, case4
movi r2, 8 
beq r2, r13, case8
movi r2, 16 
beq r2, r13, case16
movi r2, 32
beq r2, r13, case32
movi r2, 64
beq r2, r13, case64
movi r2, 128
beq r2, r13, case128
movi r2, 256
beq r2, r13, case256
movi r2, 512
beq r2, r13, case512
movi r2, 1024
beq r2, r13, case1024
movi r2, 2048
beq r2, r13, case2048
case0:
movia r8, MY_COLOR
br handleit
case2:
movia r8, COLOR_2
br handleit
case4:
movia r8, COLOR_4
br handleit
case8:
movia r8, COLOR_8
br handleit
case16:
movia r8, COLOR_16
br handleit
case32:
movia r8, COLOR_32
br handleit
case64:
movia r8, COLOR_64
br handleit
case128:
movia r8, COLOR_128
br handleit
case256:
movia r8, COLOR_256
br handleit
case512:
movia r8, COLOR_512
br handleit
case1024:
movia r8, COLOR_1024
br handleit
case2048:
movia r8, COLOR_2048
br handleit
handleit:

ldw r13, 0(sp)
addi sp, sp, 4	
ret
#-------------------------------------------------------------------
numberpicker: 
#r4 must have game address with offset 
#r5 must have charx position
#r6 must have chary position 
#it returns nothing. 
#it calls setChar and WriteChar functions
#it stores all its pointers within

addi sp, sp, -4
stw ra, 0(sp)

ldw r13,0(r4)
movi r2, 0 
beq r2, r13, caseNumber0
movi r2, 2 
beq r2, r13, caseNumber2
movi r2, 4 
beq r2, r13, caseNumber4
movi r2, 8 
beq r2, r13, caseNumber8
movi r2, 16 
beq r2, r13, caseNumber16
movi r2, 32
beq r2, r13, caseNumber32
movi r2, 64
beq r2, r13, caseNumber64
movi r2, 128
beq r2, r13, caseNumber128
movi r2, 256
beq r2, r13, caseNumber256
movi r2, 512
beq r2, r13, caseNumber512
movi r2, 1024
beq r2, r13, caseNumber1024
movi r2, 2048
beq r2, r13, caseNumber2048

caseNumber0:
mov r18, r5
mov r19, r6
mov r4,r5
subi r4,r4,2
mov r5,r6
call setChar
movi r4, 0x20
call writeChar

mov r4, r18
mov r5, r19
subi r4, r4, 1
call setChar
movi r4, 0x20
call writeChar

mov r4, r18
mov r5, r19
call setChar
movi r4, 0x20
call writeChar

mov r4, r18
mov r5, r19
addi r4, r4, 1
call setChar
movi r4, 0x20
call writeChar

br handleNumber

caseNumber2:
mov r18, r5
mov r19, r6
mov r4,r5
mov r5,r6
call setChar
movi r4, 0x32
call writeChar

mov r4, r18
mov r5, r19
subi r4, r4, 2
call setChar
movi r4, 0x20
call writeChar

mov r4, r18
mov r5, r19
subi r4, r4, 1
call setChar
movi r4, 0x20
call writeChar

mov r4, r18
mov r5, r19
addi r4, r4, 1
call setChar
movi r4, 0x20
call writeChar


br handleNumber

caseNumber4:
mov r18, r5
mov r19, r6
mov r4,r5
mov r5,r6
call setChar
movi r4, 0x34
call writeChar

mov r4, r18
mov r5, r19
subi r4, r4, 2
call setChar
movi r4, 0x20
call writeChar

mov r4, r18
mov r5, r19
subi r4, r4, 1
call setChar
movi r4, 0x20
call writeChar

mov r4, r18
mov r5, r19
addi r4, r4, 1
call setChar
movi r4, 0x20
call writeChar

br handleNumber

caseNumber8:
mov r18, r5
mov r19, r6
mov r4,r5
mov r5,r6
call setChar
movi r4, 0x38
call writeChar

mov r4, r18
mov r5, r19
subi r4, r4, 2
call setChar
movi r4, 0x20
call writeChar

mov r4, r18
mov r5, r19
subi r4, r4, 1
call setChar
movi r4, 0x20
call writeChar

mov r4, r18
mov r5, r19
addi r4, r4, 1
call setChar
movi r4, 0x20
call writeChar

br handleNumber

caseNumber16:
mov r18, r5
mov r19, r6
mov r4,r5
mov r5,r6
call setChar
movi r4, 0x36
call writeChar

mov r4, r18
mov r5, r19
subi r4, r4, 2
call setChar
movi r4, 0x20
call writeChar

mov r4, r18
mov r5, r19
addi r4, r4, 1
call setChar
movi r4, 0x20
call writeChar

mov r4, r18
subi r4, r4, 1
mov r5, r19
call setChar
movi r4, 0x31
call writeChar
br handleNumber

caseNumber32:
mov r18, r5
mov r19, r6
mov r4,r5
mov r5,r6
call setChar
movi r4, 0x32
call writeChar

mov r4, r18
mov r5, r19
subi r4, r4, 2
call setChar
movi r4, 0x20
call writeChar

mov r4, r18
mov r5, r19
addi r4, r4, 1
call setChar
movi r4, 0x20
call writeChar

mov r4, r18
subi r4, r4, 1
mov r5, r19
call setChar
movi r4, 0x33
call writeChar
br handleNumber

caseNumber64:
mov r18, r5
mov r19, r6
mov r4,r5
mov r5,r6
call setChar
movi r4, 0x34
call writeChar

mov r4, r18
mov r5, r19
subi r4, r4, 2
call setChar
movi r4, 0x20
call writeChar

mov r4, r18
mov r5, r19
addi r4, r4, 1
call setChar
movi r4, 0x20
call writeChar


mov r4, r18
subi r4, r4, 1
mov r5, r19
call setChar
movi r4, 0x36
call writeChar
br handleNumber

caseNumber128:
mov r18, r5
mov r19, r6
mov r4,r5
subi r4,r4,1
mov r5,r6
call setChar
movi r4, 0x31
call writeChar

mov r4, r18
mov r5, r19
subi r4, r4, 2
call setChar
movi r4, 0x20
call writeChar

mov r4, r18
mov r5, r19
call setChar
movi r4, 0x32
call writeChar

mov r4, r18
mov r5, r19
addi r4, r4, 1
call setChar
movi r4, 0x38
call writeChar

br handleNumber

caseNumber256:
mov r18, r5
mov r19, r6
mov r4,r5
subi r4,r4,1
mov r5,r6
call setChar
movi r4, 0x32
call writeChar

mov r4, r18
mov r5, r19
subi r4, r4, 2
call setChar
movi r4, 0x20
call writeChar

mov r4, r18
mov r5, r19
call setChar
movi r4, 0x35
call writeChar

mov r4, r18
mov r5, r19
addi r4, r4, 1
call setChar
movi r4, 0x36
call writeChar

br handleNumber

caseNumber512:
mov r18, r5
mov r19, r6
mov r4,r5
subi r4,r4,1
mov r5,r6
call setChar
movi r4, 0x35
call writeChar

mov r4, r18
mov r5, r19
call setChar
movi r4, 0x31
call writeChar

mov r4, r18
mov r5, r19
addi r4, r4, 1
call setChar
movi r4, 0x32
call writeChar

mov r4, r18
mov r5, r19
subi r4, r4, 2
call setChar
movi r4, 0x20
call writeChar

br handleNumber

caseNumber1024:
mov r18, r5
mov r19, r6
mov r4,r5
subi r4,r4,2
mov r5,r6
call setChar
movi r4, 0x31
call writeChar


mov r4, r18
mov r5, r19
subi r4, r4, 1
call setChar
movi r4, 0x30
call writeChar

mov r4, r18
mov r5, r19
call setChar
movi r4, 0x32
call writeChar

mov r4, r18
mov r5, r19
addi r4, r4, 1
call setChar
movi r4, 0x34
call writeChar
br handleNumber

caseNumber2048:
mov r18, r5
mov r19, r6
mov r4,r5
subi r4,r4,2
mov r5,r6
call setChar
movi r4, 0x32
call writeChar


mov r4, r18
mov r5, r19
subi r4, r4, 1
call setChar
movi r4, 0x30
call writeChar

mov r4, r18
mov r5, r19
call setChar
movi r4, 0x34
call writeChar

mov r4, r18
mov r5, r19
addi r4, r4, 1
call setChar
movi r4, 0x38
call writeChar
br handleNumber

handleNumber:

ldw ra, 0(sp)
addi sp, sp, 4

ret

#-------------------------------------------------------------------
#-------------------------------------------------------------------
makeThepic:
#It takes in no parameters but it needs to be called AFTER calling setthebox 
#function. 
#it returns nothing. 
#It draws a box on the VGA screen
#It uses pointers and manipulates registers(almost all) 
#since it does this, all registers are callee stored in the stack for safety. 


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

 
 movia r5, 60
 mov r9,r5
 
 movia r6, 260
 
 movia r7, 20
 mov r10, r7
 
 movia r8, 220
  
 #take r5 as the x min. 
 #take r6 as the x max
 #take r7 as the y min. 
 #take r8 as the y max.
 #take r9 as the x current.
 #take r10 as the y current. 
 #take r11,r12,r13 as cal1
 
 ycasePIC: 
 beq r10,r8, exitYloopPIC
	xcasePIC: 
		beq r9,r6, exitXloopPIC
			muli r11, r9, 2
			muli r12, r10, 1024
			add r11,r11,r12
			movia r12, ADDR_VGA
			add r13,r12,r11
			ldh r5, 0(r4)
			sthio r5,0(r13)
			addi r9, r9, 1
			addi r4, r4, 2
		br xcasePIC
	br ycasePIC
	
	exitXloopPIC:
		movi r9, 60
		addi r10, r10, 1
	br ycasePIC
 
 exitYloopPIC:
	#leave everything
	
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




