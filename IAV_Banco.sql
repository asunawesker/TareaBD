-- Alumna: Iraís Aguirre Valente
-- EE: Base de Datos
-- PE: ISW - 301

-- Creando la base de datos
CREATE DATABASE IAV_BANCO On (
	Name = 'IAV_Banco_Data',
	Filename = 'c:\data\IAV_Bancos_Data.mdf',
	Size = 5 MB,
	Maxsize = 250 MB,
	Filegrowth = 10%
), (
	Name = 'IAV_Banco_Sec',
	Filename = 'c:\data\IAV_Bancos_Sec.ndf',
	Size = 10 MB,
	Maxsize = 100 MB,
	Filegrowth = 5 MB
)

LOG ON (
	Name = 'IAV_Banco_Log',
	Filename = 'c:\data\IAV_Bancos_Log.ldf',
	Size = 10 MB,
	Maxsize = 100 MB,
	Filegrowth = 5 MB
)
Go

use IAV_BANCO
go

-- Creando tabla ejecutivos
CREATE TABLE EJECUTIVOS (
    cveEjecutivo char(4) primary key check (cveEjecutivo like '[0-9][A-Z][0-9][0-9]'),
    ejecutivo char(50)
)

-- Creando tabla clientes
CREATE TABLE CLIENTES (
    cveCliente char(4) primary key check (cveCliente like '[0-9][A-Z][0-9][0-9]'),
    nombre varchar(50),
    calle varchar(50),
    ciudad varchar(50)
)

-- Creando tabla sucursales
CREATE TABLE SUCURSALES (
    cveSucursal char(4) primary key check (cveSucursal like '[0-9][A-Z][0-9][0-9]'),
    nombre varchar(50),
    ciudad_sucursal varchar(50),
)

-- Creando tabla cuentas
CREATE TABLE CUENTAS (
    noCuenta int primary key,
    cveCliente char(4),
    cveSucursal char(4),
    cveEjecutivo char(4),
    tipo varchar(10) check (tipo in ('Oro','Platino','Junior','Nómina')),

    CONSTRAINT fk_clientes_cuentas FOREIGN KEY (cveCliente)
    REFERENCES CLIENTES(cveCliente),
    CONSTRAINT fk_sucursales_cuentas FOREIGN KEY (cveSucursal)
    REFERENCES SUCURSALES(cveSucursal),
    CONSTRAINT fk_ejecutivo_cuentas FOREIGN KEY (cveEjecutivo)
    REFERENCES EJECUTIVOS(cveEjecutivo)
)

-- Creando tabla depositos
CREATE TABLE DEPOSITOS (
    folio int primary key,
    noCuenta int,
    importe int,

    CONSTRAINT fk_cuentas_depositos FOREIGN KEY (noCuenta)
    REFERENCES CUENTAS(noCuenta),
)

--Función que saca una comisión del 5% en un depósito
CREATE FUNCTION FN_COMISIONDEPOSITO (@DEPOSITO DECIMAL (10,2))
RETURNS DECIMAL (10,2)
AS 
	BEGIN 
		DECLARE @COMISION DECIMAL (10,2)
		SET @COMISION = @DEPOSITO * 0.05
	RETURN (@COMISION)
	END
GO

--Procedimiento almacenado 
CREATE PROC DEPOSITO_COMISION_COBRADA
AS
SELECT  CLIENTES.nombre AS 'Nombre cliente', DEPOSITOS.importe AS 'Importe', dbo.FN_COMISIONDEPOSITO (DEPOSITOS.importe) AS 'Comisión depósito'
FROM 
	DEPOSITOS INNER JOIN CUENTAS ON DEPOSITOS.noCuenta = CUENTAS.noCuenta
	INNER JOIN CLIENTES ON CUENTAS.cveCliente = CLIENTES.cveCliente

EXEC  DEPOSITO_COMISION_COBRADA

-- Disparador
CREATE TRIGGER AÑADIRDEPOSITO
ON depositos 
FOR INSERT
AS
	IF (SELECT importe FROM inserted) > 1000
	BEGIN
		ROLLBACK TRANSACTION 
		PRINT 'Depositos mayores de 1000 son en caja'
    END
	ELSE 
	   PRINT 'Deposito aceptado'


