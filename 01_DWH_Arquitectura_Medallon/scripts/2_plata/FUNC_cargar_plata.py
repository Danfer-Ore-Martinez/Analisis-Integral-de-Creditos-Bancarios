import pandas as pd
from time import perf_counter
from sqlalchemy import text
from sqlalchemy.engine import Engine
from limpieza_tablas.conexiones_y_rutas import obtener_engine,obtener_ruta_archivo
import traceback

def truncar_tabla(conexion: Engine, nombre_tabla: str, nombre_schema: str) -> None:
    """
    CARGA UNA TABLA EN ESPECIFICO
    ------------------------------
    
    ADVERTENCIA
    -----------
    Al ejecutar la funcion se va a truncar la tabla en especifico. 
    
    PROPOSITO
    ---------
    Truncar una tabla en especifico en la bd.  
    
    PARAMETROS
    ----------  
    conexion (Engine): Conexion con la base de datos.  
    nombre_tabla (str): Nombre de la tabla que se va a truncar.  
    nombre_schema (str): Nombre del schema de la tabla.  
    
    VALOR DE RETORNO
    ----------------
        No retorna ningun valor 
    """
    
    print(f">>> Truncando la tabla: {nombre_schema+'.'+nombre_tabla}")
    with conexion.begin() as conn:
        conn.execute(text(f"TRUNCATE TABLE {nombre_schema}.{nombre_tabla}"))

def cargar_tabla(df: pd.DataFrame, conexion: Engine, nombre_tabla: str, nombre_schema: str, si_existe: str,index_s: bool, tamanio_carga: int) -> None: 
    """
    CARGA UNA TABLA EN ESPECIFICO
    ------------------------------
    
    PROPOSITO
    ---------
    Cargar una tabla en especifico en la bd, con un df. 
    
    PARAMETROS
    ----------
    df (pd.DataFrame): df que va a llenar la tabla de sql.   
    conexion (Engine): Conexion con la base de datos.  
    nombre_tabla (str): Nombre de la tabla donde se va a ingresar los datos.  
    nombre_schema (str): Nombre del schema de la tabla.  
    si_existe (str): Que accion se va a realizar en caso la tabla ya exista ('fail','replace','append').  
    index_s (bool): Se debe o no se debe mantener el indice (True: Se mantiene, False: No se mantiene).  
    tamanio_carga (int): Cantidad de filas que va recibir cada lote, es decir de cuantas filas en cuantas filas se van a ir añadiendo registros en la bd. 
        
    VALOR DE RETORNO
    ----------------
    No retorna ningun valor 
    """
    print("-"*80)
    incio_carga = perf_counter()
    
    with conexion.begin() as conn:
        print(f">>> Cargando la tabla: {nombre_schema+'.'+nombre_tabla}")
        df.to_sql(
            con= conn,
            name= nombre_tabla,
            schema= nombre_schema,
            if_exists= si_existe,
            index= index_s,
            chunksize= tamanio_carga
        )
        fin_carga = perf_counter()
        print(f">>> Carga completa de la tabla {nombre_schema+'.'+nombre_tabla}")
        print(f"Tiempo utilizado en cargar los datos: {round(fin_carga - incio_carga) } segundo")
        print("-"*80)

def plata_cargar_plata() -> None:
    """
    CARGAR LOS DATOS LIMPIOS EN LA CAPA PLATA
    -----------------------------------------
    
    ADVERTENCIA
    -----------
    Al ejecutar la funcion se van a Truncar las siguientes tablas: 
    - 'plata.productos_crediticios'  
    - 'plata.sucursales'  
    - 'plata.clientes'  
    - 'plata.oficiales_credito'  
    - 'plata.prestamos'  
    - 'plata.pagos'  
    
    PROPOSITO
    ---------
    Cargar los datos limpios en la capa plata de sql server  
    Tablas -> Archivos  
    - 'plata.productos_crediticios' -> 'limpio_productos_crediticios.parquet'
    - 'plata.sucursales' -> 'limpio_sucursales.parquet'
    - 'plata.clientes' -> 'limpio_clientes.parquet'
    - 'plata.oficiales_credito' -> 'limpio_oficiales_credito.parquet'  
    - 'plata.prestamos' -> 'limpio_prestamos.parquet'
    - 'plata.pagos' -> 'limpio_pagos.parquet'
    
    PARAMETROS
    ----------
    No requiere parametros  
        
    VALOR DE RETORNO
    ----------------
    No retorna ningun valor 
    """
    
    try: 
        #==========================
        # IMPORTANDO LOS DF LIMPIOS
        #==========================
        df_productos = pd.read_parquet(obtener_ruta_archivo("archivos_limpios","limpio_productos_crediticios.parquet"))
        df_sucursales = pd.read_parquet(obtener_ruta_archivo("archivos_limpios","limpio_sucursales.parquet"))
        df_clientes = pd.read_parquet(obtener_ruta_archivo("archivos_limpios","limpio_clientes.parquet"))
        df_oficiales_credito = pd.read_parquet(obtener_ruta_archivo("archivos_limpios","limpio_oficiales_credito.parquet"))
        df_prestamos = pd.read_parquet(obtener_ruta_archivo("archivos_limpios","limpio_prestamos.parquet"))
        df_pagos = pd.read_parquet(obtener_ruta_archivo("archivos_limpios","limpio_pagos.parquet"))
        
        #=========================================
        # PROCESO CARGA DE LOS DATOS EN SQL SERVER
        #=========================================
        engine_con = obtener_engine()
        
        print("="*100)
        print("INICIANDO EL PROCESO DE CARGA DE DATOS EN LA CAPA PLATA EN EL SERVIDOR DE SQL SERVER")
        print("="*100)
        
        inicio_carga_total = perf_counter()
        
        truncar_tabla(engine_con,'productos_crediticios','plata')
        cargar_tabla(df_productos,engine_con,'productos_crediticios','plata','append',False,10000)
        
        truncar_tabla(engine_con,'sucursales','plata')
        cargar_tabla(df_sucursales,engine_con,'sucursales','plata','append',False,10000)
        
        truncar_tabla(engine_con,'clientes','plata')
        cargar_tabla(df_clientes,engine_con,'clientes','plata','append',False,10000)
        
        truncar_tabla(engine_con,'oficiales_credito','plata')
        cargar_tabla(df_oficiales_credito,engine_con,'oficiales_credito','plata','append',False,10000)
        
        truncar_tabla(engine_con,'prestamos','plata')
        cargar_tabla(df_prestamos,engine_con,'prestamos','plata','append',False,10000)
        
        truncar_tabla(engine_con,'pagos','plata')
        cargar_tabla(df_pagos,engine_con,'pagos','plata','append',False,10000)
        
        fin_carga_total = perf_counter()
        print("="*80)
        print("PROCESO DE CARGA DE DATOS EN LA CAPA PLATA COMPLETA")
        print(f"Tiempo utilizado en cargar todos los datos en la capa plata: {round(fin_carga_total - inicio_carga_total) } segundos")
        print("="*80)
    except Exception as e:
        tb = traceback.extract_tb(e.__traceback__)

        ultimo_error = tb[-1]

        print("=" * 70)
        print("HA OCURRIDO UN ERROR AL MOMENTO DE CARGAR DATOS EN LA CAPA BRONZE")
        print(f"Mensaje del error: {e}")
        print(f"Tipo de error: {type(e).__name__}")
        print(f"Archivo: {ultimo_error.filename}")
        print(f"Línea: {ultimo_error.lineno}")
        print(f"Función: {ultimo_error.name}")
        print("=" * 70)
