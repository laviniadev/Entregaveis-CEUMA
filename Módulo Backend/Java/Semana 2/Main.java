public class Main {
    public static void main(String[] args) {
        Pessoa pessoa1 = new Pessoa("Ana", 25, "São Luís");
        Pessoa pessoa2 = new Pessoa("Bruno", 32, "Imperatriz");
        Pessoa pessoa3 = new Pessoa("Carla", 28, "Caxias");

        if (pessoa1.idade > pessoa2.idade && pessoa1.idade > pessoa3.idade) {
            System.out.println(pessoa1.nome + " é a pessoa mais velha.");
        } else if (pessoa2.idade > pessoa1.idade && pessoa2.idade > pessoa3.idade) {
            System.out.println(pessoa2.nome + " é a pessoa mais velha.");
        } else {
            System.out.println(pessoa3.nome + " é a pessoa mais velha.");
        }

        Carro carro1 = new Carro("Toyota", "Corolla", 2020);
        Carro carro2 = new Carro("Honda", "Civic", 2022);

        carro1.ano = 2021;

        System.out.println("Carro 1: " + carro1.marca + ", " + carro1.modelo + ", " + carro1.ano);
        System.out.println("Carro 2: " + carro2.marca + ", " + carro2.modelo + ", " + carro2.ano);

    }
}
