-- PASO 1: Mostramos el Vivero 2 y sus zonas asignadas (ANTES)
SELECT * FROM Vivero WHERE id_vivero = 2;
SELECT * FROM Zona WHERE id_vivero = 2;

-- PASO 2: Ejecutamos el borrado (El vivero cierra)
DELETE FROM Vivero WHERE id_vivero = 2;

-- PASO 3: Mostramos de nuevo para comprobar que el Vivero 2 y sus Zonas han desaparecido (DESPUÉS)
SELECT * FROM Vivero;
SELECT * FROM Zona;

-- PASO 1: Mostramos al Cliente 1, que sabemos que tiene pedidos registrados
SELECT * FROM Cliente WHERE id_cliente = 1;
SELECT * FROM Pedido WHERE id_cliente = 1;

-- PASO 2: Intentamos borrar al cliente 
DELETE FROM Cliente WHERE id_cliente = 1;
