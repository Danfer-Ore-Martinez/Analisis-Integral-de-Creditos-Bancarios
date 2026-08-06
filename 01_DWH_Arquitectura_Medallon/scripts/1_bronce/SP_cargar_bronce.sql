/*
==========================================================
CREACION STORED PROCEDURE PARA CARGAR DATOS EN CAPA BRONCE
==========================================================

ADVERTENCIA: 
	Tener cuidado al ejecutar, el STORED PRODCEDURE trunca las siguientes tablas: 
		- 'bronce.clientes'
		- 'bronce.oficiales_credito' 
		- 'bronce.pagos'
		- 'bronce.prestamos'
		- 'bronce.productos_crediticios'
		- 'bronce.sucursales'

PROPOSITO: 
	Crear un STORED PROCEDURE encargado de llenar las tablas con la informacion extraida desde los archivos csv: 
				    TABLAS                |            ARCHIVOS  
		- 'bronce.productos_crediticios'  |   - 'productos_crediticios.csv'
		- 'bronce.sucursales'             |   - 'sucursales.csv'
	    - 'bronce.clientes'               |   - 'clientes.csv'
		- 'bronce.oficiales_credito'      |   - 'oficiales_credito.csv'  
		- 'bronce.prestamos'              |   - 'prestamos.csv'
		- 'bronce.pagos'                  |   - 'pagos.csv'
		            
*/
USE DWH_Creditos;
GO 

