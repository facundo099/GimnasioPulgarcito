USE GimnasioPulgarcito;
GO

-- Aca van los Triggers
-- Este trigger evita que un cliente con estado = 0 se anote a una clase

CREATE TRIGGER tr_Agregar_ClaseCliente ON ClasesClientes
AFTER INSERT
AS
BEGIN
    DECLARE @IdCliente int
    DECLARE @Estado bit

    SELECT @IdCliente = IdCliente FROM inserted

    SELECT @Estado = Estado FROM Clientes WHERE IdCliente = @IdCliente

    IF @Estado = 0
    BEGIN
        RAISERROR('El cliente no está activo.', 16, 1)
        ROLLBACK TRANSACTION
        RETURN;
    END
END;

GO;

-- Profesor inactivo NO puede dar clases

CREATE TRIGGER tr_Agregar_ClaseProfesor ON ClasesProfesores
AFTER INSERT
AS
BEGIN
    DECLARE @IdProfesor int
    DECLARE @IdEmpleado int
    DECLARE @Estado bit

    SELECT @IdProfesor = IdProfesor FROM inserted

    SELECT @IdEmpleado = IdEmpleado FROM Profesores WHERE IdProfesor = @IdProfesor

    SELECT @Estado = Estado FROM Empleados WHERE IdEmpleado = @IdEmpleado

    IF @Estado = 0
    BEGIN
        RAISERROR('El profesor no está activo.', 16, 1)
        ROLLBACK TRANSACTION
        RETURN;
    END
END;

