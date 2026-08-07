/*
=========================================
VERIFICACION CANTIDAD DE FILAS Y COLUMNAS
=========================================

PROPOSITO DEL SCRIPT:
	1. Verificar que la cantidad de filas sean las correctas.
	2. Verificar el nombre de las columnas y los tipos de datos.
	3. Verificar que las llaves sustitudas sean únicas. 
	4. Verificar la integridad de las relaciones entre tablas.
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

/*
========================================
VERIFICACION DE CLAVES SUSTITUTAS UNICAS
========================================
*/

-- oro.dim_productos_credicios 
-- Resultados Esperados: Tabla Vacia 
SELECT
	producto_llave,
	COUNT(*) AS registros_repetidos 
FROM oro.dim_productos_crediticios
GROUP BY producto_llave
HAVING COUNT(*) > 1

-- oro.dim_sucursales 
-- Resultados Esperados: Tabla Vacia 
SELECT
	sucursal_llave,
	COUNT(*) AS registros_repetidos 
FROM oro.dim_sucursales
GROUP BY sucursal_llave
HAVING COUNT(*) > 1

-- oro.dim_clientes 
-- Resultados Esperados: Tabla Vacia 
SELECT
	cliente_llave,
	COUNT(*) AS registros_repetidos 
FROM oro.dim_clientes
GROUP BY cliente_llave
HAVING COUNT(*) > 1

-- fact_prestamos 
-- Resultados Esperados: Tabla Vacia 
SELECT
	prestamo_llave,
	COUNT(*) AS registros_repetidos 
FROM oro.fact_prestamos
GROUP BY prestamo_llave
HAVING COUNT(*) > 1

/*
============================================================
VERIFICACION DE LA INTEGRIDAD DE LAS RELACIONES ENTRE TABLAS
============================================================
*/

-- dim_clientes con dim_sucursales 
-- Resultado Esperado: Tabla Vacia
SELECT
	cli.cliente_llave,
	cli.sucursal_llave
FROM oro.dim_clientes AS cli 
LEFT JOIN oro.dim_sucursales AS suc
	ON cli.sucursal_llave = suc.sucursal_llave
WHERE suc.sucursal_llave IS NULL

-- dim_oficiales_credito con dim_sucursales 
-- Resultado Esperado: Tabla Vacia
SELECT
	ofi.oficial_llave,
	ofi.sucursal_llave
FROM oro.dim_oficiales_credito AS ofi 
LEFT JOIN oro.dim_sucursales AS suc
	ON ofi.sucursal_llave = suc.sucursal_llave
WHERE suc.sucursal_llave IS NULL

-- fact_prestamos con dim_sucursales, dim_clientes, dim_oficiales_credito y dim_productos_crediticios 
-- Resultado Esperado: Tabla Vacia
SELECT
	pres.prestamo_llave,
	pres.prestamo_id
FROM oro.fact_prestamos as pres
LEFT JOIN oro.dim_sucursales AS suc
	ON pres.sucursal_llave = suc.sucursal_llave
LEFT JOIN oro.dim_clientes AS cli
	ON pres.cliente_llave = cli.cliente_llave
LEFT JOIN oro.dim_oficiales_credito AS ofi
	ON pres.oficial_llave = ofi.oficial_llave
LEFT JOIN oro.dim_productos_crediticios AS pro
	ON pres.producto_llave = pro.producto_llave
WHERE suc.sucursal_llave IS NULL
	  OR cli.cliente_llave  IS NULL
	  OR ofi.oficial_llave  IS NULL 
	  OR pro.producto_llave IS NULL

-- fact_pagos con fac_prestamos, dim_sucursales, dim_clientes, dim_oficiales_credito y dim_productos_crediticios 
-- Resultado Esperado: Tabla Vacia
SELECT
	pag.pago_id
FROM oro.fact_pagos as pag
LEFT JOIN oro.fact_prestamos AS pres 
	ON pag.prestamo_llave = pres.prestamo_llave
LEFT JOIN oro.dim_sucursales AS suc
	ON pag.sucursal_llave = suc.sucursal_llave
LEFT JOIN oro.dim_clientes AS cli
	ON pag.cliente_llave = cli.cliente_llave
LEFT JOIN oro.dim_oficiales_credito AS ofi
	ON pag.oficial_llave = ofi.oficial_llave
LEFT JOIN oro.dim_productos_crediticios AS pro
	ON pag.producto_llave = pro.producto_llave
WHERE pres.prestamo_llave IS NULL 
	  OR suc.sucursal_llave IS NULL
	  OR cli.cliente_llave  IS NULL
	  OR ofi.oficial_llave  IS NULL 
	  OR pro.producto_llave IS NULL
