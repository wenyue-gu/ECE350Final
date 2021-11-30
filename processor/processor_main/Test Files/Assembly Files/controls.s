nop 				# Advanced Control Test with Bypassing
nop 				# Values initialized using addi (positive only)
nop 				# Registers 10,11 track correct and 20,21 track incorrect
nop 				# Values in the first two tests be updated if the number of lines is modified
nop 				# Author: Nathaniel Brooke
nop
nop
nop 				    # Test Bypassing into JR
addi $r31, $r0, 12		# r31 = 12
nop				        # Avoid RAW hazard for jr
addi $r31, $r0, 16		# r31 = 16 (with RAW hazard)
jr $r31     			# PC = r31 = 16
addi $r20, $r20, 1		# r20 += 1 (Incorrect)
addi $r20, $r20, 1		# r20 += 1 (Incorrect)
addi $r20, $r20, 1		# r20 += 1 (Incorrect)
addi $r20, $r20, 1		# r20 += 1 (Incorrect)
addi $r10, $r10, 1		# r10 += 1 (Correct)
add $r11, $r10, $r11		# Accumulate r10 score
add $r21, $r20, $r21		# Accumulate r20 score
and $r10, $r0, $r10		# r10 should be 1
and $r20, $r0, $r20		# r20 should be 0
nop
nop 				# Test JAL into JR
addi $r31, $r0, 32		# r31 = 32
nop				# Avoid RAW hazard for jr
jal j1				# jal to jr (with RAW hazard)
nop				# Spacer
nop				# Spacer
j end1				# Jump to test cleanup
nop				# Spacer
nop				# Spacer
j1: jr $r31 			# jr immediately after jal
addi $r20, $r20, 1		# r20 += 1 (Incorrect)
addi $r20, $r20, 1		# r20 += 1 (Incorrect)
end1: nop			# Landing pad for jump
add $r11, $r10, $r11		# Accumulate r10 score
add $r21, $r20, $r21		# Accumulate r20 score
and $r10, $r0, $r10		# r10 should be 0
and $r20, $r0, $r20		# r20 should be 0
nop
nop 				# Test Bypassing into Branch (with loops)

addi $r1, $r0, 5		# r1 = 5
b1: addi $r2, $r2, 1		# r2 += 1
blt $r2, $r1, b1		# if r2 < r1 take branch (5 times)
b2: addi $r1, $r1, 1		# r1 += 1
