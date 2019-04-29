.data
# Arranjo inicializado com elementos N não nulos. O valor de N é provido no relatório.
_array: .word 3:5                   # N palavras com o valor 3
_size:  .word 5                     # tamanho do arranjo

.text
.globl  main

main:
    jal     clear2
    li      $v0, 10	                # Exit syscall
    syscall

clear2:
    # inicialização dos parâmetros
    la      $a0, _array
    lw      $a1, _size
    # Prólogo do laço. Deve conter uma única instrução de inicialização de p.
    add     $t0, $a0, $zero         # copy p to t0
    sll     $t2, $a1, 2             # t2 = size * 4
    add     $t2, $a0, $t2           # t2 += array base

Loop2:                              # Teste, corpo e iteração do laço.
    slt     $t3, $t0, $t2           # t3 = 1 if p > array[size]
    beq     $t3, $zero, Exit        # if p >= &array[size] goto Exit
    sw      $zero, 0($t0)           # *p = 0
    addi    $t0, $t0, 4             # p = p + 1
    j       Loop2

Exit:                               # Epílogo do procedimento
    jr      $ra
