# Catalogos de Datos para la Capa Oro

## Resumen
La Capa Oro es la capa que representa datos relevantes y utilizado para la toma de deciones en el negocio, la estructura que tiene facilita la creación 
de reportes y análisis de datos. Esta dividida en dos tipo de tablas **Tablas dimension** y **Tablas fact**, cada una representa una metrica del negocio.

---

### 1. **oro.dim_productos_crediticios**
- **Propósito:** Almacenar información de los productos crediticios, adicionalmente la información es complementada con detalles sobre montos mínimos o máximos. 
- **Columnas:**

| Nombre Columna   | Tipo de Dato  | Descripción                                                                                   |
|------------------|---------------|-----------------------------------------------------------------------------------------------|
| producto_llave   | BIGINT        | Llave sustituta única encargada de identificar cada registro en la tabla dimensión.           |
| producto_id      | INT           | Identificador único asignado a cada producto.                                                 |
| nombre_producto  | NVARCHAR(40)  | Nombre del producto crediticio.                                                               |
| tipo_credito     | NVARCHAR(50)  | Tipo de Crédito (ejem: 'Personal', 'Hipotecario').                                            |      
| moneda           | NVARCHAR(30)  | Moneda en la que se va a trabajar el crédito (ejem: 'PEN', 'USD').                            |
| requiere_garantia| VARCHAR(8)    | Estado que verifica si el crédito requiere garantía o no (ejem: 'Si', 'No', 'n/a').           |
| plazo_min_meses  | INT           | Plazo mínimo en meses.                                                                        |
| plazo_max_meses  | INT           | Plazo máximo en meses.                                                                        |
| tasa_nom_min     | DECIMAL(10,2) | Tasa nominal mínima para dicho producto.                                                      |
| tasa_nom_max     | DECIMAL(10,2) | Tasa nominal máxima para dicho producto.                                                      |
| monto_minimo     | DECIMAL(10,2) | Monto mínimo para dicho producto.                                                             |
| monto_maximo     | DECIMAL(10,2) | Monto máximo para dicho producto.                                                            |

---
### 2. **oro.dim_sucursales**
- **Propósito:** Almacenar información de las diversas sucursales y adicionalmente brinda información geográfica.  
- **Columnas:**

| Nombre Columna   | Tipo de Dato  | Descripción                                                                                   |
|------------------|---------------|-----------------------------------------------------------------------------------------------|
| sucursal_llave   | BIGINT        | Llave sustituta única encargada de identificar cada registro en la tabla dimensión.           |
| sucursal_id      | INT           | Identificador único asignado a cada sucursal.                                                 |
| codigo_sucursal  | NVARCHAR(30)  | Codigo de referencia de la sucursal (ejem: 'SUC0001', 'SUC0018').                             |
| fecha_apertura   | DATE          | Fecha de apertura de dicha sucursal.                                                          |      
| estado_sucursal  | NVARCHAR(30)  | Estado actual de la sucursal (ejem: 'Activa', 'Inactiva', 'n/a').                             |
| nombre_sucursal  | NVARCHAR(50)  | Nombre de cada sucursal.                                                                      |
| tipo_sucursal    | NVARCHAR(30)  | Tipo de sucursal (ejem: 'Punto de Atención', 'Oficina Especial').                             |
| ciudad           | NVARCHAR(30)  | Ciudad donde se ubica dicha sucursal (ejem: 'San Juan de Lurigancho', 'Arequipa').            |
| departamento     | NVARCHAR(30)  | Departamento donde se ubica dicha sucursal (ejem: 'Arequipa', 'Lima').                        |
| region           | NVARCHAR(30)  | Región donde se ubica dicha sucursal (ejem: 'Sur', 'Norte').                                  |
| zona             | NVARCHAR(30)  | Zona donde se ubica dicha sucursal (ejem: 'Urbano', 'Selva').                                 |
