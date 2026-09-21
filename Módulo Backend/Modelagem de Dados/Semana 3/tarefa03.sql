-- Sprint 3 - Modelo lógico normalizado até a 3FN
-- Dialeto: MySQL 8.0+

CREATE TABLE hotel (
    id_hotel INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(80) NOT NULL,
    uf CHAR(2) NOT NULL,
    CONSTRAINT ck_hotel_uf CHECK (uf REGEXP '^[A-Z]{2}$')
);

CREATE TABLE hospede (
    id_hospede INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    CONSTRAINT uq_hospede_cpf UNIQUE (cpf),
    CONSTRAINT uq_hospede_email UNIQUE (email),
    CONSTRAINT ck_hospede_cpf CHECK (cpf REGEXP '^[0-9]{11}$'),
    CONSTRAINT ck_hospede_email CHECK (email LIKE '%_@_%._%')
);

CREATE TABLE quarto (
    id_quarto INT PRIMARY KEY AUTO_INCREMENT,
    id_hotel INT NOT NULL,
    numero VARCHAR(10) NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    capacidade SMALLINT NOT NULL,
    valor_diaria DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'DISPONIVEL',
    CONSTRAINT uq_quarto_hotel_numero UNIQUE (id_hotel, numero),
    CONSTRAINT ck_quarto_tipo CHECK (tipo IN ('STANDARD', 'LUXO', 'SUITE')),
    CONSTRAINT ck_quarto_capacidade CHECK (capacidade > 0),
    CONSTRAINT ck_quarto_valor_diaria CHECK (valor_diaria > 0),
    CONSTRAINT ck_quarto_status CHECK (status IN ('DISPONIVEL', 'OCUPADO', 'MANUTENCAO')),
    CONSTRAINT fk_quarto_hotel
        FOREIGN KEY (id_hotel) REFERENCES hotel (id_hotel)
);

CREATE TABLE reserva (
    id_reserva INT PRIMARY KEY AUTO_INCREMENT,
    id_hospede INT NOT NULL,
    id_quarto INT NOT NULL,
    data_checkin DATE NOT NULL,
    data_checkout DATE NOT NULL,
    quantidade_hospedes SMALLINT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'PENDENTE',
    CONSTRAINT ck_reserva_periodo CHECK (data_checkout > data_checkin),
    CONSTRAINT ck_reserva_quantidade CHECK (quantidade_hospedes > 0),
    CONSTRAINT ck_reserva_status CHECK (status IN ('PENDENTE', 'CONFIRMADA', 'CANCELADA', 'CONCLUIDA')),
    CONSTRAINT fk_reserva_hospede
        FOREIGN KEY (id_hospede) REFERENCES hospede (id_hospede),
    CONSTRAINT fk_reserva_quarto
        FOREIGN KEY (id_quarto) REFERENCES quarto (id_quarto)
);

-- Três INSERTs por tabela.
INSERT INTO hotel (nome, cidade, uf) VALUES ('Hotel Beira Mar', 'Fortaleza', 'CE');
INSERT INTO hotel (nome, cidade, uf) VALUES ('Hotel Jardins', 'São Paulo', 'SP');
INSERT INTO hotel (nome, cidade, uf) VALUES ('Hotel Serra Verde', 'Gramado', 'RS');

INSERT INTO hospede (nome, cpf, email, telefone) VALUES ('Ana Souza', '12345678901', 'ana.souza@email.com', '85999990001');
INSERT INTO hospede (nome, cpf, email, telefone) VALUES ('Bruno Lima', '23456789012', 'bruno.lima@email.com', '11999990002');
INSERT INTO hospede (nome, cpf, email, telefone) VALUES ('Carla Mendes', '34567890123', 'carla.mendes@email.com', '54999990003');

INSERT INTO quarto (id_hotel, numero, tipo, capacidade, valor_diaria, status) VALUES (1, '101', 'STANDARD', 2, 180.00, 'DISPONIVEL');
INSERT INTO quarto (id_hotel, numero, tipo, capacidade, valor_diaria, status) VALUES (2, '205', 'LUXO', 2, 320.00, 'OCUPADO');
INSERT INTO quarto (id_hotel, numero, tipo, capacidade, valor_diaria, status) VALUES (3, '010', 'SUITE', 4, 550.00, 'DISPONIVEL');

INSERT INTO reserva (id_hospede, id_quarto, data_checkin, data_checkout, quantidade_hospedes, status) VALUES (1, 1, '2026-10-10', '2026-10-13', 2, 'CONFIRMADA');
INSERT INTO reserva (id_hospede, id_quarto, data_checkin, data_checkout, quantidade_hospedes, status) VALUES (2, 2, '2026-09-04', '2026-09-07', 1, 'CONCLUIDA');
INSERT INTO reserva (id_hospede, id_quarto, data_checkin, data_checkout, quantidade_hospedes, status) VALUES (3, 3, '2026-12-20', '2026-12-25', 3, 'PENDENTE');

-- Consulta 1: reservas com hóspede, quarto e hotel.
SELECT
    r.id_reserva,
    h.nome AS hospede,
    ht.nome AS hotel,
    q.numero AS quarto,
    r.data_checkin,
    r.data_checkout,
    r.quantidade_hospedes,
    r.status
FROM reserva AS r
JOIN hospede AS h ON h.id_hospede = r.id_hospede
JOIN quarto AS q ON q.id_quarto = r.id_quarto
JOIN hotel AS ht ON ht.id_hotel = q.id_hotel
ORDER BY r.data_checkin;

-- Consulta 2: quartos e quantidade de reservas registradas por hotel.
SELECT
    ht.nome AS hotel,
    q.numero AS quarto,
    q.tipo,
    q.status,
    COUNT(r.id_reserva) AS total_reservas
FROM hotel AS ht
JOIN quarto AS q ON q.id_hotel = ht.id_hotel
LEFT JOIN reserva AS r ON r.id_quarto = q.id_quarto
GROUP BY ht.id_hotel, ht.nome, q.id_quarto, q.numero, q.tipo, q.status
ORDER BY ht.nome, q.numero;
