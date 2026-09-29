-- Sprint 5 — Sistema Acadêmico
-- Execute no PostgreSQL para obter os planos e tempos reais.
-- Os resultados dependem dos dados e do ambiente; não são antecipados aqui.

-- 1. Busca de aluno pelo nome.
EXPLAIN ANALYZE
SELECT
    id,
    nome,
    email
FROM aluno
WHERE nome = 'Ana Souza';

-- 2. Busca de matrícula pelo aluno.
EXPLAIN ANALYZE
SELECT
    id,
    aluno_id,
    disciplina_id,
    data_matricula
FROM matricula
WHERE aluno_id = 1;

-- 3. Busca de disciplinas de um professor.
EXPLAIN ANALYZE
SELECT
    d.nome,
    p.nome
FROM disciplina d
INNER JOIN professor p
    ON d.professor_id = p.id
WHERE d.professor_id = 1;