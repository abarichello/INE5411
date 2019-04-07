# 2.31 - Translate to MIPS asm
# int fib(int n) {
#     if (n == 0) {
#         return 0;
#     } else if (n == 1) {
#         return 1;
#     } else {
#         return fib(n-1) + fib(n-2);
#     }
# }

# --- incomplete ---

main:
addi    $a0, $zero, 3
jal     fib
nop                         # breakpoint here to check result

fib:
addi    $sp,   $sp, -8      # push 2
sw      $a0, 4($sp)         # save n
sw      $ra, 0($sp)         # save ra
add     $v0, $zero, $zero   # return 0
bne     $a0, $zero, L0      # if n != 0 goto L0
addi    $sp, $sp, 8         # pop 2
jr      $ra

L0:
addi    $v0, $zero, 1       # return 1
bne     $a0, $v0, L1        # goto L1 if n != 1
addi    $sp, $sp, 8         # pop 2
jr      $ra

L1:
addi    $a0, $a0, -1        # t0 = n - 1
jal     fib                 # fib(n-1)
addi    $t0, $v0, 0         # t0 = fib(n-1)
lw      $a0, 4($sp)         # restore n
lw      $ra, 0($sp)         # restore ra
addi    $sp, $sp, 8         # pop 2
addi    $a0, $a0, -2        # n = n - 2
jal     fib                 # fib(n-2)
addi    $t1, $v0, 0         # t1 = fib(n+1)
add     $v0, $t0, $t1       # v0 = fib(n-1) + fib(n-2)
jr      $ra