-- Intento de disparador con el punto 3
/*
CREATE TRIGGER AÑADIRCUENTA 
	ON CUENTAS
	FOR INSERT
AS 
BEGIN
    DECLARE @noCuenta int, @tipo varchar(10)Z
    SELECT @tipo = tipo FROM inserted
    IF EXISTS (SELECT noCuenta FROM CUENTAS WHERE noCuenta = (SELECT noCuenta FROM inserted))
	BEGIN
		IF (@tipo = 'Oro')
		BEGIN
			ROLLBACK TRANSACTION
			PRINT 'Cuenta tipo oro ya existente'
		END
		IF (@tipo = 'Platino')
		BEGIN
			ROLLBACK TRANSACTION
			PRINT 'Cuenta tipo platino ya existente'
		END
		IF (@tipo = 'Junior')
		BEGIN
			ROLLBACK TRANSACTION
			PRINT 'Cuenta tipo junior ya existente'
		END
		IF (@tipo = 'Nómina')
		BEGIN
			ROLLBACK TRANSACTION
			PRINT 'Cuenta tipo nómina ya existente'
		END		
	END
	ELSE 
		PRINT 'Cuenta nueva'
END
GO
*/

--Insertando valores en la tabla ejecutivos
insert into EJECUTIVOS
values ('1E40','Turner')

insert into EJECUTIVOS
values ('1E41','Hayes')

insert into EJECUTIVOS
values ('1E42','Johnson')

--Insertando valores en la tabla clientes
insert into CLIENTES
values ('1C23', 'Jones', 'Main', 'Harrison')

insert into CLIENTES
values ('1C24', 'Smith', 'North', 'Rye')

insert into CLIENTES
values ('1C25', 'Hayes', 'Main', 'Harrison')

insert into CLIENTES
values ('1C26', 'Curry', 'North', 'Rye')

insert into CLIENTES
values ('1C27', 'Lindsay', 'Park', 'Pittsfield')

insert into CLIENTES
values ('1C28', 'Turner', 'Putnam', 'Stamford')

insert into CLIENTES
values ('1C29', 'Williams', 'Nassau', 'Princeton')

insert into CLIENTES
values ('1C30', 'Adams', 'Spring', 'Pittsfield')

insert into CLIENTES
values ('1C40', 'Johnson', 'Alma', 'Palo Alto')

insert into CLIENTES
values ('1C41', 'Glenn', 'Sand', 'Woodside')

insert into CLIENTES
values ('1C42', 'Brooks', 'Senator', 'Brooklyn')

insert into CLIENTES
values ('1C43', 'Green', 'Walnut', 'Stamford')

--Insertando valores en la tabla sucursales
insert into SUCURSALES
values ('1S60', 'Downtown', 'Brooklyn')

insert into SUCURSALES
values ('1S61', 'Redwood', 'Palo Alto')

insert into SUCURSALES
values ('1S62', 'Perryridge', 'Horseneck')

insert into SUCURSALES
values ('1S63', 'Mianus', 'Horseneck')

insert into SUCURSALES
values ('1S64', 'Round Hill', 'Horseneck')

insert into SUCURSALES
values ('1S65', 'Pownal', 'Bennington')

insert into SUCURSALES
values ('1S66', 'North Town', 'Rye')

insert into SUCURSALES
values ('1S67', 'Bringhton', 'Brooklyn')

--Insertando valores en la tabla cuentas
insert into CUENTAS
values (101, '1C40', '1S60', '1E40', 'Oro')

insert into CUENTAS
values (102, '1C25', '1S60', '1E41', 'Platino')

insert into CUENTAS
values (105, '1C41', '1S61', '1E42', 'Junior')

insert into CUENTAS
values (201, '1C29', '1S62', '1E40', 'Nómina')

insert into CUENTAS
values (215, '1C24', '1S63', '1E41', 'Oro')

insert into CUENTAS
values (217, '1C41', '1S64', '1E42', 'Platino')

insert into CUENTAS
values (222, '1C27', '1S66', '1E40', 'Oro')

