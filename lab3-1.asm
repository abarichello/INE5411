.data
_save: .word 6,6,1,6,6,2,7,6,5 # Estimulo 1.1
#_save: .word 6,6,6,6,6,6,6,6,6 # Estimulo 1.2
_k: .word 6
.text
.globl main

# i = 0;
# while (save[i] == k)
#   i += 1;

# i = $s3
# k = $s5
# save[0] = $s6

main: # inicialização
add $s3, $zero, $zero   # i = 0;
la $s6, _save
lw $s5, _k

Loop: # corpo do laço
sll $t1, $s3, 2
add $t1, $t1, $s6
lw $t0, 0($t1)
bne $t0, $s5, Exit
addi $s3, $s3, 1
j Loop

Exit: # rotina para imprimir inteiro no console
addi $v0, $zero, 1
add $a0, $zero, $s3
syscall
