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
addi    $sp, $sp, -12       # push 2
sw      $ra, 8($sp)         # save ra
sw      $s0, 4($sp)         # save s0
sw      $a0, 0($sp)         # save a0
bgt     $a0, $zero, test2   # if n > 0 test if n == 1
addi    $v0, $zero, 0       # return 0
j       rtn

test2:
addi    $t0, $zero, 1       # flag 1
bne     $t0, $a0, gen       # if n > 1 gen
add     $v0, $zero, $t0     # fib(1) = 1
j       rtn

gen:
addi    $a0, $a0, -1        # t0 = n - 1
jal     fib                 # fib(n-1)
add     $s0, $v0, $zero     # s0 = fib(n-1)
sub     $a0, $a0, 1         # a0 = n-2
jal     fib                 # fib(n-2)
add     $v0, $v0, $s0       # v0 = fib(n-1) + fib(n-2)

rtn:
lw      $ra, 8($sp)         # save ra
lw      $s0, 4($sp)         # save s0
lw      $a0, 0($sp)         # save a0
addi    $sp, $sp, 12        # pop 3
jr      $ra
