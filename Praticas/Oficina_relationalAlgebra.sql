--a
SELECT * FROM Peca WHERE (custoUnitario<10 AND codigo like '%98%');
--b
SELECT * from Reparacao WHERE (dataInicio>='2010-09-01' AND dataFim<='2010-09-30');
 ou
 SELECT	matricula
FROM	Carro,	Reparacao
WHERE	Carro.idCarro=Reparacao.idCarro	AND	strftime('%m',	
dataFim)	=	'09'	AND	strftime('%Y',	dataFim)	=	'2010';
--c
SELECT C2.nome FROM Reparacao
INNER JOIN ReparacaoPeca RP on Reparacao.idReparacao = RP.idReparacao
INNER JOIN Carro C on Reparacao.idCarro = C.idCarro
INNER JOIN Cliente C2 on C.idCliente = C2.idCliente
INNER JOIN Peca P on RP.idPeca = P.idPeca
WHERE P.custoUnitario > 10 ORDER BY P.custoUnitario DESC;

ou 
SELECT	nome	FROM	Cliente,	Carro,	Reparacao,	ReparacaoPeca,	Peca
WHERE	Cliente.idCliente=Carro.idCliente
AND	Carro.idCarro=Reparacao.idCarro
AND	Reparacao.idReparacao=ReparacaoPeca.idReparacao
AND	ReparacaoPeca.idPeca=Peca.idPeca
AND	custoUnitario>10
ORDER	BY	custoUnitario	DESC;
--d
SELECT nome FROM Cliente WHERE idCliente NOT IN (SELECT idCliente FROM Carro);

--e
SELECT idcarro, count(*) AS num FROM Reparacao GROUP BY idcarro;
ou
SELECT	matricula,	COUNT(*)	"Num	Reparacoes"	FROM	Carro,	
Reparacao
WHERE	Carro.idCarro	=	Reparacao.idCarro
GROUP	BY	matricula;
--f
SELECT matricula, sum(strftime('%d', dataFim)-strftime('%d',dataInicio)) "Ndias" From carro, Reparacao WHERE carro.idcarro=reparacao.idcarro GROUP BY matricula;


--g 
SELECT	AVG(custoUnitario)	"Média",	SUM(custoUnitario*quantidade)	
"Val	total", COUNT(*)	"No	de	peças",	MIN(custoUnitario)	"preço	
menor",	MAX(custoUnitario)	"preço	maior"
FROM	Peca;


--h
CREATE	VIEW	EspecialidadesMarca	AS	
SELECT	Marca.nome	AS	nomeMarca,	Especialidade.nome	AS	
nomeEspec,	COUNT(*)	AS	numEspecMarca
FROM	Especialidade,	Funcionario,	FuncionarioReparacao,	Reparacao,	
Carro,	Modelo,	Marca
WHERE	Especialidade.idEspecialidade=Funcionario.idEspecialidade	
AND	Funcionario.idFuncionario=FuncionarioReparacao.idFuncionario	
AND	FuncionarioReparacao.idReparacao=Reparacao.idReparacao	AND	
Reparacao.idCarro=Carro.idCarro	AND	
Carro.idModelo=Modelo.idModelo	AND	
Modelo.idMarca=Marca.idMarca
GROUP	BY	Marca.nome,	Especialidade.nome;
SELECT	nomeMarca	AS	nomeMarca1,	nomeEspec
FROM	EspecialidadesMarca
WHERE	numEspecMarca	IN	(
SELECT	MAX(numEspecMarca)
FROM	EspecialidadesMarca
GROUP	BY	nomeMarca
HAVING	nomeMarca=nomeMarca1);

