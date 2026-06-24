USE GimnasioPulgarcito;
GO;

-- Aca van los Triggers

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

GO;

CREATE TRIGGER tr_Agregar_MembresiaCliente ON MembresiasClientes
AFTER INSERT
AS
BEGIN
    DECLARE @IdCliente int
    DECLARE @FechaInicio date
    DECLARE @FechaAlta date

    SELECT @IdCliente = IdCliente FROM inserted
    SELECT @FechaInicio = FechaInicio FROM inserted

    SELECT @FechaAlta = FechaAlta FROM Clientes WHERE IdCliente = @IdCliente

    IF @FechaInicio < @FechaAlta
    BEGIN
        RAISERROR('La membresía no puede iniciar antes del alta del cliente.', 16, 1)
        ROLLBACK TRANSACTION
        RETURN;
    END
END;




-- Pruebas: tr_Agregar_ClaseCliente

SELECT * FROM Clientes
-- Caso 1: FALLA - cliente inactivo (IdCliente 2, Maria)
INSERT INTO ClasesClientes (IdHorario, IdCliente)
VALUES (1, 2)
-- Resultado esperado: error 'El cliente no está activo.'

SELECT * FROM ClasesClientes
-- Resultado esperado: tabla vacía

-- Caso 2: FUNCIONA - cliente activo (IdCliente 1, Juan)
INSERT INTO ClasesClientes (IdHorario, IdCliente)
VALUES (1, 1)
-- Resultado esperado: inserción exitosa

SELECT * FROM ClasesClientes
-- Resultado esperado: 1 fila cargada