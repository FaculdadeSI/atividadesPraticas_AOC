.data
prompt: .asciiz "Digite o CPF (somente números): "
success_msg: .asciiz "\nCPF válido! Você pode realizar compras fiadas.\n"
failure_msg: .asciiz "\nCPF inválido! Você não pode realizar compras fiadas.\n"

.text
.globl main

main:
  # Imprimir o prompt para digitar o CPF
  li $v0, 4
  la $a0, prompt
  syscall

  # Ler o CPF digitado pelo usuário (como uma sequência de 11 dígitos)
  li $v0, 8  # Syscall 8 para ler uma string (CPF)
  la $a0, buffer
  li $a1, 12  # Lê até 12 caracteres (11 dígitos + caractere nulo)
  syscall

  # Calcular o primeiro dígito verificador (PRIMEIRO)
  li $t1, 0       # Inicializar soma com 0
  li $t2, 2       # Inicializar multiplicador com 2
  li $t3, 9       # Inicializar contador para número de dígitos do CPF
  move $t0, $a0   # Endereço da string CPF

loop_primeiro:
    lb $t4, 0($t0)  # Carregar o caractere da string
    beqz $t4, loop_primeiro_calc  # Se for o caractere nulo (\0), calcular o dígito verificador
    sub $t4, $t4, 48  # Converter de caractere para inteiro (ASCII)
    mul $t4, $t4, $t2  # Multiplicar o dígito pelo multiplicador
    add $t1, $t1, $t4  # Somar à soma total
    addi $t0, $t0, 1   # Avançar para o próximo caractere
    addi $t2, $t2, 1   # Incrementar o multiplicador
    addi $t3, $t3, -1  # Decrementar o contador de dígitos
    j loop_primeiro

loop_primeiro_calc:
    # Calcular o resto da divisão da soma total por 11
    li $t4, 11
    rem $t1, $t1, $t4

    # Verificar se o primeiro dígito verificador está correto
    bnez $t1, primeiro_nao_zero  # Se resto != 0, o dígito é 11 - resto
    li $t5, 0  # O dígito é 0
    j primeiro_valido

primeiro_nao_zero:
    sub $t5, $t4, $t1  # O dígito é 11 - resto

primeiro_valido:
    # Comparar o primeiro dígito verificador com o dígito informado pelo usuário
    lb $t6, 9($t0)  # Carregar o primeiro dígito verificador do CPF
    bne $t5, $t6, cpf_invalid

  # Calcular o segundo dígito verificador (SEGUNDO)
  li $t1, 0       # Inicializar soma com 0
  li $t2, 2       # Inicializar multiplicador com 2
  li $t3, 10      # Inicializar contador para número de dígitos do CPF
  move $t0, $a0   # Endereço da string CPF

loop_segundo:
    lb $t4, 0($t0)  # Carregar o caractere da string
    beqz $t4, loop_segundo_calc  # Se for o caractere nulo (\0), calcular o dígito verificador
    sub $t4, $t4, 48  # Converter de caractere para inteiro (ASCII)
    mul $t4, $t4, $t2  # Multiplicar o dígito pelo multiplicador
    add $t1, $t1, $t4  # Somar à soma total
    addi $t0, $t0, 1   # Avançar para o próximo caractere
    addi $t2, $t2, 1   # Incrementar o multiplicador
    addi $t3, $t3, -1  # Decrementar o contador de dígitos
    j loop_segundo

loop_segundo_calc:
    # Calcular o resto da divisão da soma total por 11
    li $t4, 11
    rem $t1, $t1, $t4

    # Verificar se o segundo dígito verificador está correto
    bnez $t1, segundo_nao_zero  # Se resto != 0, o dígito é 11 - resto
    li $t5, 0  # O dígito é 0
    j segundo_valido

segundo_nao_zero:
    sub $t5, $t4, $t1  # O dígito é 11 - resto

segundo_valido:
    # Comparar o segundo dígito verificador com o dígito informado pelo usuário
    lb $t6, 10($t0)  # Carregar o segundo dígito verificador do CPF
    bne $t5, $t6, cpf_invalid

cpf_valid:
  # Se chegou aqui, o CPF é válido
  li $v0, 4
  la $a0, success_msg
  syscall
  j exit_program

cpf_invalid:
  # Imprimir mensagem de CPF inválido
  li $v0, 4
  la $a0, failure_msg
  syscall

exit_program:
  # Encerrar o programa
  li $v0, 10
  syscall

.data
buffer: .space 12
