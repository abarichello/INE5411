# int fact(int n) {
#     if (n < 1) {
#         return 1;
#     } else {
#         return (n * fact(n - 1));
#     }
# }

main:
addi $a0, $zero, 3
jal  fact
nop                     # breakpoint here to check result

fact:
addi $sp, $sp, -8       # push 2
sw   $ra, 4($sp)        # push ra
sw   $a0, 0($sp)        # push n
slti $t0, $a0, 1        # test for n < 1
beq  $t0, $zero, L1     # goto L1 if n >= 1
addi $v0, $zero, 1      # return 1 (else)
addi $sp, $sp, 8        # pop 2
jr   $ra                # return

L1:                     # n >= 1
addi $a0, $a0, -1       # t0 = n - 1
jal  fact               # call fact with n - 1
lw   $ra, 4($sp)        # restore ra
lw   $a0, 0($sp)        # restore n from stack
addi $sp, $sp, 8        # pop 2
mul  $v0, $a0, $v0      # v0 = n * fact(n - 1)
jr   $ra                # return
