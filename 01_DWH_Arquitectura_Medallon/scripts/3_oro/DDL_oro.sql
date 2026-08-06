/*
============
DDL CAPA ORO
============

ADVERTENCIA: 
	El script puede eliminar las siguiente VIEWS en caso ya existen:
		- oro.dim_productos_crediticios 
		- oro.dim_sucursales 
		- oro.dim_clientes 
		- oro.dim_oficiales_credito
		- oro.fact_prestamos
		- oro.fact_pagos 

PROPOSITO DEL SCRIPT: 
	Crear las VIEWS, necesarias para la capa oro. 
	La capa oro, representa la etapa final del DWH, las dimensiones y hechos (galaxy schema).

	La fuente de datos para estos VIEWS son las tablas de la capa plata.

USO: 
	Las VIEWS, pueden ser utilizadas para analisis y reportes. 
*/

USE DWH_Creditos;
GO
/*
=================================================
Creacion dimension: oro.dim_productos_crediticios
=================================================
*/ 
IF OBJECT_ID('oro.dim_productos_crediticios','V') IS NOT NULL
BEGIN 
	DROP VIEW oro.dim_productos_crediticios;
END
GO 

CREATE VIEW oro.dim_productos_crediticios AS (
	SELECT
		ROW_NUMBER() OVER(ORDER BY producto_id) AS producto_llave,
		producto_id,
		nombre_producto,
		tipo_credito,
		moneda,
		-- De BIT, a un tipo mas claro y entendible para reporte o analisis 
		CASE 
			WHEN requiere_garantia = 1 THEN 'Si'
			WHEN requiere_garantia = 0 THEN 'No'
			ELSE 'n/a'
		END AS requiere_garantia,
		plazo_min_meses,
		plazo_max_meses,
		tasa_nom_min,
		tasa_nom_max,
		monto_minimo,
		monto_maximo
	FROM plata.productos_crediticios
)
GO 

/*
======================================
Creacion dimension: oro.dim_sucursales
======================================
*/ 
IF OBJECT_ID('oro.dim_sucursales','V') IS NOT NULL
BEGIN 
	DROP VIEW oro.dim_sucursales;
END
GO 

CREATE VIEW oro.dim_sucursales AS (
	SELECT 
		ROW_NUMBER() OVER(ORDER BY codigo_sucursal,fecha_apertura) AS sucursal_llave, 
		sucursal_id,
		codigo_sucursal,
		fecha_apertura,
		estado_sucursal,
		nombre_sucursal,
		tipo_sucursal,
		ciudad,
		departamento,
		region,
		zona
	FROM plata.sucursales
)
GO

/*
====================================
Creacion dimension: oro.dim_clientes
====================================
*/ 
IF OBJECT_ID('oro.dim_clientes','V') IS NOT NULL
BEGIN 
	DROP VIEW oro.dim_clientes;
END
GO 

CREATE VIEW oro.dim_clientes AS (
	SELECT 
		ROW_NUMBER() OVER(ORDER BY cli.cliente_id, cli.fecha_registro) AS cliente_llave,
		suc.sucursal_llave,
		cli.cliente_id,
		cli.tipo_documento,
		cli.numero_documento,
		cli.fecha_registro,
		cli.estado_cliente,
		cli.segmento_cliente,
		cli.canal_captacion,
		cli.score_crediticio,
		cli.ingresos_mensuales,
		cli.egresos_mensuales,
		cli.patrimonio_estimado,
		cli.fecha_nacimiento,
		cli.nombres,
		cli.apellido_paterno,
		cli.apellido_materno,
		cli.genero,
		cli.estado_civil,
		cli.nivel_educacion,
		cli.ocupacion,
		cli.sector_economico,
		cli.ciudad_residencia,
		cli.departamento_residencia,
		cli.region_residencia
	FROM plata.clientes AS cli 
	LEFT JOIN oro.dim_sucursales AS suc
		ON cli.sucursal_id = suc.sucursal_id
)
GO

