# Sistema Acadêmico — Sprint 5

## Descrição

Este projeto é um banco de dados PostgreSQL para gerenciamento acadêmico. Ele reúne informações de alunos, professores, cursos, disciplinas, turmas, matrículas, avaliações, notas e frequência.

## Estrutura do Banco

O banco possui 10 tabelas, com pelo menos 15 registros em cada uma:

- `aluno`
- `professor`
- `disciplina`
- `matricula`
- `curso`
- `turma`
- `avaliacao`
- `nota`
- `frequencia`
- `curso_disciplina`

## Modelo Lógico

- Um professor pode ministrar várias disciplinas (`professor` → `disciplina`).
- Alunos e disciplinas se relacionam por meio de `matricula` (`aluno` → `matricula` ← `disciplina`).
- Uma disciplina pode aparecer em várias turmas, e cada turma possui um professor (`disciplina` → `turma` ← `professor`).
- Uma turma pode ter várias avaliações (`turma` → `avaliacao`).
- As notas relacionam avaliações e alunos (`avaliacao` → `nota` ← `aluno`).
- A frequência relaciona alunos e turmas (`aluno` → `frequencia` ← `turma`).
- Cursos e disciplinas se relacionam por `curso_disciplina` (`curso` → `curso_disciplina` ← `disciplina`).

## Restrições

- `PRIMARY KEY`: identifica cada registro de forma única.
- `FOREIGN KEY`: liga tabelas e impede referências a registros inexistentes.
- `NOT NULL`: exige o preenchimento dos campos obrigatórios.
- `UNIQUE`: impede valores ou combinações duplicadas onde isso é necessário.
- `CHECK`: limita valores, como carga horária positiva e notas de 0 a 10.
- `DEFAULT`: define um valor automático quando nenhum é informado, como a data de matrícula e a presença.

## Normalização

As informações foram separadas em tabelas específicas para reduzir repetição. As chaves estrangeiras mantêm os relacionamentos entre elas.

## Índices

O arquivo `03_indices.sql` cria os seguintes índices:

- `idx_aluno_nome`, `idx_professor_nome` e `idx_disciplina_nome`: buscas por nome.
- `idx_matricula_data`: buscas por data de matrícula.
- `idx_matricula_aluno` e `idx_matricula_disciplina`: relacionamentos e consultas de matrículas.
- `idx_disciplina_professor`: relacionamento entre disciplinas e professores.
- `idx_turma_disciplina` e `idx_turma_professor`: relacionamentos usados nas consultas de turmas.
- `idx_avaliacao_turma`: relacionamento entre avaliações e turmas.
- `idx_nota_aluno` e `idx_frequencia_aluno`: consultas de notas e frequência por aluno.

Os índices foram aplicados principalmente em colunas usadas em buscas, relacionamentos e `JOIN`s. Não é necessário indexar todas as colunas, pois índices também têm custo nas operações de `INSERT`, `UPDATE` e `DELETE`. Chaves primárias e restrições `UNIQUE` já criam seus próprios índices no PostgreSQL.

## Consultas

O arquivo `04_consultas.sql` contém 12 consultas com `SELECT`, `WHERE`, `INNER JOIN`, `LEFT JOIN`, `GROUP BY`, `HAVING`, `ORDER BY`, `COUNT`, `AVG` e subconsultas:

1. Listar alunos.
2. Listar professores.
3. Buscar a disciplina Banco de Dados pelo nome.
4. Mostrar alunos e disciplinas em que estão matriculados.
5. Mostrar disciplinas e seus professores.
6. Contar alunos por disciplina.
7. Calcular a média de notas por aluno.
8. Mostrar alunos com média igual ou superior a 7.
9. Encontrar alunos com nota acima da média geral.
10. Mostrar alunos e notas em ordem decrescente de nota.
11. Contar faltas por aluno.
12. Mostrar cursos e suas disciplinas.

## Transações

O arquivo `05_transacoes.sql` demonstra `BEGIN`, `COMMIT`, `ROLLBACK`, `SAVEPOINT`, `ROLLBACK TO SAVEPOINT` e `RETURNING`. Uma transação cadastra aluno e matrícula; outra cadastra professor e disciplina. As CTEs usam o ID retornado pelo próprio `INSERT`. Também há exemplos de operações canceladas com `ROLLBACK` e `ROLLBACK TO SAVEPOINT`.

## Controle de Acesso

O arquivo `06_permissoes.sql` cria as roles `secretaria_academica` e `professor_academico`, além dos usuários `usuario_secretaria` e `usuario_professor`.

A secretaria pode consultar as tabelas acadêmicas previstas e inserir ou atualizar matrículas. O professor pode consultar alunos, disciplinas, turmas e avaliações, além de inserir ou atualizar notas e frequências. As permissões seguem o princípio do menor privilégio: cada role recebe apenas o acesso necessário para suas atividades. O script usa `GRANT` e `REVOKE`. Para executar o arquivo, use um superusuário ou uma conta com `CREATEROLE` que também seja proprietária das tabelas, sequences e do schema (ou tenha opção de concessão sobre eles). `CREATEROLE` sozinho permite criar roles e usuários, mas não concede automaticamente permissão para conceder acesso aos objetos.

## EXPLAIN ANALYZE

`EXPLAIN ANALYZE` executa a consulta e exibe o plano real junto com informações de execução. Os resultados reais devem ser obtidos executando `07_explain.sql` no PostgreSQL; nenhum resultado foi presumido neste README. Como as tabelas têm poucos registros, o PostgreSQL pode optar por `Seq Scan` mesmo quando existe um índice.

## Estrutura dos Arquivos

```text
entregavel5/
├── README.md
├── 01_ddl.sql
├── 02_inserts.sql
├── 03_indices.sql
├── 04_consultas.sql
├── 05_transacoes.sql
├── 06_permissoes.sql
└── 07_explain.sql
```

## Tecnologias

- PostgreSQL
- SQL
- Git
- GitHub
