-- Active: 1688235154457@@127.0.0.1@5432@tipoibge@public

CREATE Table
    Cidade(
        id INT PRIMARY KEY,
        nome_cidade VARCHAR(200),
        id_estado INT,
        capital BOOLEAN,
        qtd_populacao INT
    );

CREATE TABLE
    Estado(
        id INT PRIMARY KEY,
        id_pais INT,
        nome_estado VARCHAR(200)
    );

CREATE TABLE
    Pais(
        id INT PRIMARY KEY,
        nome_pais VARCHAR(200),
        continente VARCHAR(200)
    );


/* INSERIR DADOS*/
INSERT INTO pais( id, nome_pais, continente)
VALUES (1, 'Brasil', 'América do Sul'), (2, 'Argentina', 'América do Sul'), (3, 'Estados Unidos', 'América do Norte'), (4, 'República Dominicana', 'América Central'), (5, 'El Salvador', 'América Central'), (6, 'Chile', 'América do Sul');


INSERT INTO
    estado (id, id_pais, nome_estado)
VALUES (1, 1, 'São Paulo'), (2, 1, 'Rio de Janeiro'), (3, 2, 'Província de Buenos Aires'), (4, 3, 'California'), (5, 4, 'Distrito Nacional'), (6, 1, 'Maranhão'), (7, 5, 'San Salvador'), (8, 6, 'Santiago');

INSERT INTO
    cidade (
        id,
        nome_cidade,
        id_estado,
        capital,
        qtd_populacao
    )
VALUES (
        1,
        'São Paulo',
        1,
        'True',
        1234567
    ), (
        2,
        'Rio de Janeiro',
        1,
        'False',
        987654
    ), (
        3,
        'Buenos Aires',
        2,
        'True',
        2897365
    ), (
        4,
        'San Francisco',
        5,
        'True',
        883305
    ), (
        5,
        'Santo Domingo',
        4,
        'True',
        965040
    ), (
        6,
        'São Luís',
        6,
        'False',
        1108975
    ), (
        7,
        'San Salvador',
        7,
        'True',
        567698
    ), (
        8,
        'Santiago',
        8,
        'True',
        7224845
    );


/*SCRIPT SQL*/

SELECT -- SELECIONA AS COLUNAS COM NOMES DE CIDADE, ESTADO E PAÍS
    p.nome_pais,
    e.nome_estado,
    c.nome_cidade
FROM cidade c -- DEFINE cidade COMO TABELA PRINCIPAL DA CONSULTA
    JOIN estado e ON c.id_estado = e.id -- REALIZA A JUNÇÃO ENTRE A TABELA ESTADO E CIDADE / PAIS E ESTADO
    JOIN pais p ON e.id_pais = p.id
WHERE -- FILTRA CIDADES QUE SÃO CAPITAIS, COM POPULAÇÃO MAIOR QUE 500 MIL E COM NOMES SANTOS
    c.capital = 'True'
    AND c.qtd_populacao > 500000
    AND (
        e.nome_estado LIKE 'São%'
        OR e.nome_estado LIKE 'Santo%'
        OR e.nome_estado LIKE 'San%'
        OR e.nome_estado LIKE 'Saint%'
    )
    AND p.continente IN (
        'América no Norte',
        'América Central',
        'América do Sul'
    )
ORDER BY
    p.nome_pais,
    e.nome_estado,
    c.nome_cidade;
