DROP TABLE IF EXISTS Marca;
CREATE TABLE Marca(
	idMarca  INTEGER PRIMARY KEY,
	Nome TEXT
);
DROP TABLE IF EXISTS Modelo;
CREATE TABLE Modelo(
	idModelo INTEGER,
    Nome TEXT,
    idMarca TEXT REFERENCES Marca
);
DROP TABLE IF EXISTS CodPostal;
CREATE TABLE CodPostal(
	codPostal1 TEXT PRIMARY KEY,
	Localidade TEXT
);
DROP TABLE IF EXISTS Cliente;
CREATE TABLE Cliente(
	idCliente INTEGER PRIMARY KEY,
    Nome TEXT,
    Morada TEXT,
    codPostal1 TEXT REFERENCES CodPostal,
    codPostal2 TEXT REFERENCES CodPostal,
    Telefone INTEGER
);
DROP TABLE IF EXISTS Carro;
CREATE TABLE Carro(
	idCarro INTEGER PRIMARY KEY,
    Matricula TEXT UNIQUE,
    idModelo INTEGER REFERENCES Modelo,
    idCliente INTEGER REFERENCES Cliente
);
DROP TABLE IF EXISTS Reparacao;
CREATE TABLE Reparacao(
	idReparacao INTEGER PRIMARY KEY,
    DataInicio DATE,
    DataFim DATE CHECK (DataFim > DataInicio),
    idCliente INTEGER REFERENCES Cliente,
    idCarro INTEGER REFERENCES Carro
);
DROP TABLE IF EXISTS Peca;
CREATE TABLE Peca(
	idPeca INTEGER PRIMARY KEY,
    Codigo INTEGER UNIQUE,
    Designacao TEXT,
    CustoUnitario Real CHECK (CustoUnitario > 0),
    Quantidade INTEGER CHECK (Quantidade > 0)
);
DROP TABLE IF EXISTS ReparacaoPeca;
CREATE TABLE ReparacaoPeca(
	idReparacao INTEGER REFERENCES Reparacao,
    idPeca INTEGER REFERENCES Peca,
    PRIMARY KEY(idReparacao,idPeca)
);
DROP TABLE IF EXISTS PecaModelo;
CREATE TABLE PecaModelo(
    idPeca INTEGER REFERENCES Peca,
    idModelo INTEGER REFERENCES Modelo,
    PRIMARY KEY(idPeca,idModelo)
);
DROP TABLE IF EXISTS Especialidade;
CREATE TABLE Especialidade(
	idEspecialidade INTEGER PRIMARY KEY,
    Nome TEXT,
    CustoHorario REAL CHECK (CustoHorario > 0)
);
DROP TABLE IF EXISTS Funcionario;
CREATE TABLE Funcionario(
	idFuncionario INTEGER PRIMARY KEY,
    Nome TEXT,
    Morada TEXT,
    codPostal1 TEXT REFERENCES CodPostal,
    codPostal2 TEXT,
    Telefone INTEGER,
    idEspecialidade INTEGER REFERENCES Especialidade
);
DROP TABLE IF EXISTS FuncionarioReparacao;
CREATE TABLE FuncionarioReparacao(
	idFuncionario INTEGER REFERENCES Funcionario,
    idReparacao INTEGER REFERENCES Reparacao,
    NumHoras INTEGER CHECK (NumHoras > 0),
    PRIMARY KEY(idFuncionario,idReparacao)
);