insert into CUENTAS
values (305, '1C28', '1S66', '1E41', 'Platino')

--Insertando valores en la tabla depositos
insert into DEPOSITOS
values (1, 101, 500)

insert into DEPOSITOS
values (2, 215, 700)

insert into DEPOSITOS
values (3, 102, 400)

insert into DEPOSITOS
values (4, 215, 350)

insert into DEPOSITOS
values (5, 201, 900)

insert into DEPOSITOS
values (6, 222, 700)

insert into DEPOSITOS
values (7, 217, 750)

insert into DEPOSITOS
values (8, 105, 850)

insert into DEPOSITOS
values (9, 105, 900)

insert into DEPOSITOS
values (10, 102, 300)

insert into DEPOSITOS
values (11, 101, 1200)

insert into DEPOSITOS
values (12, 222, 250)

insert into DEPOSITOS
values (13, 222, 370)

insert into DEPOSITOS
values (14, 217, 280)

insert into DEPOSITOS
values (15, 215, 700)

insert into DEPOSITOS
values (16, 222, 800)

insert into DEPOSITOS
values (17, 102, 700)

insert into DEPOSITOS
values (18, 201, 650)

insert into DEPOSITOS
values (19, 217, 890)

insert into DEPOSITOS
values (20, 101, 340)

--CONSULTAS
--(1)
SELECT nombre AS 'Nombre Sucursal'
FROM SUCURSALES
WHERE ciudad_sucursal = 'Horseneck' 

--(2)
SELECT CLIENTES.nombre AS 'Nombre Cliente', SUCURSALES.nombre AS 'Nombre Sucursal'
FROM 
    CUENTAS INNER JOIN CLIENTES ON CUENTAS.cveCliente = CLIENTES.cveCliente
    INNER JOIN SUCURSALES ON CUENTAS.cveSucursal = SUCURSALES.cveSucursal

--(3)
SELECT ciudad_sucursal AS 'Ciudad', COUNT(nombre) AS 'No. Sucursales'
FROM SUCURSALES
GROUP BY ciudad_sucursal

--(4) 
SELECT CLIENTES.nombre AS 'Nombre Cliente', COUNT(CUENTAS.cveCliente) AS 'No. cuentas'
FROM 
    CLIENTES INNER JOIN CUENTAS ON CLIENTES.cveCliente = CUENTAS.cveCliente 
GROUP BY CLIENTES.nombre

--(5)
SELECT CLIENTES.nombre AS 'Nombre Cliente', EJECUTIVOS.ejecutivo AS 'Nombre Ejecutivo'
FROM 
    CUENTAS INNER JOIN CLIENTES ON CLIENTES.cveCliente = CUENTAS.cveCliente
    INNER JOIN EJECUTIVOS ON EJECUTIVOS.cveEjecutivo = CUENTAS.cveEjecutivo

--(6)    
SELECT EJECUTIVOS.ejecutivo AS 'Ejecutivo', COUNT(noCuenta) AS 'No. Cuentas que atiende'
FROM 
    CUENTAS INNER JOIN EJECUTIVOS ON EJECUTIVOS.cveEjecutivo = CUENTAS.cveEjecutivo
GROUP BY ejecutivo

--(7)
SELECT CLIENTES.nombre AS 'Nombre Cliente', SUM(DEPOSITOS.importe) AS 'Saldo'
FROM 
    CUENTAS INNER JOIN CLIENTES ON CLIENTES.cveCliente = CUENTAS.cveCliente
    INNER JOIN DEPOSITOS ON DEPOSITOS.noCuenta = CUENTAS.noCuenta
GROUP BY CLIENTES.nombre

--(8)
SELECT CLIENTES.nombre AS 'Nombre Cliente'
FROM CLIENTES
WHERE CLIENTES.cveCliente NOT IN (
    SELECT CLIENTES.cveCliente
    FROM 
        CUENTAS INNER JOIN CLIENTES ON CLIENTES.cveCliente = CUENTAS.cveCliente
        INNER JOIN DEPOSITOS ON DEPOSITOS.noCuenta = CUENTAS.noCuenta
)