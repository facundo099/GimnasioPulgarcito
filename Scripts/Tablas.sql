--CREATE DATABASE GimnasioPulgarcito;
USE GimnasioPulgarcito;
GO

CREATE TABLE [Persona] (
  [IdPersona]       int            IDENTITY(1,1) PRIMARY KEY,
  [Nombre]          varchar(100)  NOT NULL,
  [Apellido]        varchar(100)  NOT NULL,
  [DNI]             varchar(20)   NOT NULL UNIQUE,
  [FechaNacimiento] date,
  [Telefono]        varchar(30),
  [Email]           varchar(150)  UNIQUE,
  [Direccion]       varchar(255)
);
CREATE TABLE [Cargos] (
  [IdCargo]     int           IDENTITY(1,1) PRIMARY KEY,
  [Nombre]      varchar(100) NOT NULL,
  [Descripcion] varchar(255)
);
CREATE TABLE [Clientes] (
  [IdCliente] int  IDENTITY(1,1) PRIMARY KEY,
  [IdPersona] int  NOT NULL UNIQUE,  
  [FechaAlta] date NOT NULL DEFAULT GETDATE(),
  [Estado]    bit  NOT NULL DEFAULT 1, 
  CONSTRAINT FK_Clientes_Persona FOREIGN KEY ([IdPersona]) REFERENCES [Persona]([IdPersona])
);
CREATE TABLE [Empleados] (
  [IdEmpleado]    int            IDENTITY(1,1) PRIMARY KEY,
  [IdPersona]     int            NOT NULL UNIQUE,
  [IdCargo]       int            NOT NULL,
  [FechaIngreso]  date           NOT NULL,    
  [Estado]        bit            NOT NULL DEFAULT 1,
  CONSTRAINT FK_Empleados_Persona FOREIGN KEY ([IdPersona]) REFERENCES [Persona]([IdPersona]),
  CONSTRAINT FK_Empleados_Cargos  FOREIGN KEY ([IdCargo])   REFERENCES [Cargos]([IdCargo])
);
CREATE TABLE [Profesores] (
  [IdProfesor]   int           IDENTITY(1,1) PRIMARY KEY,
  [IdEmpleado]   int           NOT NULL UNIQUE,
  [Especialidad] varchar(255),
  CONSTRAINT FK_Profesores_Empleados FOREIGN KEY ([IdEmpleado]) REFERENCES [Empleados]([IdEmpleado])
);
CREATE TABLE [Membresias] (
  [IdMembresia]   int            IDENTITY(1,1) PRIMARY KEY,
  [Nombre]        varchar(100)   NOT NULL,
  [Descripcion]   varchar(255),  
  [DuracionDias]  int            NOT NULL,
  [AccesoClases]  bit            NOT NULL DEFAULT 0,
  [AccesoPiscina] bit            NOT NULL DEFAULT 0,
  [Estado]        bit            NOT NULL DEFAULT 1,

  CONSTRAINT CHK_Membresia_Duracion
    CHECK ([DuracionDias] > 0)
);
CREATE TABLE [MembresiasClientes] (
  [IdMembresiaCliente] int            IDENTITY(1,1) PRIMARY KEY,
  [IdCliente]          int            NOT NULL,
  [IdMembresia]        int            NOT NULL,
  [FechaInicio]        date           NOT NULL,
  [FechaFin]           date           NOT NULL,  
  [EsRenovacion]       bit            NOT NULL DEFAULT 0,
  [Estado]             bit            NOT NULL DEFAULT 1,

  CONSTRAINT FK_MemClientes_Cliente
    FOREIGN KEY ([IdCliente])
    REFERENCES [Clientes]([IdCliente]),

  CONSTRAINT FK_MemClientes_Membresia
    FOREIGN KEY ([IdMembresia])
    REFERENCES [Membresias]([IdMembresia]),

  CONSTRAINT CHK_MemCliente_Fechas
    CHECK ([FechaFin] >= [FechaInicio]),

);
CREATE TABLE [Clases] (
  [IdClase]     int           IDENTITY(1,1) PRIMARY KEY,
  [Nombre]      varchar(100) NOT NULL,
  [Descripcion] varchar(255),
  [Estado]      bit           NOT NULL DEFAULT 1  
);
CREATE TABLE [ClasesProfesores] (
  [IdClaseProfesor] int  IDENTITY(1,1) PRIMARY KEY,
  [IdClase]         int  NOT NULL,
  [IdProfesor]      int  NOT NULL,
  [Estado]          bit  NOT NULL DEFAULT 1,
  CONSTRAINT UQ_ClaseProfesor          UNIQUE ([IdClase], [IdProfesor]),
  CONSTRAINT FK_ClasesProf_Clase       FOREIGN KEY ([IdClase])    REFERENCES [Clases]([IdClase]),
  CONSTRAINT FK_ClasesProf_Profesor    FOREIGN KEY ([IdProfesor]) REFERENCES [Profesores]([IdProfesor])
);
CREATE TABLE [HorariosClases] (
  [IdHorario]   int          IDENTITY(1,1) PRIMARY KEY,
  [IdClase]     int          NOT NULL,
  [DiaSemana]   tinyint      NOT NULL, 
  [HoraInicio]  time         NOT NULL,
  [HoraFin]     time         NOT NULL,
  [Estado]      bit          NOT NULL DEFAULT 1,
  CONSTRAINT FK_Horarios_Clase FOREIGN KEY ([IdClase]) REFERENCES [Clases]([IdClase]),
  CONSTRAINT CHK_Horarios_Dia CHECK ([DiaSemana] BETWEEN 1 AND 7),
  CONSTRAINT CHK_Horario_Horas CHECK ([HoraFin] > [HoraInicio])
);
CREATE TABLE [ClasesClientes] (
  [IdClaseCliente]   int  IDENTITY(1,1) PRIMARY KEY,
  [IdHorario]        int  NOT NULL,
  [IdCliente]        int  NOT NULL,
  [FechaInscripcion] date NOT NULL DEFAULT GETDATE(), 
  [FechaBaja] date NOT NULL DEFAULT GETDATE(),	
  [Estado]           bit  NOT NULL DEFAULT 1,  
  CONSTRAINT UQ_InscripcionHorarioCliente UNIQUE ([IdHorario], [IdCliente]),
  CONSTRAINT FK_ClasesClientes_Horario  FOREIGN KEY ([IdHorario]) REFERENCES [HorariosClases]([IdHorario]),
  CONSTRAINT FK_ClasesClientes_Cliente  FOREIGN KEY ([IdCliente]) REFERENCES [Clientes]([IdCliente])
);




