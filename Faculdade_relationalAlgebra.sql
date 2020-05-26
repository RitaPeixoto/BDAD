--1
SELECT nr FROM Aluno;
--2
SELECT cod, Design FROM Cadeira WHERE curso =='AC';
--3
SELECT Aluno.nome FROM Aluno, Prof Where Aluno.nome == Prof.nome;
SELECT nome FROM aluno INTERSECT SELECT nome FROM prof;
--4
SELECT Aluno.nome FROM Aluno EXCEPT SELECT Aluno.nome FROM Aluno, Prof WHERE Aluno.nome == Prof.nome;
SELECT	nome	FROM	Aluno	EXCEPT	SELECT	nome	FROM	Prof
--5
SELECT nome FROM Aluno UNION SELECT nome FROM Prof;
SELECT nome FROM Aluno UNION ALL SELECT nome FROM Prof;--to have all of the names

--6
SELECT  Aluno.nome FROM Aluno,Prova WHERE Aluno.nr==Prova.nr AND Prova.cod=='TS1';
SELECT Aluno.nome FROM Aluno WHERE Aluno.nr in (SELECT Prova.nr FROM Prova WHERE cod = 'TS1');
SELECT	nome FROM Aluno WHERE	nr	in	(SELECT	distinct	Aluno.nr FROM	Aluno,	Prova WHERE	Aluno.nr=Prova.nr	AND	Prova.cod=’TS1’);

--7
SELECT nome FROM aluno WHERE aluno.nr IN (SELECT nr from prova NATURAL JOIN cadeira WHERE cadeira.curso='IS');
SELECT nome FROM aluno WHERE Aluno.nr in (SELECT nr FROM prova WHERE cod in (SELECT cod FROM cadeira WHERE curso = 'IS'));--prefereble not to use so many subqueries, avoid several levels of nested subqueries
SELECT nome FROM (SELECT	DISTINCT	Aluno.nr, nome	FROM	Aluno,	Cadeira,	Prova	WHERE	Aluno.nr=Prova.nr	AND	Prova.cod=Cadeira.cod	AND	Cadeira.curso	=	'IS');

--8
SELECT DISTINCT nome FROM Aluno WHERE nr NOT IN
(SELECT nr AS alunonr
FROM Aluno, Cadeira
WHERE curso='IS' AND NOT (cod IN
(SELECT cod
FROM Prova
WHERE nota>=10 AND nr=alunonr))
);

--9
SELECT DISTINCT nota FROM Prova P1 WHERE not exists(select * from Prova P2 where P1.nota < P2.nota);
SELECT max(prova.nota) FROM prova;

--10
SELECT DISTINCT (select avg(nota) FROM Prova WHERE Prova.cod == 'BD') FROM Prova;
SELECT avg(prova.nota) FROM prova WHERE prova.cod='BD';

--11
SELECT count(*) FROM Aluno;
SELECT count(aluno.nome) FROM aluno;

--12
SELECT cadeira.curso, count(*) FROM cadeira GROUP BY cadeira.curso;
--13
SELECT aluno.Nome, count(*) FROM aluno, prova WHERE aluno.nr = prova.nr GROUP BY aluno.Nome;
SELECT	nr,	count(*)	FROM	Prova	GROUP	BY	nr;

--14
SELECT avg(number) as avgProvasAluno
FROM (SELECT count(*) AS number FROM aluno, prova WHERE aluno.nr = prova.nr GROUP BY aluno.nr);
SELECT	avg(sum)	FROM	(SELECT	count(*)	as	sum	FROM	Prova	GROUP	BY	nr);

--15
SELECT Nome, avg(nota) FROM (SELECT nr, max(nota) AS nota FROM prova GROUP BY nr, cod) NATURAL JOIN aluno WHERE nota >= 10 GROUP BY nr;
SELECT	nome,	AVG(maxNota)
FROM	(SELECT	nome,	cod,	MAX(nota)	maxNota
FROM	Prova,	Aluno
WHERE	Prova.nr	=	Aluno.nr
AND	nota	>=	10
GROUP	BY	nome,	cod)
GROUP	BY	nome;


--16    
SELECT	A.cod,	nome,	maxNota
FROM	(SELECT	cod,	MAX(nota)	maxNota
FROM	Prova
GROUP	BY	cod)	A,	Prova,	Aluno
WHERE	A.cod	=	Prova.cod
AND	nota=maxNota
AND	Prova.nr=Aluno.nr;


--17

SELECT	DISTINCT	nome,	curso
FROM	Aluno,	Prova,	Cadeira	C
WHERE	Aluno.nr	=	Prova.nr	AND	Prova.cod	=	C.cod	AND	Aluno.nr	NOT	
IN
(SELECT	nr	AS	alunonr
FROM	Aluno,	Cadeira
WHERE	Cadeira.curso	=	C.curso	AND	NOT	(cod	IN
(SELECT	cod
FROM	Prova
WHERE	nota	>=	10	AND	nr=alunonr))
)
ORDER	BY	curso, nome;