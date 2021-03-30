.data
# Arranjo inicializado com elementos N não nulos. O valor de N é provido no relatório.
_array: .byte 3:5                   # N bytes com o valor 3
_size:  .word 5                     # tamanho do arranjo

.text
.globl  main

main:
    la      $a0, _array
    lw      $a1, _size
    jal     clear1
    li      $v0, 10                 # Exit syscall
    syscall

clear1:
    # inicialização dos parâmetros
    # Prólogo do laço. Deve conter uma única instrução de inicialização do índice.
    add     $t0, $zero, $zero       # i = 0

Loop1:                              # Teste, corpo e iteração do laço.
    slt     $t3, $t0, $a1           # t3 = 1 if i < _size
    beq     $t3, $zero, Exit        # if i >= _size goto Exit
    sll     $t1, $t0, 0             # t1 = i * 1
    add     $t2, $a0, $t1           # t2 = base of array + offset
    sb      $zero, 0($t2)           # array[i] = 0
    addi    $t0, $t0, 1             # i++
    j       Loop1

Exit:                               # Epílogo do procedimento
    jr      $ra