/*
=============================================
Creacion dimension: oro.dim_oficiales_credito
=============================================
*/ 
IF OBJECT_ID('oro.dim_oficiales_credito','V') IS NOT NULL
BEGIN 
	DROP VIEW oro.dim_oficiales_credito;
END
GO 

CREATE VIEW oro.dim_oficiales_credito AS (
	SELECT 
		ROW_NUMBER() OVER(ORDER BY ofi.oficial_id, ofi.fecha_ingreso) AS oficial_llave,
		suc.sucursal_llave,
		ofi.oficial_id,
		ofi.fecha_ingreso,
		ofi.cargo,
		ofi.estado,
		ofi.nombres,
		ofi.apellido_paterno,
		ofi.apellido_materno,
		ofi.genero
	FROM plata.oficiales_credito AS ofi 
	LEFT JOIN oro.dim_sucursales AS suc
		ON ofi.sucursal_id = suc.sucursal_id
)
GO

/*
======================================
Creacion dimension: oro.fact_prestamos
======================================
*/ 
IF OBJECT_ID('oro.fact_prestamos','V') IS NOT NULL
BEGIN 
	DROP VIEW oro.fact_prestamos;
END
GO 

CREATE VIEW oro.fact_prestamos AS (
	SELECT 
		ROW_NUMBER() OVER(ORDER BY pres.numero_contrato, pres.fecha_otorgamiento) AS  prestamo_llave,
		ofi.oficial_llave,
		suc.sucursal_llave,
		pro.producto_llave,
		cli.cliente_llave,
		pres.prestamo_id,
		pres.numero_contrato,
		pres.proposito_credito,
		pres.estado,
		pres.clasificacion_riesgo_sbs,
		pres.dias_mora,
		pres.garantia_tipo,
		pres.garantia_valor,
		pres.fecha_otorgamiento,
		pres.fecha_vencimiento,
		pres.plazo_meses,
		pres.frecuencia_pago,
		pres.numero_cuotas_total,
		pres.numero_cuotas_pagadas,
		pres.numero_cuotas_pendientes,
		pres.cuota_programada,
		pres.fecha_primer_pago_programado,
		pres.fecha_ultimo_pago_real AS fecha_ultimo_pago,
		pres.canal_desembolso,
		pres.monto_original,
		pres.saldo_capital_vigente,
		pres.tasa_interes_nominal_anual,
		pres.tasa_interes_efectiva_anual
	FROM plata.prestamos AS pres
	LEFT JOIN oro.dim_productos_crediticios AS pro
		ON pres.producto_id = pro.producto_id
	LEFT JOIN oro.dim_sucursales AS suc
		ON pres.sucursal_id = suc.sucursal_id
	LEFT JOIN oro.dim_clientes AS cli 
		ON pres.cliente_id = cli.cliente_id
	LEFT JOIN oro.dim_oficiales_credito AS ofi 
		ON pres.oficial_id = ofi.oficial_id
)
GO

/*
==================================
Creacion dimension: oro.fact_pagos
==================================
*/ 
IF OBJECT_ID('oro.fact_pagos','V') IS NOT NULL
BEGIN 
	DROP VIEW oro.fact_pagos;
END
GO 

CREATE VIEW oro.fact_pagos AS (
	SELECT 
		pag.pago_id,
		pres.prestamo_llave,
		pres.cliente_llave,
		pres.producto_llave,
		pres.sucursal_llave,
		pres.oficial_llave,
		pag.referencia_pago,
		pag.numero_cuota,
		pag.fecha_vencimiento_cuota,
		pag.fecha_pago,
		pag.dias_retraso,	
		pag.estado_pago,
		pag.canal_pago,
		pag.monto_cuota_programada,
		pag.monto_capital_programado,
		pag.monto_interes_programado,
		pag.monto_pagado_total,
		pag.monto_capital_pagado,
		pag.monto_interes_pagado,
		pag.monto_mora_pagado,
		pag.saldo_capital_despues_pago
	FROM plata.pagos AS pag
	LEFT JOIN oro.fact_prestamos AS pres
		ON pag.prestamo_id = pres.prestamo_id
)
GO
