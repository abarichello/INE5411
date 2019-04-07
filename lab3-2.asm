.data
_save: .word 6,6,6,6,6,6,6,6,6 # Trocar para Estimulo 2.1
#_save: .word 6,6,6,6,6,6,6,6,6 # Estimulo 2.2
_k: .word 6
_error: .asciiz "Index Out of Bounds Exception"
.text
.globl main

# i = 0;
# while (save[i] == k)
#   i += 1;

# i = $s3
# k = $s5
# save[0] = $s6
# size = $t2

main: # inicialização
add $s3, $zero, $zero   # i = 0;
la $s6, _save
lw $s5, _k
lw $t2, 4($s6)

Loop: # corpo do laço
sltu $t1, $s3, $t2
beq $t1, $zero, IndexOutOfBounds

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
j End

IndexOutOfBounds: # rotina para imprimir mensagem de erro no console
addi $v0, $zero, 4
la $a0, _error
syscall
End:
