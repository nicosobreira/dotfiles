# Estrutura de Dados e Algoritmos

## O que são algorítimos?

É o meio termo entre input e output, **transforma** um em outro.

## Big O notation

Esse notação busca obter uma **expressão matemática** para avaliar o tempo de execução de um algoritmo, de forma a não depender do computador e das configuração do programa sendo executado. Para obter essa expressão o autor do livro utiliza algumas "regras", que são: a quantidade de dados do algoritmo tem que ser **grande**; e constantes aditivas ou multiplicativas devem ser **desconsideradas** (log (n) + 3 --> log (n)).
A expressão final é dada em função do *input* do algorítimo.

### Passos

O passo de um algorítimo é um número fixo de operações básicas - como algébricas e condicionais, com o tempo de execução sendo constante.

#### Exemplo 1

``` c
int func(int n[10]) {
    for (int i = 0; i < 10; i++) {
        for (int j = 0; j < 10; j++) {
            if (n[i] == n[j])
                return n[i]
        }
    }
    return 0
}
```

O [exemplo 1](#exemplo-1) possui $$10^2$$ passos, sendo o `for loops` e `if statment` as **operações básicas**. Nesse exemplo a **operação dominante** é o `if 
statment`, na quarta linha, que "roda" por $$10^2$$, ou generalizando $$n^2$$.

## Exercícios

1.1. Certo
1.2.
    i - verdadeiro
    ii - falso, o vetor (ou array) precisa ter um tamanho `n`
1.3. ??
1.4

