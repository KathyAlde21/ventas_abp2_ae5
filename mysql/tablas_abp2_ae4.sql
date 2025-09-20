-- =============================
-- CREANDO TABLAS -
-- de acuerdo a trabajo ABP2 AE4
-- =============================
-- ======================================================
-- 1) CATEGORIA
-- ======================================================
CREATE TABLE categoria (
  idcategoria int NOT NULL,
  nombrecategoria varchar(75) NOT NULL,
  PRIMARY KEY (idcategoria)
);

-- ======================================================
-- 2) CLIENTES
-- ======================================================
CREATE TABLE clientes (
  idcliente int NOT NULL,
  nombres varchar(50) NOT NULL,
  apellidos varchar(50) NOT NULL,
  direccion varchar(70) DEFAULT NULL,
  telefono int DEFAULT NULL,
  PRIMARY KEY (idcliente)
);

-- ======================================================
-- 3) DETALLE VENTA
-- ======================================================
CREATE TABLE detalleventa (
  ventas_idventa int NOT NULL,
  producto_idproducto int NOT NULL,
  cantidad int DEFAULT NULL,
  PRIMARY KEY (ventas_idventa, producto_idproducto),
  KEY idx_detalle_venta (ventas_idventa),
  KEY idx_detalle_producto (producto_idproducto),
  CONSTRAINT detalleventa_ibfk_1 FOREIGN KEY (ventas_idventa) REFERENCES ventas (idventa),
  CONSTRAINT detalleventa_ibfk_2 FOREIGN KEY (producto_idproducto) REFERENCES producto (idproducto)
);

-- ======================================================
-- 4) PRODUCTO
-- ======================================================
CREATE TABLE producto (
  idproducto int NOT NULL,
  nombreproducto varchar(50) NOT NULL,
  valor int NOT NULL,
  categoria_idcategoria int NOT NULL,
  PRIMARY KEY (idproducto),
  KEY idx_producto_categoria (categoria_idcategoria),
  CONSTRAINT producto_categoria_fk FOREIGN KEY (categoria_idcategoria) REFERENCES categoria (idcategoria) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ======================================================
-- 5) VENTAS
-- ======================================================
CREATE TABLE ventas (
  idventa int NOT NULL,
  vendedor varchar(50) DEFAULT NULL,
  cantarticulos int NOT NULL,
  subtotal int NOT NULL,
  impuesto int NOT NULL,
  total int NOT NULL,
  clientes_idcliente int NOT NULL,
  PRIMARY KEY (idventa),
  KEY idx_ventas_cliente (clientes_idcliente),
  CONSTRAINT ventas_ibfk_1 FOREIGN KEY (clientes_idcliente) REFERENCES clientes (idcliente)
);

-- ============================
-- Verificación rápida
-- ============================
SHOW TABLES;
SHOW CREATE TABLE categoria;
SHOW CREATE TABLE clientes;
SHOW CREATE TABLE detalleventa;
SHOW CREATE TABLE producto;
SHOW CREATE TABLE ventas;