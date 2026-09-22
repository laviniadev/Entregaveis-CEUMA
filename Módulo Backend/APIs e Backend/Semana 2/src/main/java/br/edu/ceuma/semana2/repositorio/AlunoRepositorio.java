package br.edu.ceuma.semana2.repositorio;

import br.edu.ceuma.semana2.entidade.Aluno;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AlunoRepositorio extends JpaRepository<Aluno, Long> {

    List<Aluno> findByNome(String nome);
}
