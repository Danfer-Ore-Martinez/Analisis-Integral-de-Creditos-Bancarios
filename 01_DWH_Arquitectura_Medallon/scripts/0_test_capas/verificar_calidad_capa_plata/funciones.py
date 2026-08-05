import pandas as pd 
import numpy as np

# Utilizado en todas las tablas
def limpiar_texto(texto: str) -> str:
    """
    ESTA FUNCIÓN SE ENCARGA DE LIMPIAR EL FORMATO DE LOS TEXTOS
    -----------------------------------------------------------
    
    Nota 
    ----
        Utilizar en .apply()
        
    Argumentos
    ----------
        texto (str): Valor de la fila original    
        
    Resultado
    --------- 
        texto_CORRECTO (str): Valor de la fila ahora con un formato correcto  

    Ejemplo
    -------
        columna_nombres = ["Juan carlos ", "mAría JOSE", "LUIS",nan]  
        df.columna_str.apply(limpiar_texto)  
        >>> ["Juan Carlos", "María Jose", "Luis", 'n/a']  
        
        columna_ocupacion = ["  MESERO ", "IngNIERO Civil", "Empleado PUBLICO",nan]  
        df.columna_str.apply(limpiar_texto)  
        >>> ["Mesero", "Ingeniero Civil, "Empleado Publico", 'n/a']  

        columna_proposito = ["CrediTO Hipotecario ", "Automovil NuEVo", "RemoDELACION",nan]  
        df.columna_str.apply(limpiar_texto)  
        >>> ["Credito Hipotecarios", "Automovil Nuevo, "Remodelacion", 'n/a']  
    """
    conectores = {
        "de", "del", "la", "las", "el", "los",
        "y", "e", "o", "u", "a", "en", "con", "por", "para"
    }
    
    texto = texto.strip()
    
    if texto == "":
        return 'n/a'
    
    palabras = texto.lower().split()
    
    resultado = []
    for i, palabra in enumerate(palabras):
        if i == 0 or palabra not in conectores:
            resultado.append(palabra.capitalize())
        else:
            resultado.append(palabra)
    return " ".join(resultado)


"""
============================================
FUNCIONES tabla_bronce.productos_crediticios
============================================
"""

# utilizando en tabla bronce.productos_crediticios -> requiere_garantia
def formato_requiere_garantia(fila_requiere_garantia: str) -> str:
    """
    ESTA FUNCIÓN SE ENCARGA DE LIMPIAR LOS FORMATOS DE REQUIERE GARANTIA
    --------------------------------------------------------------------
    
    Nota 
    ----
        Utilizar en .apply()
        
    Argumentos
    ----------
        fila_requiere_garantia (str): Valor de la fila de requiere_garantia  
        
    Resultado
    -------- 
        fila_requiere_garantia_limpia (str): Valor de la fila de requiere_garantia con el formato adecuado  
    
    Ejemplo
    -------
        fila_requiere_garantia  = 'TRUe'  
        formato_requiere_moneda(fila_requiere_garantia)  
        >>> True  
        
        fila_requiere_garantia  = 'YES'  
        formato_requiere_moneda(fila_requiere_garantia)  
        >>> True  
        
        fila_requiere_garantia  = ' FaLse'  
        formato_requiere_moneda(fila_requiere_garantia)  
        >>> False  
        
        fila_requiere_garantia  = 'NO '  
        formato_requiere_moneda(fila_requiere_garantia)  
        >>> False  
        
        fila_requiere_garantia  = nan  
        formato_requiere_moneda(fila_requiere_garantia)  
        >>> 'n/a'  
    """
    
    fila_requiere_garantia = fila_requiere_garantia.strip()
    
    if fila_requiere_garantia == '':
        fila_requiere_garantia = 'NULO'
    
    match fila_requiere_garantia.upper()[0]:
        case 'T' | 'Y':
            return True
        case 'F' | 'N':
            return False
        case _:
            return 'n/a'


