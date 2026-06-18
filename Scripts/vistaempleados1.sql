USE GimnasioPulgarcito;
GO
CREATE VIEW vw_Empleados AS 
SELECT
p.Nombre,
p.Apellido,
c.Nombre AS Cargo,
e.Estado
from Empleados e 
INNER JOIN Persona p ON P.IdPersona=e.IdPersona
INNER JOIN Cargos c ON c.IdCargo=e.IdCargo;
