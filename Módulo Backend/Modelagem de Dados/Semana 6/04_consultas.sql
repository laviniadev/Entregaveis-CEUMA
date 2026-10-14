-- Sprint 5 — Sistema Acadêmico
-- 1. Listar alunos.
SELECT
    id,
    nome,
    email,
    data_nascimento
FROM aluno;

-- 2. Listar professores.
SELECT
    id,
    nome,
    email
FROM professor;

-- 3. Buscar Banco de Dados pelo nome.
SELECT
    id,
    nome,
    carga_horaria
FROM disciplina
WHERE nome = 'Banco de Dados';

-- 4. Mostrar alunos e disciplinas em que estão matriculados.
SELECT
    a.nome AS aluno,
    d.nome AS disciplina,
    m.data_matricula
FROM matricula m
INNER JOIN aluno a
    ON m.aluno_id = a.id
INNER JOIN disciplina d
    ON m.disciplina_id = d.id;

-- 5. Mostrar disciplinas e seus professores.
SELECT
    d.nome AS disciplina,
    p.nome AS professor
FROM disciplina d
INNER JOIN professor p
    ON d.professor_id = p.id;

-- 6. Contar quantidade de alunos por disciplina.
SELECT
    d.nome AS disciplina,
    COUNT(m.aluno_id) AS quantidade_alunos
FROM disciplina d
LEFT JOIN matricula m
    ON d.id = m.disciplina_id
GROUP BY d.id, d.nome;

-- 7. Calcular média de notas por aluno.
SELECT
    a.nome AS aluno,
    AVG(n.valor) AS media
FROM aluno a
INNER JOIN nota n
    ON a.id = n.aluno_id
GROUP BY a.id, a.nome;

-- 8. Mostrar alunos com média igual ou superior a 7.
SELECT
    a.nome AS aluno,
    AVG(n.valor) AS media
FROM aluno a
INNER JOIN nota n
    ON a.id = n.aluno_id
GROUP BY a.id, a.nome
HAVING AVG(n.valor) >= 7;

-- 9. Encontrar alunos com nota acima da média geral.
SELECT nome
FROM aluno
WHERE id IN (
    SELECT aluno_id
    FROM nota
    WHERE valor > (
        SELECT AVG(valor)
        FROM nota
    )
);

-- 10. Mostrar alunos e notas da maior para a menor.
SELECT
    a.nome AS aluno,
    n.valor AS nota
FROM nota n
INNER JOIN aluno a
    ON n.aluno_id = a.id
ORDER BY n.valor DESC;

-- 11. Contar faltas dos alunos.
SELECT
    a.nome AS aluno,
    COUNT(*) AS faltas
FROM frequencia f
INNER JOIN aluno a
    ON f.aluno_id = a.id
WHERE f.presente = FALSE
GROUP BY a.id, a.nome;

-- 12. Mostrar cursos e suas disciplinas.
SELECT
    c.nome AS curso,
    d.nome AS disciplina
FROM curso_disciplina cd
INNER JOIN curso c
    ON cd.curso_id = c.id
INNER JOIN disciplina d
    ON cd.disciplina_id = d.id
ORDER BY c.nome;