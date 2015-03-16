.include "nios_macros.s"
.text 


#------------------------------------------------------------
down: 
subi sp, sp, 24
stw r15, 0(sp)
stw r14, 4(sp)
stw r13, 8(sp)
stw r12, 12(sp)
stw r11, 16(sp)
stw r10, 20(sp)
#------------------------
mov r16,r4
movi r10, 1
step1:
ldw r17,0(r16)
ldw r18,16(r16)
ldw r19,32(r16)
ldw r20,48(r16)
#------------------------
beq r19, r0, keepstatic34
beq r19, r20, merge34
beq r19, r0, shift34
bne r19, r20, keepstatic34
#------------------------
step2: 
ldw r17,0(r16)
ldw r18,16(r16)
ldw r19,32(r16)
ldw r20,48(r16)

beq r18, r0, keepstatic23
beq r18, r19, merge23
cmpeqi r15, r19, 0 
cmpeqi r14, r20, 0 
movi r13, 1
beq r14, r13, shift231
beq r15, r13, shift232
br keepstatic23
#------------------------
step3: 
ldw r17,0(r16)
ldw r18,16(r16)
ldw r19,32(r16)
ldw r20,48(r16)

beq r17, r0, keepstatic12
beq r17, r18, merge12
cmpeqi r12, r18, 0 
cmpeqi r15, r19, 0 
cmpeqi r14, r20, 0  
movi r13, 1 
beq r14, r13, shift121
beq r15, r13, shift122
beq r12, r13, shift123
br keepstatic12

#------------------------
merge34:
muli r20, r20, 2
stw r20, 48(r16)
stw r0, 32(r16) 

mov r21, r5
ldw r22, 0(r21)
addi r22, r22, 1
stw r22, 0(r21)

br step2

shift34:
stw r19, 48(r16)
mov r19, r0
stw r19, 32(r16) 
br step2

keepstatic34: 
br step2

#------------------------
merge23: 
muli r19, r19, 2
stw r19, 32(r16)
stw r0, 16(r16)

mov r21, r5
ldw r22, 0(r21)
addi r22, r22, 1
stw r22, 0(r21)

br step3

shift231:
stw r18, 48(r16)
stw r0, 16(r16) 
br step3

shift232: 
stw r18, 32(r16)
stw r0, 16(r16)
br step3

keepstatic23:
br step3
#------------------------
merge12: 
muli r18, r18, 2
stw r18, 16(r16)
stw r0, 0(r16)

mov r21, r5
ldw r22, 0(r21)
addi r22, r22, 1
stw r22, 0(r21)
br recallHandler

shift121:
stw r17, 48(r16)
stw r0, 0 (r16)
br recallHandler

shift122:
stw r17, 32(r16)
stw r0, 0(r16)
br recallHandler

shift123:
stw r17, 16(r16)
stw r0, 0(r16)
br recallHandler

keepstatic12:
br recallHandler
#------------------------
recallHandler: 
movi r18, 4 
beq r10, r18, finishDown
mov r11, r10
muli r11, r11, 4
mov r16, r4
add r16, r16, r11
addi r10, r10, 1
br step1

#------------------------
finishDown: 
ldw r15, 0(sp)
ldw r14, 4(sp)
ldw r13, 8(sp)
ldw r12, 12(sp)
ldw r11, 16(sp)
ldw r10, 20(sp)
addi sp,sp,24

ret
#------------------------------------------------------------
#------------------------------------------------------------
up: 
subi sp, sp, 24
stw r15, 0(sp)
stw r14, 4(sp)
stw r13, 8(sp)
stw r12, 12(sp)
stw r11, 16(sp)
stw r10, 20(sp)
#------------------------
mov r16,r4
movi r10, 1
ustep1:
ldw r17,0(r16)
ldw r18,16(r16)
ldw r19,32(r16)
ldw r20,48(r16)
#------------------------
beq r18, r0, keepstatic43
beq r18, r17, merge43
beq r18, r0, shift43
bne r18, r17, keepstatic43
#------------------------
ustep2: 
ldw r17,0(r16)
ldw r18,16(r16)
ldw r19,32(r16)
ldw r20,48(r16)

beq r19, r0, keepstatic32
beq r19, r18, merge32
cmpeqi r15, r18, 0 
cmpeqi r14, r17, 0 
movi r13, 1
beq r14, r13, shift321
beq r15, r13, shift322
br keepstatic32
#------------------------
ustep3: 
ldw r17,0(r16)
ldw r18,16(r16)
ldw r19,32(r16)
ldw r20,48(r16)

beq r20, r0, keepstatic21
beq r20, r19, merge21
cmpeqi r12, r19, 0 
cmpeqi r15, r18, 0 
cmpeqi r14, r17, 0  
movi r13, 1 
beq r14, r13, shift211
beq r15, r13, shift212
beq r12, r13, shift213
br keepstatic21

#------------------------
merge43:
muli r17, r17, 2
stw r17, 0(r16)
stw r0, 16(r16) 

mov r21, r5
ldw r22, 0(r21)
addi r22, r22, 1
stw r22, 0(r21)

br ustep2

shift43:
stw r18, 0(r16)
mov r18, r0
stw r18, 16(r16) 
br ustep2

keepstatic43: 
br ustep2

#------------------------
merge32: 
muli r18, r18, 2
stw r18, 16(r16)
stw r0, 32(r16)

mov r21, r5
ldw r22, 0(r21)
addi r22, r22, 1
stw r22, 0(r21)

br ustep3

shift321:
stw r19, 0(r16)
stw r0, 32(r16) 
br ustep3

shift322: 
stw r19, 16(r16)
stw r0, 32(r16)
br ustep3

keepstatic32:
br ustep3
#------------------------
merge21: 
muli r19, r19, 2
stw r19, 32(r16)
stw r0, 48(r16)

mov r21, r5
ldw r22, 0(r21)
addi r22, r22, 1
stw r22, 0(r21)
br recallHandlerup

shift211:
stw r20, 0(r16)
stw r0, 48 (r16)
br recallHandlerup

shift212:
stw r20, 16(r16)
stw r0, 48(r16)
br recallHandlerup

shift213:
stw r20, 32(r16)
stw r0, 48(r16)
br recallHandlerup

keepstatic21:
br recallHandlerup
#------------------------
recallHandlerup: 
movi r19, 4 
beq r10, r19, finishUp
mov r11, r10
muli r11, r11, 4
mov r16, r4
add r16, r16, r11
addi r10, r10, 1
br ustep1

#------------------------
finishUp: 
ldw r15, 0(sp)
ldw r14, 4(sp)
ldw r13, 8(sp)
ldw r12, 12(sp)
ldw r11, 16(sp)
ldw r10, 20(sp)
addi sp,sp,24


ret















