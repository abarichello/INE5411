# Estímulos?: v[] = [9, 8, 7, 6, 5, 4, 3, 2, 1,-1] e k = 2
.data
_v: .word 9,8,7,6,5,4,3,2,1,-1
_k: .word 2

.text
.globl main

main:
la      $a0, _v
lw      $a1, _k
jal     swap
li      $v0, 10
syscall

swap:
sll     $t0, $a1, 2     # t0 = k*4
add     $t0, $t0, $a0   # t0 = base + t0
lw      $t1, 0($t0)     # t1 = v[k]
lw      $t2, 4($t0)     # t2 = v[k+1]
sw      $t2, 0($t0)     # v[k] = v[k+1]
sw      $t1, 4($t0)     # v[k+1] = v[k]
jr      $ra
