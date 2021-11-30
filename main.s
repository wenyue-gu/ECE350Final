# $r1 + 1 if correctly hits a mole
# set $rstatus=0 if no mole hit is detected 

nop
nop 
nop
nop
nop
nop 
nop
addi $r1, $r0, 0
addi $r30, $r0, 0
j1: bex j2
j j1
j2: add $r1, $r1, $r30
addi $r30, $r0, 0
j j1
