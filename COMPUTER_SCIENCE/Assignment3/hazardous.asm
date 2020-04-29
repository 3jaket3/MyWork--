.data
out_string1: .asciiz "Worked"
out_string2: .asciiz "didnt work"

.text


li $t2,30
li $t1,1 # data hazard
add $t1,$t1,$t1 #data hazard
add $t1,$t1,$t2 #data hazard /control hazard
beq $t1,32,addworked # control hazard
li $v0, 4
la $a0, out_string2
syscall

addworked:
li $v0, 4
la $a0, out_string1
syscall

li $v0,10
syscall