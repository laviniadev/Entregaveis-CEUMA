-- Sprint 5 — Sistema Acadêmico
-- Execute como superuser ou como proprietário dos objetos com CREATEROLE.
-- CREATE ROLE/USER exige CREATEROLE; os GRANTs exigem propriedade dos objetos
-- (ou opção de concessão). Um usuário com apenas CREATEROLE não basta para tudo.
-- Os usuários são criados sem senha; a configuração de autenticação fica a cargo do administrador.

CREATE ROLE secretaria_academica;
CREATE ROLE professor_academico;

CREATE USER usuario_secretaria;
CREATE USER usuario_professor;

GRANT secretaria_academica TO usuario_secretaria;
GRANT professor_academico TO usuario_professor;

-- Permite que as roles acessem as tabelas do schema padrão.
GRANT USAGE ON SCHEMA public TO secretaria_academica, professor_academico;

-- Remove permissões anteriores dessas roles antes de conceder o acesso previsto.
REVOKE ALL PRIVILEGES ON TABLE aluno, professor, disciplina, curso, turma, matricula
FROM secretaria_academica;

GRANT SELECT ON TABLE aluno, professor, disciplina, curso, turma
TO secretaria_academica;

GRANT SELECT, INSERT, UPDATE ON TABLE matricula
TO secretaria_academica;

-- SERIAL usa sequences próprias, que também precisam de permissão para INSERT.
GRANT USAGE, SELECT ON SEQUENCE matricula_id_seq
TO secretaria_academica;

REVOKE DELETE ON TABLE aluno, professor, disciplina, curso, turma, matricula
FROM secretaria_academica;

REVOKE ALL PRIVILEGES ON TABLE aluno, disciplina, turma, avaliacao, nota, frequencia
FROM professor_academico;

GRANT SELECT ON TABLE aluno, disciplina, turma, avaliacao
TO professor_academico;

GRANT SELECT, INSERT, UPDATE ON TABLE nota, frequencia
TO professor_academico;

GRANT USAGE, SELECT ON SEQUENCE nota_id_seq, frequencia_id_seq
TO professor_academico;

REVOKE INSERT, UPDATE, DELETE ON TABLE aluno
FROM professor_academico;

REVOKE DELETE ON TABLE nota, frequencia
FROM professor_academico;
