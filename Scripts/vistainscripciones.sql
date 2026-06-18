CREATE VIEW v_InscripcionesClases AS
SELECT 
    hc.IdHorario,
    cl.Nombre AS Clase,
    hc.DiaSemana,
    hc.HoraInicio,
    p_cli.Nombre + ' ' + p_cli.Apellido AS Alumno,
    p_cli.Telefono AS TelefonoAlumno,
    cc.FechaInscripcion AS FechaDeAlta
FROM ClasesClientes cc
INNER JOIN Clientes c
    ON cc.IdCliente = c.IdCliente
INNER JOIN Persona p_cli
    ON c.IdPersona = p_cli.IdPersona
INNER JOIN HorariosClases hc
    ON cc.IdHorario = hc.IdHorario
INNER JOIN Clases cl
    ON hc.IdClase = cl.IdClase
WHERE cc.Estado = 1;