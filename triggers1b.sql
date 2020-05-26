--Simultaneamente: (1) impedir a atribuição de peças não compatíveis com o
--modelo do carro em reparação; e (2) impedir a atribuição de peças sem stock
--suficiente para satisfazer a quantidade pretendida na reparação.


CREATE TRIGGER OFICINA1B
BEFORE INSERT ON ReparacaoPeca
WHEN New.idPeca NOT IN 
(SELECT idPeca FROM ReparacaoPeca WHERE idModelo = (SELECT idModelo FROM Carro WHERE idCarro= (SELECT idCarro FROM Reparacao WHERE idReparacao = New.idReparacao)))
OR
New.idPeca IN
(SELECT idPeca FROM Peca  WHERE quantidade < New.quantidade)
Begin
    Select raise(ignore);
END;


/*
CREATE TRIGGER validaPecasReparacao 
BEFORE INSERT ON ReparacaoPeca 
FOR EACH ROW
BEGIN 
SELECT CASE 
WHEN ((SELECT COUNT(*) FROM 
	 Peca, PecaModelo, Carro, Reparacao
	 WHERE Peca.idPeca = PecaModelo.idPeca
	 AND PecaModelo.idModelo = Carro.idModelo
	 AND Carro.idCarro = Reparacao.idCarro
	 AND Reparacao.idReparacao = NEW.idReparacao
	 AND Peca.idPeca = NEW.idPeca
	 AND Peca.quantidade >= NEW.quantidade) = 0) 
THEN RAISE(ABORT, 'Peça ou quantidade invalidos.')
END; 
END;
*/