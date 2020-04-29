.data
newline: .asciiz "\n"

.text
main:
addi $s0, $zero,10



jal increasestack

li $v0, 4
la $a0, newline
syscall
#print
	
li $v0, 1
move $a0, $s0 
syscall	

#end of program
li $v0, 10
syscall

	increasestack:
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	
	addi $s0,$s0, 30
	
	li $v0, 1
	move $a0, $s0
	syscall
	
	# this restores the previous state in memory
	lw $s0, 0($sp)
	addi $sp,$sp, 4
	
	jr $ra # jumps back to where you were before
	


