--Não permitir o utilizador marcar uma consulta caso o número de marcações
--para esse dia venha a ultrapassar a disponibilidade desse médico para esse
--dia


CREATE TRIGGER Clinica2a
BEFORE INSERT ON ConsultasMarcadas
WHEN New.codmedico NOT IN (SELECT codigo FROM Disponibilidade WHERE dia = New.data AND codigo NOT IN (
SELECT codmedico FROM ConsultasMarcadas WHERE data = New.data
GROUP BY codmedico
HAVING COUNT(*) >= (SELECT numdoentes FROM HorarioConsultas AS HC, Disponibilidade AS D 
WHERE HC.idhorarioconsulta = D.idhorarioconsulta AND D.dia = data AND D.codigo = codmedico)))
BEGIN
SELECT RAISE(IGNORE);
END;


/*
Soluçao professora: 
DROP TRIGGER IF EXISTS validanumerodemarcacoes;

CREATE TRIGGER validanumerodemarcacoes
BEFORE INSERT ON ConsultasMarcadas
FOR EACH ROW
BEGIN 
SELECT CASE 
WHEN ((SELECT COUNT(*)-numdoentes FROM 
	 ConsultasMarcadas, Disponibilidade, HorarioConsultas
	 WHERE ConsultasMarcadas.codmedico=NEW.codmedico
	 AND ConsultasMarcadas.data=NEW.data
	 AND ConsultasMarcadas.data = Disponibilidade.dia
	 AND ConsultasMarcadas.codmedico = Disponibilidade.codigo
AND Disponibilidade.idHorarioConsulta=HorarioConsultas.idHorarioConsulta 
)>=0) 
THEN RAISE(ABORT, 'Marcacao nao perimitida por exceder o numero de doentes para esse dia.')
END; 
END;




*/