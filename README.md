# Diseño Relacional - Sistema de Gestión de Viveros (Tajinaste S.A.)

## 1. Entidades Principales
Se han transformado en tablas independientes con claves primarias autoincrementales (`SERIAL`).

*   **Vivero**
    *   `id_vivero` (PK): `SERIAL`. Identificador único.
    *   `latitud`, `longitud`: `DECIMAL(9,6) NOT NULL`. Precisión adecuada para coordenadas geográficas.
*   **Producto**
    *   `id_producto` (PK): `SERIAL`. 
    *   `tipo`: `VARCHAR(50) NOT NULL`. 
    *   `precio`: `DECIMAL(10,2) NOT NULL`. 
    *   *Restricción:* `CHECK (precio > 0)`. El precio no puede ser negativo ni 0.
*   **Empleado**
    *   `id_empleado` (PK): `SERIAL`.
    *   `cargo`: `VARCHAR(50) NOT NULL`.
*   **Cliente**
    *   `id_cliente` (PK): `SERIAL`.
    *   `bonificaciones`: `DECIMAL(10,2) NOT NULL DEFAULT 0`. Saldo del programa Tajinaste Plus.
    *   *Restricción:* `CHECK (bonificaciones >= 0)`.

## 2. Entidades Débiles
*   **Zona**
    *   Al ser una entidad débil por dependencia en identificación, su Clave Primaria (PK) se compone de su propio identificador y el identificador de la entidad fuerte de la que depende.
    *   `id_zona` (PK): `INT`.
    *   `id_vivero` (PK, FK): `INT`. Referencia a `Vivero`.
    *   `latitud`, `longitud`: `DECIMAL(9,6) NOT NULL`.
    *   *Restricción:* `ON DELETE CASCADE`. Si un vivero se destruye, sus zonas desaparecen con él.

## 3. Relaciones (1:N) y Tablas Intermedias (M:N)

### Relaciones 1:N 
*   **Pedido** (Relaciona Empleado, Cliente y Pedido)
    *   `id_pedido` (PK): `SERIAL`.
    *   `id_cliente` (FK): `INT NOT NULL`.
    *   `id_empleado` (FK): `INT NOT NULL`.
    *   `fecha_pedido`: `DATE NOT NULL DEFAULT CURRENT_DATE`.
    *   *Restricción:* `ON DELETE RESTRICT` en `id_empleado`. No se puede borrar a un empleado si tiene pedidos asociados por motivos de auditoría y ventas.

### Relaciones M:N (Generan nuevas tablas)
*   **Detalle_Pedido** (Relación *Contiene* entre Pedido y Producto)
    *   `id_pedido` (PK, FK), `id_producto` (PK, FK): `INT`. Forman una PK compuesta para evitar duplicar el mismo producto en distintas líneas del mismo pedido.
    *   `cantidad`: `INT NOT NULL`. `CHECK (cantidad > 0)`.
    *   `precio`: `DECIMAL(10,2) NOT NULL`. Se guarda aquí para mantener el histórico de precios en el momento de la compra.
*   **Stock_Zona** (Relación *Tiene* entre Zona y Producto)
    *   `id_zona`, `id_vivero` (PK, FK): `INT`. Apuntan a la entidad débil Zona.
    *   `id_producto` (PK, FK): `INT`.
    *   `stock`: `INT NOT NULL`. `CHECK (stock >= 0)`.
*   **Historial_Asignacion** (Relación *Asignados* entre Empleado y Zona)
    *   `id_empleado` (PK, FK): `INT`.
    *   `id_zona`, `id_vivero` (PK, FK): `INT`.
    *   `fecha` (PK): `DATE NOT NULL`. Debe formar parte de la clave principal para permitir que un mismo empleado sea reasignado a la misma zona en distintas fechas.
    *   *Restricción:* `ON DELETE CASCADE` respecto al empleado.

## 4. Decisiones de Diseño y Lógica de Negocio
*   **Atributos Derivados (Calculados):** No se incluyen como columnas físicas ni el "Volumen de Compras" del cliente ni el "Precio total" del pedido para evitar redundancia e inconsistencia de datos. Ambos valores se calcularán mediante consultas `SELECT` o `Vistas` sumando los importes de `Detalle_Pedido`.
*   **Doble rol PK/FK:** Las tablas generadas por relaciones M:N y las entidades débiles usan atributos que son simultáneamente Claves Primarias y Foráneas. Esto garantiza la unicidad del registro (PK) y la integridad referencial de los datos (FK).
