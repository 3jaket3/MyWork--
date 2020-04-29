.data
# the next two lines define a array (mdArray as a 2x2 miltidimensional array)
mdArray:	.word 2,5,4
	        .word 3,7,8
   		.word 6,9,2
   		       	.word 2,0,4
   		        .word,7,9,0
   		        .word 4,5,6
   		               .word 2,7,4
   		               .word 8,9,1
   		               .word 7,3,2
		
size: .word 3 #dimension of the array (2x2 in this case, note this is only for square martrices)

.eqv DATA_SIZE 4 # number of bytes per element, 4 for ints, 1 for chars, 8 for doubles
.eqv PAGE_SIZE 36 # = size*size*data_size
.text 
main: 
la $a0 mdArray # base address
lw $a1, size  # size
jal sumDiagonal # sum of diagonals, in our example, this is 13

move $a0, $v0 # this is because sumDiagonal will return its last value in $v0
li $v0, 1
syscall

#and done
li $v0, 10
syscall

sumDiagonal:

li $v0,0 #sum = 0
li $t0,0 #t0 as the index
li $t1,0 #address
li $t2,0
	sumLoop:
		
		mul $t1, $t0 ,$a1
		add $t1, $t1,$t0
		mul $t1, $t1,DATA_SIZE
		mul $t2,$t0,PAGE_SIZE
		add $t1, $t1, $t2
		add $t1,$t1,$a0
		
		lw $t3, ($t1) # getting element
		add $v0,$v0,$t3
                addi $t0,$t0,1
		blt $t0,$a1,sumLoop
		
jr $ra #ends sum diagonal