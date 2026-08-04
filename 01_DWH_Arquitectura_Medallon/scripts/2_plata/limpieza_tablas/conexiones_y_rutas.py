from dotenv import load_dotenv
from urllib.parse import quote_plus
from sqlalchemy  import create_engine
from sqlalchemy.engine import Engine
from pathlib import Path
import os

load_dotenv(dotenv_path=Path(__file__).resolve().parents[2] /".env")

def obtener_engine()-> Engine:
    """
    ESTA FUNCIÓN SE ENCARGA DE OBTENER EL ENGINE
    --------------------------------------------
    
    Argumentos
    ----------
        Esta funcion no solicita argumentos. 
        
    Resultado
    ---------
        engine_bd (Engine): Esta funcion retorna el Engine para la conexion a la BD. 
    
    Ejemplo de uso 
    --------------
        engine = obtener_engine()  
        
        df = pd.read_sql(  
            "query",  
            con=engine  
        )
    """
    
    # Credenciales de inicio 
    usuario = os.getenv("DB_USUARIO")
    contrasenia = os.getenv("DB_PASSWORD")
    servidor = os.getenv("DB_SERVER")
    base_datos = os.getenv("DB_NAME")

    if not all([usuario, contrasenia, servidor, base_datos]):
        raise ValueError("Uno o varios de los valores de credenciales esta vacio")
    
    usuario = quote_plus(usuario)
    contrasenia = quote_plus(contrasenia)
    servidor = quote_plus(servidor)
    base_datos = quote_plus(base_datos)
    
    return create_engine(f"mssql+pyodbc://{usuario}:{contrasenia}@{servidor}/{base_datos}?driver=ODBC+Driver+17+for+SQL+Server")


RUTA_DATASETS = Path(__file__).resolve().parents[4] / "00_datasets"
CARPETAS = {
    "archivos_iniciales": RUTA_DATASETS,
    "archivos_de_ayuda": RUTA_DATASETS / "archivos_de_ayuda",
    "archivos_para_revision": RUTA_DATASETS / "registros_para_revision",
    "archivos_semi_limpios": RUTA_DATASETS / "tablas_semi_limpias",
    "archivos_limpios": RUTA_DATASETS / "tablas_limpias"
}

def obtener_ruta_archivo(categoria: str, nombre_archivo: str)-> Path: 
    """
    ESTA FUNCIÓN SE ENCARGA DE OBTENER LA RUTA DE LOS ARCHIVOS
    --------------------------------------------
    
    Argumentos
    ----------
        categoria (str): Categoria del archivo (archivos_iniciales, archivos_para_revision, archivos_limpios, archivos_semi_limpios, archivos_de_ayuda).  
        nombre_archivo (str): Nombre del archivo al que se quiere acceder. 
        
    Resultado
    ---------
        Esta funcion retorna la ruta del archivo solicitado.  
    
    Ejemplo de uso 
    --------------
        
        ruta_archivo("archivos_iniciales","clientes.csv")  
        >>> D:\\Data_Analytics\\PROYECTOS\\Analisis_Integral_de_Cartera_de_Creditos_Bancarios\\0_Data_Sets\\clientes.csv  
        
        df = pd.read_csv(ruta_archivo("archivos_iniciales","clientes.csv"))
    """
    
    if categoria not in CARPETAS:
        raise ValueError("La categoria ingresada no es una opcion valida (archivos_iniciales, archivos_de_ayuda, archivos_para_revision, archivos_limpios)")
    
    return CARPETAS[categoria] / nombre_archivo