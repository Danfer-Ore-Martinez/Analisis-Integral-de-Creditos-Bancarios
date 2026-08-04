/*
===========================================
Inicializando la Base de Datos DWH_Creditos
===========================================

ADVERTENCIA: 
	El siguiente script, puede borrar la base de datos llamada 'DWH_Creditos' en caso existir, ejecutar con cuidado. 

PROPOSTIO DEL SCRIPT:
	1.- Crear la base de datos 'DWH_Creditos', para la creación del DWH de arquitectura Medallon.
	2.- Crear los schemas necesarios para cada capa 'bronce', 'plata', 'oro'.
*/

USE master;

-- Verifica si existe  la base de datos 'DWH_Creditos', en caso existir la borra y la crea nuevamente, si existe solo la crea. 
IF EXISTS(SELECT 1 FROM SYS.databases WHERE name = 'DWH_Creditos') 
BEGIN 
	ALTER DATABASE DWH_Creditos SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DWH_Creditos;
END;
GO

CREATE DATABASE DWH_Creditos; 
GO

USE DWH_Creditos;
GO 

-- Crea los Schemas para cada capa del DWH 
CREATE SCHEMA bronce;
GO
CREATE SCHEMA plata;
GO
CREATE SCHEMA oro;
