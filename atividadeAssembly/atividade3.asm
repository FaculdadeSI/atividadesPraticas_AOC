.data
msg_input: .asciiz "Digite um número: "
msg_perfect: .asciiz "O número é perfeito."
msg_not_perfect: .asciiz "O número não é perfeito."

.text
.globl main
main:
    # Prompt para o usuário digitar um número
    li $v0, 4
    la $a0, msg_input
    syscall
    
    # Lê o número digitado pelo usuário
    li $v0, 5
    syscall
    move $t0, $v0  # Armazena o número em $t0
    
    # Inicializa as variáveis
    li $t1, 1     # Inicia o contador em 1
    li $t2, 0     # Inicia a soma em 0
    
loop:
    # Verifica se $t1 é divisor de $t0
    div $t0, $t1
    mfhi $t3      # Resto da divisão
    beqz $t3, sum # Se resto = 0, $t1 é divisor
    
next:
    # Incrementa $t1
    addi $t1, $t1, 1
    blt $t1, $t0, loop  # Se $t1 < $t0, vai para o próximo loop
    
    # Verifica se a soma é igual ao número
    beq $t2, $t0, perfect
    j not_perfect

sum:
    # Soma o divisor na variável $t2
    add $t2, $t2, $t1
    j next

perfect:
    # Imprime a mensagem de número perfeito
    li $v0, 4
    la $a0, msg_perfect
    syscall
    j exit

not_perfect:
    # Imprime a mensagem de número não perfeito
    li $v0, 4
    la $a0, msg_not_perfect
    syscall

exit:
    # Encerra o programa
    li $v0, 10
    syscall
