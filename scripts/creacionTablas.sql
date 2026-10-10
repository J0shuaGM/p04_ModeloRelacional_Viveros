-- ASIGNACIÓN DE PERMISOS
-- Conceder todos los privilegios sobre las tablas y secuencias (campos SERIAL) al administrador
CREATE USER admin_viveros WITH SUPERUSER PASSWORD 'admin123';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin_viveros;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin_viveros;

-- CREACIÓN DE TABLAS

CREATE TABLE Vivero (
    id_vivero SERIAL PRIMARY KEY,
    latitud DECIMAL(9,6) NOT NULL,
    longitud DECIMAL(9,6) NOT NULL
);

CREATE TABLE Producto (
    id_producto SERIAL PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_precio_producto CHECK (precio > 0)
);

CREATE TABLE Empleado (
    id_empleado SERIAL PRIMARY KEY,
    cargo VARCHAR(50) NOT NULL
);

CREATE TABLE Cliente (
    id_cliente SERIAL PRIMARY KEY,
    bonificaciones DECIMAL(10,2) DEFAULT 0,
    CONSTRAINT chk_bonificaciones CHECK (bonificaciones >= 0)
);

-- CREACIÓN DE TABLA DÉBIL ZONA

CREATE TABLE Zona (
    id_zona INT,
    id_vivero INT,
    latitud DECIMAL(9,6) NOT NULL,
    longitud DECIMAL(9,6) NOT NULL,
    PRIMARY KEY (id_zona, id_vivero),
    CONSTRAINT fk_zona_vivero FOREIGN KEY (id_vivero) REFERENCES Vivero(id_vivero) ON DELETE CASCADE
);

-- CREACIÓN DE TABLA PEDIDO

CREATE TABLE Pedido (
    id_pedido SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
    fecha_pedido DATE DEFAULT CURRENT_DATE NOT NULL,
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente) ON DELETE RESTRICT,
    CONSTRAINT fk_pedido_empleado FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado) ON DELETE RESTRICT
);

-- CREACIÓN DE TABLAS INTERMEDIAS 

CREATE TABLE Detalle_Pedido (
    id_pedido INT,
    id_producto INT,
    cantidad INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_pedido, id_producto),
    CONSTRAINT fk_detalle_pedido FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido) ON DELETE CASCADE,
    CONSTRAINT fk_detalle_producto FOREIGN KEY (id_producto) REFERENCES Producto(id_producto) ON DELETE RESTRICT,
    CONSTRAINT chk_cantidad CHECK (cantidad > 0),
    CONSTRAINT chk_precio_detalle CHECK (precio >= 0)
);

CREATE TABLE Stock_Zona (
    id_zona INT,
    id_vivero INT,
    id_producto INT,
    stock INT NOT NULL,
    PRIMARY KEY (id_zona, id_vivero, id_producto),
    CONSTRAINT fk_stock_zona FOREIGN KEY (id_zona, id_vivero) REFERENCES Zona(id_zona, id_vivero) ON DELETE CASCADE,
    CONSTRAINT fk_stock_producto FOREIGN KEY (id_producto) REFERENCES Producto(id_producto) ON DELETE CASCADE,
    CONSTRAINT chk_stock CHECK (stock >= 0)
);

CREATE TABLE Historial_Asignacion (
    id_empleado INT,
    id_zona INT,
    id_vivero INT,
    fecha DATE NOT NULL,
    PRIMARY KEY (id_empleado, id_zona, id_vivero, fecha),
    CONSTRAINT fk_historial_empleado FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado) ON DELETE CASCADE,
    CONSTRAINT fk_historial_zona FOREIGN KEY (id_zona, id_vivero) REFERENCES Zona(id_zona, id_vivero) ON DELETE CASCADE
);
