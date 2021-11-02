# Name: Rayan Bouamrane	
# ID: 260788250

	.data

intA:	.asciiz 		"Integer a: "
intB:	.asciiz 		"Integer b: "
intC:	.asciiz 		"Integer c: "
solStr:	.asciiz 		"Solution "
noSol:	.asciiz 		"No solutions exist.\n"
newL:	.asciiz 		"\n"
col: 	.asciiz			": "

	.text
	.globl main
		
main:	li $t0, 0		# counter variable initialized to 0
	
	li $v0, 4		# load "print string" code to $v0
	la $a0, intA		# string "Integer a:\n" loaded to $a0
	syscall			# string "Integer a:\n" printed 
	li $v0, 5		# load "read integer" code to $v0
	syscall			# user must type int into command line to be stored in $v0
	add $t1, $v0, $0 	# copy $v0 to $t1 as the register $v0 will be reused
	
	li $v0, 4 		# identical steps to load intB
	la $a0, intB
	syscall
	li $v0, 5
	syscall		
	add $t2, $v0, $0
	
	li $v0, 4		# identical steps to load intC
	la $a0, intC
	syscall
	li $v0, 5
	syscall		
	add $t3, $v0, $0
	
	li $v0, 4
	la $a0, newL 		# print new line
	syscall
	
	li $s0, 0		# initializing a boolean to 0, will be set to one when a solution is found
	li $s1, 0		# initializing a counter of number of solutions found to 0

	rem $s2, $t1, $t2	# load the value of 'a mod b' to $s2
	
L1:	bgt $t0, $t3, end	# jump to end if the count in $0 is bigger than c

	mul $t4, $t0, $t0	# x times x stored in $t4
	rem $t5, $t4, $t2	# x times x mod b stored in $t5
	bne $t5, $s2, J1	# if unequal, jump to J1
	li $s0, 1		# solution has been found, boolean set to 1
	addi $s1, $s1, 1	# number of solutions found incremented
	
	li $v0, 4
	la $a0, solStr 		# print solStr string
	syscall
	
	li $v0, 1		# load "print integer" code to $v0 
	la $a0, ($s1) 		# print solution counter
	syscall
	
	li $v0, 4
	la $a0, col		# print colon
	syscall
	
	li $v0, 1		
	la $a0, ($t0)		# print solution (the increment)
	syscall
	
	li $v0, 4
	la $a0, newL 		# print new line
	syscall
	
J1:	addi $t0, $t0, 1	# counter increments
	j L1			# jump to L1, continue looping
	
end:	bne $s0, $0, exit	# if boolean still equals 0, no solutions have been found, else exit
	li $v0, 4		
	la $a0, noSol		# print no solutions	
	syscall
	
exit:	nop			