# utilizando en tabla bronce.productos_crediticios -> formato_moneda
def formato_moneda(fila_moneda: str) -> str:
    """
    ESTA FUNCIÓN SE ENCARGA DE LIMPIAR LOS FORMATOS DE MONEDA
    ---------------------------------------------------------
    
    Nota 
    ----
        Utilizar en .apply()
        
    Argumentos
    ----------
        fila_moneda (str): Valor de la fila de moneda  
        
    Resultado
    -------- 
        fila_moneda_limpia (str): Valor de la fila de moneda con el formato adecuado  
    
    Ejemplo
    -------
        fila_moneda  = 'Pen'  
        formato_moneda(fila_moneda)  
        >>> 'PEN'  
        
        fila_moneda  = 'S/.'  
        formato_moneda(fila_moneda)  
        >>> 'PEN'  
        
        fila_moneda  = '$'  
        formato_moneda(fila_moneda)  
        >>> 'USD'  
        
        fila_moneda  = 'Usd'  
        formato_moneda(fila_moneda)  
        >>> 'USD'  
        
        fila_moneda  = nan  
        formato_moneda(fila_moneda)  
        >>> 'n/a'  
    """
    
    fila_moneda = fila_moneda.strip()
    
    if fila_moneda == '':
        fila_moneda = 'NULO'
    
    match fila_moneda.upper()[0]:
        case 'P' | 'S':
            return 'PEN'
        case 'U' | '$':
            return 'USD'
        case _:
            return 'n/a'


"""
==================================
FUNCIONES tabla_bronce.surcursales
==================================
"""
# utilizando en tabla.bronce.estado_sucursal -> zona
def formato_zona(fila_zona: str) -> str:
    """
    ESTA FUNCIÓN SE ENCARGA DE LIMPIAR LOS FORMATOS DE LA ZONA DE  SUCURSAL
    -----------------------------------------------------------------------
    
    Nota 
    ----
        Utilizar en .apply()  
        
    Argumentos
    ----------
        fila_zona (str): Valor de la fila de la surcursal  
        
    Resultado
    -------- 
        fila_zona_limpia (str): Valor de la fila de la surcursal con el formato adecuado  
    
    Ejemplo
    -------
        fila_zona  = 'SELVA '  
        formato_zona(fila_zona)  
        >>> 'Selva'  
        
        fila_zona  = '  RURAL '  
        formato_zona(fila_zona)  
        >>> 'Rural'  
        
        fila_zona  = nan  
        formato_zona(fila_zona)  
        >>> 'n/a'  
    """
    
    fila_zona = fila_zona.strip()
    
    if fila_zona == '':
        fila_zona = 'NULO'
    
    match fila_zona.upper()[0]:
        case 'U':
            return 'Urbano'
        case 'S':
            return 'Selva'
        case 'R':
            return 'Rural'
        case _:
            return 'n/a'

# utilizando en tabla.bronce.estado_sucursal -> estado_sucursal
def formato_estado_sucursal(fila_estado_surcursal: str) -> str:
    """
    ESTA FUNCIÓN SE ENCARGA DE LIMPIAR LOS FORMATOS DEL ESTADO DE LA SUCURSAL
    -------------------------------------------------------------------------
    
    Nota 
    ----
        Utilizar en .apply()
        
    Argumentos
    ----------
        fila_estado_surcursal (str): Valor de la fila del estado de la surcursal
        
    Resultado
    -------- 
        fila_estado_surcursal_limpia (str): Valor de la fila del estado de la surcursal con el formato adecuado 
    
    Ejemplo
    -------
        fila_estado_surcursal  = 'Act'  
        formato_estado_sucursal(fila_estado_surcursal)  
        >>> 'Activa'  
        
        fila_estado_surcursal  = 'INA'  
        formato_estado_sucursal(fila_estado_surcursal)  
        >>> 'Inactiva'  
        
        fila_estado_surcursal  = nan  
        formato_estado_sucursal(fila_estado_surcursal)  
        >>> 'n/a'  
    """
    
    fila_estado_surcursal = fila_estado_surcursal.strip()
    
    if fila_estado_surcursal == '':
        fila_estado_surcursal = 'NULO'
    
    match fila_estado_surcursal.upper()[0]:
        case 'A':
            return 'Activa'
        case 'I':
            return 'Inactiva'
        case _:
            return 'n/a'

"""
===============================
FUNCIONES tabla_bronce.clientes
===============================
"""
# utilizando en tabla.bronce_clientes -> genero
# Tambien se utiliza en bornce.oficiales_credito -> genero
def formato_genero(fila_genero: str) -> str:
    """
    ESTA FUNCIÓN SE ENCARGA DE LIMPIAR LOS FORMATOS DE LOS GENEROS
    --------------------------------------------------------------
    
    Nota 
    ----
        Utilizar en .apply()
        
    Argumentos
    ----------
        fila_genero (str): Valor de la fila del genero  
        
    Resultado
    -------- 
        fila_genero_limpia (str): Valor de la fila del genero con el formato adecuado  
    
    Ejemplo
    -------
        fila_genero  = 'F'  
        formato_genero(fila_genero)  
        >>> 'FEMENINO'  
        
        fila_genero  = 'MAS'  
        formato_genero(fila_genero)  
        >>> 'MASCULINO'  
        
        fila_genero  = nan  
        formato_genero(fila_genero)  
        >>> 'n/a'  
    """
    
    fila_genero = fila_genero.strip()
    
    if fila_genero == '':
        fila_genero = 'NULO'
    
    match fila_genero.upper()[0]: 
        case 'F':
            return 'Femenino'
        case 'M':
            return 'Masculino'
        case _:
            return 'n/a'


