package br.edu.ceuma.semana2.controlador;

import br.edu.ceuma.semana2.entidade.Aluno;
import br.edu.ceuma.semana2.servico.AlunoServico;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/alunos")
public class AlunoControlador {

    private final AlunoServico alunoServico;
    private final String nomeAluno;
    private final String raAluno;

    public AlunoControlador(AlunoServico alunoServico,
                            @Value("${aluno.nome}") String nomeAluno,
                            @Value("${aluno.ra}") String raAluno) {
        this.alunoServico = alunoServico;
        this.nomeAluno = nomeAluno;
        this.raAluno = raAluno;
    }

    @GetMapping
    public List<Aluno> listar() {
        return alunoServico.listarTodos();
    }

    @GetMapping(params = "nome")
    public List<Aluno> buscarPorNome(@RequestParam String nome) {
        return alunoServico.buscarPorNome(nome);
    }

    @GetMapping("/{id}")
    public Aluno buscarPorId(@PathVariable Long id) {
        return alunoServico.buscarPorId(id);
    }

    @PostMapping
    public Aluno criar(@RequestBody Aluno aluno) {
        return alunoServico.salvar(aluno);
    }

    @GetMapping("/ra")
    public String informarRa() {
        return "O RA do aluno " + nomeAluno + " é " + raAluno;
    }
}
