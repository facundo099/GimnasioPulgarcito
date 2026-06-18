CREATE VIEW v_GrillaClases AS
SELECT 
    hc.IdHorario,
    cl.Nombre AS Clase,
    cl.Descripcion AS DescripcionClase,
    hc.DiaSemana,
    hc.HoraInicio,
    hc.HoraFin,
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