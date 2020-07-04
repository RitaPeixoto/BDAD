-- Não permitir marcar uma consulta com a mesma hora de início de uma outra
-- consulta no mesmo dia, mesmo médico.

CREATE TRIGGER Clinica2B
BEFORE INSERT ON ConsultasMarcadas
WHEN New.horainicio IN (SELECT horainicio FROM ConsultasMarcadas
WHERE data = New.data AND codmedico = New.codmedico AND horainicio = New.horainicio)
BEGIN
SELECT RAISE(IGNORE);
END;


/*
Soluçao professora: 

DROP TRIGGER IF EXISTS validanumerodemarcacoes;

CREATE TRIGGER validahorademarcacao
BEFORE INSERT ON ConsultasMarcadas
FOR EACH ROW
BEGIN 
SELECT CASE 
WHEN ((SELECT COUNT(*) FROM 
	 ConsultasMarcadas
	 WHERE ConsultasMarcadas.codmedico=NEW.codmedico
	 AND ConsultasMarcadas.data = NEW.data
	 AND ConsultasMarcadas.horainicio=NEW.horainicio)>0) 
THEN RAISE(ABORT, 'Marcacao nao perimitida para esse horario.')
END; 
END;

*/