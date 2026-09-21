# Modelo Lógico — Rede de Hotéis

```mermaid
erDiagram
    HOTEL ||--o{ QUARTO : possui
    HOSPEDE ||--o{ RESERVA : realiza
    QUARTO ||--o{ RESERVA : recebe

    HOTEL {
        INT id_hotel PK
        VARCHAR nome
        VARCHAR cidade
        CHAR uf
    }

    HOSPEDE {
        INT id_hospede PK
        VARCHAR nome
        CHAR cpf UK
        VARCHAR email UK
        VARCHAR telefone
    }

    QUARTO {
        INT id_quarto PK
        INT id_hotel FK
        VARCHAR numero
        VARCHAR tipo
        SMALLINT capacidade
        DECIMAL valor_diaria
        VARCHAR status
    }

    RESERVA {
        INT id_reserva PK
        INT id_hospede FK
        INT id_quarto FK
        DATE data_checkin
        DATE data_checkout
        SMALLINT quantidade_hospedes
        VARCHAR status
    }
```

## Relações e regras

- Um **hotel** possui zero ou muitos quartos; cada quarto pertence a exatamente um hotel.
- Um **hóspede** realiza zero ou muitas reservas; cada reserva pertence a exatamente um hóspede.
- Um **quarto** pode constar em zero ou muitas reservas ao longo do tempo; cada reserva é para exatamente um quarto.
- O número do quarto é único dentro do hotel (`id_hotel`, `numero`).
