-- CAPTURA 1: Circuito de Ventas (Muestra: Pedido, Cliente, Empleado, Detalle_Pedido y Producto)
SELECT 
    p.id_pedido, p.fecha_pedido,
    c.id_cliente, c.bonificaciones,
    e.cargo AS cargo_vendedor,
    prod.tipo AS producto_vendido,
    dp.cantidad, dp.precio AS precio_compra
FROM Pedido p
JOIN Cliente c ON p.id_cliente = c.id_cliente
JOIN Empleado e ON p.id_empleado = e.id_empleado
JOIN Detalle_Pedido dp ON p.id_pedido = dp.id_pedido
JOIN Producto prod ON dp.id_producto = prod.id_producto;

-- CAPTURA 2: Circuito de Infraestructura (Muestra: Vivero, Zona y Stock_Zona)
SELECT 
    v.id_vivero, v.latitud AS lat_vivero,
    z.id_zona, z.latitud AS lat_zona,
    sz.id_producto, sz.stock
FROM Vivero v
JOIN Zona z ON v.id_vivero = z.id_vivero
JOIN Stock_Zona sz ON z.id_zona = sz.id_zona AND z.id_vivero = sz.id_vivero;

-- CAPTURA 3: La tabla que falta (Historial_Asignacion)
SELECT * FROM Historial_Asignacion;
