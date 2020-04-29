.data 

prompt1: .asciiz "enter a positive integer less than 10 "

.text

li $v0, 4
la $a0, prompt1
syscall

li $v0, 5
syscall
move $a0,$v0
move $t0,$a0
li $v0,1

jal fact

move $a0,$v0
li $v0,1
syscall

li $v0,10
syscall

fact:

slti $t1,$a0,1
beq $t1,$zero push
jr $ra


push:
addi $sp,$sp, -8
sw $ra, 4($sp)
sw $a0, 0($sp)
addi $a0 $a0,-1
jal fact


lw $a0, 0($sp)
lw $ra 4($sp)
mul $v0,$v0,$a0
addi $sp,$sp,8
jr $ra







