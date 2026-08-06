/*
=====================================================
VERIFICACION CANTIDAD DE FILAS Y COLUMNAS CAPA BRONCE
=====================================================

PROPOSITO DEL SCRIPT:
	1. Verificar que la cantidad de filas de las tablas sean iguales a la cantidad de filas de los archivos. 
	2. Verificar el nombre de las columnas y los tipos de datos
*/

USE DWH_Creditos;
GO 

-- RESULTADO ESPERADO: 8
SELECT
	COUNT(*) AS cantidad_filas_tabla_productos_crediticios
FROM bronce.productos_crediticios;

-- Detalles de las columnas
SELECT 
	COLUMN_NAME,
	DATA_TYPE,
	IS_NULLABLE,
	CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'productos_crediticios'
	AND TABLE_SCHEMA = 'bronce'

-- RESULTADO ESPERADO: 26 
SELECT
	COUNT(*) AS cantidad_filas_tabla_sucursales
FROM bronce.sucursales

SELECT 
	COLUMN_NAME,
	DATA_TYPE,
	IS_NULLABLE,
	CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'sucursales'
	AND TABLE_SCHEMA = 'bronce'

-- RESULTADO ESPERADO: 5005
SELECT
	COUNT(*) AS cantidad_filas_tabla_clientes
FROM bronce.clientes

SELECT 
	COLUMN_NAME,
	DATA_TYPE,
	IS_NULLABLE,
	CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'clientes'
	AND TABLE_SCHEMA = 'bronce'

-- RESULTADO ESPERADO: 62
SELECT
	COUNT(*) AS cantidad_filas_tabla_oficiales_credito
FROM bronce.oficiales_credito

SELECT 
	COLUMN_NAME,
	DATA_TYPE,
	IS_NULLABLE,
	CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'oficiales_credito'
	AND TABLE_SCHEMA = 'bronce'


-- RESULTADO ESPERADO: 6499
SELECT
	COUNT(*) AS cantidad_filas_tabla_prestamos
FROM bronce.prestamos

SELECT 
	COLUMN_NAME,
	DATA_TYPE,
	IS_NULLABLE,
	CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'prestamos'
	AND TABLE_SCHEMA = 'bronce'

-- RESULTADO ESPERADO: 136944
SELECT
	COUNT(*) AS cantidad_filas_tabla_pagos
FROM bronce.pagos

SELECT 
	COLUMN_NAME,
	DATA_TYPE,
	IS_NULLABLE,
	CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'pagos'
	AND TABLE_SCHEMA = 'bronce'
