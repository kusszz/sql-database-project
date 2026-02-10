-- Final SQL Project - Shop
-- Daria Kusz
-- Emilia Mrosek


/* Project Requirements:
1. You must create a database and populate it with records.
2. The database must contain several tables (>= 3) with properly defined primary keys, foreign keys, constraints, etc.
3. You must create at least two roles and grant them permissions.
4. You must write at least one meaningful function and create at least one view.

The project should be completed in the form of two .sql files (with comments!). 
In one file, you should create the database, i.e., tables, views, etc., 
and in the second, present its contents, i.e., write several sample queries 
that utilize the solutions you have created.
*/


-- Creating a database for a newly opened online bike shop

--createdb bike_shop;
--psql bike_shop
CREATE DATABASE bike_shop;
\c bike_shop

DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS order_details;

CREATE TABLE customers (
	customer_id VARCHAR(3) NOT NULL, 
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL CHECK (email LIKE '%@%.%'),
	phone_no INTEGER NOT NULL,
	PRIMARY KEY (customer_id)
);

CREATE TABLE products (
	product_id VARCHAR(2) NOT NULL ,
	name VARCHAR(50) NOT NULL,
	category VARCHAR(50) NOT NULL,
	unit_price NUMERIC(10,2) NOT NULL,
	stock_quantity INTEGER NOT NULL CHECK (stock_quantity >= 0),
PRIMARY KEY (product_id)
);

CREATE TABLE orders (
	order_id VARCHAR(5) NOT NULL,
	customer_id VARCHAR(3) NOT NULL,
	order_date DATE NOT NULL,
	city VARCHAR(50) NOT NULL,
	address VARCHAR(50) NOT NULL ,
	zip_code text NOT NULL,
    ship_date DATE CHECK (ship_date >= order_date),
    delivery_date DATE CHECK (delivery_date >= ship_date),
	PRIMARY KEY (order_id),
	FOREIGN KEY(customer_id) REFERENCES customers (customer_id)
);

CREATE TABLE order_details (
	order_id VARCHAR(5) NOT NULL,
	product_id VARCHAR(2) NOT NULL,
	quantity INTEGER NOT NULL CHECK (quantity > 0),
	FOREIGN KEY(order_id) REFERENCES orders (order_id),
	FOREIGN KEY(product_id) REFERENCES products (product_id)
);

/* Adding values to the customers table */
INSERT INTO customers (customer_id, first_name, last_name, email, phone_no) VALUES
('001', 'Patrycja', 'Chmiel', 'p.i.paliwo@wp.pl', 572405647),
('002', 'Emilia', 'Mrozek', 'idze.zima@wp.pl', 638227531),
('003', 'Karol', 'Pyrkowski', 'batman001.@gmail.com', 852686782),
('004', 'Tomek', 'Kopara', 'budowa@gmail.com', 145974097),
('005', 'Olga', 'Zieleń', 'zielone.wzgórze@wp.pl', 604244415),
('006', 'Ryszard', 'Brylok', 'łańcóch.za.40.kola@gmail.com', 281412729),
('007', 'Szymon', 'Myga', 'szymon.myga@ug.edu.pl', 386482887),
('008', 'Anna', 'Zielwzgórz', 'idk.w.sumie@wp.pl', 123678467),
('009', 'Borys', 'Wążka', 'owady.i.spółka@gmail.com', 781436576),
('010', 'Daria', 'Kurz', 'odkurzacz02@gmail.com', 379401941);

/* Adding values to the products table */
INSERT INTO products (product_id, name, category, unit_price, stock_quantity) VALUES
('01', 'Mevo', 'city', 1200.50, 25),
('02', 'CityWhirl', 'city', 1450.99, 8),
('03', 'UrbanFlow', 'city', 1650.00, 7),
('04', 'FreeTrek', 'trekking', 1700.99, 20),
('05', 'RouteMaster', 'trekking', 1750.00, 16),
('06', 'ThunderPeak', 'mountain', 2100.99, 14),
('07', 'WindCutter', 'road', 2100.99, 9);

/* Adding values to the orders table */
INSERT INTO orders (order_id, customer_id, order_date, city, address, zip_code, ship_date, delivery_date) VALUES
('00001', '003', '2025-04-10', 'Rumia', 'Starowiejska 1', '84-230', '2025-04-12', '2025-04-15'),
('00002', '002', '2025-04-12', 'Gdańsk', 'Piastowska 100/3', '80-958', '2025-04-14', '2025-04-16'),
('00003', '001', '2025-04-17', 'Gdynia', 'Niepodległości 3', '81-001', '2025-04-20', '2025-04-23'),
('00004', '004', '2025-04-25', 'Pruszcz Gdański', 'Pomorska 602', '83-000', '2025-04-27', '2025-04-30'),
('00005', '009', '2025-03-31', 'Sopot', 'Spacerowa 11', '81-745', '2025-04-01', '2025-04-03'),
('00006', '010', '2025-05-01', 'Sopot', 'Leszczynowa 34', '81-749', '2025-05-06', '2025-05-08'),
('00007', '005', '2025-05-03', 'Gdańsk', 'Marynarki Polskiej 99', '80-391', '2025-05-06', '2025-05-10'),
('00008', '006', '2025-05-06', 'Wejherowo', 'Różana 45', '84-200', '2025-05-10', '2025-05-13'),
('00009', '008', '2025-05-11', 'Tczew', 'Malinowa 77', '83-110', '2025-05-15', '2025-05-17'),
('00010', '003', '2025-05-14', 'Rumia', 'Starowiejska 1', '84-230', '2025-05-16', '2025-05-18'),
('00011', '007', '2025-05-20', 'Gdańsk', 'Pszczółki 666', '80-805', '2025-05-22', NULL),
('00012', '004', '2025-05-24', 'Pruszcz Gdański', 'Pomorska 602', '83-000', NULL, NULL);

