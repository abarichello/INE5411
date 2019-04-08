# int f(int a, int b, int c, int d) {
#     return func(func(a+b), c+d);
# }

# func = int f(int a, int b);


main:
addi    $a0, $zero, 3
jal     func
nop                         # breakpoint here to check result

f:
addi    $sp, $sp, -20       # push 4
sw      $ra, 16($sp)        # save ra
sw      $a0, 12($sp)        # save ao = a
sw      $a1, 8($sp)         # save a1 = b
sw      $a2, 4($sp)         # save a2 = c
sw      $a3, 0($sp)         # save a3 = d
jal     func                # func(a,b)
add     $a0, $v0, $zero     # copy func(a,b) to a0
add     $a1, $a2, $a3       # a1 = c+d
jal     func                # func(func(a,b), c+d)

ret:
lw      $ra, 16($sp)        # pop ra
lw      $a0, 12($sp)        # pop ao = a
lw      $a1, 8($sp)         # pop a1 = b
lw      $a2, 4($sp)         # pop a2 = c
lw      $a3, 0($sp)         # pop a3 = d
addi    $sp, $sp, 20        # pop 4
jr      $ra	                # jump to $ra

func:
nop
