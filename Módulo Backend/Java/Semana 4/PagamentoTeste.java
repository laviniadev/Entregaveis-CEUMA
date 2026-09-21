package tarefa04;

public class PagamentoTeste {
    public static void main(String[] args) {
        FormaPagamento pix = new Pix(75.50, "cliente@banco.com");
        FormaPagamento debito = new Debito(120.00, 200.00);
        FormaPagamento credito = new Credito(300.00, 500.00, 3);

        pix.pagar();
        pix.exibirDetalhes();

        debito.pagar();
        debito.exibirDetalhes();

        credito.pagar();
        credito.exibirDetalhes();

        // A validação também impede a cobrança de valores nulos ou negativos.
        FormaPagamento pixComValorInvalido = new Pix(0, "cliente@banco.com");
        pixComValorInvalido.pagar();
        pixComValorInvalido.exibirDetalhes();
    }
}
