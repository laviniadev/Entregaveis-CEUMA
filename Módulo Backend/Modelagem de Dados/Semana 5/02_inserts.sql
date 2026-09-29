-- Sprint 5 — Sistema Acadêmico
-- Execute depois de 01_ddl.sql. Cada tabela recebe pelo menos 15 registros.

INSERT INTO aluno (nome, email, data_nascimento)
VALUES
('Ana Souza', 'ana@email.com', '2005-03-15'),
('Carlos Lima', 'carlos@email.com', '2004-07-22'),
('Mariana Alves', 'mariana@email.com', '2005-11-10'),
('Joao Silva', 'joao@email.com', '2004-01-30'),
('Lucas Ferreira', 'lucas@email.com', '2005-05-12'),
('Beatriz Santos', 'beatriz@email.com', '2004-09-18'),
('Gabriel Costa', 'gabriel@email.com', '2005-02-25'),
('Laura Mendes', 'laura@email.com', '2004-12-03'),
('Rafael Rocha', 'rafael@email.com', '2005-06-14'),
('Camila Martins', 'camila@email.com', '2004-04-20'),
('Felipe Oliveira', 'felipe@email.com', '2005-08-11'),
('Julia Carvalho', 'julia@email.com', '2004-10-27'),
('Matheus Ribeiro', 'matheus@email.com', '2005-01-19'),
('Isabela Gomes', 'isabela@email.com', '2004-05-31'),
('Bruno Almeida', 'bruno@email.com', '2005-07-07');

INSERT INTO professor (nome, email)
VALUES
('Ricardo Santos', 'ricardo@email.com'),
('Fernanda Costa', 'fernanda@email.com'),
('Paulo Mendes', 'paulo@email.com'),
('Juliana Rocha', 'juliana@email.com'),
('Marcelo Lima', 'marcelo@email.com'),
('Patricia Alves', 'patricia@email.com'),
('Roberto Silva', 'roberto@email.com'),
('Amanda Martins', 'amanda@email.com'),
('Eduardo Souza', 'eduardo@email.com'),
('Carla Ribeiro', 'carla@email.com'),
('Daniel Gomes', 'daniel@email.com'),
('Renata Oliveira', 'renata@email.com'),
('Marcos Carvalho', 'marcos@email.com'),
('Vanessa Ferreira', 'vanessa@email.com'),
('Gustavo Almeida', 'gustavo@email.com');

INSERT INTO disciplina (nome, carga_horaria, professor_id)
VALUES
('Banco de Dados', 60, 1),
('Programacao Java', 80, 2),
('Engenharia de Software', 60, 3),
('Redes de Computadores', 40, 4),
('Algoritmos', 80, 5),
('Estrutura de Dados', 60, 6),
('Desenvolvimento Web', 60, 7),
('Sistemas Operacionais', 60, 8),
('Seguranca da Informacao', 40, 9),
('Computacao em Nuvem', 40, 10),
('Inteligencia Artificial', 60, 11),
('Desenvolvimento Mobile', 60, 12),
('Arquitetura de Software', 40, 13),
('Teste de Software', 40, 14),
('Gestao de Projetos', 40, 15);

INSERT INTO curso (nome, duracao_semestres)
VALUES
('Engenharia de Software', 8),
('Ciencia da Computacao', 8),
('Sistemas de Informacao', 8),
('Analise e Desenvolvimento de Sistemas', 5),
('Redes de Computadores', 5),
('Banco de Dados', 5),
('Seguranca da Informacao', 5),
('Inteligencia Artificial', 5),
('Computacao em Nuvem', 5),
('Engenharia da Computacao', 10),
('Desenvolvimento Web', 4),
('Desenvolvimento Mobile', 4),
('Gestao de TI', 4),
('Jogos Digitais', 5),
('Ciencia de Dados', 5);

