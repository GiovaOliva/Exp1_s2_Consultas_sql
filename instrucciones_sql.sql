-- CREACION DE LA DB
CREATE DATABASE IF NOT EXISTS tecnologi_inc;

-- USAR LA DB
USE tecnologi_inc;

-- CREACION DE TABLAS
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    fecha_registro DATE,
    email VARCHAR(100),
    telefono VARCHAR(20)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    nombre_producto VARCHAR(100),
    categoria VARCHAR(50),
    precio DECIMAL(10, 2),
    stock INT
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    cantidad INT,
    fecha_venta DATE,
    total_venta DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE sales_staff (
    staff_id INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    email VARCHAR(100),
    telefono VARCHAR(20)
);

-- POBLACION DE TABLAS

-- Tabla customers
INSERT INTO customers (customer_id, nombre, apellido, fecha_registro, email, telefono)
VALUES 
(2, 'Ana', 'Gómez', '2024-10-01', 'ana.gomez@mail.com', '234567890'),
(3, 'Luis', 'Martínez', '2023-09-15', 'luis.martinez@mail.com', '345678901');

-- Tabla products
INSERT INTO products (product_id, nombre_producto, categoria, precio, stock)
VALUES 
(2, 'Impresora', 'Electrónica', 150.00, 25),
(3, 'Monitor', 'Electrónica', 300.00, 5);

-- Tabla sales
INSERT INTO sales (sale_id, customer_id, product_id, cantidad, fecha_venta, total_venta)
VALUES 
(2, 2, 2, 1, '2024-10-15', 150.00), 
(3, 3, 1, 1, '2024-10-05', 1200.00);

-- Tabla sales_staff
INSERT INTO sales_staff (staff_id, nombre, apellido, email, telefono)
VALUES 
(2, 'Maria', 'Fuentes', 'maria.fuentes@mail.com', '456789012'),
(3, 'Roberto', 'Sánchez', 'roberto.sanchez@mail.com', '567890123');


-- CONSULTAS

-- Obtener la lista de clientes registrados en el último mes, mostrando su nombre completo y fecha de registro.
SELECT CONCAT(nombre, ' ', apellido) AS nombre_completo, fecha_registro
FROM customers
WHERE fecha_registro >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
ORDER BY fecha_registro DESC;


-- Calcular el incremento del 15% del precio de todos los productos cuyo nombre termine en “A” y que tengan más de 10 unidades en stock.
SELECT nombre_producto, precio, 
       ROUND(precio * 1.15, 1) AS precio_incrementado
FROM products
WHERE nombre_producto LIKE '%a' AND stock > 10
ORDER BY precio_incrementado ASC;

-- Mostrar la lista del personal de ventas, con nombre completo, correo electrónico y una contraseña por defecto.
SELECT CONCAT(nombre, ' ', apellido) AS nombre_completo, 
       email,
       CONCAT(LEFT(nombre, 4), LENGTH(email), RIGHT(apellido, 3)) AS contrasena_predeterminada
FROM sales_staff
ORDER BY apellido DESC, nombre ASC;