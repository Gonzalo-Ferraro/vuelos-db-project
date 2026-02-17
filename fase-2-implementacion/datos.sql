USE vuelos;

-- 1. UBICACIONES (Max 20 caracteres)
INSERT INTO ubicaciones (pais, estado, ciudad, huso) VALUES 
('Argentina', 'BsAs', 'Ezeiza', -3),
('Brasil', 'Sao Paulo', 'Guarulhos', -3),
('Chile', 'Santiago', 'Pudahuel', -4),
('España', 'Madrid', 'Madrid', 1);

-- 2. AEROPUERTOS (Nombre max 40, Tel max 15, Dir max 30)
INSERT INTO aeropuertos (codigo, nombre, telefono, direccion, pais, estado, ciudad) VALUES 
('EZE', 'Ezeiza Intl', '541154806111', 'Aut. Richieri 33', 'Argentina', 'BsAs', 'Ezeiza'),
('GRU', 'Guarulhos Intl', '55112445', 'Rod. Helio Smidt', 'Brasil', 'Sao Paulo', 'Guarulhos'),
('SCL', 'SCL Intl', '5622690', 'Av. Cortinez', 'Chile', 'Santiago', 'Pudahuel'),
('MAD', 'Barajas', '3491321', 'Av Hispanidad', 'España', 'Madrid', 'Madrid');

-- 3. MODELOS DE AVION (Max 20 caracteres)
INSERT INTO modelos_avion (modelo, fabricante, cabinas, cant_asientos) VALUES 
('Boeing 737', 'Boeing', 2, 170),
('Airbus A320', 'Airbus', 2, 180);

-- 4. CLASES (Max 20 caracteres, Porcentaje DECIMAL(2,2))
INSERT INTO clases (nombre, porcentaje) VALUES 
('Turista', 0.10),
('Ejecutiva', 0.05),
('Primera', 0.00);

-- 5. COMODIDADES
INSERT INTO comodidades (codigo, descripcion) VALUES 
(1, 'Wifi'), (2, 'Comida');

-- 6. VUELOS PROGRAMADOS
INSERT INTO vuelos_programados (numero, aeropuerto_salida, aeropuerto_llegada) VALUES 
('AR1234', 'EZE', 'GRU'),
('LA500', 'GRU', 'SCL');

-- 7. SALIDAS
INSERT INTO salidas (vuelo, dia, hora_sale, hora_llega, modelo_avion) VALUES 
('AR1234', 'Lu', '10:00:00', '13:00:00', 'Boeing 737'),
('AR1234', 'Vi', '18:00:00', '21:00:00', 'Boeing 737'),
('LA500',  'Sa', '08:00:00', '12:00:00', 'Airbus A320');

-- 8. BRINDA (Precio DECIMAL(7,2) UNSIGNED)
INSERT INTO brinda (vuelo, dia, clase, precio, cant_asientos) VALUES 
('AR1234', 'Lu', 'Turista', 500.00, 150),
('AR1234', 'Lu', 'Ejecutiva', 1200.00, 20),
('AR1234', 'Vi', 'Turista', 550.00, 170);

-- 9. INSTANCIAS DE VUELO (Estado max 15)
INSERT INTO instancias_vuelo (vuelo, fecha, dia, estado) VALUES 
('AR1234', '2024-10-21', 'Lu', 'A TIEMPO'),
('AR1234', '2024-10-25', 'Vi', 'DEMORADO');

-- 10. PASAJEROS (Nombre/Ape max 20, Dir max 40, Tel max 15)
INSERT INTO pasajeros (doc_tipo, doc_nro, apellido, nombre, direccion, telefono, nacionalidad) VALUES 
('DNI', 11111111, 'Gomez', 'Juan', 'Calle Falsa 123', '5550101', 'Argentina');

-- 11. EMPLEADOS (Mismas longitudes que pasajeros)
INSERT INTO empleados (legajo, password, doc_tipo, doc_nro, apellido, nombre, direccion, telefono) VALUES 
(100, '202cb962ac59075b964b07152d234b70', 'DNI', 33333333, 'Perez', 'Pepe', 'Av Siempre Viva', '5559999');

-- 12. RESERVAS (Estado max 15, NOT NULL)
INSERT INTO reservas (fecha, vencimiento, estado, doc_tipo, doc_nro, legajo) VALUES 
('2024-10-10', '2024-10-15', 'CONFIRMADA', 'DNI', 11111111, 100);

-- 13. ASIENTOS RESERVADOS
INSERT INTO asientos_reservados (vuelo, fecha, clase, cantidad) VALUES 
('AR1234', '2024-10-21', 'Turista', 15);