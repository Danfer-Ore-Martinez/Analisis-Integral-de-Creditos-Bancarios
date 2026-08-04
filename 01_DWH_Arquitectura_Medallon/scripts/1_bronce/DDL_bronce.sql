/*
===============
DDL Capa Bronce
===============

ADVERTENCIA: 
	El siguiente script, puede borrar las siguientes tablas de la base de datos 'DWH_Creditos':
		- 'bronce.productos_crediticios'
		- 'bronce.sucursales'
		- 'bronce.clientes'
		- 'bronce.oficiales_credito' 
		- 'bronce.prestamos'
		- 'bronce.pagos'
		

PROPOSTIO DEL SCRIPT:
	1.- Crear las siguientes tablas para la capa Bronce:
		- 'bronce.productos_crediticios'
		- 'bronce.sucursales'
		- 'bronce.clientes'
		- 'bronce.oficiales_credito' 
		- 'bronce.prestamos'
		- 'bronce.pagos'
NOTA: 
	Las fechas se han creado como VARCHAR(15), porque las columnas de fecha tienen formatos diferentes.
*/

USE DWH_Creditos;
GO
/*
===========================
CREACION TABLAS CAPA BRONCE
===========================
*/
IF OBJECT_ID('bronce.productos_crediticios','U') IS NOT NULL 
BEGIN
	DROP TABLE bronce.productos_crediticios;
END
GO 
CREATE TABLE bronce.productos_crediticios (
	producto_id INT,
	nombre_producto VARCHAR(40),
	tipo_credito VARCHAR(50),
	tasa_nom_min DECIMAL(8,4),
	tasa_nom_max DECIMAL(8,4), 
	plazo_min_meses INT, 
	plazo_max_meses INT, 
	monto_minimo DECIMAL(10,2),
	monto_maximo DECIMAL(10,2), 
	requiere_garantia VARCHAR(15),
	moneda VARCHAR(30)
); 

IF OBJECT_ID('bronce.sucursales','U') IS NOT NULL 
BEGIN
	DROP TABLE bronce.sucursales;
END
GO 
CREATE TABLE bronce.sucursales (
	sucursal_id INT,
	codigo_sucursal VARCHAR(30),
	nombre_sucursal VARCHAR(50),
	tipo_sucursal VARCHAR(30),
	ciudad VARCHAR(30),
	departamento VARCHAR(30),
	region VARCHAR(30),
	zona VARCHAR(30),
	fecha_apertura VARCHAR(15), 
	estado_sucursal VARCHAR(30)
); 

IF OBJECT_ID('bronce.clientes','U') IS NOT NULL 
BEGIN
	DROP TABLE bronce.clientes;
END
GO 
CREATE TABLE bronce.clientes (
	cliente_id INT,
	tipo_documento VARCHAR(10),
	numero_documento VARCHAR(20), 
	nombres VARCHAR(50),
	apellido_paterno VARCHAR(30),
	apellido_materno VARCHAR(30),
	fecha_nacimiento VARCHAR(15),
	edad INT,
	genero VARCHAR(20),
	estado_civil VARCHAR(30),
	nivel_educacion VARCHAR(30),
	ocupacion VARCHAR (50),
	sector_economico VARCHAR(50),
	ciudad_residencia VARCHAR(30),
	departamento_residencia VARCHAR(30),
	region_residencia VARCHAR(30),
	ingresos_mensuales DECIMAL(10,2),
	egresos_mensuales DECIMAL(10,2),
	patrimonio_estimado DECIMAL(10,2),
	score_crediticio INT,
	segmento_cliente VARCHAR(30),
	canal_captacion VARCHAR(30),
	antiguedad_cliente_meses INT,
	fecha_registro VARCHAR(15),
	sucursal_id INT,
	estado_cliente VARCHAR(30)
);


IF OBJECT_ID('bronce.oficiales_credito','U') IS NOT NULL 
BEGIN
	DROP TABLE bronce.oficiales_credito;
END
GO 
CREATE TABLE bronce.oficiales_credito (
	oficial_id INT,
	sucursal_id INT,
	nombres VARCHAR(50),
	apellido_paterno VARCHAR(30),
	apellido_materno VARCHAR(30),
	genero VARCHAR(20),
	cargo VARCHAR(40),
	fecha_ingreso VARCHAR(15),
	estado VARCHAR(30),
); 

IF OBJECT_ID('bronce.prestamos','U') IS NOT NULL 
BEGIN
	DROP TABLE bronce.prestamos;
END
GO 
CREATE TABLE bronce.prestamos (
	prestamo_id INT, 
	cliente_id INT, 
	sucursal_id INT, 
	producto_id INT,
	oficial_id INT, 
	numero_contrato VARCHAR(30),
	fecha_otorgamiento VARCHAR(15),
	fecha_vencimiento VARCHAR(15),
	monto_original DECIMAL(10,2),
	saldo_capital_vigente DECIMAL(10,2),
	tasa_interes_nominal_anual DECIMAL(8,4), 
	tasa_interes_efectiva_anual DECIMAL(8,4),
	plazo_meses INT, 
	tipo_credito VARCHAR(30),
	moneda VARCHAR(30),
	frecuencia_pago VARCHAR(30),
	cuota_programada DECIMAL(10,2),
	numero_cuotas_total INT,
	numero_cuotas_pagadas INT, 
	numero_cuotas_pendientes INT, 
	estado VARCHAR(30),
	dias_mora INT,
	clasificacion_riesgo_sbs VARCHAR(30),
	garantia_tipo VARCHAR(30),
	garantia_valor DECIMAL(10,2),
	proposito_credito VARCHAR(50),
	canal_desembolso VARCHAR(30),
	fecha_primer_pago_programado VARCHAR(15),
	fecha_ultimo_pago_real VARCHAR(15) 
);

IF OBJECT_ID('bronce.pagos','U') IS NOT NULL 
BEGIN
	DROP TABLE bronce.pagos;
END
GO 
CREATE TABLE bronce.pagos (
	pago_id INT,
	prestamo_id INT,
	numero_cuota INT,
	fecha_vencimiento_cuota VARCHAR(15),
	fecha_pago VARCHAR(15),
	monto_cuota_programada DECIMAL(10,2),
	monto_capital_programado DECIMAL(10,2),
	monto_interes_programado DECIMAL(10,2),
	monto_pagado_total DECIMAL(10,2),
	monto_capital_pagado DECIMAL(10,2),
	monto_interes_pagado DECIMAL(10,2),
	monto_mora_pagado DECIMAL(10,2),
	saldo_capital_despues_pago DECIMAL(10,2),
	dias_retraso INT,
	estado_pago VARCHAR(30),
	canal_pago VARCHAR(30),
	referencia_pago VARCHAR(30)
); 
