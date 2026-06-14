USE GimnasioPulgarcito;
Go;
  -- ============================================================
  -- ALTA PERSONA
  -- ============================================================
CREATE PROCEDURE sp_AltaPersona
  @Nombre          varchar(100),
  @Apellido        varchar(100),
  @DNI             varchar(20),
  @FechaNacimiento date         = NULL,
  @Telefono        varchar(30)  = NULL,
  @Email           varchar(150) = NULL,
  @Direccion       varchar(255) = NULL,
  @IdPersonaNueva  int OUTPUT
AS
BEGIN
  SET NOCOUNT ON;

  -- ================
  -- VALIDACIONES
  -- ================

  IF LTRIM(RTRIM(ISNULL(@Nombre, ''))) = ''
  BEGIN
    RAISERROR('El Nombre es obligatorio.', 16, 1);
    RETURN;
  END

  IF LTRIM(RTRIM(ISNULL(@Apellido, ''))) = ''
  BEGIN
    RAISERROR('El Apellido es obligatorio.', 16, 1);
    RETURN;
  END

  IF LTRIM(RTRIM(ISNULL(@DNI, ''))) = ''
  BEGIN
    RAISERROR('El DNI es obligatorio.', 16, 1);
    RETURN;
  END

  IF EXISTS (SELECT 1 FROM Persona WHERE DNI = @DNI)
  BEGIN
    RAISERROR('Ya existe una persona registrada con ese DNI.', 16, 1);
    RETURN;
  END

  IF @Email IS NOT NULL AND EXISTS (SELECT 1 FROM Persona WHERE Email = @Email)
  BEGIN
    RAISERROR('Ya existe una persona registrada con ese Email.', 16, 1);
    RETURN;
  END

  -- ================
  -- TRANSACCIÓN
  -- ================
  BEGIN TRANSACTION;

  BEGIN TRY

    INSERT INTO Persona (Nombre, Apellido, DNI, FechaNacimiento, Telefono, Email, Direccion)
    VALUES (@Nombre, @Apellido, @DNI, @FechaNacimiento, @Telefono, @Email, @Direccion);

    SET @IdPersonaNueva = SCOPE_IDENTITY();

    COMMIT TRANSACTION;

  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    DECLARE @Mensaje varchar(500) = 'Error al registrar la persona: ' + ERROR_MESSAGE();
    RAISERROR(@Mensaje, 16, 1);
    RETURN;
  END CATCH

END;
GO

  -- ============================================================
  -- ALTA CLIENTE
  -- ============================================================

CREATE PROCEDURE sp_AltaCliente
  @IdPersona      int,
  @IdClienteNuevo int OUTPUT
AS
BEGIN
  SET NOCOUNT ON;

  -- ===============
  -- VALIDACIONES
  -- ===============

  IF NOT EXISTS (SELECT 1 FROM Persona WHERE IdPersona = @IdPersona)
  BEGIN
    RAISERROR('No existe una persona con ese IdPersona.', 16, 1);
    RETURN;
  END

  IF EXISTS (SELECT 1 FROM Clientes WHERE IdPersona = @IdPersona)
  BEGIN
    RAISERROR('Esa persona ya está registrada como cliente.', 16, 1);
    RETURN;
  END

  -- =============
  -- TRANSACCIÓN
  -- =============
  BEGIN TRANSACTION;

  BEGIN TRY

    INSERT INTO Clientes (IdPersona, FechaAlta, Estado)
    VALUES (@IdPersona, GETDATE(), 1);

    SET @IdClienteNuevo = SCOPE_IDENTITY();

    COMMIT TRANSACTION;

  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    DECLARE @Mensaje varchar(500) = 'Error al registrar el cliente: ' + ERROR_MESSAGE();
    RAISERROR(@Mensaje, 16, 1);
    RETURN;
  END CATCH

END;
GO

  -- ============================================================
  -- ALTA EMPLEADO
  -- ============================================================

CREATE PROCEDURE sp_AltaEmpleado
  @IdPersona        int,
  @IdCargo          int,
  @FechaIngreso     date,
  @ValorHora        decimal(10,2),
  -- Datos opcionales si también es Profesor
  @EsProfesor       bit          = 0,
  @Especialidad     varchar(255) = NULL,
  -- Output
  @IdEmpleadoNuevo  int OUTPUT
AS
BEGIN
  SET NOCOUNT ON;

  -- =============
  -- VALIDACIONES
  -- =============

  IF NOT EXISTS (SELECT 1 FROM Persona WHERE IdPersona = @IdPersona)
  BEGIN
    RAISERROR('No existe una persona con ese IdPersona.', 16, 1);
    RETURN;
  END

  IF EXISTS (SELECT 1 FROM Empleados WHERE IdPersona = @IdPersona)
  BEGIN
    RAISERROR('Esa persona ya está registrada como empleado.', 16, 1);
    RETURN;
  END

  IF NOT EXISTS (SELECT 1 FROM Cargos WHERE IdCargo = @IdCargo)
  BEGIN
    RAISERROR('El cargo indicado no existe.', 16, 1);
    RETURN;
  END

  IF @ValorHora <= 0
  BEGIN
    RAISERROR('El valor hora debe ser mayor a cero.', 16, 1);
    RETURN;
  END

  IF @FechaIngreso IS NULL
  BEGIN
    RAISERROR('La fecha de ingreso es obligatoria.', 16, 1);
    RETURN;
  END

  -- Si es profesor pero el cargo no corresponde, advertimos
  -- (supuesto: IdCargo = 2 es Instructor, ajustá el valor si cambia)
  IF @EsProfesor = 1 AND NOT EXISTS (
    SELECT 1 FROM Cargos WHERE IdCargo = @IdCargo AND Nombre = 'Instructor'
  )
  BEGIN
    RAISERROR('Para registrar como profesor, el cargo debe ser Instructor.', 16, 1);
    RETURN;
  END

  -- ============
  -- TRANSACCIÓN
  -- ============
  BEGIN TRANSACTION;

  BEGIN TRY

    -- 1. Insertar Empleado
    INSERT INTO Empleados (IdPersona, IdCargo, FechaIngreso, ValorHora, Estado)
    VALUES (@IdPersona, @IdCargo, @FechaIngreso, @ValorHora, 1);

    SET @IdEmpleadoNuevo = SCOPE_IDENTITY();

    -- 2. Si es profesor, insertar en Profesores
    IF @EsProfesor = 1
    BEGIN
      INSERT INTO Profesores (IdEmpleado, Especialidad)
      VALUES (@IdEmpleadoNuevo, @Especialidad);
    END

    COMMIT TRANSACTION;

  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    DECLARE @Mensaje varchar(500) = 'Error al registrar el empleado: ' + ERROR_MESSAGE();
    RAISERROR(@Mensaje, 16, 1);
    RETURN;
  END CATCH

END;
GO