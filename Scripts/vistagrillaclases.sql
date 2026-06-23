USE GimnasioPulgarcito2;
GO
ALTER VIEW v_GrillaClases AS
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
    

   
   
 
