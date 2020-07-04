--Quando se inserem registos numa vista com os nomes de todos os modelos e
--respetivas marcas, estas inserções sejam propagadas para as tabelas que dão
--origem à vista

/*
Soluçao professora:
CREATE VIEW modelosMarcas AS
SELECT Modelo.nome AS nomeModelo, Marca.nome AS nomeMarca FROM Modelo, Marca
WHERE Modelo.idMarca=Marca.idMarca;


CREATE TRIGGER insertOnView 
INSTEAD OF INSERT ON modelosMarcas 
FOR EACH ROW
BEGIN 
  INSERT INTO Marca (nome) VALUES (NEW.nomeMarca);
  INSERT INTO Modelo (nome, idMarca) SELECT NEW.nomeModelo, idMarca FROM Marca WHERE nome=NEW.nomeMarca;
END;

-- Teste dos gatilhos validaPecasReparacao e atualizaStockPecas
--INSERT INTO ReparacaoPeca (idReparacao, idPeca, quantidade) VALUES (3, 1, 20);--Peça incompativel
--INSERT INTO ReparacaoPeca (idReparacao, idPeca, quantidade) VALUES (3, 2, 12);--Quantidade indiponível
--INSERT INTO ReparacaoPeca (idReparacao, idPeca, quantidade) VALUES (3, 2, 2);
--SELECT * FROM ReparacaoPeca;
--SELECT * FROM Peca;

-- Teste do gatilho defaultCliente
--INSERT INTO Reparacao (dataInicio, dataFim, idCliente, idCarro) VALUES ('2010-07-14', '2010-07-16', NULL, 5);
--SELECT * FROM Reparacao;

-- Teste do gatilho insertOnView
--INSERT INTO modelosMarcas VALUES ('Legacy 2.5i Premium','Subaru');
--INSERT INTO modelosMarcas VALUES ('Megane','Renault');
--SELECT * FROM Marca;
--SELECT * FROM Modelo;




*/