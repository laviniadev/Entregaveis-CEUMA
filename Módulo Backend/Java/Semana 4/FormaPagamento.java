package tarefa04;

public abstract class FormaPagamento {
    private final double valor;
    private String status = "Pendente";

    protected FormaPagamento(double valor) {
        this.valor = valor;
    }

    public abstract void pagar();

    public abstract void exibirDetalhes();

    protected boolean validarValor() {
        if (valor <= 0) {
            status = "Recusado: valor inválido";
            System.out.println("Pagamento recusado: o valor deve ser maior que zero.");
            return false;
        }
        return true;
    }

    protected double getValor() {
        return valor;
    }

    protected String getStatus() {
        return status;
    }

    protected void definirStatus(String status) {
        this.status = status;
    }
}