/* Adding values to the order_details table */
INSERT INTO order_details (order_id, product_id, quantity) VALUES
   ('00001', '01', 1),
   ('00002', '01', 1),
   ('00002', '07', 2),
   ('00003', '05', 1),
   ('00003', '04', 1),
   ('00004', '05', 1),
   ('00005', '07', 2),
   ('00006', '07', 1),
   ('00006', '02', 2),
   ('00007', '02', 2),
   ('00007', '01', 2),
   ('00008', '03', 1),
   ('00009', '07', 2),
   ('00010', '06', 1),
   ('00011', '03', 1),
   ('00011', '05', 3),
   ('00012', '01', 2);

/* Views */

-- View showing how much a customer spent in total for a given order
CREATE OR REPLACE VIEW orders_total AS  
SELECT
    od.order_id AS order_number, 
    c.first_name ||'  '|| c.last_name AS customer, 
    SUM(p.unit_price * od.quantity) AS total_spent
FROM
customers c
    INNER JOIN orders o ON o.customer_id = c.customer_id
    INNER JOIN order_details od ON o.order_id = od.order_id
    INNER JOIN products p ON od.product_id = p.product_id
   GROUP BY customer, order_number
   ORDER BY order_number;

-- View showing how many orders were made in a given month
CREATE OR REPLACE VIEW orders_per_month AS 
SELECT
    TO_CHAR(o.order_date, 'Month') AS MONTH, 
    COUNT(o.order_id) AS order_count
FROM
orders o
   GROUP BY MONTH
   ORDER BY MONTH;

-- View showing all order details. We create it for the function.
CREATE OR REPLACE VIEW orders_view AS
SELECT 
    o.order_id AS order_number,
    c.first_name || ' ' || c.last_name AS customer,
    o.order_date AS order_date,
    o.address || ' ' || o.city || ' ' || o.zip_code AS address,
    STRING_AGG(p.name || ' (' || od.quantity || 'x ' || p.unit_price || ')', ', ') AS products,
    SUM(od.quantity) AS total_quantity,
    SUM(od.quantity * p.unit_price) AS order_total,
    CASE 
        WHEN o.delivery_date IS NOT NULL THEN 'delivered' 
        ELSE (CASE WHEN o.ship_date IS NOT NULL THEN 'shipped' ELSE 'processing' END) 
    END AS order_status
FROM orders o
INNER JOIN order_details od ON od.order_id = o.order_id
INNER JOIN products p ON p.product_id = od.product_id                    
INNER JOIN customers c ON c.customer_id = o.customer_id
GROUP BY 
    o.order_id, c.first_name, c.last_name, o.order_date, o.address, o.city, o.zip_code
ORDER BY o.order_id;


-- Function

-- Function to search for orders by order_number. It will be available mainly to customers who want to view their order details
CREATE OR REPLACE FUNCTION search_orders(id_param VARCHAR(5))
RETURNS TABLE (
    order_number VARCHAR(5),
    order_date DATE,
    customer VARCHAR(100),
    address text,
    products text,
    total_quantity INTEGER,
    order_total NUMERIC(10,2),
    status VARCHAR(20)
) AS $$
    SELECT 
        v.order_number, v.order_date, v.customer, v.address, v.products, v.total_quantity, v.order_total, v.order_status
    FROM orders_view v
    WHERE v.order_number = id_param;
$$ LANGUAGE SQL SECURITY DEFINER;

-- ROLES

\c bike_shop postgres

-- Creating roles: employee and customer
CREATE ROLE employee;
CREATE ROLE customer;

-- We want the employee to be able to add or update products and to view other tables
GRANT INSERT, UPDATE ON products TO employee;
GRANT SELECT ON products, customers, orders, order_details, orders_view, orders_total, orders_per_month TO employee;
GRANT EXECUTE ON FUNCTION search_orders(VARCHAR) TO employee;

-- We want the customer to have access to the product database (e.g., to know stock quantity)
GRANT SELECT ON products TO customer; 
-- The customer should not see ALL order details
REVOKE ALL ON orders_view FROM customer; 
-- But only their own - if they know the order ID, they can see its details (like in DPD)
GRANT EXECUTE ON FUNCTION search_orders(VARCHAR) TO customer;
