.data
_v: .word 9,8,7,6,5,4,3,2,1,-1
_n: .word 10

.text
.globl  main

main:
la      $a0, _v
lw      $a1, _n
addi    $s3, $zero, 2019
jal     sort                  # marca 3
addi    $t1, $s3, 1           # marca 4
li      $v0, 10               # Exit syscall
syscall

# procedure sort
sort:
addi    $sp, $sp, -12         # push 4
sw      $ra, 8($sp)           # push ra
sw      $s1, 4($sp)           # push s1
sw      $s0, 0($sp)           # push s0 (i)
move    $s3, $a1
move    $s0, $zero            # MARCA 0 // inicialização da variavel i

for1tst:                      # início do corpo do laço externo
nop                           # MARCA 1
slt     $t0, $s0, $s3         # t0 = i < n
beq     $t0, $zero, exit1     # if not t0 goto exit1
addi    $s1, $s0, -1          # s1 = i-1

for2tst:                      # inicio do corpo do laço interno
slti    $t0, $s1, 0           # t0 = j < 0
bne     $t0, $zero, exit2     # if j < 0 goto exit2
sll     $t1, $s1, 2           # j = s1 * 4
add     $t2, $a0, $t1         # t2 = *v[j]
lw      $t3, 0($t2)           # t3 = v[j]
lw      $t4, 4($t2)           # t4 = v[j+1]
slt     $t0, $t4, $t3         # t0 = v[j+1] < v[j]
beq     $t0, $zero, exit2     # if (v[j+1] > v[j]) goto exit2
move    $a1, $s1
nop                           # MARCA 2
jal     swap                  # chamada de swap
addi    $s1, $s1, -1          # j -= 1
j       for2tst               # fim do corpo do laço interno

exit2:
addi    $s0, $s0, 1           # i += 1
j       for1tst

exit1:                        # fim do corpo do laço externo
lw      $s0, 0($sp)
lw      $s1, 4($sp)
lw      $ra, 8($sp)
addi    $sp, $sp, 12
jr      $ra

# codificação da procedure swap
swap:
sll     $t1, $a1, 2           # reg $t1=k+4
add     $t1, $a0, $t1         # reg $t1=v+(k*4)
lw      $t0, 0($t1)           # reg $t0 (temp)  =v[k]
lw      $t2, 4($t1)           # reg $t2 = v[k+1]
sw      $t2, 0($t1)           # v[k] = reg $t2
sw      $t0, 4($t1)           # v[k+1] = reg $t0 temp
jr      $ra                   # retorna para a rotina chamadora
