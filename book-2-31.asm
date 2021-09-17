.text			# Define o início do Text Segment
.globl main		# Define o início do código do usuário
main:
addi  $a0, $a0, 3
jal   fib
nop

fib:
bne   $a0, $0, R0
addi  $v0, $0, 0
jr    $ra

R0:
slti  $t0, $a0, 2
beq   $t0, $0, Else
addi  $v0, $0, 1
jr    $ra

Else:
addi  $sp, $sp, -8
sw    $a0, 0($sp)
sw    $ra, 4($sp)
addi  $a0, $a0, -1
jal   fib
lw    $a0, 0($sp)
lw    $ra, 4($sp)
move  $t1, $v0

addi  $sp, $sp, -8
sw    $a0, 0($sp)
sw    $ra, 4($sp)
addi  $a0, $a0, -2
jal   fib
lw    $a0, 0($sp)
lw    $ra, 4($sp)
addi  $sp, $sp, 8
add   $v0, $t1, $v0
jr    $ra
