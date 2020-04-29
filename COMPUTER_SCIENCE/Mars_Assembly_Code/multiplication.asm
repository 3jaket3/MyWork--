.data

fpconstant:
.double 1.2345
fpconstant2:
.double 2.3456

out_string_overflow: .asciiz " overflow detected\n"
out_string_nooverflow: .asciiz " no overflow detected\n"
.text

l.d $f2, fpconstant
l.d $f4, fpconstant2
mul.d $f6, $f2, $f4


# get 2 numbers
li $v0, 5
syscall
move $s2,$v0
li $v0, 5
syscall
move $s3,$v0

mult $s2,$s3 # multiply
mfhi $s1 #get high lol
mflo $s0 # get low get low lol lil john

move $t1, $s1  # move to temp
srl $t1,$t1,31 #shift i want the sign bit
andi $t1 $s1, 0 # and with zero result:( $t1 - if 0) ($t1 + if 1)

beqz $t1 , negative
move $t1, $s1  # move to temp
sltu $t1,$zero,$t1 
beqz $t1 , nooverflow
b overflow
negative:
move $t1, $s1  # move to temp
sll $t1,$t1,1
sltu $t1,$zero,$t1 
beqz $t1 , nooverflow
b overflow


overflow:
li $v0,4
la $a0, out_string_overflow
syscall
b exit

nooverflow:
li $v0,4
la $a0, out_string_nooverflow
syscall
b exit

exit:
li $v0,10
syscall

   
 

