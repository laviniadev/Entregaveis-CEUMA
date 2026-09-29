# Sistema de Biblioteca — Entregável 4

## Descrição

Este projeto apresenta a implementação física de um banco de dados para um sistema de biblioteca utilizando PostgreSQL.

O sistema possui três tabelas principais:

- Usuario
- Livro
- Emprestimo

O objetivo é implementar o modelo lógico desenvolvido anteriormente, adicionando recursos de performance, integridade transacional e segurança.

## Estrutura do Banco

### Usuario

- `id_usuario` — Chave Primária
- `nome`
- `email`
- `data_cadastro`

### Livro

- `id_livro` — Chave Primária
- `titulo`
- `isbn`
- `disponivel`

### Emprestimo

- `id_emprestimo` — Chave Primária
- `id_usuario` — Chave Estrangeira
- `id_livro` — Chave Estrangeira
- `data_emprestimo`
- `data_devolucao`

## Relacionamentos

Um usuário pode realizar vários empréstimos.

Um livro pode participar de vários empréstimos ao longo do tempo.

`Usuario (1) --- (N) Emprestimo (N) --- (1) Livro`

## Escolha dos Tipos de Dados

- `SERIAL`: utilizado nas chaves primárias para gerar os IDs automaticamente.
- `INTEGER`: utilizado nas chaves estrangeiras.
- `VARCHAR`: utilizado para nome, email, título e ISBN.
- `TIMESTAMPTZ`: utilizado para armazenar datas e horários com fuso horário.
- `BOOLEAN`: utilizado para indicar se o livro está disponível.

## Restrições

- `PRIMARY KEY`: identifica cada registro.
- `FOREIGN KEY`: mantém os relacionamentos entre as tabelas.
- `NOT NULL`: impede valores nulos em campos obrigatórios.
- `UNIQUE`: impede emails e ISBNs duplicados.
- `DEFAULT`: define valores automaticamente.
- `CHECK`: impede que a data de devolução seja anterior à data do empréstimo.

## Estratégia de Indexação

Foram criados índices nas colunas `id_usuario` e `id_livro` da tabela `emprestimo`.

Essas colunas são utilizadas nos relacionamentos e podem ser utilizadas frequentemente em consultas e JOINs.

Não foram criados índices em todas as colunas para evitar custos desnecessários nas operações de `INSERT`, `UPDATE` e `DELETE`.

As colunas `email` e `isbn` possuem `UNIQUE`, portanto o PostgreSQL já mantém índices únicos para essas colunas.

## Transações

Foram criadas duas transações principais para cadastrar usuários, livros e seus respectivos empréstimos.

Foram utilizados:

- `BEGIN`
- `COMMIT`
- `ROLLBACK`
- `SAVEPOINT`
- `ROLLBACK TO SAVEPOINT`
- `RETURNING`

O `RETURNING` foi utilizado para recuperar os IDs gerados automaticamente e utilizá-los no cadastro dos empréstimos.

## EXPLAIN ANALYZE

Foram analisadas duas consultas.

### Consulta por id_usuario

Resultado:

`Seq Scan`

Planning Time: `0.468 ms`

Execution Time: `0.020 ms`

### Consulta por id_livro

Resultado:

`Seq Scan`

Planning Time: `0.058 ms`

Execution Time: `0.016 ms`

### Análise

Nas duas consultas, o PostgreSQL utilizou `Seq Scan` em vez dos índices criados.

Isso ocorreu porque a tabela `emprestimo` possui poucos registros. Nesse caso, o PostgreSQL considerou mais eficiente percorrer diretamente a tabela.

Os índices `idx_emprestimo_usuario` e `idx_emprestimo_livro` continuam disponíveis e podem ser utilizados quando houver um volume maior de dados.

## Controle de Acesso

Foi criada a role `funcionario_biblioteca`.

Também foram criados dois usuários:

### funcionario

Possui a role `funcionario_biblioteca` e pode consultar as tabelas e registrar ou atualizar empréstimos.

### consulta

Possui apenas permissão de leitura na tabela `livro`.

Foram utilizados `GRANT` e `REVOKE` para controlar as permissões seguindo o princípio do menor privilégio.

## Tecnologias

- PostgreSQL
- SQL
- Git
- GitHub