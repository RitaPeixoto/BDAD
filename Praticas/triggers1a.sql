--Se não for especificado o cliente aquando a inserção de uma reparação,
--assumir que o cliente é o proprietário do carro.

CREATE TRIGGER OFICINA1A
AFTER INSERT ON Reparacao
WHEN (New.idClient is NULL)
Begin
    UPDATE Reparacao
    SET idCliente = (SELECT idCliente FROM Carro WHERE idCarro = New.idCarro)
    WHERE idReparcao = New.idReparacao;
END;
