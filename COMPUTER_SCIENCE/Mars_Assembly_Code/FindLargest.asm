.data 
	theArray: .word 3,12,34,56,4,8,57,89
			.word 7,99
.eqv ARRAY_SIZE 40 # total array size
.eqv DATA_SIZE 4 # interger size
length: .word 10
.text
main:
la $a0,theArray
lw $a1,length
jal FindLargest

move $a0,$v0
li $v0,1
syscall

li $v0,10
syscall


FindLargest:
li $v0,0
li $t0,0 # index
li $t1,0 # memory address
li $t2,0

	loop:
	
	
	blt $a1,$t0,exit
	mul $t1,$t0,DATA_SIZE
	add $t1,$t1,$a0
	lw $t2,($t1)
	addi $t0,$t0,1
	blt $t2,$v0,loop
	move $v0,$t2
	b loop
	
exit:
jr $ra	
	
	