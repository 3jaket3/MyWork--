.data

.text

li $a0, 0
li $a1,10
li $v0,0
jal mysum
move $a0,$v0
li $v0, 1
syscall

li $v0, 10


mysum:

bne $a0, $a1, ms_recurse
move $v0, $a1
jr $ra

ms_recurse:
sub $sp, $sp, 8
sw $ra, 0($sp)
sw $a0, 4($sp)
add $a0,$a0, 1
jal mysum
lw $a0, 4($sp)
add $v0, $v0, $a0
lw $ra, 0($sp)
add $sp,$sp,8
jr $ra
