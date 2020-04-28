--1
SELECT nr FROM Aluno;
--2
SELECT cod, Design FROM Cadeira WHERE curso =='AC';
--3
SELECT Aluno.nome FROM Aluno, Prof Where Aluno.nome == Prof.nome;
SELECT nome FROM aluno INTERSECT SELECT nome FROM prof;
--4
SELECT Aluno.nome FROM Aluno EXCEPT SELECT Aluno.nome FROM Aluno, Prof WHERE Aluno.nome == Prof.nome;
SELECT Aluno.nome FROM Aluno EXCEPT SELECT Prof.nome FROM Prof;
--5
SELECT nome FROM Aluno UNION SELECT nome FROM Prof;
SELECT nome FROM Aluno UNION ALL SELECT nome FROM Prof;--to have all of the names

--6
SELECT  Aluno.nome FROM Aluno,Prova WHERE Aluno.nr==Prova.nr AND Prova.cod=='TS1';
SELECT Aluno.nome FROM Aluno WHERE Aluno.nr in (SELECT Prova.nr FROM Prova WHERE cod = 'TS1');

--7
SELECT nome FROM aluno WHERE aluno.nr IN (SELECT nr from prova NATURAL JOIN cadeira WHERE cadeira.curso='IS');
SELECT nome FROM aluno WHERE Aluno.nr in (SELECT nr FROM prova WHERE cod in (SELECT cod FROM cadeira WHERE curso = 'IS'));--prefereble not to use so many subqueries, avoid several levels of nested subqueries

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

--14
SELECT avg(number) as avgProvasAluno
FROM (SELECT count(*) AS number FROM aluno, prova WHERE aluno.nr = prova.nr GROUP BY aluno.nr);
--15
SELECT Nome, avg(nota) FROM (SELECT nr, max(nota) AS nota FROM prova GROUP BY nr, cod) NATURAL JOIN aluno WHERE nota >= 10 GROUP BY nr;
--16


--17
