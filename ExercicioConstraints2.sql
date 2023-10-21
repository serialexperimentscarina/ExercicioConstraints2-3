CREATE DATABASE mecanica

USE mecanica

CREATE TABLE cliente(
ID						INT				NOT NULL	IDENTITY(3401,15),
nome					VARCHAR(100)	NOT NULL,
logradouro				VARCHAR(200)	NOT NULL,
numero					INT				NOT NULL	CHECK(numero >= 0),
CEP						CHAR(8)			NOT NULL	CHECK(LEN(CEP) = 8),
complemento				VARCHAR(255)	NOT NULL
PRIMARY KEY(ID)
)

CREATE TABLE telefone_cliente(
clienteID				INT				NOT NULL,
telefone				VARCHAR(11)		NOT NULL	CHECK(LEN(telefone) >= 10)
PRIMARY KEY(clienteID, telefone)
FOREIGN KEY(clienteID) REFERENCES cliente(ID)
)

CREATE TABLE veiculo(
placa					CHAR(7)			NOT NULL	CHECK(LEN(placa) = 7),
marca					VARCHAR(30)		NOT NULL,
modelo					VARCHAR(30)		NOT NULL,
cor						VARCHAR(15)		NOT NULL,
ano_fabricacao			INT				NOT NULL	CHECK(ano_fabricacao > 1997),
ano_modelo				INT				NOT NULL	CHECK(ano_modelo > 1997),
data_aquisicao			DATE			NOT NULL,
clienteID				INT				NOT NULL
PRIMARY KEY(placa),
FOREIGN KEY(clienteID) REFERENCES cliente(ID),
CONSTRAINT chk_ano CHECK(ano_modelo >= ano_fabricacao AND ano_modelo <= ano_fabricacao + 1)
)

CREATE TABLE peca(
ID						INT				NOT NULL	IDENTITY(3411,7),
nome					VARCHAR(30)		NOT NULL	UNIQUE,
preco					DECIMAL(4,2)	NOT NULL	CHECK(preco >= 0),
estoque					INT				NOT NULL	CHECK(estoque >= 10)
PRIMARY KEY(ID)
)

CREATE TABLE categoria(
ID						INT				NOT NULL	IDENTITY(1,1),
categoria				VARCHAR(10)		NOT NULL,
valor_hora				DECIMAL(4,2)	NOT NULL
PRIMARY KEY(ID),
CONSTRAINT chk_cat CHECK((UPPER(categoria) = 'ESTÁGIARIO' AND valor_hora >= 15) OR (UPPER(categoria) = 'NÍVEL 1' AND valor_hora >= 25) OR (UPPER(categoria) = 'NÍVEL 2' AND valor_hora >= 35) OR (UPPER(categoria) = 'NÍVEL 3' AND valor_hora >= 50))
)

CREATE TABLE funcionario(
ID						INT				NOT NULL	IDENTITY(101,1),
nome					INT				NOT NULL,
logradouro				VARCHAR(200)	NOT NULL,
numero					INT				NOT NULL	CHECK(numero >= 0),
telefone				CHAR(11)		NOT NULL	CHECK(LEN(telefone) >= 10),
categoria_habilitacao	VARCHAR(2)		NOT NULL	CHECK(UPPER(categoria_habilitacao) = 'A' OR UPPER(categoria_habilitacao) = 'B' OR UPPER(categoria_habilitacao) = 'C' OR UPPER(categoria_habilitacao) = 'D' OR UPPER(categoria_habilitacao) = 'E'),
categoriaID				INT				NOT NULL
PRIMARY KEY(ID)
FOREIGN KEY(categoriaID) REFERENCES categoria(ID)
)

CREATE TABLE reparo(
veiculoplaca			CHAR(7)			NOT NULL,
funcionarioID			INT				NOT NULL,
pecaID					INT				NOT NULL,
data					DATE			NOT NULL	DEFAULT(GETDATE()),
custo_total				DECIMAL(4,2)	NOT NULL	CHECK(custo_total >= 0),
tempo					INT				NOT NULL	CHECK(tempo >= 0)
PRIMARY KEY(veiculoplaca, funcionarioID, pecaID, data)
FOREIGN KEY(veiculoplaca) REFERENCES veiculo(placa),
FOREIGN KEY(funcionarioID) REFERENCES funcionario(ID),
FOREIGN KEY(pecaID) REFERENCES peca(ID)
)
