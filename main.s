# $r1 + 1 if correctly hits a mole
# set $rstatus=0 if no mole hit is detected 

j1: bex j2
nop
nop
j j1
j2: add $r1, $r1, $r30
nop
nop
addi $r30, $r0, 0
nop
nop
j j1
