sll $t0, $s3, 2    # t0 = i*4
add $t0, $s6, $t0  # t0 = A[0] + i*4
lw  $t0, 0($t0)    # t0 = A[i]
sll $t1, $s4, 2    # t1 = j*4
add $t1, $s6, $t1  # t1 = A[0] + j*4
lw  $t1, 0($t1)    # t1 = A[i]
add $t2, $t0, $t1  # t2 = A[i] + A[j]
sw  $t2	,32($s7)   # B[8] = t2