# utilizando en tabla_bronce.clientes -> nivel_de_educacion
def formato_nivel_educacion(fila_nivel_educacion: str) -> str:
    """
    ESTA FUNCIÓN SE ENCARGA DE LIMPIAR LOS FORMATOS DEL NIVEL DE EDUCACION
    ----------------------------------------------------------------------
    
    Nota 
    ----
        Utilizar en .apply()  
        
    Argumentos
    ----------
        fila_nivel_educacion (str): Valor de la fila del nivel de educacion  
        
    Resultado
    -------- 
        fila_nivel_educacion_limpia (str): Valor de la fila del nivel de educacion con el formato adecuado  
    
    Ejemplo
    -------
        fila_nivel_educacion  = 'SEcun'  
        formato_nivel_educacion(fila_nivel_educacion)  
        >>> 'Secundaria'  
        
        fila_nivel_educacion  = 'Ténico'  
        formato_nivel_educacion(fila_nivel_educacion)  
        >>> 'Técnico'  
        
        fila_nivel_educacion  = nan  
        formato_nivel_educacion(fila_nivel_educacion)  
        >>> 'n/a'  
    """
    
    fila_nivel_educacion = fila_nivel_educacion.strip()
    
    if fila_nivel_educacion == '':
        fila_nivel_educacion = 'NULO'
    
    match fila_nivel_educacion.upper()[0]:
        case 'S':
            return 'Secundaria'
        case 'U':
            return 'Universitario'
        case 'T':
            return 'Técnico'
        case 'P':
            return 'Postgrado'
        case _:
            return 'n/a'

""""
================================
FUNCIONES tabla_bronce.prestamos
================================
"""
# utilizando en tabla_bronce.prestamos-> clasificacion_riesgo_sbs
def formato_clasificacion_riesgo_sbs(tipo_credito: str, dias_mora: int) -> str:
    """
    ESTA FUNCIÓN SE ENCARGA DE LIMPIAR LOS FORMATOS DE LA CLASIFICACION DE RIESGO DE LA SBS 
    ---------------------------------------------------------------------------------------
    
    Nota 
    ----
        Utilizar en .apply(axis = 1)  
        Para la implementación de esta función se van a utilizar las siguientes columnas: "dias_mora" y "tipo_credito"
        
    Argumentos
    ----------
        tipo_credito (str): Tipo de credito asignado a dicho prestamo  
        dias_mora (int): Dias de mora que presenta la persona  
        
    Resultado
    ---------
        clasificacion de riesgo (str): Tipo de riesgo segun los dias de mora y el tipo de credito  
    
    Ejemplo
    -------
        formato_clasificacion_riesgo_sbs('Consumo', 8)  
        >>> 'Normal'  
        
        formato_clasificacion_riesgo_sbs('Persona', 39)
        >>> 'Deficiente' 
        
        formato_clasificacion_riesgo_sbs('Hipotecario', 360)
        >>> 'Dudoso' 
    """

    reglas = {
        "Consumo": [
            (8,"Normal"),
            (30,"CPP"),
            (60,"Deficiente"),
            (120,"Dudoso"),
            (float("inf"), "Pérdida")
        ], 
        "Personal": [
            (8,"Normal"),
            (30,"CPP"),
            (60,"Deficiente"),
            (120,"Dudoso"),
            (float("inf"), "Pérdida")
        ], 
        "Vehicular": [
            (8,"Normal"),
            (30,"CPP"),
            (60,"Deficiente"),
            (120,"Dudoso"),
            (float("inf"), "Pérdida")
        ],
        "Microempresa": [
            (8,"Normal"),
            (30,"CPP"),
            (60,"Deficiente"),
            (120,"Dudoso"),
            (float("inf"), "Pérdida")
        ],
        "Hipotecario": [
            (30,"Normal"),
            (60,"CPP"),
            (120,"Deficiente"),
            (365,"Dudoso"),
            (float("inf"), "Pérdida")
        ]
    }
    for limite, categoria in reglas[tipo_credito]:
        if dias_mora <= limite:
            return categoria

