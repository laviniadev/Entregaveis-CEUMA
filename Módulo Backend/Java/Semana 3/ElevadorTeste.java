package tarefa03;

public class ElevadorTeste {
    public static void main(String[] args) {
        Elevador elevador = new Elevador(1, 500);

        // Subida bem-sucedida: peso dentro do limite.
        elevador.definirPesoAtual(420);
        elevador.subir();

        // Subida bloqueada: peso acima do limite.
        elevador.definirPesoAtual(550);
        elevador.subir();
    }
}
