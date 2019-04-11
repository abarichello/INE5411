# lock(lk);
# shvar = max(shvar, x);
# unlock(lk);

# lk = $a0
# shvar = $a1
# x = $a2

addi    $t1, $zero, 1       # t1 = 1
ll      $t0, 0($t0)         # ll into $t0
sc      $t1, 0($a0)         # sc into $t1
bne     $t0, $zero, trylock # if locked, try again
beq     $t1, $zero, trylock # if sc failed, try again
lw      $t2, 0($a1)         # t2 = shvar
slt     $t3, $t2, $a2       # t3 = 1 if shvar < x
bne     $t3, $zero, skip    # if shvar < x goto skip
sw      $a2, 0($a1)         # shvar = x
skip:
sw      $zero, 0($a0)       # store 0 in lk
