-- Sprint 5 — Sistema Acadêmico
-- Execute depois de 01_ddl.sql e 02_inserts.sql.
-- As transações principais usam CTEs com RETURNING para reaproveitar os IDs gerados.

-- Transação 1: cadastrar aluno e matrícula; confirma os dois registros juntos.
BEGIN;

WITH novo_aluno AS (
    INSERT INTO aluno (nome, email, data_nascimento)
    VALUES ('Aluno da Transacao', 'aluno.transacao@email.com', '2005-09-20')
    RETURNING id
)
INSERT INTO matricula (aluno_id, disciplina_id)
SELECT id, 1
FROM novo_aluno;

COMMIT;

-- Transação 2: cadastrar professor e disciplina; confirma os dois registros juntos.
BEGIN;

WITH novo_professor AS (
    INSERT INTO professor (nome, email)
    VALUES ('Professor da Transacao', 'professor.transacao@email.com')
    RETURNING id
)
INSERT INTO disciplina (nome, carga_horaria, professor_id)
SELECT 'Disciplina da Transacao', 40, id
FROM novo_professor;

COMMIT;

-- Exemplo de ROLLBACK: o aluno temporário não permanece cadastrado.
BEGIN;

INSERT INTO aluno (nome, email, data_nascimento)
VALUES ('Aluno Cancelado', 'aluno.cancelado@email.com', '2005-01-01');

ROLLBACK;

-- Exemplo de SAVEPOINT e ROLLBACK TO SAVEPOINT.
BEGIN;

SAVEPOINT antes_do_teste;

INSERT INTO aluno (nome, email, data_nascimento)
VALUES ('Aluno do Savepoint', 'aluno.savepoint@email.com', '2005-02-02');

ROLLBACK TO SAVEPOINT antes_do_teste;
COMMIT;