.data
    prompt1: .asciiz "\nDigite a idade do primeiro homem: "
    prompt2: .asciiz "Digite a idade do segundo homem: "
    prompt3: .asciiz "Digite a idade da primeira mulher: "
    prompt4: .asciiz "Digite a idade da segunda mulher: "
    result1: .asciiz "\nA soma das idades do homem mais velho com a mulher mais nova: "
    result2: .asciiz "O produto das idades do homem mais novo com a mulher mais velha: "
    newline: .asciiz "\n"

.text
.globl main

main:
    # Imprimir prompt para a idade do primeiro homem
    li $v0, 4
    la $a0, prompt1
    syscall

    # Ler idade do primeiro homem
    li $v0, 5
    syscall
    move $t0, $v0 # $t0 = idade primeiro homem

    # Imprimir prompt para a idade do segundo homem
    li $v0, 4
    la $a0, prompt2
    syscall

    # Ler idade do segundo homem
    li $v0, 5
    syscall
    move $t1, $v0 # $t1 = idade segundo homem

    # Imprimir prompt para a idade da primeira mulher
    li $v0, 4
    la $a0, prompt3
    syscall

    # Ler idade da primeira mulher
    li $v0, 5
    syscall
    move $t2, $v0 # $t2 = idade primeira mulher

    # Imprimir prompt para a idade da segunda mulher
    li $v0, 4
    la $a0, prompt4
    syscall

    # Ler idade da segunda mulher
    li $v0, 5
    syscall
    move $t3, $v0 # $t3 = idade segunda mulher

    # Encontrar o homem mais velho
    blt $t0, $t1, mulher_mais_nova # se idade primeiro homem < idade segundo homem, a primeira mulher é mais nova
    move $t4, $t0 # $t4 = idade homem mais velho
    move $t5, $t1 # $t5 = idade homem mais novo
    b mulher_mais_velha

mulher_mais_nova:
    move $t4, $t1 # $t4 = idade homem mais velho
    move $t5, $t0 # $t5 = idade homem mais novo

mulher_mais_velha:
    # Calcular resultados
    # Soma das idades do homem mais velho com a mulher mais nova
    add $t6, $t4, $t2 # $t6 = soma das idades

    # Produto das idades do homem mais novo com a mulher mais velha
    mul $t7, $t5, $t3 # $t7 = produto das idades

    # Imprimir resultado da soma
    li $v0, 4
    la $a0, result1
    syscall

    li $v0, 1
    move $a0, $t6
    syscall

    # Imprimir resultado do produto
    li $v0, 4
    la $a0, result2
    syscall

    li $v0, 1
    move $a0, $t7
    syscall

    # Pular linha
    li $v0, 4
    la $a0, newline
    syscall

    # Terminar programa
    li $v0, 10
    syscall
