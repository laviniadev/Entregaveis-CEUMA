package br.edu.ceuma.semana2.servico;

import br.edu.ceuma.semana2.entidade.Aluno;
import br.edu.ceuma.semana2.repositorio.AlunoRepositorio;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AlunoServico {

    private final AlunoRepositorio alunoRepositorio;

    public AlunoServico(AlunoRepositorio alunoRepositorio) {
        this.alunoRepositorio = alunoRepositorio;
    }

    public List<Aluno> listarTodos() {
        return alunoRepositorio.findAll();
    }

    public Aluno buscarPorId(Long id) {
        return alunoRepositorio.findById(id).orElse(null);
    }

    public List<Aluno> buscarPorNome(String nome) {
        return alunoRepositorio.findByNome(nome);
    }

    public Aluno salvar(Aluno aluno) {
        return alunoRepositorio.save(aluno);
    }
}
