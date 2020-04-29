.data
newline: .asciiz "\n"
prompt_user: .asciiz "enter integer\n"

.text
main:

#get input 1
li $v0, 4
la $a0, prompt_user
syscall
li $v0,5
syscall
move $s0,$v0
move $a1,$s0
# get input 2
li $v0, 4
la $a0, prompt_user
syscall
li $v0,5
syscall
move $s1,$v0
move $a2,$s1


jal multiply

move $a0,$v0
li $v0, 1
syscall	
li $v0, 4
la $a0, newline
syscall
move $a0,$s0
li $v0, 1
syscall	
li $v0, 4
la $a0, newline
syscall
move $a0,$s1
li $v0, 1
syscall	
	
li $v0, 10
syscall

multiply:
	addi $sp,$sp,-8
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	mul $s0,$s0,$s0
	mul $s1,$s1,$s1
	mul $v0,$s0,$s1
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addi $sp,$sp,8
	jr $ra

