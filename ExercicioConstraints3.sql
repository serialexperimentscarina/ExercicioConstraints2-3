CREATE DATABASE maternidade

USE maternidade

CREATE TABLE mae(
ID_mae					INT				NOT NULL	IDENTITY(1001,1),
nome					VARCHAR(60)		NOT NULL,
logradouro_endereco		VARCHAR(100)	NOT NULL,
numero_endereco			INT				NOT NULL	CHECK(numero_endereco >= 0),
CEP_endereco			CHAR(8)			NOT NULL	CHECK(LEN(CEP_endereco) = 8),
complemento_endereco	VARCHAR(200)	NOT NULL,
telefone				CHAR(10)		NOT NULL	CHECK(LEN(telefone) = 10),
data_nasc				DATE			NOT NULL
PRIMARY KEY(ID_mae)
)

CREATE TABLE bebe(
ID_bebe					INT				NOT NULL	IDENTITY(1,1),
nome					VARCHAR(60)		NOT NULL,
data_nasc				DATE			NOT NULL	DEFAULT(GETDATE()),
altura					DECIMAL(7,2)	NOT NULL	CHECK(altura <= 0),
peso					DECIMAL(4,3)	NOT NULL	CHECK(peso <= 0),
maeID_mae				INT				NOT NULL
PRIMARY KEY(ID_bebe)
FOREIGN KEY(maeID_mae) REFERENCES mae(ID_mae)
)

CREATE TABLE medico(
CRM_numero				INT				NOT NULL,
CRM_UF					CHAR(2)			NOT NULL,
nome					VARCHAR(60)		NOT NULL,
telefone_celular		CHAR(11)		NOT NULL	UNIQUE	CHECK(LEN(telefone_celular) = 10),
especialidade			VARCHAR(30)		NOT NULL
PRIMARY KEY(CRM_Numero, CRM_UF)
)

CREATE TABLE bebe_medico(
bebeID_bebe				INT				NOT NULL,
medicoCRM_numero		INT				NOT NULL,
medicoCRM_UF			CHAR(2)			NOT NULL,
PRIMARY KEY(bebeID_bebe, medicoCRM_numero, medicoCRM_UF),
FOREIGN KEY(bebeID_bebe) REFERENCES bebe(ID_bebe),
FOREIGN KEY(medicoCRM_numero,medicoCRM_UF) REFERENCES medico(CRM_Numero, CRM_UF)
)