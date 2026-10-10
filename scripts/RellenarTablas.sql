

-- 1. Inserción en tabla Vivero 
INSERT INTO Vivero (latitud, longitud) VALUES
(28.4698, -16.2549), -- Vivero 1 (Tenerife Norte)
(28.0520, -16.6190), -- Vivero 2 (Tenerife Sur)
(28.1234, -15.4321), -- Vivero 3 (Gran Canaria)
(28.6543, -17.8901), -- Vivero 4 (La Palma)
(28.9876, -13.5678); -- Vivero 5 (Lanzarote)

-- 2. Inserción en tabla Producto 
-- Variedad para abarcar diferentes tipos
INSERT INTO Producto (tipo, precio) VALUES
('Planta de interior - Monstera', 25.50),
('Planta de exterior - Rosal', 15.00),
('Fertilizante líquido 1L', 12.75),
('Maceta de barro 30cm', 18.20),
('Herramienta - Tijeras de podar', 22.00);

-- 3. Inserción en tabla Empleado 
INSERT INTO Empleado (cargo) VALUES
('Gerente de Vivero'),
('Jardinero Especialista'),
('Mozo de Almacén'),
('Atención al Cliente'),
('Jardinero de Exterior');

-- 4. Inserción en tabla Cliente 
-- Abordando escenarios con bonificaciones y sin bonificaciones (clientes nuevos)
INSERT INTO Cliente (bonificaciones) VALUES
(150.50), -- Cliente habitual
(0.00),   -- Cliente nuevo sin bonificaciones
(45.00),  -- Cliente ocasional
(300.00), -- Cliente VIP (muchas bonificaciones)
(10.50);

-- 5. Inserción en tabla Zona 
-- Zonas repartidas en distintos viveros (id_vivero 1 y 2)
INSERT INTO Zona (id_zona, id_vivero, latitud, longitud) VALUES
(1, 1, 28.4699, -16.2550), -- Zona Exterior del Vivero 1
(2, 1, 28.4697, -16.2548), -- Almacén del Vivero 1
(1, 2, 28.0521, -16.6191), -- Zona Exterior del Vivero 2
(2, 2, 28.0519, -16.6189), -- Interior del Vivero 2
(3, 2, 28.0522, -16.6195); -- Invernadero especial del Vivero 2

-- 6. Inserción en tabla Pedido 
-- Relacionamos clientes y empleados en diferentes fechas
INSERT INTO Pedido (id_cliente, id_empleado, fecha_pedido) VALUES
(1, 4, '2026-10-01'), -- Cliente 1 atendido por Empleado 4
(1, 4, '2026-10-05'), -- Mismo cliente repite pedido en otra fecha
(2, 1, '2026-10-06'), -- Cliente nuevo atendido por Gerente
(4, 4, '2026-10-08'), 
(3, 1, '2026-10-10');

-- 7. Inserción en tabla Detalle_Pedido 
-- Diferentes productos, cantidades y simulando variaciones de precio histórico
INSERT INTO Detalle_Pedido (id_pedido, id_producto, cantidad, precio) VALUES
(1, 1, 2, 25.50), -- 2 Monsteras a precio normal
(1, 4, 2, 18.00), -- 2 Macetas (precio ligeramente rebajado respecto al original)
(2, 3, 1, 12.75), -- 1 Fertilizante
(3, 5, 1, 22.00), -- 1 Tijera
(4, 2, 5, 14.50), -- 5 Rosales (descuento por volumen)
(5, 1, 1, 25.50);

-- 8. Inserción en tabla Stock_Zona 
-- Mostrando stock abundante, stock bajo y sin stock (0)
INSERT INTO Stock_Zona (id_zona, id_vivero, id_producto, stock) VALUES
(1, 1, 2, 50),  -- 50 rosales en exterior Vivero 1
(2, 1, 3, 100), -- 100 fertilizantes en almacén Vivero 1
(1, 2, 2, 30),  -- 30 rosales en exterior Vivero 2
(2, 2, 1, 15),  -- 15 monsteras en interior Vivero 2
(2, 2, 4, 0);   -- Macetas agotadas en interior Vivero 2 (Escenario de falta de stock)

-- 9. Inserción en tabla Historial_Asignacion (Al menos 5 filas)
-- Empleados moviéndose de zona a lo largo del tiempo
INSERT INTO Historial_Asignacion (id_empleado, id_zona, id_vivero, fecha) VALUES
(2, 1, 1, '2025-01-15'), -- Empleado 2 asignado a exterior V1 en 2025
(2, 2, 1, '2026-06-01'), -- Empleado 2 se mueve a almacén V1 en 2026
(3, 2, 1, '2026-01-10'), -- Empleado 3 asignado al almacén V1
(5, 1, 2, '2025-05-20'), -- Empleado 5 asignado a exterior V2
(5, 3, 2, '2026-09-01'); -- Empleado 5 reasignado a invernadero V2
