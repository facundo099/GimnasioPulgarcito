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
