.data
out_string1: .asciiz "Worked"
out_string2: .asciiz "didnt work"

.text
li $t1,1
li $t2,30
add $t1,$t1,$t1
add $t2,$t1,$t2
li $zero,0
beq $t2,32,addworked
li $v0, 4
la $a0, out_string2
syscall

addworked:
li $v0, 4
la $a0, out_string1
syscall

li $v0,10
syscall