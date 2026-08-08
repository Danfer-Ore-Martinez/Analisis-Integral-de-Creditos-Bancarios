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
| tasa_nom_min     | DECIMAL(8,4)  | Tasa nominal mínima para dicho producto.                                                      |
| tasa_nom_max     | DECIMAL(8,4)  | Tasa nominal máxima para dicho producto.                                                      |
| monto_minimo     | DECIMAL(10,2) | Monto mínimo para dicho producto.                                                             |
| monto_maximo     | DECIMAL(10,2) | Monto máximo para dicho producto.                                                             |

---
### 2. **oro.dim_sucursales**
- **Propósito:** Almacenar información de las diversas sucursales y adicionalmente brinda información geográfica.  
- **Columnas:**

| Nombre Columna   | Tipo de Dato  | Descripción                                                                                   |
|------------------|---------------|-----------------------------------------------------------------------------------------------|
| sucursal_llave   | BIGINT        | Llave sustituta única encargada de identificar cada registro en la tabla dimensión.           |
| sucursal_id      | INT           | Identificador único asignado a cada sucursal.                                                 |
| codigo_sucursal  | NVARCHAR(30)  | Código de referencia de la sucursal (ejem: 'SUC0001', 'SUC0018').                             |
| fecha_apertura   | DATE          | Fecha de apertura de dicha sucursal.                                                          |
| estado_sucursal  | NVARCHAR(30)  | Estado actual de la sucursal (ejem: 'Activa', 'Inactiva', 'n/a').                             |
| nombre_sucursal  | NVARCHAR(50)  | Nombre de cada sucursal.                                                                      |
| tipo_sucursal    | NVARCHAR(30)  | Tipo de sucursal (ejem: 'Punto de Atención', 'Oficina Especial').                             |
| ciudad           | NVARCHAR(30)  | Ciudad donde se ubica dicha sucursal (ejem: 'San Juan de Lurigancho', 'Arequipa').            |
| departamento     | NVARCHAR(30)  | Departamento donde se ubica dicha sucursal (ejem: 'Arequipa', 'Lima').                        |
| region           | NVARCHAR(30)  | Región donde se ubica dicha sucursal (ejem: 'Sur', 'Norte').                                  |
| zona             | NVARCHAR(30)  | Zona donde se ubica dicha sucursal (ejem: 'Urbano', 'Selva').                                 |

---
### 3. **oro.dim_clientes**
- **Propósito:** Almacenar información sobre los clientes, desde información y detalles personales de clientes, hasta información relevante asociada al negocio.  
- **Columnas:**

| Nombre Columna          | Tipo de Dato  | Descripción                                                                                   |
|-------------------------|---------------|-----------------------------------------------------------------------------------------------|
| cliente_llave           | BIGINT        | Llave sustituta única encargada de identificar cada registro en la tabla dim_lientes.         |
| sucursal_llave          | BIGINT        | Llave foránea de la tabla dim_sucursales.                                                       |
| cliente_id              | INT           | Identificador único asociado a cada cliente.                                                  |
| tipo_documento          | NVARCHAR(10)  | Tipo de documento asociado al cliente (ejem: 'DNI','CE').                                     |
| numero_documento        | NVARCHAR(20)  | Numero de documento asociado al tipo de documento.                                            |
| fecha_registro          | DATE          | Fecha de registro del cliente.                                                                |
| estado_cliente          | NVARCHAR(30)  | Estado actual del cliente (ejem: 'Activo', 'Inactivo', 'Bloqueado').                          |
| segmento_cliente        | NVARCHAR(30)  | Segmento al que pertenece el cliente (ejem: 'Regular', 'Premium', 'VIP').                     |
| canal_captacion         | NVARCHAR(30)  | Canal mediante el cual se logro captar al cliente (ejem: 'Digital', 'Agencia', 'Referido').   |
| score_crediticio        | INT           | Score crediticio del cliente, refleja la confianza que se le tiene.                           |
| ingresos_mensuales      | DECIMAL(10,2) | Ingresos mensuales de dicho cliente.                                                          |
| egresos_mensuales       | DECIMAL(10,2) | Egresos mensuales de dicho cliente.                                                           |
| patrimonio_estimado     | DECIMAL(10,2) | Patrimonio estimado de dicho cliente.                                                         |
| fecha_nacimiento        | DATE          | Fecha de nacimiento del cliente.                                                              |
| nombres                 | NVARCHAR(50)  | Nombre del cliente.                                                                           |
| apellido_paterno        | NVARCHAR(30)  | Apellido paterno del cliente.                                                                 |
| apellido_materno        | NVARCHAR(30)  | Apellido materno del cliente.                                                                 |
| genero                  | NVARCHAR(20)  | Genero del cliente (ejem: 'Masculino', 'Femenino').                                           |
| estado_civil            | NVARCHAR(30)  | Estado civil del cliente (ejem: 'Casado', 'Soltero', 'Conviviente').                          |
| nivel_educacion         | NVARCHAR(30)  | Nivel de educación del cliente (ejem: 'Universitario', 'Técnico', 'Postgrado').               |
| ocupacion               | NVARCHAR(50)  | Ocupación principal del cliente (ejem: 'Empresario', 'Empleado Publico').                     |
| sector_economico        | NVARCHAR(50)  | Sector económico al que pertenece el cliente (ejem: 'Agricultura', 'Educación').              |
| ciudad_residencia       | NVARCHAR(30)  | Ciudad de residencia del cliente.                                                             |
| departamento_residencia | NVARCHAR(30)  | Departamento de residencia del cliente.                                                       |
| region_residencia       | NVARCHAR(30)  | Región de residencia del cliente.                                                             |

