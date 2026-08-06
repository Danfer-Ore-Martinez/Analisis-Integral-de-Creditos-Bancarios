/*
=========================================
VERIFICACION CANTIDAD DE FILAS Y COLUMNAS
=========================================

PROPOSITO DEL SCRIPT:
	1. Verificar que la cantidad de filas sean las correctas
	2. Verificar el nombre de las columnas y los tipos de datos
*/

USE DWH_Creditos;
GO 

-- RESULTADO ESPERADO: 8
SELECT
	COUNT(*) AS cantidad_filas_tabla_productos_crediticios
FROM oro.dim_productos_crediticios;

SELECT 
	COLUMN_NAME,
	DATA_TYPE,
	IS_NULLABLE,
	CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_productos_crediticios'
	AND TABLE_SCHEMA = 'oro'

-- RESULTADO ESPERADO: 24
SELECT
	COUNT(*) AS cantidad_filas_tabla_sucursales
FROM oro.dim_sucursales

SELECT 
	COLUMN_NAME,
	DATA_TYPE,
	IS_NULLABLE,
	CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_sucursales'
	AND TABLE_SCHEMA = 'oro'

-- RESULTADO ESPERADO: 5000
SELECT
	COUNT(*) AS cantidad_filas_tabla_clientes
FROM oro.dim_clientes

SELECT 
	COLUMN_NAME,
	DATA_TYPE,
	IS_NULLABLE,
	CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_clientes'
	AND TABLE_SCHEMA = 'oro'

-- RESULTADO ESPERADO: 60
SELECT
	COUNT(*) AS cantidad_filas_tabla_oficiales_credito
FROM oro.dim_oficiales_credito

SELECT 
	COLUMN_NAME,
	DATA_TYPE,
	IS_NULLABLE,
	CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_oficiales_credito'
	AND TABLE_SCHEMA = 'oro'


-- RESULTADO ESPERADO: 6495
SELECT
	COUNT(*) AS cantidad_filas_tabla_prestamos
FROM oro.fact_prestamos

SELECT 
	COLUMN_NAME,
	DATA_TYPE,
	IS_NULLABLE,
	CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'fact_prestamos'
	AND TABLE_SCHEMA = 'oro'

-- RESULTADO ESPERADO: 134911
SELECT
	COUNT(*) AS cantidad_filas_tabla_pagos
FROM oro.fact_pagos

SELECT 
	COLUMN_NAME,
	DATA_TYPE,
	IS_NULLABLE,
	CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'fact_pagos'
	AND TABLE_SCHEMA = 'oro'