--i
CREATE	VIEW	PrecoReparacao1	AS
SELECT	FuncionarioReparacao.idReparacao	AS	idReparacao,	
ifnull(SUM(Especialidade.custoHorario*FuncionarioReparacao.numHo
ras),0)	AS	precoFuncionario
FROM	Especialidade,	Funcionario,	FuncionarioReparacao
WHERE	Especialidade.idEspecialidade=Funcionario.idEspecialidade	
AND	Funcionario.idFuncionario=FuncionarioReparacao.idFuncionario
GROUP	BY	FuncionarioReparacao.idReparacao;
CREATE	VIEW	PrecoReparacao2	AS	
SELECT	ReparacaoPeca.idReparacao	AS	idReparacao,	
ifnull(SUM(Peca.custoUnitario*ReparacaoPeca.quantidade),0)	AS	
precoPeca	
FROM	ReparacaoPeca,	Peca
WHERE	ReparacaoPeca.idPeca=Peca.idpeca
GROUP	BY	ReparacaoPeca.idReparacao;
CREATE	VIEW	precoReparacao	AS	
SELECT	ifnull(idReparacao1,idReparacao2)	AS	idReparacao,	
ifnull(precoFuncionario,0)	+	ifnull(precoPeca,0)	AS	preco
FROM
(SELECT	PrecoReparacao1.idReparacao	AS	idReparacao1,	
PrecoReparacao1.precoFuncionario,	PrecoReparacao2.idReparacao	AS	
idReparacao2,	PrecoReparacao2.precoPeca
FROM	PrecoReparacao1	
LEFT	JOIN	PrecoReparacao2	
ON	PrecoReparacao1.idReparacao	=	PrecoReparacao2.idReparacao
UNION	ALL
SELECT	PrecoReparacao1.idReparacao	AS	idReparacao1,	
PrecoReparacao1.precoFuncionario,	PrecoReparacao2.idReparacao	AS	
idReparacao2,	PrecoReparacao2.precoPeca
FROM	PrecoReparacao2
LEFT	JOIN	PrecoReparacao1
ON	PrecoReparacao1.idReparacao	=	PrecoReparacao2.idReparacao
WHERE		PrecoReparacao1.idReparacao	IS	NULL);

--j
CREATE	VIEW	PrecoReparacao1	AS
SELECT	FuncionarioReparacao.idReparacao	AS	idReparacao,	
ifnull(SUM(Especialidade.custoHorario*FuncionarioReparacao.numHo
ras),0)	AS	precoFuncionario
FROM	Especialidade,	Funcionario,	FuncionarioReparacao
WHERE	Especialidade.idEspecialidade=Funcionario.idEspecialidade	
AND	Funcionario.idFuncionario=FuncionarioReparacao.idFuncionario
GROUP	BY	FuncionarioReparacao.idReparacao;
CREATE	VIEW	PrecoReparacao2	AS	
SELECT	ReparacaoPeca.idReparacao	AS	idReparacao,	
ifnull(SUM(Peca.custoUnitario*ReparacaoPeca.quantidade),0)	AS	
precoPeca	
FROM	ReparacaoPeca,	Peca
WHERE	ReparacaoPeca.idPeca=Peca.idpeca
GROUP	BY	ReparacaoPeca.idReparacao;
CREATE	VIEW	precoReparacao	AS	
SELECT	ifnull(idReparacao1,idReparacao2)	AS	idReparacao,
ifnull(precoFuncionario,0)	+	ifnull(precoPeca,0)	AS	preco
FROM
(SELECT	PrecoReparacao1.idReparacao	AS	idReparacao1,	
PrecoReparacao1.precoFuncionario,	PrecoReparacao2.idReparacao	AS	
idReparacao2,	PrecoReparacao2.precoPeca
FROM	PrecoReparacao1	
LEFT	JOIN	PrecoReparacao2	
ON	PrecoReparacao1.idReparacao	=	PrecoReparacao2.idReparacao
UNION	ALL
SELECT	PrecoReparacao1.idReparacao	AS	idReparacao1,	
PrecoReparacao1.precoFuncionario,	PrecoReparacao2.idReparacao	AS	
idReparacao2,	PrecoReparacao2.precoPeca
FROM	PrecoReparacao2
LEFT	JOIN	PrecoReparacao1
ON	PrecoReparacao1.idReparacao	=	PrecoReparacao2.idReparacao
WHERE		PrecoReparacao1.idReparacao	IS	NULL)
WHERE	preco>60;
Com	a	vista	PrecoReparacao
SELECT	*	FROM	PrecoReparacao	WHERE	preco>60;

--k
SELECT	nome
FROM	Cliente,	Carro,	Reparacao,	PrecoReparacao
WHERE	Cliente.idCliente=Carro.idCliente
AND	Carro.idCarro=Reparacao.idCarro
AND	Reparacao.idReparacao=PrecoReparacao.idReparacao
AND	PrecoReparacao.preco	=	(SELECT	MAX(preco)	FROM	
PrecoReparacao);

--l
SELECT	matricula
FROM	Carro,	Reparacao,	PrecoReparacao
WHERE	Carro.idCarro=Reparacao.idCarro
AND	Reparacao.idReparacao=PrecoReparacao.idReparacao
AND	PrecoReparacao.preco	=
(SELECT	MAX(preco)	FROM	PrecoReparacao	
WHERE	preco	NOT	IN	
(SELECT	MAX(preco)	FROM	PrecoReparacao));

--m
SELECT	*	FROM	PrecoReparacao	ORDER	BY	preco DESC	LIMIT	3;

