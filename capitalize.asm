# This program illustrates an exercise of capitalizing a string.
# The test string is hardcoded. The program should capitalize the input string
# Comment your work

# Name: Rayan Bouamrane
# ID: 260788250

	.data

inputstring: 	.asciiz 	"I am somehow a student at McGill University "
outputstring:	.space 127     # "The program should be able to handle strings up to 127 characters in length"
newL:		.asciiz		"\n"

	.text
	.globl main

main:	li $v0, 4		# load "print string" code to $v0
	la $a0, inputstring	# inputstring loaded into $a0
	syscall			# print string
	
	la $a1, outputstring	# outputstring loaded into $a1
	
L1:	lb $t0, 0($a0)		# $t0 stores current address pointer
	beq $t0, 0, end		# checks if the current character = '/0' , jump to end if this is the case
	slti $t2, $t0, 123	# checks the current character is less than 123, anything below 'z'
	beq $t2, 0, Incr	# if false, character is not a letter and shouldn't be altered, jump to Incr
	slti $t2, $t0, 97	# checks the current character is less than 97, anything below 'A'
				# note: assignment states we can assume alphabetic characters, no need to check ASCII 91-96
	bne $t2, 0, Incr       # if true, i.e. $t0 is less than 97, character is capitalized or not a letter and shouldn't be altered, jump to Incr
	subi $t0, $t0, 32	# if we reach this line, character lies between 97 and 123, it is a lowercase letter,
				# the ASCII is increased by 32, capitalizing it
	
Incr:	sb $t0, 0($a1)		# stores the changed chararcter
	addi $a0, $a0, 1	# increment pointer
	addi $a1, $a1, 1	
	j L1			

end:	li $v0, 4
	la $a0, newL 		# print new line
	syscall

	li $v0, 4		
	la $a0, outputstring	# print outputstring
	syscall
