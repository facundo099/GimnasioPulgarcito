USE GimnasioPulgarcito

-- ============================================================
-- 1. PERSONA
-- ============================================================
INSERT INTO Persona (Nombre, Apellido, DNI, FechaNacimiento, Telefono, Email, Direccion) VALUES
('Juan', 'García', '30111222', '1990-03-15', '1144001100', 'juan.garcia@email.com', 'Av. Santa Fe 1234, CABA'),
('María', 'López', '32222333', '1988-07-22', '1155002200', 'maria.lopez@email.com', 'Corrientes 567, CABA'),
('Carlos', 'Martínez', '28333444', '1985-11-10', '1166003300', 'carlos.martinez@email.com','Rivadavia 890, CABA'),
('Lucía', 'Fernández', '35444555', '1995-01-30', '1177004400', 'lucia.fernandez@email.com','Belgrano 321, CABA'),
('Marcos', 'Rodríguez', '27555666', '1982-06-18', '1188005500', 'marcos.rodriguez@email.com','Callao 654, CABA'),
('Valentina', 'Pérez', '38666777', '1998-09-05', '1199006600', 'valentina.perez@email.com','Pueyrredón 987, CABA'),
('Diego', 'Sánchez', '31777888', '1991-12-25', '1100007700', 'diego.sanchez@email.com', 'Scalabrini Ortiz 111, CABA'),
('Sofía', 'Torres', '36888999', '1996-04-14', '1111008800', 'sofia.torres@email.com', 'Lavalle 222, CABA'),
('Andrés', 'Ruiz', '29999000', '1987-08-03', '1122009900', 'andres.ruiz@email.com', 'Tucumán 333, CABA'),
('Carolina', 'Gómez',     '33000111', '1993-02-19', '1133000011', 'carolina.gomez@email.com', 'Maipú 444, CABA'),
('Matias', 'Romero', '32111555', '1992-04-12', '1132114455', 'matias.romero@gmail.com', 'Av. Cabildo 1200'),
('Florencia', 'Silva', '34888777', '1995-07-23', '1143225566', 'flor.silva@gmail.com', 'Av. Santa Fe 1500'),
('Gonzalo', 'Ibarra', '29999444', '1989-02-08', '1154336677', 'gonzalo.ibarra@gmail.com', 'Belgrano 220'),
('Julieta', 'Suarez', '37777111', '2000-01-19', '1165447788', 'julieta.suarez@gmail.com', 'Rivadavia 780'),
('Nicolas', 'Vega', '31111888', '1991-11-30', '1176558899', 'nicolas.vega@gmail.com', 'Mitre 950'),
('Mariano', 'Rios', '28888555', '1987-05-15', '1187669900', 'mariano.rios@gmail.com', 'Callao 500'),
('Paula', 'Dominguez', '35555222', '1994-09-04', '1198770011', 'paula.dominguez@gmail.com', 'Corrientes 840'),
('Leandro', 'Navarro', '27666111', '1983-06-25', '1119881122', 'leandro.navarro@gmail.com', 'San Juan 320');

-- ============================================================
-- 2. CARGOS
-- ============================================================
INSERT INTO Cargos (Nombre, Descripcion) VALUES
('Recepcionista', 'Atención al público, gestión de turnos e inscripciones'),
('Instructor', 'Dicta clases grupales y supervisa rutinas'),
('Coordinador de Clases','Organiza los horarios y asigna profesores'),
('Administrativo', 'Gestión de pagos, facturación y legajos'),
('Gerente', 'Responsable general de la operación del gimnasio');

-- ============================================================
-- 3. CLIENTES
-- (Personas 6, 7, 8, 9, 10 serán clientes)
-- ============================================================
INSERT INTO Clientes
(IdPersona, FechaAlta, FechaBaja, Estado)
VALUES
(6, '2024-01-10', NULL, 1),
(7, '2024-02-15', NULL, 1),
(8, '2024-03-20', NULL, 1),
(9, '2024-04-05', NULL, 1),
(10, '2024-05-01', NULL, 1),
(11, '2026-01-10', NULL, 1),
(12, '2026-02-05', NULL, 1),
(13, '2026-02-20', NULL, 1),
(14, '2025-12-15', '2026-05-30', 0),
(15, '2026-01-18', '2026-06-10', 0);

