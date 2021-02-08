.text			# Define o início do Text Segment
.globl main		# Define o início do código do usuário
main:			# Label que define o início do código do usuário
add $s0, $zero, $gp	# Copia o valor de $gp no registrador $s0
lbu $t0, 0($s0)		# Copia o byte da posição de memória [$s0 + 0] para $t0
sb $t1, 1($s0)		# Copia byte menos significativo de $t1 para posição de memória [$s0 + 1]