---

### 4. **oro.dim_oficiales_credito**
- **Propósito:** Almacenar información de los oficiales de crédito (personas encargadas de aprobar o rechazar un crédito).  
- **Columnas:**

| Nombre Columna   | Tipo de Dato  | Descripción                                                                                   |
|------------------|---------------|-----------------------------------------------------------------------------------------------|
| oficial_llave    | BIGINT        | Llave sustituta única encargada de identificar cada registro en la tabla dimensión.           |
| sucursal_llave   | BIGINT        | Llave foránea de la tabla dim_sucursales.                                                     |
| oficial_id       | INT           | Identificador único asociado a cada oficial de crédito.                                       |
| fecha_ingreso    | DATE          | Fecha de ingreso del oficial de crédito.                                                      |
| cargo            | NVARCHAR(30)  | Cargo actual del oficial de crédito (ejem: 'Analista de Crédito', 'Oficial Senior').          |
| estado           | NVARCHAR(50)  | Estado actual del oficial de crédito (ejem: 'Activo', 'Inactivo').                            |
| nombres          | NVARCHAR(30)  | Nombre del oficial de crédito.                                                                |
| apellido_paterno | NVARCHAR(30)  | Apellido paterno del oficial de crédito.                                                      |
| apellido_materno | NVARCHAR(30)  | Apellido materno del oficial de crédito.                                                      |
| genero           | NVARCHAR(30)  | Genero del oficial de crédito.                                                                |

---

### 5. **oro.fact_prestamos**
- **Propósito:** Almacenar información sobre los prestamos dados, detalles y situación actual de estos.   
- **Columnas:**

