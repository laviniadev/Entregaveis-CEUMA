package tarefa04;

public class Pix extends FormaPagamento {
    private final String chavePix;

    public Pix(double valor, String chavePix) {
        super(valor);
        this.chavePix = chavePix;
    }

    @Override
    public void pagar() {
        if (!validarValor()) {
            return;
        }

        definirStatus("Aprovado instantaneamente");
        System.out.println("Pagamento via Pix aprovado.");
    }

    @Override
    public void exibirDetalhes() {
        System.out.println("Pix | Valor: R$ " + getValor() + " | Status: " + getStatus()
                + " | Chave: " + chavePix);
    }
}
