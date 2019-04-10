retry:
addi    $t0, $zero, 1       # copy locked value
ll      $t1, 0($s1)         # load linked
sc      $t0, 0($s1)         # store conditional
beq     $t0, $zero, again   # retry if store fails
add     $s4, $zero, $t1     # put load linked value in s4 when it succeeds
