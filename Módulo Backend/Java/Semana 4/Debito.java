package tarefa04;

public class Debito extends FormaPagamento {
    private double saldoDisponivel;

    public Debito(double valor, double saldoDisponivel) {
        super(valor);
        this.saldoDisponivel = saldoDisponivel;
    }

    @Override
    public void pagar() {
        if (!validarValor()) {
            return;
        }

        if (getValor() > saldoDisponivel) {
            definirStatus("Recusado: saldo insuficiente");
            System.out.println("Pagamento no débito recusado: saldo insuficiente.");
            return;
        }

        saldoDisponivel -= getValor();
        definirStatus("Aprovado");
        System.out.println("Pagamento no débito aprovado.");
    }

    @Override
    public void exibirDetalhes() {
        System.out.println("Débito | Valor: R$ " + getValor() + " | Status: " + getStatus()
                + " | Saldo restante: R$ " + saldoDisponivel);
    }
}