--n
SELECT	C1.nome	"Proprietário",	C2.nome	"Cliente"
FROM	Cliente	C1,	Cliente	C2,	Carro,	Reparacao
WHERE	Reparacao.idCarro=Carro.idCarro
AND	Carro.idCliente=C1.idCliente
AND	Reparacao.idCliente=C2.idCliente
AND	C1.idCliente<>C2.idCliente;

--o
SELECT	localidade	FROM	CodPostal,	Cliente
WHERE	CodPostal.codPostal1=Cliente.codPostal1
UNION
SELECT	localidade	FROM	CodPostal,	Funcionario
WHERE	CodPostal.codPostal1=Funcionario.codPostal1;

--p

SELECT	localidade	FROM	CodPostal,	Cliente
WHERE	CodPostal.codPostal1=Cliente.codPostal1
INTERSECT
SELECT	localidade	FROM	CodPostal,	Funcionario
WHERE	CodPostal.codPostal1=Funcionario.codPostal1;

--q
Sem	utilização	de	vistas
SELECT	codigo
FROM	Peca,	PecaModelo,	Modelo,	Marca
WHERE	Peca.idPeca=PecaModelo.idPeca	AND	
PecaModelo.idModelo=Modelo.idModelo	AND	
Modelo.idMarca=Marca.idMarca
AND	Marca.nome='Volvo'	AND	Peca.custoUnitario	>	(SELECT	
MAX(Peca.custoUnitario)	FROM	Peca,	PecaModelo,	Modelo,	Marca	
WHERE	Peca.idPeca=PecaModelo.idPeca	AND	
PecaModelo.idModelo=Modelo.idModelo	AND	
Modelo.idMarca=Marca.idMarca	AND	Marca.nome='Renault');
Com	utilização	de	vistas
CREATE	VIEW	PecasMarca	AS
SELECT	Peca.idPeca	as	idPeca,	Marca.nome	as	nomeMarca
FROM	Peca,	PecaModelo,	Modelo,	Marca
WHERE	Peca.idPeca=PecaModelo.idPeca	AND	
PecaModelo.idModelo=Modelo.idModelo	AND	
Modelo.idMarca=Marca.idMarca;
SELECT	código
FROM	Peca,	PecasMarca
WHERE	Peca.idPeca=PecasMarca.idPeca	AND	
PecasMarca.nomeMarca='Volvo'	AND	Peca.	custoUnitario	>	(SELECT	
MAX(custoUnitario)	FROM	Peca,	PecasMarca	WHERE	
Peca.idPeca=PecasMarca.idPeca	AND	
PecasMarca.nomeMarca='Renault');


--r
SELECT	código
FROM	Peca,	PecasMarca
WHERE	Peca.idPeca=PecasMarca.idPeca	AND	
PecasMarca.nomeMarca='Volvo'	AND	Peca.custoUnitario	>	(SELECT	
MIN(custoUnitario)	FROM	Peca,	PecasMarca	WHERE	
Peca.idPeca=PecasMarca.idPeca	AND	
PecasMarca.nomeMarca='Renault');

--s
SELECT	matricula	FROM	Carro
WHERE	idCarro	IN
(SELECT	idCarro	FROM	Reparacao
GROUP	BY	idCarro
HAVING	COUNT(*)>1);

--t 
SELECT	dataInicio,	dataFim,	Cliente.nome
FROM	Reparacao,	Cliente,	Carro
WHERE	Reparacao.idCarro=Carro.idCarro	AND	
Carro.idCliente=Cliente.idCliente	AND	Carro.idCarro	IN
(SELECT	idCarro	FROM	Reparacao
GROUP	BY	idCarro
HAVING	COUNT(*)>1);

--u
SELECT	idReparacao
FROM	Reparacao
WHERE	idReparacao	NOT	IN
(SELECT	idReparacao	AS	idReparacao1	FROM	Reparacao,	
Especialidade
WHERE	idEspecialidade	NOT	IN
(SELECT	idEspecialidade
FROM	FuncionarioReparacao,Funcionario
WHERE	
FuncionarioReparacao.idFuncionario=Funcionario.idFuncionario	AND	
FuncionarioReparacao.idReparacao=idReparacao1));

--v
SELECT	idReparacao,	ifnull(dataFim,date('now'))-dataInicio	"Duração"	
FROM	Reparacao;

--w
SELECT	CASE	WHEN	Marca.nome='Renault'	THEN	'Top'
WHEN	Marca.nome='Volvo'	THEN	'Down'
ELSE	'NoWay'	END	AS	nomemarca
FROM	Carro,	Modelo,	Marca
WHERE	Carro.idModelo=Modelo.idmodelo	AND	
Modelo.idMarca=Marca.idMarca;

