# Rede de Hotéis — Modelo de Dados

## Entidades

### 1. Hóspede

* `id_hospede` **(PK)**
* `nome`
* `cpf`
* `email`
* `telefone`

### 2. Quarto

* `id_quarto` **(PK)**
* `numero`
* `tipo`
* `capacidade`
* `valor_diaria`
* `status`

### 3. Reserva

* `id_reserva` **(PK)**
* `id_hospede` **(FK)**
* `id_quarto` **(FK)**
* `data_checkin`
* `data_checkout`
* `quantidade_hospedes`
* `status`

## Relacionamentos

* Um hóspede pode fazer várias reservas, mas cada reserva pertence a um único hóspede. **(1:N)**
* Um quarto pode ter várias reservas ao longo do tempo, mas cada reserva está ligada a um único quarto. **(1:N)**
