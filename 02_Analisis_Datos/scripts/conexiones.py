from dotenv import load_dotenv
from urllib.parse import quote_plus
from sqlalchemy  import create_engine
from sqlalchemy.engine import Engine
from pathlib import Path
import os

load_dotenv(dotenv_path=Path(__file__).resolve().parent /".env")

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

