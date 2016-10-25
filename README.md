# t2Funcional

Objetivo: **Implementar o conceito de expressoes regulares em Haskell.**

  *Nao usar em momento algum funcoes recursivas na cauda!!!!*

Construtores:

  String vazia           == eps
  Literal                == char
  Escolha (ou)           == |+|
  Concatenacao           == |.|
  Iteracao (Kleene star) == star

Validacoes necessarias:

  1. Todos strings sobre {a,b} com no maximo 2 a's.
  2. Todos strings sobre {a,b} com exatamente 2 a's.
  3. Todos strings sobre {a,b} com nenhum caracter adjacente repetido.
      Ex.: aa,bb
  4. Todas constantes numericas fracionarias sobre {0-9} U {.}.
  5. Todos identificadores para tipos em Haskell.
  6. Identificadores validos em Java.

Entrega:
  - Relatorio cientifico com detalhes da implementacao. Computacoes detalhadas
    de alguns exemplos, como por exemplo das operacoes de concatenacao e iteracao.

  - Formatacao SBC

  - Sala de entrega: PDF e Codigo (.zip)
