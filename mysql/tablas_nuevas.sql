-- ============================================================
-- 1) FACTURA: varias facturas pueden cancelar una misma venta
-- ============================================================
CREATE TABLE `factura` (
  `numfactura` INT NOT NULL AUTO_INCREMENT,          -- número único y correlativo
  `fecha_generacion` DATE NOT NULL,
  `fecha_pago` DATE DEFAULT NULL,
  `monto` INT NOT NULL,                              -- monto de la factura (por ejemplo, monto pagado)
  `subtotal` INT NOT NULL,
  `impuesto` INT NOT NULL,
  `total` INT NOT NULL,
  `venta_idventa` INT NOT NULL,                      -- FK a ventas
  PRIMARY KEY (`numfactura`),
  KEY `idx_factura_venta` (`venta_idventa`),
  CONSTRAINT `factura_venta_fk`
    FOREIGN KEY (`venta_idventa`)
    REFERENCES `ventas` (`idventa`)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CHECK (`subtotal` >= 0),
  CHECK (`impuesto` >= 0),
  CHECK (`total` = `subtotal` + `impuesto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ==========================================================================
-- 2) ORDEN_COMPRA: relación 1 a 1 con venta (cada venta tiene una sola orden)
-- ==========================================================================
CREATE TABLE `orden_compra` (
  `idorden_compra` INT NOT NULL AUTO_INCREMENT,
  `fecha_creacion` DATE NOT NULL,
  `autorizado_por` VARCHAR(100) NOT NULL,
  `observaciones` VARCHAR(255) DEFAULT NULL,
  `venta_idventa` INT NOT NULL,                      -- FK a ventas (UNIQUE para forzar 1 a 1)
  PRIMARY KEY (`idorden_compra`),
  UNIQUE KEY `uq_orden_compra_venta` (`venta_idventa`),
  CONSTRAINT `orden_compra_venta_fk`
    FOREIGN KEY (`venta_idventa`)
    REFERENCES `ventas` (`idventa`)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- =============================================================================
--   3) ADQUISICION_PRODUCTO: adquisiciones/compras de stock por producto (N a 1)
-- =============================================================================
CREATE TABLE `adquisicion_producto` (
  `idadquisicion` INT NOT NULL AUTO_INCREMENT,       -- correlativo
  `fecha_compra` DATE NOT NULL,
  `proveedor` VARCHAR(120) NOT NULL,
  `cantidad` INT NOT NULL,
  `producto_idproducto` INT NOT NULL,                -- FK a producto
  PRIMARY KEY (`idadquisicion`),
  KEY `idx_adq_producto` (`producto_idproducto`),
  CONSTRAINT `adq_producto_fk`
    FOREIGN KEY (`producto_idproducto`)
    REFERENCES `producto` (`idproducto`)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CHECK (`cantidad` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;