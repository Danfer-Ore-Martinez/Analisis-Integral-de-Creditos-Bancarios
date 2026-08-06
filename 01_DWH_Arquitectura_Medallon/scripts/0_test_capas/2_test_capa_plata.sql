/*
====================================================
VERIFICACION CANTIDAD DE FILAS Y COLUMNAS CAPA PLATA
====================================================

PROPOSITO DEL SCRIPT:
	1. Verificar que la cantidad de filas de las tablas sean iguales a la cantidad de filas de los archivos. 
	2. Verificar el nombre de las columnas y los tipos de datos
*/

USE DWH_Creditos;
GO 

-- RESULTADO ESPERADO: 8
SELECT
	COUNT(*) AS cantidad_filas_tabla_productos_crediticios
FROM plata.productos_crediticios;

SELECT 
	COLUMN_NAME,
	DATA_TYPE,
	IS_NULLABLE,
	CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'productos_crediticios'
	AND TABLE_SCHEMA = 'plata'

-- RESULTADO ESPERADO: 24
SELECT
	COUNT(*) AS cantidad_filas_tabla_sucursales
FROM plata.sucursales

SELECT 
	COLUMN_NAME,
	DATA_TYPE,
	IS_NULLABLE,
	CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'sucursales'
	AND TABLE_SCHEMA = 'plata'

-- RESULTADO ESPERADO: 5000
SELECT
	COUNT(*) AS cantidad_filas_tabla_clientes
FROM plata.clientes

SELECT 
	COLUMN_NAME,
	DATA_TYPE,
	IS_NULLABLE,
	CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'clientes'
	AND TABLE_SCHEMA = 'plata'

-- RESULTADO ESPERADO: 60
SELECT
	COUNT(*) AS cantidad_filas_tabla_oficiales_credito
FROM plata.oficiales_credito

SELECT 
	COLUMN_NAME,
	DATA_TYPE,
	IS_NULLABLE,
	CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'oficiales_credito'
	AND TABLE_SCHEMA = 'plata'


-- RESULTADO ESPERADO: 6495
SELECT
	COUNT(*) AS cantidad_filas_tabla_prestamos
FROM plata.prestamos

SELECT 
	COLUMN_NAME,
	DATA_TYPE,
	IS_NULLABLE,
	CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'prestamos'
	AND TABLE_SCHEMA = 'plata'

-- RESULTADO ESPERADO: 134911
SELECT
	COUNT(*) AS cantidad_filas_tabla_pagos
FROM plata.pagos

SELECT 
	COLUMN_NAME,
	DATA_TYPE,
	IS_NULLABLE,
	CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'pagos'
	AND TABLE_SCHEMA = 'plata'
