.data
_v: .word 9,8,7,6,5,4,3,2,1,-1
_n: .word 10

.text
.globl  main

main:
la      $a0,_v
lw      $a1,_n
jal     sort
li      $v0, 10               # Exit syscall
syscall

# procedure sort
sort:
# preservação de registradores armazenando seus conteúdos na pilha
addi    $sp, $sp, -12         # push 4
sw      $ra, 8($sp)           # push ra
sw      $s1, 4($sp)           # push s1
sw      $s0, 0($sp)           # push s0 (i)
move    $s0, $zero            # i = 0 (s0)

for1tst:                      # início do corpo do laço externo
nop                           # MARCA 1
slt     $t0, $s0, $a1         # t0 = i < n
beq     $t0, $zero, exit1     # if not t0 goto exit1
addi    $s1, $s0, -1          # s1 = i-1

for2tst:                      # inicio do corpo do laço interno
slti    $t0, $s1, 0           # t0 = s1 < 0
bne     $t0, $zero, exit2     # if t0 != 0 goto exit2
sll     $t1, $s1, 2           #
add     $t2, $a0, $t1
lw      $t3, 0($t2)
lw      $t4, 4($t2)
slt     $t0, $t4, $t3
beq     $t0, $zero, exit2
nop                           # MARCA 2
jal     swap 	              # chamada de swap
addi    $s1, $s1, -1
j       for2tst

exit2:                        # fim do corpo do laço interno
addi    $s0, $s0, 1
j       for1tst

exit1:                        # fim do corpo do laço externo
# restauração de conteúdos de registradores preservados na pilha
lw      $s0, 0($sp)
lw      $s1, 4($sp)
lw      $ra, 8($sp)
addi    $sp, $sp, 12
jr      $ra

# codificação da procedure swap
swap:
sll     $t0, $a1, 2           # t0 = k*4
add     $t0, $t0, $a0         # t0 = base + t0
lw      $t1, 0($t0)           # t1 = v[k]
lw      $t2, 4($t0)           # t2 = v[k+1]
sw      $t2, 0($t0)           # v[k] = v[k+1]
sw      $t1, 4($t0)           # v[k+1] = v[k]
jr      $ra
