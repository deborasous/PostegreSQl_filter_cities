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

/* INSERIR DADOS ESPANHA*/

INSERT INTO
    pais(id, nome_pais, continente)
VALUES (7, 'Espanha', 'Europa');

INSERT INTO
    estado (id, id_pais, nome_estado)
VALUES (16, 7, 'Andaluzia');

INSERT INTO
    cidade (
        id,
        nome_cidade,
        id_estado,
        capital,
        qtd_populacao
    )
VALUES (17, 'Toulouse', 8, 'False', 479553);


/*SCRIPT SQL*/

SELECT
    -- SELECIONA AS COLUNAS COM NOMES DE CIDADE, ESTADO E PAÍS
    p.nome_pais,
    e.nome_estado,
    c.nome_cidade
FROM
    cidade c -- DEFINE cidade COMO TABELA PRINCIPAL DA CONSULTA
    JOIN estado e ON c.id_estado = e.id -- REALIZA A JUNÇÃO ENTRE A TABELA ESTADO E CIDADE / PAIS E ESTADO
    JOIN pais p ON e.id_pais = p.id
WHERE
    -- FILTRA CIDADES QUE SÃO CAPITAIS, COM POPULAÇÃO MAIOR QUE 500 MIL E COM NOMES SANTOS
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

/*RETORNAR PAISES QUE TENHAM MAIS HABITANTES QUE A POPULAÇÃO TOTAL DAS CIDADES DA ESPANHA*/

SELECT
    p.nome_pais,
    SUM(c.qtd_populacao) AS total_populacao
FROM cidade c
    JOIN estado e ON c.id_estado = e.id
    JOIN pais p ON e.id_pais = p.id
GROUP BY p, nome_pais
HAVING SUM(c.qtd_populacao) > (
        SELECT
            SUM(qtd_populacao)
        FROM cidade c
            JOIN estado e ON c.id_estado = e.id
            JOIN pais p ON e.id_pais = p.id
        WHERE
            p.nome_pais = 'Espanha'
    )
ORDER BY total_populacao DESC;

SELECT p.nome_pais, SUM(c.qtd_populacao) AS total_populacao
FROM Pais p
JOIN Estado e ON p.id = e.id_pais
JOIN Cidade c ON e.id = c.id_estado
WHERE p.continente = 'Europa'
GROUP BY p.nome_pais;
