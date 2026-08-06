/*
===============
DDL Capa Plata
===============

ADVERTENCIA: 
	El script, borra las siguientes tablas de la base de datos 'DWH_Creditos':
		- 'plata.productos_crediticios'
		- 'plata.sucursales'
		- 'plata.clientes'
		- 'plata.oficiales_credito' 
		- 'plata.prestamos'
		- 'plata.pagos'
		

PROPOSITO DEL SCRIPT:
	1.- Crear las siguientes tablas para la capa Plata:
		- 'plata.productos_crediticios'
		- 'plata.sucursales'
		- 'plata.clientes'
		- 'plata.oficiales_credito' 
		- 'plata.prestamos'
		- 'plata.pagos'
*/

USE DWH_Creditos;
GO
/*
==========================
CREACION TABLAS CAPA PLATA
==========================
*/

IF OBJECT_ID('plata.productos_crediticios','U') IS NOT NULL 
BEGIN
	DROP TABLE plata.productos_crediticios;
END
GO 
CREATE TABLE plata.productos_crediticios (
	producto_id INT,
	nombre_producto NVARCHAR(40),
	tipo_credito NVARCHAR(50),
	tasa_nom_min DECIMAL(8,4),
	tasa_nom_max DECIMAL(8,4), 
	plazo_min_meses INT, 
	plazo_max_meses INT, 
	monto_minimo DECIMAL(10,2),
	monto_maximo DECIMAL(10,2), 
	requiere_garantia NVARCHAR(15),
	moneda NVARCHAR(30),
	dwh_fecha_carga DATETIME2 DEFAULT GETDATE()
); 

IF OBJECT_ID('plata.sucursales','U') IS NOT NULL 
BEGIN
	DROP TABLE plata.sucursales;
END
GO 
CREATE TABLE plata.sucursales (
	sucursal_id INT,
	codigo_sucursal NVARCHAR(30),
	nombre_sucursal NVARCHAR(50),
	tipo_sucursal NVARCHAR(30),
	ciudad NVARCHAR(30),
	departamento NVARCHAR(30),
	region NVARCHAR(30),
	zona NVARCHAR(30),
	fecha_apertura DATE, 
	estado_sucursal NVARCHAR(30),
	dwh_fecha_carga DATETIME2 DEFAULT GETDATE()
); 

IF OBJECT_ID('plata.clientes','U') IS NOT NULL 
BEGIN
	DROP TABLE plata.clientes;
END
GO 
CREATE TABLE plata.clientes (
	cliente_id INT,
	tipo_documento NVARCHAR(10),
	numero_documento NVARCHAR(20), 
	nombres NVARCHAR(50),
	apellido_paterno NVARCHAR(30),
	apellido_materno NVARCHAR(30),
	fecha_nacimiento DATE,
	edad INT,
	genero NVARCHAR(20),
	estado_civil NVARCHAR(30),
	nivel_educacion NVARCHAR(30),
	ocupacion NVARCHAR (50),
	sector_economico NVARCHAR(50),
	ciudad_residencia NVARCHAR(30),
	departamento_residencia NVARCHAR(30),
	region_residencia NVARCHAR(30),
	ingresos_mensuales DECIMAL(10,2),
	egresos_mensuales DECIMAL(10,2),
	patrimonio_estimado DECIMAL(10,2),
	score_crediticio INT,
	segmento_cliente NVARCHAR(30),
	canal_captacion NVARCHAR(30),
	antiguedad_cliente_meses INT,
	fecha_registro DATE,
	sucursal_id INT,
	estado_cliente NVARCHAR(30),
	dwh_fecha_carga DATETIME2 DEFAULT GETDATE()
);


IF OBJECT_ID('plata.oficiales_credito','U') IS NOT NULL 
BEGIN
	DROP TABLE plata.oficiales_credito;
END
GO 
CREATE TABLE plata.oficiales_credito (
	oficial_id INT,
	sucursal_id INT,
	nombres NVARCHAR(50),
	apellido_paterno NVARCHAR(30),
	apellido_materno NVARCHAR(30),
	genero NVARCHAR(20),
	cargo NVARCHAR(40),
	fecha_ingreso DATE,
	estado NVARCHAR(30),
	dwh_fecha_carga DATETIME2 DEFAULT GETDATE()
); 

IF OBJECT_ID('plata.prestamos','U') IS NOT NULL 
BEGIN
	DROP TABLE plata.prestamos;
END
GO 
CREATE TABLE plata.prestamos (
	prestamo_id INT, 
	cliente_id INT, 
	sucursal_id INT, 
	producto_id INT,
	oficial_id INT, 
	numero_contrato NVARCHAR(30),
	fecha_otorgamiento DATE,
	fecha_vencimiento DATE,
	monto_original DECIMAL(10,2),
	saldo_capital_vigente DECIMAL(10,2),
	tasa_interes_nominal_anual DECIMAL(8,4), 
	tasa_interes_efectiva_anual DECIMAL(8,4),
	plazo_meses INT, 
	tipo_credito NVARCHAR(30),
	moneda NVARCHAR(30),
	frecuencia_pago NVARCHAR(30),
	cuota_programada DECIMAL(10,2),
	numero_cuotas_total INT,
	numero_cuotas_pagadas INT, 
	numero_cuotas_pendientes INT, 
	estado NVARCHAR(30),
	dias_mora INT,
	clasificacion_riesgo_sbs NVARCHAR(30),
	garantia_tipo NVARCHAR(30),
	garantia_valor DECIMAL(10,2),
	proposito_credito NVARCHAR(50),
	canal_desembolso NVARCHAR(30),
	fecha_primer_pago_programado DATE,
	fecha_ultimo_pago_real DATE,
	dwh_fecha_carga DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID('plata.pagos','U') IS NOT NULL 
BEGIN
	DROP TABLE plata.pagos;
END
GO 
CREATE TABLE plata.pagos (
	pago_id INT,
	prestamo_id INT,
	numero_cuota INT,
	fecha_vencimiento_cuota DATE,
	fecha_pago DATE,
	monto_cuota_programada DECIMAL(10,2),
	monto_capital_programado DECIMAL(10,2),
	monto_interes_programado DECIMAL(10,2),
	monto_pagado_total DECIMAL(10,2),
	monto_capital_pagado DECIMAL(10,2),
	monto_interes_pagado DECIMAL(10,2),
	monto_mora_pagado DECIMAL(10,2),
	saldo_capital_despues_pago DECIMAL(10,2),
	dias_retraso INT,
	estado_pago NVARCHAR(30),
	canal_pago NVARCHAR(30),
	referencia_pago NVARCHAR(30),
	dwh_fecha_carga DATETIME2 DEFAULT GETDATE()
); 
