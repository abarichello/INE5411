# func(func(a+c,b),d)

addi    $sp, $sp, -8
sw      $ra,4($sp)
sw      $a3,0($sp)
add     $a0, $a0,$a2
jal     func
add     $a0, $v0, $zero
lw      $a1, 0($sp)
jal     func
lw      $ra, 4($sp)
addi    $sp,$sp,8
jr      $ra
