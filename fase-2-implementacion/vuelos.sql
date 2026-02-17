CREATE DATABASE vuelos;
USE vuelos;

-- 1. UBICACIONES
CREATE TABLE ubicaciones (
    pais VARCHAR(20) NOT NULL,    -- Corregido: longitud 20
    estado VARCHAR(20) NOT NULL,  -- Corregido: longitud 20
    ciudad VARCHAR(20) NOT NULL,  -- Corregido: longitud 20
    huso TINYINT NOT NULL CHECK (huso BETWEEN -12 AND 12),
    CONSTRAINT pk_ubicaciones PRIMARY KEY (pais, estado, ciudad)
) ENGINE=InnoDB;

-- 2. AEROPUERTOS
CREATE TABLE aeropuertos (
    codigo VARCHAR(10) NOT NULL,
    nombre VARCHAR(40) NOT NULL,    -- Corregido: longitud 40
    telefono VARCHAR(15) NOT NULL,  -- Corregido: longitud 15
    direccion VARCHAR(30) NOT NULL, -- Corregido: longitud 30
    pais VARCHAR(20) NOT NULL,      -- Corregido: longitud 20
    estado VARCHAR(20) NOT NULL,    -- Corregido: longitud 20
    ciudad VARCHAR(20) NOT NULL,    -- Corregido: longitud 20
    CONSTRAINT pk_aeropuertos PRIMARY KEY (codigo),
    CONSTRAINT fk_aeropuertos_ubicaciones FOREIGN KEY (pais, estado, ciudad) 
        REFERENCES ubicaciones (pais, estado, ciudad) ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 3. VUELOS PROGRAMADOS
CREATE TABLE vuelos_programados (
    numero VARCHAR(10) NOT NULL,
    aeropuerto_salida VARCHAR(10) NOT NULL,
    aeropuerto_llegada VARCHAR(10) NOT NULL,
    CONSTRAINT pk_vuelos_programados PRIMARY KEY (numero),
    CONSTRAINT fk_vp_salida FOREIGN KEY (aeropuerto_salida) REFERENCES aeropuertos (codigo),
    CONSTRAINT fk_vp_llegada FOREIGN KEY (aeropuerto_llegada) REFERENCES aeropuertos (codigo)
) ENGINE=InnoDB;

-- 4. MODELOS DE AVION
CREATE TABLE modelos_avion (
    modelo VARCHAR(20) NOT NULL,      -- Corregido: longitud 20
    fabricante VARCHAR(20) NOT NULL,  -- Corregido: longitud 20
    cabinas INT UNSIGNED NOT NULL,
    cant_asientos INT UNSIGNED NOT NULL,
    CONSTRAINT pk_modelos_avion PRIMARY KEY (modelo)
) ENGINE=InnoDB;

-- 5. CLASES
CREATE TABLE clases (
    nombre VARCHAR(20) NOT NULL,      -- Corregido: longitud 20
    porcentaje DECIMAL(2, 2) UNSIGNED NOT NULL CHECK (porcentaje BETWEEN 0 AND 0.99), -- Corregido: tipo y UNSIGNED
    CONSTRAINT pk_clases PRIMARY KEY (nombre)
) ENGINE=InnoDB;

-- 6. COMODIDADES
CREATE TABLE comodidades (
    codigo INT UNSIGNED NOT NULL,
    descripcion TEXT NOT NULL,
    CONSTRAINT pk_comodidades PRIMARY KEY (codigo)
) ENGINE=InnoDB;

-- 7. SALIDAS
CREATE TABLE salidas (
    vuelo VARCHAR(10) NOT NULL,
    dia ENUM('Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa') NOT NULL,
    hora_sale TIME NOT NULL,
    hora_llega TIME NOT NULL,
    modelo_avion VARCHAR(20) NOT NULL, -- Corregido: longitud 20
    CONSTRAINT pk_salidas PRIMARY KEY (vuelo, dia),
    CONSTRAINT fk_salidas_vp FOREIGN KEY (vuelo) REFERENCES vuelos_programados (numero),
    CONSTRAINT fk_salidas_modelo FOREIGN KEY (modelo_avion) REFERENCES modelos_avion (modelo)
) ENGINE=InnoDB;

-- 8. INSTANCIAS DE VUELO
CREATE TABLE instancias_vuelo (
    vuelo VARCHAR(10) NOT NULL,
    fecha DATE NOT NULL,
    dia ENUM('Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa') NOT NULL,
    estado VARCHAR(15), -- Corregido: longitud 15
    CONSTRAINT pk_instancias PRIMARY KEY (vuelo, fecha),
    CONSTRAINT fk_instancias_salidas FOREIGN KEY (vuelo, dia) REFERENCES salidas (vuelo, dia)
) ENGINE=InnoDB;

-- 9. PASAJEROS
CREATE TABLE pasajeros (
    doc_tipo VARCHAR(10) NOT NULL,
    doc_nro INT UNSIGNED NOT NULL,
    apellido VARCHAR(20) NOT NULL,    -- Corregido: longitud 20
    nombre VARCHAR(20) NOT NULL,      -- Corregido: longitud 20
    direccion VARCHAR(40) NOT NULL,   -- Corregido: longitud 40
    telefono VARCHAR(15) NOT NULL,    -- Corregido: longitud 15
    nacionalidad VARCHAR(20) NOT NULL, -- Corregido: longitud 20
    CONSTRAINT pk_pasajeros PRIMARY KEY (doc_tipo, doc_nro)
) ENGINE=InnoDB;

-- 10. EMPLEADOS
CREATE TABLE empleados (
    legajo INT UNSIGNED NOT NULL,
    password CHAR(32) NOT NULL,
    doc_tipo VARCHAR(10) NOT NULL,
    doc_nro INT UNSIGNED NOT NULL,
    apellido VARCHAR(20) NOT NULL,    -- Corregido: longitud 20
    nombre VARCHAR(20) NOT NULL,      -- Corregido: longitud 20
    direccion VARCHAR(40) NOT NULL,   -- Corregido: longitud 40
    telefono VARCHAR(15) NOT NULL,    -- Corregido: longitud 15
    CONSTRAINT pk_empleados PRIMARY KEY (legajo)
) ENGINE=InnoDB;

-- 11. RESERVAS
CREATE TABLE reservas (
   numero INT UNSIGNED NOT NULL AUTO_INCREMENT, -- Corregido: AUTO_INCREMENT
   fecha DATE NOT NULL,
   vencimiento DATE NOT NULL,
   estado VARCHAR(15) NOT NULL,                 -- Corregido: longitud 15 y NOT NULL
   doc_tipo VARCHAR(10) NOT NULL,
   doc_nro INT UNSIGNED NOT NULL,
   legajo INT UNSIGNED NOT NULL,
   CONSTRAINT pk_reservas PRIMARY KEY (numero),
   CONSTRAINT fk_res_pasajero FOREIGN KEY (doc_tipo, doc_nro) REFERENCES pasajeros (doc_tipo, doc_nro),
   CONSTRAINT fk_res_empleado FOREIGN KEY (legajo) REFERENCES empleados (legajo)
) ENGINE=InnoDB;

-- 12. BRINDA
CREATE TABLE brinda (
    vuelo VARCHAR(10) NOT NULL,
    dia ENUM('Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa') NOT NULL,
    clase VARCHAR(20) NOT NULL,             -- Corregido: longitud 20
    precio DECIMAL(7, 2) UNSIGNED NOT NULL, -- Corregido: UNSIGNED
    cant_asientos INT UNSIGNED NOT NULL,
    CONSTRAINT pk_brinda PRIMARY KEY (vuelo, dia, clase),
    CONSTRAINT fk_brinda_salida FOREIGN KEY (vuelo, dia) REFERENCES salidas (vuelo, dia),
    CONSTRAINT fk_brinda_clase FOREIGN KEY (clase) REFERENCES clases (nombre)
) ENGINE=InnoDB;

-- 13. POSEE
CREATE TABLE posee (
    clase VARCHAR(20) NOT NULL, -- Corregido: longitud 20
    comodidad INT UNSIGNED NOT NULL,
    CONSTRAINT pk_posee PRIMARY KEY (clase, comodidad),
    CONSTRAINT fk_posee_clase FOREIGN KEY (clase) REFERENCES clases (nombre),
    CONSTRAINT fk_posee_comodidad FOREIGN KEY (comodidad) REFERENCES comodidades (codigo)
) ENGINE=InnoDB;

-- 14. RESERVA_VUELO_CLASE
CREATE TABLE reserva_vuelo_clase (
    numero INT UNSIGNED NOT NULL,
    vuelo VARCHAR(10) NOT NULL,
    fecha_vuelo DATE NOT NULL,
    clase VARCHAR(20) NOT NULL, -- Corregido: longitud 20
    -- Corregido: 'clase' fuera de la PRIMARY KEY
    CONSTRAINT pk_rvc PRIMARY KEY (numero, vuelo, fecha_vuelo),
    CONSTRAINT fk_rvc_res FOREIGN KEY (numero) REFERENCES reservas (numero),
    CONSTRAINT fk_rvc_instancia FOREIGN KEY (vuelo, fecha_vuelo) REFERENCES instancias_vuelo (vuelo, fecha),
    CONSTRAINT fk_rvc_clase FOREIGN KEY (clase) REFERENCES clases (nombre)
) ENGINE=InnoDB;

-- 15. ASIENTOS_RESERVADOS
CREATE TABLE asientos_reservados (
    vuelo VARCHAR(10) NOT NULL,
    fecha DATE NOT NULL,
    clase VARCHAR(20) NOT NULL, -- Corregido: longitud 20
    cantidad INT UNSIGNED NOT NULL,
    CONSTRAINT pk_asientos_reservados PRIMARY KEY (vuelo, fecha, clase),
    CONSTRAINT fk_ar_instancia FOREIGN KEY (vuelo, fecha) REFERENCES instancias_vuelo (vuelo, fecha),
    CONSTRAINT fk_ar_clase FOREIGN KEY (clase) REFERENCES clases (nombre)
) ENGINE=InnoDB;

---
-- VISTA
---

CREATE VIEW vuelos_disponibles AS
SELECT  iv.vuelo AS nro_vuelo,
        s.modelo_avion AS modelo,
        iv.fecha AS fecha,
        iv.dia AS dia_sale,
        s.hora_sale AS hora_sale,
        s.hora_llega AS hora_llega,
        TIMEDIFF(s.hora_llega, s.hora_sale) AS tiempo_estimado,
        a_salida.codigo AS codigo_aero_sale,
        a_salida.nombre AS nombre_aero_sale,
        a_salida.ciudad AS ciudad_sale,
        a_salida.estado AS estado_sale,
        a_salida.pais AS pais_sale,
        a_llegada.codigo AS codigo_aero_llega,
        a_llegada.nombre AS nombre_aero_llega,
        a_llegada.ciudad AS ciudad_llega,
        a_llegada.estado AS estado_llega,
        a_llegada.pais AS pais_llega,
        b.precio AS precio,
        ((b.cant_asientos + (b.cant_asientos * c.porcentaje)) - COALESCE(ar.cantidad, 0)) AS asientos_disponibles,
        b.clase AS clase
FROM instancias_vuelo iv
JOIN salidas s ON s.vuelo = iv.vuelo AND s.dia = iv.dia
JOIN vuelos_programados vp ON s.vuelo = vp.numero
JOIN aeropuertos a_salida ON vp.aeropuerto_salida = a_salida.codigo
JOIN aeropuertos a_llegada ON vp.aeropuerto_llegada = a_llegada.codigo
JOIN brinda b ON s.vuelo = b.vuelo AND s.dia = b.dia
JOIN clases c ON b.clase = c.nombre
LEFT JOIN asientos_reservados ar ON iv.vuelo = ar.vuelo AND iv.fecha = ar.fecha AND b.clase = ar.clase;

---
-- USUARIOS Y PERMISOS
---

CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON vuelos.* TO 'admin'@'localhost' WITH GRANT OPTION;

CREATE USER 'empleado'@'%' IDENTIFIED BY 'empleado';
GRANT SELECT ON vuelos.* TO 'empleado'@'%';
GRANT INSERT, UPDATE, DELETE ON vuelos.reservas TO 'empleado'@'%';
GRANT INSERT, UPDATE, DELETE ON vuelos.pasajeros TO 'empleado'@'%';
GRANT INSERT, UPDATE, DELETE ON vuelos.reserva_vuelo_clase TO 'empleado'@'%';

CREATE USER 'cliente'@'%' IDENTIFIED BY 'cliente';
GRANT SELECT ON vuelos_disponibles TO 'cliente'@'%';

FLUSH PRIVILEGES;