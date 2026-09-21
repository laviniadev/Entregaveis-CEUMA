package tarefa03;

public class Elevador {
    private int andarAtual;
    private final double pesoMaximo;
    private double pesoAtual;

    public Elevador(int andarInicial, double pesoMaximo) {
        this.andarAtual = andarInicial;
        this.pesoMaximo = pesoMaximo;
    }

    public void definirPesoAtual(double pesoAtual) {
        if (pesoAtual < 0) {
            System.out.println("O peso atual não pode ser negativo.");
        }

        this.pesoAtual = pesoAtual;
    }

    public void subir() {
        if (pesoAtual > pesoMaximo) {
            System.out.println("O elevador não sairá do andar " + andarAtual
                    + " por excesso de peso.");
        }

        andarAtual++;
        System.out.println("O elevador parou no andar " + andarAtual + ".");
    }
}
