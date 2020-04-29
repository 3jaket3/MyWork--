# Jake Tully
# lab2 
# 1/24/2018

.data

out_string: .asciiz "\nHello, World!\n"

.text

main:





li $t1, 1
li $t2, 2

add $t0, $t1, $t2
move $a0, $t0
li $v0, 1
syscall



li $v0,5
syscall
move $t0,$v0

move $a0, $t2 
li $v0, 1
syscall

bgt $t0, $t1, t0_bigger
move $t2,$t1
b endif
t0_bigger: move $t2,$t0

endif:


li $v0,5
syscall
move $t2,$v0
li $v0,5
syscall
move $t3,$v0

loopstart:
beq $t2, $t3 endloop
li $v0,5
syscall
move $t2,$v0
li $v0,5
syscall
move $t3,$v0
b loopstart
endloop:


li $v0 10
syscall