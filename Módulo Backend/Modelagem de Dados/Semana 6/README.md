# Sistema Acadêmico — Sprint 6

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
entregavel6/
├── README.md
├── 01_ddl.sql
├── 02_inserts.sql
├── 03_indices.sql
├── 04_consultas.sql
├── 05_transacoes.sql
├── 06_permissoes.sql
├── 07_explain.sql
├── 08_backup.sh
└── 09_mongodb.js
```

## Tecnologias

- PostgreSQL
- SQL
- Git
- GitHub

## Sprint 6 — Backup PostgreSQL e MongoDB

### Backup lógico do PostgreSQL

O script `08_backup.sh` faz backup lógico do banco `sistema_academico` com `pg_dump` no formato customizado do PostgreSQL (`-Fc`). Esse formato é adequado para restauração seletiva usando `pg_restore`. O script define variáveis para banco (`DB_NAME`), usuário (`DB_USER`) e diretório (`BACKUP_DIR`), cria o diretório quando necessário e gera um nome com data e hora. Em caso de falha do `pg_dump`, informa o erro, remove o arquivo incompleto e termina com código diferente de zero. Após um backup bem-sucedido, remove apenas arquivos `.dump` com mais de 30 dias do diretório configurado.

O script não contém senha. Configure a autenticação do PostgreSQL pelo mecanismo habitual, como `~/.pgpass` com permissões restritas ou as variáveis de conexão `PGHOST`, `PGPORT` e `PGPASSWORD` no ambiente protegido. O usuário PostgreSQL precisa ter acesso de leitura aos objetos que serão exportados.

Para permitir a execução e iniciar o backup:

```sh
chmod +x 08_backup.sh
./08_backup.sh
```

As variáveis podem ser sobrescritas no ambiente, por exemplo `DB_NAME`, `DB_USER` e `BACKUP_DIR`. A limpeza considera somente arquivos regulares terminados em `.dump` dentro do diretório definido.

### Agendamento diário com Cron

Para executar diariamente às 02:00, adicione ao crontab:

```cron
0 2 * * * /caminho/completo/do/projeto/08_backup.sh
```

Na expressão, `0` é o minuto, `2` é a hora, e os três asteriscos indicam qualquer dia do mês, mês e dia da semana. Use o caminho absoluto real do script no projeto; configure também no ambiente do Cron as variáveis de conexão necessárias, se aplicável.

### Regra de backup 3-2-1

Mantenha 3 cópias dos dados, em 2 tipos de mídia diferentes, e pelo menos 1 cópia fora do ambiente principal. O backup local gerado pelo script é uma parte da estratégia; cópias adicionais precisam ser armazenadas em mídias ou locais independentes.

### Teste seguro de restauração

Faça o teste em um banco separado para não sobrescrever o banco principal. Crie o banco de teste e restaure um arquivo `.dump` gerado pelo script:

```sh
createdb -U postgres sistema_academico_teste
pg_restore -U postgres -d sistema_academico_teste caminho_do_backup.dump
```

Depois da restauração, valide os dados com consultas como:

```sql
SELECT COUNT(*) FROM aluno;
SELECT COUNT(*) FROM professor;
SELECT COUNT(*) FROM disciplina;
SELECT COUNT(*) FROM matricula;
```

Registre abaixo os resultados obtidos na execução real; ainda não foram executadas contagens neste projeto:

| Tabela | Contagem observada |
| --- | --- |
| aluno | ____________________ |
| professor | ____________________ |
| disciplina | ____________________ |
| matricula | ____________________ |

### Introdução ao MongoDB

O arquivo `09_mongodb.js` usa `mongosh` para selecionar o banco `sistema_academico` e criar/popular duas collections: `cursos` e `alunos`. Ele insere primeiro cinco cursos, captura os `insertedId` retornados e usa esses IDs em dez documentos de alunos, totalizando quinze documentos de exemplo. Alguns alunos têm campos adicionais, como bolsa, projeto ou idioma preferido, para demonstrar a flexibilidade de esquema.

O documento de aluno incorpora (`Embedding`) um objeto `contato` com telefone e cidade, pois são dados pequenos e normalmente acessados junto com o aluno. O campo `curso_id` usa referência (`Referencing`) ao `_id` de um documento na collection `cursos`: curso é uma entidade independente compartilhada por vários alunos e pode ser consultada ou atualizada separadamente.

O script demonstra `find()` com filtros por cidade e curso, projeção para mostrar somente nome e email, ordenação alfabética por `nome` com `.sort({ nome: 1 })` e uma consulta que combina filtro, projeção e ordenação. Cria um índice simples em `email` e um índice composto em `curso_id` e `nome`. As chamadas `.explain("executionStats")` analisam uma busca por email e uma busca por curso ordenada por nome; seu objetivo é permitir observar o plano e as estatísticas reais da execução. Os planos ainda não foram coletados. Registre aqui o resultado após executar o script no MongoDB:

| Consulta analisada | Plano/estatísticas observados |
| --- | --- |
| Busca por email | ____________________ |
| Busca por curso ordenada por nome | ____________________ |

Execute com `mongosh 09_mongodb.js` em um ambiente MongoDB acessível. Cada execução insere novos documentos de exemplo; execute uma vez em uma base de demonstração limpa ou considere os dados acumulados ao repetir.

### PostgreSQL e MongoDB no Sistema Acadêmico

PostgreSQL é adequado como banco principal para matrículas, notas, professores, disciplinas, avaliações e frequência, que possuem relacionamentos fortes, integridade referencial, restrições e necessidade de transações. MongoDB pode ser útil para dados mais flexíveis e variáveis, como perfis de alunos, preferências, configurações, logs e atividades, cujos documentos podem ter campos diferentes. A escolha depende do padrão de acesso e da estrutura dos dados: cada banco atende melhor a necessidades distintas, e nenhum é sempre a melhor opção para todos os casos.
