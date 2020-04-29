.data

prompt1: .asciiz " enter integer 1\n"
prompt2: .asciiz " enter integer 2\n"
prompt3: .asciiz " 0 for add 1 for multiply\n"

.text

li $v0, 4
la $a0, prompt1
syscall

li $v0, 5
syscall
move $t0,$v0

li $v0,4
la $a0, prompt2
syscall

li $v0, 5
syscall
move $t1,$v0

li $v0,4
la $a0, prompt3
syscall

li $v0, 5
syscall
move $t3,$v0

beqz $t3, additon
mul $t3,$t0,$t1
b exit

additon:
add $t3,$t0,$t1
b exit


exit:
li $v0, 1
move $a0,$t3
syscall

li $v0,10
syscall

