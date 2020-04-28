--a
SELECT * FROM Peca WHERE (custoUnitario<10 AND codigo like '%98%');
--b
SELECT * from Reparacao WHERE (dataInicio>='2010-09-01' AND dataFim<='2010-09-30');
--c
SELECT C2.nome FROM Reparacao
INNER JOIN ReparacaoPeca RP on Reparacao.idReparacao = RP.idReparacao
INNER JOIN Carro C on Reparacao.idCarro = C.idCarro
INNER JOIN Cliente C2 on C.idCliente = C2.idCliente
INNER JOIN Peca P on RP.idPeca = P.idPeca
WHERE P.custoUnitario > 10 ORDER BY P.custoUnitario DESC;
--d
SELECT nome FROM Cliente WHERE idCliente NOT IN (SELECT idCliente FROM Carro);
--e
SELECT idcarro, count(*) AS num FROM Reparacao GROUP BY idcarro;
--f
SELECT matricula, sum(strftime('%d', dataFim)-strftime('%d',dataInicio)) "Ndias" From carro, Reparacao WHERE carro.idcarro=reparacao.idcarro GROUP BY matricula;
--g 


--n


--o


--p


--s


