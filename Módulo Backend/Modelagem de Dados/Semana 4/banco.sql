CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    data_cadastro TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE livro (
    id_livro SERIAL PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    disponivel BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE emprestimo (
    id_emprestimo SERIAL PRIMARY KEY,
    id_usuario INTEGER NOT NULL,
    id_livro INTEGER NOT NULL,
    data_emprestimo TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_devolucao TIMESTAMPTZ,

    CONSTRAINT fk_emprestimo_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario),

    CONSTRAINT fk_emprestimo_livro
        FOREIGN KEY (id_livro)
        REFERENCES livro(id_livro),

    CONSTRAINT chk_data_devolucao
        CHECK (
            data_devolucao IS NULL
            OR data_devolucao >= data_emprestimo
        )
);

CREATE INDEX idx_emprestimo_usuario
ON emprestimo(id_usuario);

CREATE INDEX idx_emprestimo_livro
ON emprestimo(id_livro);

BEGIN;

WITH novo_usuario AS (
    INSERT INTO usuario (nome, email)
    VALUES ('Pedro Silva', 'pedro@email.com')
    RETURNING id_usuario
),
novo_livro AS (
    INSERT INTO livro (titulo, isbn)
    VALUES ('Dom Casmurro', '9788535914849')
    RETURNING id_livro
)
INSERT INTO emprestimo (id_usuario, id_livro)
SELECT
    novo_usuario.id_usuario,
    novo_livro.id_livro
FROM novo_usuario
CROSS JOIN novo_livro;

SAVEPOINT emprestimo_1;

COMMIT;

BEGIN;

WITH novo_usuario AS (
    INSERT INTO usuario (nome, email)
    VALUES ('Ana Silva', 'ana@email.com')
    RETURNING id_usuario
),
novo_livro AS (
    INSERT INTO livro (titulo, isbn)
    VALUES ('1984', '9788535914840')
    RETURNING id_livro
)
INSERT INTO emprestimo (id_usuario, id_livro)
SELECT
    novo_usuario.id_usuario,
    novo_livro.id_livro
FROM novo_usuario
CROSS JOIN novo_livro;

SAVEPOINT emprestimo_2;

COMMIT;

BEGIN;

INSERT INTO usuario (nome, email)
VALUES ('Usuario Teste', 'teste@email.com');

ROLLBACK;

BEGIN;

INSERT INTO usuario (nome, email)
VALUES ('Carlos Lima', 'carlos@email.com');

SAVEPOINT cadastro_usuario;

INSERT INTO usuario (nome, email)
VALUES ('Usuario Temporario', 'temporario@email.com');

ROLLBACK TO SAVEPOINT cadastro_usuario;

COMMIT;

EXPLAIN ANALYZE
SELECT
    id_emprestimo,
    data_emprestimo
FROM emprestimo
WHERE id_usuario = 1;

EXPLAIN ANALYZE
SELECT
    id_emprestimo,
    data_emprestimo
FROM emprestimo
WHERE id_livro = 1;

CREATE ROLE funcionario_biblioteca;

GRANT SELECT ON usuario, livro, emprestimo
TO funcionario_biblioteca;

GRANT INSERT, UPDATE ON emprestimo
TO funcionario_biblioteca;

GRANT USAGE, SELECT
ON SEQUENCE emprestimo_id_emprestimo_seq
TO funcionario_biblioteca;

CREATE USER funcionario
WITH PASSWORD 'senha_funcionario';

GRANT funcionario_biblioteca
TO funcionario;

CREATE USER consulta
WITH PASSWORD 'senha_consulta';

GRANT SELECT ON livro
TO consulta;

REVOKE INSERT, UPDATE, DELETE
ON livro
FROM consulta;