# utilizando en tabla_bronce.prestamos-> Proceso de Revision del estado del prestamo
def asignacion_estado_prestamo(numero_cuotas_pendientes: int, dias_mora: int, estado: str,tipo_credito: str) -> str:
    """
    ESTA FUNCIÓN SE ENCARGA DE ASIGNAR UN ESTADO AL PRESTAMO  
    --------------------------------------------------------
    
    Nota 
    ----
        Utilizar en .apply(axis = 1)  
        Para la implementación de esta función se van a utilizar las siguientes columnas: "numero_cuotas_pendientes", "dias_mora" y "estado"
        
    Argumentos
    ----------
        numero_cuotas_pendientes (int): Numero de cuotas pendientes para terminar de pagar el prestamo.  
        dias_mora (int): Dias de mora asignado al ultimo pago del prestamo.  
        estado (str): Estado del prestamo [Vigente, Cancelado, Moroso, Castigado, Refinanciado].  
        
    Resultado
    ---------
        estado_nuevo (str): Nuevo estado del prestamo, basado en el numero de cuotas pendientes, los dias de mora y el estado.  
    
    Ejemplo
    -------
        
        asignacion_estado_prestamo(0,0,'Moroso')  
        >>> 'Cancelado'  
        
        asignacion_estado_prestamo(10,70,'Vigente')
        >>> 'Castigado' 
        
        asignacion_estado_prestamo(10,40,'Refinanciado')
        >>> 'Refinanciado' 
    """
    
    if estado == "Refinanciado":
        return "Refinanciado"
    
    # No modifica Refinanciado, porque, es un estado que no depende de una clasifiacion automatica del banco
    reglas = {
        "Consumo": (120,"Dudoso"),
        "Personal": (120,"Dudoso"), 
        "Vehicular": (120,"Dudoso"),
        "Microempresa": (120,"Dudoso"),
        "Hipotecario": (365,"Dudoso")
    }
    
    dias_maximos_moroso_castigado = reglas[tipo_credito][0]
    
    if numero_cuotas_pendientes == 0 and dias_mora >= 0:
        return "Cancelado"

    elif numero_cuotas_pendientes > 0 and dias_mora == 0:
        return "Vigente"

    elif numero_cuotas_pendientes > 0 and 0 < dias_mora < dias_maximos_moroso_castigado:
        return "Moroso"
    
    elif numero_cuotas_pendientes > 0 and dias_mora >= dias_maximos_moroso_castigado:
        return "Castigado"

    return "Inconsistente"
""""
============================
FUNCIONES tabla_bronce.pagos
============================
"""
# Utilizado en tabla_bronce.pagos -> canal_pago
def formato_canal_pago(fila_canal_pago: str) -> str:
    """
    ESTA FUNCIÓN SE ENCARGA DE LIMPIAR EL FORMATO DEL CANAL DE PAGO
    ---------------------------------------------------------------
    
    Nota 
    ----
        Utilizar en .apply()  
        
    Argumentos
    ----------
        fila_canal_pago (str): Valor de la fila del canal de pago  
        
    Resultado
    -------- 
        fila_canal_pago_limpia (str): Valor de la fila del canal de pago con el formato adecuado  
    
    Ejemplo
    -------
        formato_canal_pago('App movi')  
        >>> 'APP Móvil'  
        
        formato_canal_pago('Web Banca')  
        >>> 'Web Bancaria'  
        
        formato_canal_pago(nan)  
        >>> 'n/a'
    """
    
    fila_canal_pago = fila_canal_pago.strip()
    
    if fila_canal_pago == '':
        fila_canal_pago = 'NULOOOO'
    
    match fila_canal_pago.strip().upper()[0:5]:
        case 'APP M':
            return 'APP Móvil'
        case 'AGENC':
            return 'Agencia'
        case 'AGENT':
            return 'Agente Bancario'
        case 'DÉBIT' | 'DEBIT':
            return 'Débito Automático'
        case 'WEB B':
            return 'Web Bancaria'
        case 'TRANS':
            return 'Transferencia Interbancaria'
        case 'CAJER':
            return 'Cajero ATM'
        case _:
            return 'n/a'

