package tarefa04;

public class Credito extends FormaPagamento {
    private double limiteDisponivel;
    private final int parcelas;

    public Credito(double valor, double limiteDisponivel, int parcelas) {
        super(valor);
        this.limiteDisponivel = limiteDisponivel;
        this.parcelas = parcelas;
    }

    @Override
    public void pagar() {
        if (!validarValor()) {
            return;
        }

        if (getValor() > limiteDisponivel) {
            definirStatus("Recusado: limite insuficiente");
            System.out.println("Pagamento no crédito recusado: limite insuficiente.");
            return;
        }

        limiteDisponivel -= getValor();
        definirStatus("Aprovado em " + parcelas + "x");
        System.out.println("Pagamento no crédito aprovado em " + parcelas + "x.");
    }

    @Override
    public void exibirDetalhes() {
        System.out.println("Crédito | Valor: R$ " + getValor() + " | Status: " + getStatus()
                + " | Parcelas: " + parcelas + " | Limite restante: R$ " + limiteDisponivel);
    }
}
