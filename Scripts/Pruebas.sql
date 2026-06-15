USE GimnasioPulgarcito;


SELECT * FROM Persona;
SELECT * FROM Empleados;
SELECT * FROM Clientes

SELECT * 
FROM Persona p
INNER JOIN Empleados E 
	ON p.IdPersona = e.IdPersona

DECLARE @NuevaPersona int;

EXEC sp_AltaPersona
  @Nombre          = 'Juan',
  @Apellido        = 'Morán',
  @DNI             = '32656325',
  @FechaNacimiento = '1986-08-26',
  @Telefono        = '1145255880',
  @Email           = 'juan.moran@email.com',
  @Direccion       = 'loria 66',
  @IdPersonaNueva  = @NuevaPersona OUTPUT;

  
DECLARE @NuevoEmpleado int;

EXEC sp_AltaEmpleado
  @IdPersona       = 1,
  @IdCargo         = 1,       -- Recepcionista
  @FechaIngreso    = '2024-06-01',
  @ValorHora       = 1310.00,
  @EsProfesor      = 0,
  @IdEmpleadoNuevo = @NuevoEmpleado OUTPUT;



INSERT INTO Cargos (Nombre, Descripcion) VALUES
('Recepcionista',        'Atención al público, gestión de turnos e inscripciones'),
('Instructor',           'Dicta clases grupales y supervisa rutinas'),
('Coordinador de Clases','Organiza los horarios y asigna profesores'),
('Administrativo',       'Gestión de pagos, facturación y legajos'),
('Gerente',              'Responsable general de la operación del gimnasio');


INSERT INTO Clientes (IdPersona, FechaAlta, Estado) VALUES
(6,  '2024-01-10', 1),
(7,  '2024-02-15', 1),
(8,  '2024-03-20', 1),
(9,  '2024-04-05', 1),
(10, '2024-05-01', 1);

GO 

DECLARE @NuevaPersona int;

EXEC sp_AltaPersona
  @Nombre          = 'Marta',
  @Apellido        = 'Olivia',
  @DNI             = '33556028',
  @FechaNacimiento = '1988-11-17',
  @Telefono        = '1122554432',
  @Email           = 'mo@email.com',
  @Direccion       = 'Largos Acosta 1667',
  @IdPersonaNueva  = @NuevaPersona OUTPUT;

-- Paso 2: registrarla como cliente
DECLARE @NuevoCliente int;

EXEC sp_AltaCliente
  @IdPersona      = @NuevaPersona,
  @IdClienteNuevo = @NuevoCliente OUTPUT;

SELECT @NuevoCliente AS IdClienteGenerado;

