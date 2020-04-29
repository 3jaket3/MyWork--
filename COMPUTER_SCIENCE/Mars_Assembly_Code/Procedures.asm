# jake tully 2/23/2018 11:57
# this program takes to numbers from user 
# then prefoms selected operation
# add multiply factorial*factorial

.data
prompt1: .asciiz "Enter a number:  "
prompt2: .asciiz "choose operation type 0 add 1 multiply 2 Sri:  "

.text
# i didnt not read in strings for the selection
# i dont feel like comparing strings (loop through and compare each byte)
jal getInputs

jal getOps

move $a0,$v0
li $v0,1
syscall

li $v0,10
syscall

getInputs:

li $v0,4
la $a0,prompt1
syscall

li $v0,5
syscall
move $s0,$v0

li $v0,4
la $a0,prompt1
syscall

li $v0,5
syscall
move $s1,$v0
jr $ra
# end of getInputs
# //////////////////////////////////////////////////


getOps:

addi $sp,$sp,-4
sw $ra 0($sp)

li $v0,4
la $a0,prompt2
syscall

li $v0,5
syscall
move $t0,$v0

beq $t0,0,addition
beq $t0,1,multiply
beq $t0,2,Sri
# end of getOps
# /////////////////////////////////////////////


addition:
add $v0,$s0,$s1
lw $ra 0($sp)
addi $sp,$sp,4
jr $ra
# end off addition
#//////////////////////////////////////////////////////

multiply:
mul $v0,$s0,$s1
lw $ra 0($sp)
addi $sp,$sp,4
jr $ra
# end of multiply
#//////////////////////////////////////////////////


Sri: # A*B*Sri(A-1,B-1) == Fact(a)*Fact(b)
move $a0,$s0
li $v0,1 # if $v0 starts at anything but 1 fact doesnt work sloppy i know
jal fact
move $s0,$v0
move $a0,$s1
li $v0,1 # if $v0 starts at anything but 1 fact doesnt work sloppy i know
jal fact
mul $v0,$v0,$s0


lw $ra 0($sp)
addi $sp,$sp,4
jr $ra
# end of Sri
#////////////////////////////////////

fact:

slti $t1,$a0,1 # get true false a0 < 1
beq $t1,$zero push # while is greter than 1 push values on to stack
jr $ra # return to call inside function gets called once

push:
addi $sp,$sp, -8
sw $ra, 4($sp)
sw $a0, 0($sp)
addi $a0 $a0,-1 # pushed values on and decrease $a0
jal fact


lw $a0, 0($sp) # start popping off values and multiplying by output
lw $ra 4($sp)
mul $v0,$v0,$a0
addi $sp,$sp,8
jr $ra # returns to jal fact inside except on last call where it returns to main