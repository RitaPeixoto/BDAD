--Atualizar automaticamente o stock de peças após inserção de registos na
--tabela ReparacaoPeca.

CREATE TRIGGER OFICINA1C
AFTER INSERT ON ReparacaoPeca
Begin
    UPDATE  Peca
    SET quantidade = quantidade - New.quantidade
    WHERE Peca. idPeca = New.idPeca;
End;    