CREATE OR ALTER PROCEDURE bronce.cargar_bronce AS 
BEGIN 
	BEGIN TRY
		DECLARE @inicio_carga_total DATETIME,@fin_carga_total DATETIME, @inicio_carga DATETIME, @fin_carga DATETIME; 
		PRINT '=============================================';
		PRINT 'INICIANDO LA CARGA DE DATOS DE LA CAPA BRONCE';
		PRINT '=============================================';

		SET @inicio_carga_total = GETDATE();

		PRINT '------------------------------------------------------------------------------------------------------------';
		SET @inicio_carga = GETDATE();
		PRINT '>>> Truncando la tabla  "bronce.productos_crediticios"';
		TRUNCATE TABLE bronce.productos_crediticios; 
		PRINT '>>> Cargando los datos en la tabla  "bronce.productos_crediticios"';
		BULK INSERT bronce.productos_crediticios 
		FROM 'D:\Data_Analytics\PROYECTOS\Analisis_Integral_de_Cartera_de_Creditos_Bancarios\00_datasets\productos_crediticios.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			CODEPAGE = '65001',
			TABLOCK
		);
		SET @fin_carga = GETDATE(); 
		PRINT '>>> Carga completa en la tabla  "bronce.productos_crediticios"';
		PRINT 'Tiempo utilizado en cargar datos ' + CAST(DATEDIFF(SECOND,@inicio_carga,@fin_carga) AS VARCHAR) + ' Segundos'; 
		PRINT '------------------------------------------------------------------------------------------------------------';


		PRINT '------------------------------------------------------------------------------------------------------------';
		SET @inicio_carga = GETDATE();
		PRINT '>>> Truncando la tabla  "bronce.sucursales"';
		TRUNCATE TABLE bronce.sucursales; 
		PRINT '>>> Cargando los datos en la tabla  "bronce.sucursales"';
		BULK INSERT bronce.sucursales 
		FROM 'D:\Data_Analytics\PROYECTOS\Analisis_Integral_de_Cartera_de_Creditos_Bancarios\00_datasets\sucursales.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			CODEPAGE = '65001',
			TABLOCK
		);
		SET @fin_carga = GETDATE(); 
		PRINT '>>> Carga completa en la tabla  "bronce.sucursales"';
		PRINT 'Tiempo utilizado en cargar datos ' + CAST(DATEDIFF(SECOND,@inicio_carga,@fin_carga) AS VARCHAR) + ' Segundos'; 
		PRINT '------------------------------------------------------------------------------------------------------------';


		PRINT '------------------------------------------------------------------------------------------------------------';
		SET @inicio_carga = GETDATE();
		PRINT '>>> Truncando la tabla  "bronce.clientes"';
		TRUNCATE TABLE bronce.clientes; 
		PRINT '>>> Cargando los datos en la tabla  "bronce.clientes"';
		BULK INSERT bronce.clientes 
		FROM 'D:\Data_Analytics\PROYECTOS\Analisis_Integral_de_Cartera_de_Creditos_Bancarios\00_datasets\clientes.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			CODEPAGE = '65001',
			TABLOCK
		);
		SET @fin_carga = GETDATE(); 
		PRINT '>>> Carga completa en la tabla  "bronce.clientes"';
		PRINT 'Tiempo utilizado en cargar datos ' + CAST(DATEDIFF(SECOND,@inicio_carga,@fin_carga) AS VARCHAR) + ' Segundos'; 
		PRINT '------------------------------------------------------------------------------------------------------------';


		PRINT '------------------------------------------------------------------------------------------------------------';
		SET @inicio_carga = GETDATE();
		PRINT '>>> Truncando la tabla  "bronce.prestamos"';
		TRUNCATE TABLE bronce.prestamos; 
		PRINT '>>> Cargando los datos en la tabla  "bronce.prestamos"';
		BULK INSERT bronce.prestamos 
		FROM 'D:\Data_Analytics\PROYECTOS\Analisis_Integral_de_Cartera_de_Creditos_Bancarios\00_datasets\prestamos.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			CODEPAGE = '65001',
			TABLOCK
		);
		SET @fin_carga = GETDATE(); 
		PRINT '>>> Carga completa en la tabla  "bronce.prestamos"';
		PRINT 'Tiempo utilizado en cargar datos ' + CAST(DATEDIFF(SECOND,@inicio_carga,@fin_carga) AS VARCHAR) + ' Segundos'; 
		PRINT '------------------------------------------------------------------------------------------------------------';


		PRINT '------------------------------------------------------------------------------------------------------------';
		SET @inicio_carga = GETDATE();
		PRINT '>>> Truncando la tabla  "bronce.oficiales_credito"';
		TRUNCATE TABLE bronce.oficiales_credito; 
		PRINT '>>> Cargando los datos en la tabla  "bronce.oficiales_credito"';
		BULK INSERT bronce.oficiales_credito 
		FROM 'D:\Data_Analytics\PROYECTOS\Analisis_Integral_de_Cartera_de_Creditos_Bancarios\00_datasets\oficiales_credito.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			CODEPAGE = '65001',
			TABLOCK
		);
		SET @fin_carga = GETDATE(); 
		PRINT '>>> Carga completa en la tabla  "bronce.oficiales_credito"';
		PRINT 'Tiempo utilizado en cargar datos ' + CAST(DATEDIFF(SECOND,@inicio_carga,@fin_carga) AS VARCHAR) + ' Segundos'; 
		PRINT '------------------------------------------------------------------------------------------------------------';
		

		PRINT '------------------------------------------------------------------------------------------------------------';
		SET @inicio_carga = GETDATE();
		PRINT '>>> Truncando la tabla  "bronce.pagos"';
		TRUNCATE TABLE bronce.pagos; 
		PRINT '>>> Cargando los datos en la tabla  "bronce.pagos"';
		BULK INSERT bronce.pagos 
		FROM 'D:\Data_Analytics\PROYECTOS\Analisis_Integral_de_Cartera_de_Creditos_Bancarios\00_datasets\pagos.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			CODEPAGE = '65001',
			TABLOCK
		);
		SET @fin_carga = GETDATE(); 
		PRINT '>>> Carga completa en la tabla  "bronce.pagos"';
		PRINT 'Tiempo utilizado en cargar datos ' + CAST(DATEDIFF(SECOND,@inicio_carga,@fin_carga) AS VARCHAR) + ' Segundos'; 
		PRINT '------------------------------------------------------------------------------------------------------------';
		

		SET @fin_carga_total = GETDATE();
		PRINT '============================================================';
		PRINT 'PROCESO DE CARGA DE LA CAPA BRONCE COMPLETADO';
		PRINT 'TIEMPO TOTAL DE CARGA DE DATOS: ' + CAST(DATEDIFF(SECOND, @inicio_carga_total,@fin_carga_total) AS VARCHAR) + ' SEGUNDOS ';
		PRINT '============================================================';
	END TRY 
	BEGIN CATCH 
		PRINT '================================================================';
		PRINT 'A OCURRIDO UN ERROR AL MOMENTO DE CARGAR DATOS EN LA CAPA BRONCE';
		PRINT 'Mensaje de Error: ' + ERROR_MESSAGE();
		PRINT 'Numero del error: ' + CAST(ERROR_NUMBER() AS VARCHAR);
		PRINT 'Linea del error: ' + CAST(ERROR_LINE() AS VARCHAR);
		PRINT 'Procedimiento del Error: ' + ERROR_PROCEDURE();
		PRINT '================================================================';
	END CATCH
END; 
GO 