-- ============================================================
-- 4. EMPLEADOS
-- (Personas 1, 2, 3, 4, 5 serán empleados)
-- ============================================================
INSERT INTO Empleados
(IdPersona, IdCargo, FechaIngreso, FechaBaja, ValorHora, Estado)
VALUES
(1, 1, '2022-03-01', NULL, 1200.00, 1), 
(2, 2, '2021-06-15', NULL, 1800.00, 1), 
(3, 2, '2020-09-01', NULL, 2000.00, 1), 
(4, 4, '2023-01-10', NULL, 1500.00, 1),
(5, 5, '2019-11-20', NULL, 3000.00, 1), 
(16, 2, '2025-10-01', NULL, 9500.00, 1),
(17, 1, '2025-08-10', '2026-03-15', 7200.00, 0),
(18, 3, '2025-07-01', '2026-04-20', 12000.00, 0);

-- ============================================================
-- 5. PROFESORES
-- (Solo los instructores: empleados 2 y 3 → María y Carlos)
-- ============================================================
INSERT INTO Profesores (IdEmpleado, Especialidad) VALUES
(2, 'Yoga y Pilates'),
(3, 'Musculación y CrossFit');

-- ============================================================
-- 6. MEMBRESIAS
-- ============================================================
INSERT INTO Membresias (Nombre, Descripcion, Precio, DuracionDias, AccesoClases, AccesoPiscina, Estado) VALUES
('Plan Básico',      'Acceso a sala de musculación',                   15000.00, 30, 0, 0, 1),
('Plan Clases',      'Acceso a sala y clases grupales',                22000.00, 30, 1, 0, 1),
('Plan Full',        'Acceso completo incluyendo piscina y clases',    35000.00, 30, 1, 1, 1),
('Plan Trimestral',  'Plan básico con duración de 3 meses',            40000.00, 90, 0, 0, 1),
('Plan Semestral',   'Plan full con duración de 6 meses',              90000.00, 180,1, 1, 1);

-- ============================================================
-- 7. MEMBRESIAS CLIENTES
-- ============================================================
INSERT INTO MembresiasClientes (IdCliente, IdMembresia, FechaInicio, FechaFin, EsRenovacion, Estado) VALUES
(1, 2, '2024-01-10', '2024-02-09', 0, 1),  
(1, 2, '2024-02-10', '2024-03-10', 1, 1),  
(2, 1, '2024-02-15', '2024-03-15', 0, 1), 
(3, 3, '2024-03-20', '2024-04-18', 0, 1),  
(4, 4, '2024-04-05', '2024-07-03', 0, 1),  
(5, 5, '2024-05-01', '2024-10-27', 0, 1);  

-- ============================================================
-- 8. CLASES
-- ============================================================
INSERT INTO Clases (Nombre, Descripcion, Estado) VALUES
('Yoga',        'Clase de yoga para todos los niveles',              1),
('Pilates',     'Ejercicios de suelo y elongación',                  1),
('CrossFit',    'Entrenamiento funcional de alta intensidad',        1),
('Musculación', 'Rutinas de fuerza con supervisión del instructor',  1),
('Spinning',    'Ciclismo indoor con música y ritmo',                1);

-- ============================================================
-- 9. CLASES PROFESORES
-- ============================================================
INSERT INTO ClasesProfesores (IdClase, IdProfesor, Estado) VALUES
(1, 1, 1),  
(2, 1, 1),  
(3, 2, 1),  
(4, 2, 1),  
(5, 1, 1),  
(5, 2, 1);  

-- ============================================================
-- 10. HORARIOS CLASES
-- (DiaSemana: 1=Lunes ... 7=Domingo)
-- ============================================================
INSERT INTO HorariosClases (IdClase, DiaSemana, HoraInicio, HoraFin, Estado) VALUES
(1, 1, '08:00', '09:00', 1),  
(1, 3, '08:00', '09:00', 1),  
(2, 2, '09:00', '10:00', 1),  
(2, 4, '09:00', '10:00', 1),  
(3, 1, '18:00', '19:00', 1),  
(3, 3, '18:00', '19:00', 1),  
(3, 5, '10:00', '11:00', 1),  
(4, 2, '17:00', '18:00', 1),  
(5, 6, '10:00', '11:00', 1),  
(5, 7, '10:00', '11:00', 1);  

-- ============================================================
-- 11. CLASES CLIENTES
-- ============================================================
INSERT INTO ClasesClientes (IdHorario, IdCliente, FechaInscripcion, FechaBaja, Estado) VALUES
(1, 1, '2024-01-11', NULL, 1),  
(3, 1, '2024-01-11', NULL, 1),  
(5, 2, '2024-02-16', NULL, 1),  
(8, 3, '2024-03-21', NULL, 1),  
(9, 4, '2024-04-06', NULL, 1),  
(9, 5, '2024-05-02', NULL, 1),  
(2, 5, '2024-05-02', NULL, 1),  
(6, 3, '2024-03-21', '2024-04-01', 0); 