# Utilizado en tabla_bronce.pagos -> fecha_pago, dias_retraso y monto_mora_pagado
# -> Revision fecha_pago, dias_retraso y monto_mora_pagado
def recalcular_monto_mora_pagado(numero_cuota: int,saldo_para_interes: float, monto_original: float, tasa_efectiva_diaria: float,dias_retraso: int) -> float: 
    """
    ESTA FUNCIÓN SE ENCARGA DE RECALCULAR EL MONTO DE MORA PAGADO
    -------------------------------------------------------------
    
    Nota 
    ----
        Utilizar en .apply(axis = 1)  
    
    Argumentos
    ----------
        numero_cuota (int): Numero de cuota de pago  
        saldo_para_interes (float): Saldo que se utiliza para calcular el interes  
        monto_original (float): Monto original del prestamo  
        tasa_efectiva_diaria (float): Tasa efectiva del prestamo  
        dias_retraso (int): Dias de retraso en el pago de la cuota  
    
    Resultado
    -------- 
        monto_mora_recalculado (float): monto de la mora recalculado  
    Ejemplo
    -------
        recalcular_monto_mora_pagado(1,nan,9218.73,0.055,0)  
        >>> 0.0  
        
        recalcular_monto_mora_pagado(10,6918.39,9218.73,0.055,84)
        >>> 330.045
        
        recalcular_monto_mora_pagado(7,7225.33,7767.38,0.059,3)
        >>> 12.88
        
    """
    
    # Como la cuota numero 1, no tiene saldo_para interes, entonces, se asigna el monto original para ese recalculo
    if numero_cuota == 1: 
        return round(
                    monto_original
                    *(
                        ((tasa_efectiva_diaria/100) + 1)
                        **(dias_retraso)
                    )
                    - monto_original,
                    2
                    )
    else:
        return round(
                    saldo_para_interes
                    *(
                        ((tasa_efectiva_diaria/100) + 1)
                        **(dias_retraso)
                    )
                    - saldo_para_interes,
                    2
                ) 
        
# Utilizado en tabla_bronce.pagos -> monto_capital_programado y monto_interes_programado 
def recalcular_monto_interes_programado(monto_original: float,numero_cuota: int,tasa_efectiva_mensual: float,numero_cuotas_total: int, monto_cuota_programada: float, saldo_para_interes: float ) -> float:
    """
    ESTA FUNCIÓN SE ENCARGA DE RECALCULAR EL INTERES PROGRAMADO
    -----------------------------------------------------------
    
    Nota 
    ----
        Utilizar en .apply(axis = 1)  
        
    Argumentos
    ----------
        monto_original (float): Monto original del prestamo  
        numero_cuota (int): Numero de cuota pagada  
        tasa_efectiva_mensual (float): Tasa efectiva mensual del prestamo  
        numero_cuotas_total (int):  Numero de cuotas totales del prestamo  
        monto_cuota_programada (float): Monto de la cuota programada  
        saldo_para_interes (float): Saldo para calcular el interes  
    
    Resultado
    -------- 
        interes_recal (float): monto del interes recalculado
    Ejemplo
    -------
        recalcular_monto_interes_programado(9218.73,1,1.678,30,393.63,nan)  
        >>> 154.72  
        
        recalcular_monto_interes_programado(12512.04,6,3.0,48,495.2,11875.8)  
        >>> 356.27  
        
        recalcular_monto_interes_programado(32613.23,18,2.34,18,2240.62,2189.33)  
        >>> 356.27  
        
    """
    
    match numero_cuota: 
        #  Esto es porque, para el primer pago no existe saldo para interes 
        case 1: 
            return round(monto_original * tasa_efectiva_mensual/100,2)
        # Esto es porque pueden existir variaciones decimales entonces mejor valido de esta forma para el ultimo valor 
        case _ if  numero_cuota == numero_cuotas_total:
            return round(monto_cuota_programada - saldo_para_interes,2)
        # Este si es el estandar para calcular el interes programado
        case _:
            return round(saldo_para_interes * tasa_efectiva_mensual/100,2)

def formato_estado_pago(fila_dias_retraso: int) -> str:
    """
    ESTA FUNCIÓN SE ENCARGA DE LIMPIAR EL FORMATO DEL ESTADO DE PAGO
    ----------------------------------------------------------------
    
    Nota 
    ----
        Utilizar en .apply()  
        
    Argumentos
    ----------
        fila_dias_retraso (str): Valor de la fila del estado de pago
        
    Resultado
    -------- 
        fila_dias_retraso_limpia (str): Valor de la fila del estado de pagocon el formato adecuado 
    
    Ejemplo
    -------
        formato_canal_pago(75)  
        >>> 'Muy Tardío'  
        
        formato_canal_pago(0)  
        >>> 'Puntual'  
        
        formato_canal_pago(5)  
        >>> 'Con Gracia'  
    """

    if fila_dias_retraso >= 31:
        return 'Muy Tardío'
    elif fila_dias_retraso >= 9:
        return 'Tardío'
    elif fila_dias_retraso >= 1: 
        return 'Con Gracia'
    elif fila_dias_retraso == 0:
        return 'Puntual'
    else:
        return 'n/a'