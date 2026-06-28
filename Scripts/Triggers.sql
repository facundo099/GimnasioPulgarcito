USE GimnasioPulgarcito;
GO;

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

INSERT INTO ClasesClientes (IdHorario, IdCliente)
VALUES (1, 2)

SELECT * FROM ClasesClientes

INSERT INTO ClasesClientes (IdHorario, IdCliente)
VALUES (1, 1)

SELECT * FROM ClasesClientes



-- Pruebas: tr_Agregar_ClaseProfesor

SELECT * FROM Profesores
SELECT * FROM Empleados

INSERT INTO ClasesProfesores (IdClase, IdProfesor)
VALUES (1, 4)

SELECT * FROM ClasesProfesores

INSERT INTO ClasesProfesores (IdClase, IdProfesor)
VALUES (1, 3)

SELECT * FROM ClasesProfesores



-- Pruebas: tr_Agregar_MembresiaCliente

SELECT * FROM Clientes

INSERT INTO MembresiasClientes (IdCliente, IdMembresia, FechaInicio, FechaFin)
VALUES (1, 1, '2020-01-01', '2020-02-01')

SELECT * FROM MembresiasClientes

INSERT INTO MembresiasClientes (IdCliente, IdMembresia, FechaInicio, FechaFin)
VALUES (1, 1, '2024-01-01', '2024-02-01')

SELECT * FROM MembresiasClientes