| Nombre Columna               | Tipo de Dato  | Descripción                                                                                   |
|------------------------------|---------------|-----------------------------------------------------------------------------------------------|
| prestamo_llave               | BIGINT        | Llave sustituta única encargada de identificar cada registro en la tabla fact_prestamos.      |
| oficial_llave                | BIGINT        | Llave foránea de la tabla dim_oficiales_credito.                                              |
| sucursal_llave               | BIGINT        | Llave foránea de la tabla dim_sucursal.                                                       |
| producto_llave               | BIGINT        | Llave foránea de la tabla dim_productos_crediticios.                                          |
| cliente_llave                | BIGINT        | Llave foránea de la tabla dim_clientes.                                                       |
| prestamo_id                  | INT           | Identificador único de cada préstamo.                                                         |
| numero_contrato              | NVARCHAR(30)  | Número de contrato asociada a cada préstamo (ejem: 'CONT-00000003', 'CONT-00000026').         |
| proposito_credito            | NVARCHAR(50)  | Breve descripción del propósito de solicitud del crédito.                                     |
| estado                       | NVARCHAR(30)  | Estado actual del crédito (ejem: 'Cancelado', 'Vigente', 'Refinanciado').                     |
| clasificacion_riesgo_sbs     | NVARCHAR(30)  | Clasificación de riesgo de crédito según la SBS (ejem: 'CPP', 'Normal', 'Dudoso').            |
| dias_mora                    | INT           | Días de mora del préstamo.                                                                    |
| garantia_tipo                | NVARCHAR(30)  | Tipo de garantía asociada a dicho préstamo (ejem: 'Sin Garantía', 'Carta Fianza').            |
| garantia_valor               | DECIMAL(10,2) | Valor de la garantía.                                                                         |
| fecha_otorgamiento           | DATE          | Fecha de otorgamiento del préstamo.                                                           |
| fecha_vencimiento            | DATE          | Fecha de vencimiento del préstamo.                                                            |
| plazo_meses                  | INT           | Duración del préstamo en meses.                                                               |
| frecuencia_pago              | NVARCHAR(30)  | Frecuencia en la cual se van a realizar los pagos (ejem: 'Mensual').                          |
| numero_cuotas_total          | INT           | Número total de cuotas a pagar.                                                               |
| numero_cuotas_pagadas        | INT           | Numero de cuotas que ya se han pagado.                                                        |
| numero_cuotas_pendientes     | INT           | Número de cuotas pendientes.                                                                  |
| cuota_programada             | DECIMAL(10,2) | Monto a pagar en cada cuota (se calcula utilizando el sistema francés de amortización).       |
| fecha_primer_pago_programado | DATE          | Fecha del primer pago programado (fecha_otorgamiento + 30 días).                              |
| fecha_ultimo_pago            | DATE          | Fecha del ultimo pago registrado del préstamo.                                                |
| canal_desembolso             | NVARCHAR(30)  | Canal de desembolso del préstamo (ejem: 'Transferencia Bancaria', 'Agencia').                 |
| monto_original               | DECIMAL(10,2) | Monto original del préstamo dado.                                                             |
| saldo_capital_vigente        | DECIMAL(10,2) | Saldo vigente del préstamo.                                                                   |
| tasa_interes_nominal_anual   | DECIMAL(8,4)  | Tasa interés nominal del préstamo.                                                            |
| tasa_interes_efectiva_anual  | DECIMAL(8,4)  | Tasa interés efectiva del préstamo.                                                           |    

---

### 6. **oro.fact_pagos**
- **Propósito:** Almacenar información sobre cada pago realizado.   
- **Columnas:**

| Nombre Columna               | Tipo de Dato  | Descripción                                                                                   |
|------------------------------|---------------|-----------------------------------------------------------------------------------------------|
| pago_id                      | INT           | Llave sustituta única encargada de identificar cada registro en la tabla fact_pagos.          |
| prestamo_llave               | BIGINT        | Llave foránea de la tabla fact_prestamos.                                                     |
| cliente_llave                | BIGINT        | Llave foránea de la tabla dim_clientes.                                                       |
| producto_llave               | BIGINT        | Llave foránea de la tabla dim_productos_crediticios.                                          |
| sucursal_llave               | BIGINT        | Llave foránea de la tabla dim_sucursal.                                                       |
| oficial_llave                | BIGINT        | Llave foránea de la tabla dim_oficiales_credito.                                              |
| referencia_pago              | NVARCHAR(30)  | Código de referencia del pago (ejem: 'REF0000012654', 'REF0000012663).                        |
| numero_cuota                 | INT           | Número de cuota.                                                                              |
| fecha_vencimiento_cuota      | DATE          | Fecha de vencimiento de la cuota.                                                             |
| fecha_pago                   | DATE          | Fecha en la que se pago la cuota.                                                             |
| dias_retraso                 | INT           | Días de retraso en pagar la cuota.                                                            |
| estado_pago                  | NVARCHAR(30)  | Esto actual del pago (ejem: 'Puntual', 'Con Gracia', 'Muy Tardío').                           |
| canal_pago                   | NVARCHAR(30)  | Canal de pago (ejem: 'APP Móvil', 'Transferencia Interbancaria').                             |
| monto_cuota_programada       | DECIMAL(10,2) | Monto programado de la cuota.                                                                 |
| monto_capitaL_programado     | DECIMAL(10,2) | Monto capital programado (monto programado destinado a reducir la deuda).                     |
| monto_interes_programado     | DECIMAL(10,2) | Monto interés programado (monto programado destinado a pagar intereses).                      |
| monto_pagado_total           | DECIMAL(10,2) | Monto real pagado (capital + interés + mora).                                                 |
| monto_capital_pagado         | DECIMAL(10,2) | Monto real pagado destinado a reducir la deuda.                                               |
| monto_interes_pagado         | DECIMAL(10,2) | Monto real destinado a pagar interés.                                                       |
| monto_mora_pagado            | DECIMAL(10,2) | Monto real destinado a pagar la mora, generada por retrasarse en los pagos.                   |
| saldo_capital_despues_pago   | DECIMAL(10,2) | Saldo capital restante, luego del pago.                                                        |  
