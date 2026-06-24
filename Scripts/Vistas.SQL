USE GimnasioPulgarcito;
GO

-- Aca van las vistas

CREATE VIEW vw_Empleados AS 
SELECT
p.Nombre,
p.Apellido,
c.Nombre AS Cargo,
e.Estado
from Empleados e 
INNER JOIN Persona p ON P.IdPersona=e.IdPersona
INNER JOIN Cargos c ON c.IdCargo=e.IdCargo;

GO;

CREATE VIEW v_GrillaClases AS
SELECT 
    hc.IdHorario,
    cl.Nombre AS Clase,
    cl.Descripcion AS DescripcionClase,

    CASE hc.DiaSemana
        WHEN 1 THEN 'Lunes'
        WHEN 2 THEN 'Martes'
        WHEN 3 THEN 'Miércoles'
        WHEN 4 THEN 'Jueves'
        WHEN 5 THEN 'Viernes'
        WHEN 6 THEN 'Sábado'
        WHEN 7 THEN 'Domingo'
    END AS [Dia de semana],

    CONVERT(VARCHAR(8), hc.HoraInicio, 108) AS [Horario Inicio],
    CONVERT(VARCHAR(8), hc.HoraFin, 108) AS [Horario Fin],

    p.Nombre + ' ' + p.Apellido AS Profesor

FROM HorariosClases hc
INNER JOIN Clases cl
    ON hc.IdClase = cl.IdClase
INNER JOIN ClasesProfesores cp
    ON cl.IdClase = cp.IdClase
INNER JOIN Profesores prof
    ON cp.IdProfesor = prof.IdProfesor
INNER JOIN Empleados emp
    ON prof.IdEmpleado = emp.IdEmpleado
INNER JOIN Persona p
    ON emp.IdPersona = p.IdPersona
WHERE hc.Estado = 1
    AND cp.Estado = 1;
    
GO;

CREATE VIEW VW_inscripciones AS
SELECT 
    hc.IdHorario,
    cl.Nombre AS Clase,
    CASE hc.DiaSemana
        WHEN 1 THEN 'Lunes'
        WHEN 2 THEN 'Martes'
        WHEN 3 THEN 'Miércoles'
        WHEN 4 THEN 'Jueves'
        WHEN 5 THEN 'Viernes'
        WHEN 6 THEN 'Sábado'
        WHEN 7 THEN 'Domingo'
    END AS DiaSemana,
    CONVERT(VARCHAR(8), hc.HoraInicio, 108) AS 'Hora Inicio',
    p_cli.Nombre + ' ' + p_cli.Apellido AS Cliente,
    p_cli.Telefono AS 'Telefono Alumno',
    cc.FechaInscripcion AS 'Fecha De Alta'
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