INSERT INTO matricula (aluno_id, disciplina_id, data_matricula)
VALUES
(1, 1, '2026-09-01'),
(2, 2, '2026-09-01'),
(3, 3, '2026-09-02'),
(4, 4, '2026-09-02'),
(5, 5, '2026-09-03'),
(6, 6, '2026-09-03'),
(7, 7, '2026-09-04'),
(8, 8, '2026-09-04'),
(9, 9, '2026-09-05'),
(10, 10, '2026-09-05'),
(11, 11, '2026-09-06'),
(12, 12, '2026-09-06'),
(13, 13, '2026-09-07'),
(14, 14, '2026-09-07'),
(15, 15, '2026-09-08');

INSERT INTO turma (nome, disciplina_id, professor_id, semestre)
VALUES
('BD-01', 1, 1, '2026.2'),
('JAVA-01', 2, 2, '2026.2'),
('ES-01', 3, 3, '2026.2'),
('REDES-01', 4, 4, '2026.2'),
('ALG-01', 5, 5, '2026.2'),
('ED-01', 6, 6, '2026.2'),
('WEB-01', 7, 7, '2026.2'),
('SO-01', 8, 8, '2026.2'),
('SEG-01', 9, 9, '2026.2'),
('CLOUD-01', 10, 10, '2026.2'),
('IA-01', 11, 11, '2026.2'),
('MOBILE-01', 12, 12, '2026.2'),
('ARQ-01', 13, 13, '2026.2'),
('TESTE-01', 14, 14, '2026.2'),
('GP-01', 15, 15, '2026.2');

INSERT INTO avaliacao (turma_id, nome, data_avaliacao, valor)
VALUES
(1, 'Prova 1', '2026-10-01', 10),
(2, 'Prova 1', '2026-10-02', 10),
(3, 'Prova 1', '2026-10-03', 10),
(4, 'Prova 1', '2026-10-04', 10),
(5, 'Prova 1', '2026-10-05', 10),
(6, 'Prova 1', '2026-10-06', 10),
(7, 'Prova 1', '2026-10-07', 10),
(8, 'Prova 1', '2026-10-08', 10),
(9, 'Prova 1', '2026-10-09', 10),
(10, 'Prova 1', '2026-10-10', 10),
(11, 'Prova 1', '2026-10-11', 10),
(12, 'Prova 1', '2026-10-12', 10),
(13, 'Prova 1', '2026-10-13', 10),
(14, 'Prova 1', '2026-10-14', 10),
(15, 'Prova 1', '2026-10-15', 10);

INSERT INTO nota (avaliacao_id, aluno_id, valor)
VALUES
(1, 1, 9.50),
(2, 2, 8.00),
(3, 3, 7.50),
(4, 4, 10.00),
(5, 5, 6.50),
(6, 6, 8.50),
(7, 7, 9.00),
(8, 8, 7.00),
(9, 9, 5.50),
(10, 10, 8.00),
(11, 11, 9.50),
(12, 12, 6.00),
(13, 13, 7.50),
(14, 14, 8.50),
(15, 15, 9.00);

INSERT INTO frequencia (aluno_id, turma_id, data_aula, presente)
VALUES
(1, 1, '2026-09-10', TRUE),
(2, 2, '2026-09-10', TRUE),
(3, 3, '2026-09-10', FALSE),
(4, 4, '2026-09-10', TRUE),
(5, 5, '2026-09-11', TRUE),
(6, 6, '2026-09-11', FALSE),
(7, 7, '2026-09-11', TRUE),
(8, 8, '2026-09-11', TRUE),
(9, 9, '2026-09-12', FALSE),
(10, 10, '2026-09-12', TRUE),
(11, 11, '2026-09-12', TRUE),
(12, 12, '2026-09-12', FALSE),
(13, 13, '2026-09-13', TRUE),
(14, 14, '2026-09-13', TRUE),
(15, 15, '2026-09-13', TRUE);

INSERT INTO curso_disciplina (curso_id, disciplina_id)
VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 5),
(2, 6),
(3, 7),
(4, 2),
(5, 4),
(6, 1),
(7, 9),
(8, 11),
(9, 10),
(10, 8),
(11, 7),
(12, 12);