// Sprint 6 — parte NoSQL do Sistema Acadêmico.
// Execute com mongosh 09_mongodb.js.
const sistemaAcademico = db.getSiblingDB("sistema_academico");
const cursos = sistemaAcademico.cursos;
const alunos = sistemaAcademico.alunos;

// Cursos são inseridos primeiro para que seus IDs reais sejam usados como referências.
const resultadoCursos = cursos.insertMany([
  { nome: "Engenharia de Software", duracao_semestres: 8, modalidade: "presencial" },
  { nome: "Ciência da Computação", duracao_semestres: 8, modalidade: "presencial" },
  { nome: "Sistemas de Informação", duracao_semestres: 8, modalidade: "híbrido" },
  { nome: "Análise e Desenvolvimento de Sistemas", duracao_semestres: 5, modalidade: "noturno" },
  { nome: "Banco de Dados", duracao_semestres: 5, modalidade: "EAD" }
]);

const cursoIds = Object.values(resultadoCursos.insertedIds);

// contato é embedding: dados pequenos normalmente lidos junto com o aluno.
// curso_id é referencing: curso é entidade compartilhada e gerenciada separadamente.
alunos.insertMany([
  { nome: "Ana Souza", email: "ana@email.com", curso_id: cursoIds[0], contato: { telefone: "85990000001", cidade: "Fortaleza" }, periodo: 3 },
  { nome: "Carlos Lima", email: "carlos@email.com", curso_id: cursoIds[1], contato: { telefone: "85990000002", cidade: "Sobral" }, periodo: 2 },
  { nome: "Mariana Alves", email: "mariana@email.com", curso_id: cursoIds[2], contato: { telefone: "85990000003", cidade: "Fortaleza" }, periodo: 4, bolsa: true },
  { nome: "João Silva", email: "joao@email.com", curso_id: cursoIds[3], contato: { telefone: "85990000004", cidade: "Juazeiro do Norte" }, periodo: 1 },
  { nome: "Lucas Ferreira", email: "lucas@email.com", curso_id: cursoIds[4], contato: { telefone: "85990000005", cidade: "Fortaleza" }, periodo: 5 },
  { nome: "Beatriz Santos", email: "beatriz@email.com", curso_id: cursoIds[0], contato: { telefone: "85990000006", cidade: "Crato" }, periodo: 2, projeto: "Iniciação científica" },
  { nome: "Gabriel Costa", email: "gabriel@email.com", curso_id: cursoIds[1], contato: { telefone: "85990000007", cidade: "Fortaleza" }, periodo: 6 },
  { nome: "Laura Mendes", email: "laura@email.com", curso_id: cursoIds[2], contato: { telefone: "85990000008", cidade: "Iguatu" }, periodo: 3 },
  { nome: "Rafael Rocha", email: "rafael@email.com", curso_id: cursoIds[3], contato: { telefone: "85990000009", cidade: "Fortaleza" }, periodo: 2, idioma_preferido: "pt-BR" },
  { nome: "Camila Martins", email: "camila@email.com", curso_id: cursoIds[4], contato: { telefone: "85990000010", cidade: "Quixadá" }, periodo: 4 }
]);

// Consultas com filtros, projeção e ordenação.
alunos.find({ "contato.cidade": "Fortaleza" });
alunos.find({ curso_id: cursoIds[0] });
alunos.find({}, { projection: { _id: 0, nome: 1, email: 1 } });
alunos.find({ "contato.cidade": "Fortaleza" }, { projection: { _id: 0, nome: 1, email: 1 } }).sort({ nome: 1 });
alunos.find({ curso_id: cursoIds[1] }).sort({ nome: 1 });

// Índice simples para email e composto para curso com ordenação por nome.
alunos.createIndex({ email: 1 }, { name: "idx_alunos_email" });
alunos.createIndex({ curso_id: 1, nome: 1 }, { name: "idx_alunos_curso_nome" });

// executionStats permite examinar estatísticas reais do plano de execução.
alunos.find({ email: "ana@email.com" }).explain("executionStats");
alunos.find({ curso_id: cursoIds[0] }).sort({ nome: 1 }).explain("executionStats");
