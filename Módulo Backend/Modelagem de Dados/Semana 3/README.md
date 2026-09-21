# Sprint 3 — Do Conceito à Tabela

## Normalização até 3FN

### Por que 3FN?

A Terceira Forma Normal reduz a repetição de dados e evita inconsistências durante inserções, alterações e exclusões. Assim, cada informação é armazenada uma única vez na tabela à qual pertence: dados do hotel em `hotel`, dados do hóspede em `hospede`, dados do quarto em `quarto` e informações da estadia em `reserva`.

### Dependências eliminadas em cada passo

| Forma normal | Decisão aplicada | Dependência eliminada |
| --- | --- | --- |
| 1FN | Cada atributo armazena um único valor; não há grupos repetidos. | Valores múltiplos no mesmo campo, como vários telefones ou quartos em uma reserva. |
| 2FN | As tabelas usam chave primária simples; os atributos não-chave dependem da chave completa. | Dependência parcial de dados de hóspede ou quarto em uma eventual chave composta da reserva. |
| 3FN | Dados do hotel foram separados em `hotel`; `quarto` guarda apenas `id_hotel`. Os dados de hóspede e quarto não são repetidos em `reserva`. | Dependências transitivas e redundância, como `id_quarto -> id_hotel -> dados do hotel` e `id_reserva -> id_hospede/id_quarto -> dados descritivos`. |

`reserva` é a tabela associativa que registra o evento de hospedagem. Ela mantém somente suas próprias informações e as chaves estrangeiras de `hospede` e `quarto`.
