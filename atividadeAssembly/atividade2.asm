.data
prompt_input: .asciiz "Digite o valor da compra: "
output_message: .asciiz "Quantidade de notas utilizadas:"
note_10_message: .asciiz "\nNotas de 10: "
note_5_message: .asciiz "\nNotas de 5: "
note_1_message: .asciiz "\nNotas de 1: "

.text
main:
  # Definindo constantes para a quantidade de notas disponíveis
  li $t1, 10      # Quantidade de notas de 10
  li $t2, 10      # Quantidade de notas de 5
  li $t3, 10      # Quantidade de notas de 1

  # Solicitar ao usuário o valor da compra
  li $v0, 4
  la $a0, prompt_input
  syscall

  # Ler o valor da compra
  li $v0, 5
  syscall
  move $t0, $v0    # Armazenar o valor da compra em $t0

  # Calculando o mínimo de notas necessárias
  li $t4, 0       # Registrador para contar o número total de notas

  check_ten:
    blez $t1, check_five  # Verificar se há notas de 10 disponíveis
    li $t5, 10     # Valor da nota de 10
    div $t0, $t5    # Divide o valor da compra pelo valor da nota de 10
    mflo $t6       # Move o quociente para $t6
    blez $t6, check_five  # Verificar se o quociente é menor ou igual a zero
    move $t1, $t6    # Atualiza a quantidade de notas de 10 disponíveis com o quociente
    mul $t6, $t6, $t5    # Multiplica o quociente pelo valor da nota de 10
    sub $t0, $t0, $t6   # Subtrai o valor das notas de 10 do total da compra
    add $t4, $t4, $t6   # Incrementa o contador de notas
    j check_ten

  check_five:
    blez $t2, check_one  # Verificar se há notas de 5 disponíveis
    li $t5, 5      # Valor da nota de 5
    div $t0, $t5    # Divide o valor da compra pelo valor da nota de 5
    mflo $t6       # Move o quociente para $t6
    blez $t6, check_one  # Verificar se o quociente é menor ou igual a zero
    move $t2, $t6    # Atualiza a quantidade de notas de 5 disponíveis com o quociente
    mul $t6, $t6, $t5    # Multiplica o quociente pelo valor da nota de 5
    sub $t0, $t0, $t6   # Subtrai o valor das notas de 5 do total da compra
    add $t4, $t4, $t6   # Incrementa o contador de notas
    j check_five

  check_one:
    blez $t3, print_result  # Verificar se há notas de 1 disponíveis
    li $t5, 1      # Valor da nota de 1
    div $t0, $t5    # Divide o valor da compra pelo valor da nota de 1
    mflo $t6       # Move o quociente para $t6
    blez $t6, print_result  # Verificar se o quociente é menor ou igual a zero
    move $t3, $t6    # Atualiza a quantidade de notas de 1 disponíveis com o quociente
    mul $t6, $t6, $t5    # Multiplica o quociente pelo valor da nota de 1
    sub $t0, $t0, $t6   # Subtrai o valor das notas de 1 do total da compra
    add $t4, $t4, $t6   # Incrementa o contador de notas
    j check_one

print_result:
  # O valor da compra foi totalmente pago
  # O resultado final estará em $t4 (contador de notas)

  # Exibir a mensagem de resultado
  li $v0, 4
  la $a0, output_message
  syscall

  # Exibir a quantidade de notas de 10
  li $v0, 4
  la $a0, note_10_message
  syscall

  # Exibir a quantidade de notas de 10 utilizadas
  move $a0, $t1
  li $v0, 1
  syscall

  # Exibir a quantidade de notas de 5
  li $v0, 4
  la $a0, note_5_message
  syscall

  # Exibir a quantidade de notas de 5 utilizadas
  move $a0, $t2
  li $v0, 1
  syscall

  # Exibir a quantidade de notas de 1
  li $v0, 4
  la $a0, note_1_message
  syscall

  # Exibir a quantidade de notas de 1 utilizadas
  move $a0, $t3
  li $v0, 1
  syscall

  # Encerrar o programa
  li $v0, 10
  syscall
