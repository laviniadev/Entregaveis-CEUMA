-- Sprint 5 — Sistema Acadêmico
-- Execute este arquivo primeiro para criar as tabelas do projeto.

CREATE TABLE aluno (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL
);

CREATE TABLE professor (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE disciplina (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    carga_horaria INT NOT NULL CHECK (carga_horaria > 0),
    professor_id INT NOT NULL,

    FOREIGN KEY (professor_id)
        REFERENCES professor(id)
);

CREATE TABLE matricula (
    id SERIAL PRIMARY KEY,
    aluno_id INT NOT NULL,
    disciplina_id INT NOT NULL,
    data_matricula DATE NOT NULL DEFAULT CURRENT_DATE,

    FOREIGN KEY (aluno_id)
        REFERENCES aluno(id),

    FOREIGN KEY (disciplina_id)
        REFERENCES disciplina(id),

    UNIQUE (aluno_id, disciplina_id)
);

CREATE TABLE curso (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    duracao_semestres INT NOT NULL CHECK (duracao_semestres > 0)
);

CREATE TABLE turma (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    disciplina_id INT NOT NULL,
    professor_id INT NOT NULL,
    semestre VARCHAR(10) NOT NULL,

    FOREIGN KEY (disciplina_id)
        REFERENCES disciplina(id),

    FOREIGN KEY (professor_id)
        REFERENCES professor(id)
);

CREATE TABLE avaliacao (
    id SERIAL PRIMARY KEY,
    turma_id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    data_avaliacao DATE NOT NULL,
    valor NUMERIC(4,2) NOT NULL CHECK (valor > 0 AND valor <= 10),

    FOREIGN KEY (turma_id)
        REFERENCES turma(id)
);

CREATE TABLE nota (
    id SERIAL PRIMARY KEY,
    avaliacao_id INT NOT NULL,
    aluno_id INT NOT NULL,
    valor NUMERIC(4,2) NOT NULL CHECK (valor >= 0 AND valor <= 10),

    FOREIGN KEY (avaliacao_id)
        REFERENCES avaliacao(id),

    FOREIGN KEY (aluno_id)
        REFERENCES aluno(id),

    UNIQUE (avaliacao_id, aluno_id)
);

CREATE TABLE frequencia (
    id SERIAL PRIMARY KEY,
    aluno_id INT NOT NULL,
    turma_id INT NOT NULL,
    data_aula DATE NOT NULL,
    presente BOOLEAN NOT NULL DEFAULT TRUE,

    FOREIGN KEY (aluno_id)
        REFERENCES aluno(id),

    FOREIGN KEY (turma_id)
        REFERENCES turma(id),

    UNIQUE (aluno_id, turma_id, data_aula)
);

CREATE TABLE curso_disciplina (
    id SERIAL PRIMARY KEY,
    curso_id INT NOT NULL,
    disciplina_id INT NOT NULL,

    FOREIGN KEY (curso_id)
        REFERENCES curso(id),

    FOREIGN KEY (disciplina_id)
        REFERENCES disciplina(id),

    UNIQUE (curso_id, disciplina_id)
);
