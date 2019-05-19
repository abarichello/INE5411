## Exception Handler ##
# Interrupt: Excode = 0
# Overflow: ExCode = 12
# Status  $12
# Cause   $13
# EPC     $14

.kdata 0x90000000
# Espa�o para salvamento de contexto:
_save: .word 0,0,0,0

# Espa�o para salvamento do valor que est� sendo digitado:
_temp: .word 0
_size: .word 0

.ktext 0x80000180	# Reloca o tratador para residir no endere�o emitido pelo HW
# -------------------------------------------------------------------------------------------------
# Etapa 1: Salvamento de contexto em mem�ria (pilha n�o pode ser usada)
lui     $k0, 0x9000
sw      $ra, 0($k0)
sw      $at, 4($k0)
sw      $t0, 8($k0)
sw      $t1, 12($k0)

# -------------------------------------------------------------------------------------------------
# Etapa 2: Decodifica��o do registrador Cause
# <Completar> Isole o c�digo ExcCode do registrador Cause para identificar a causa da exce��o.
# 	      Armazene este c�digo no registrado $k0.
mfc0    $k0, $13        # k0 = cause register
srl     $k0, $k0, 2     # Extract ExCode
andi    $k0, $k0, 0x1F

# -------------------------------------------------------------------------------------------------
# Etapa 3: Tratamento de Interrup��o - Leitura de caracteres
# <Completar> Caso o c�digo seja de interrup��o, o tratador chama o procedimento "lechar" e pula
#             para "done". Sen�o o tratador pula para a etapa seguinte "overflow".
bnez    $k0, overflow   # if != 0 (interruption), goto overflow
jal     lechar
j       done

# -------------------------------------------------------------------------------------------------
# Etapa 4: Tratamento de overflow
# <Completar> Caso o c�digo seja de overflow, o tratador deve, ao final de sua execu��o
#            (Etapa 7), reiniciar o programa.
overflow:
bne     $k0, 12, done   # if != 12 (not overflow) goto done
la      $t0, main
mtc0    $t0, $14        # EPC = addr main

# ------------------------------------------------------------------------------------------
# Etapa 5: Prepara��o do sistema para novas exce��es
# <Completar> Limpe o registrador Cause e habilite novas interrup��es no registrador Status
done:
mtc0    $zero, $13      # clear cause
mfc0    $k0, $12        # read status
ori     $k0, $k0, 0x1   # set Interrupt Enable bit
mtc0    $k0, $12        # update status

# ------------------------------------------------------------------------------------------
# Etapa 6: Restaura��o de contexto
lui $k0, 0x9000
lw  $ra, 0($k0)
lw  $at, 4($k0)
lw  $t0, 8($k0)
lw  $t1, 12($k0)

# -------------------------------------------------------------------------------------------------
# Etapa 7: Retorno ao fluxo normal de execu��o
eret              # retorna para o endere�o indicado em EPC

# Fun��o para leitura de caractere
lechar:
	#1# Ler o valor digitador no teclado da mem�ria
	lui $k0, 0xFFFF
	lw  $k0, 4($k0)
	#2# Caso o valor for ENTER (ASCII 0xA)
	li  $k1, 0x0A
	bne $k0, $k1, cont
	# - Checar se algum n�mero foi digitado
	la  $k1, _temp
	lw  $t1, 4($k1)
	beq $t1, $zero, erro
	# - Ler e resetar os valores {_temp, _size}
	lw  $t0, 0($k1)
	sw  $zero, 0($k1)
	sw  $zero, 4($k1)
	# - Gravar {_temp, _size} -> {_argumento, _entrada}
	la  $k1, _argumento
	sw  $t0, 0($k1)
	sw  $t1, 4($k1)
	j end
cont:
	#3# Caso contr�rio combine o valor lido com o armazenado em "_temp"
	addi $k0, $k0, -0x30    # Subtrai 0x30, convertendo ASCII para inteiro
	# Marca 1
	sltiu $k1, $k0, 10
	beq $k1, $zero, erro
	la  $k1, _temp    # - Se o valor for num�rico (de 0 a 9), l� o valor armazenado em
	lw  $t0, 0($k1)   #   "_temp", multiplica por 10, e soma ao valor digitado.
	li  $t1, 10       #   Isso � feito para "construir" o n�mero a partir dos valores digitados.
	mult $t0, $t1
	mflo $t0
	add $t0, $t0, $k0
	sw  $t0, 0($k1)
	# Marca 2
	addi $k0, $k0, 0x30   # Adiciona 0x30, convertendo inteiro para ASCII
	#4# E atualize _size
	lw  $t0, 4($k1)
	addiu $t0, $t0, 1
	sw  $t0, 4($k1)
	j end
erro:
	#5# Em caso de erro preparar para imprimir "e" no display
	la $k1, _temp
	sw $zero, 0($k1)
	sw $zero, 4($k1)
	li $k0, 0x65
end:
	#5# Imprimir $k0 no display e retornar
	lui $k1, 0xFFFF
	sw  $k0, 0x0C($k1)
	jr $ra
