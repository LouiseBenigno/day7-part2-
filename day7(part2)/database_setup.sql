-- ==============================================================================
-- Day 7: Data Joining & Transformation - Sample Database Setup
-- Run this script in your SQLite client to generate the database for the class.
-- ==============================================================================

-- 1. DROP EXISTING TABLES (To allow re-running the script cleanly)
DROP TABLE IF EXISTS shipping;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- 2. CREATE TABLES
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT UNIQUE,
    region TEXT
);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_name TEXT NOT NULL,
    category TEXT NOT NULL,
    price REAL NOT NULL
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER,
    product_id INTEGER,
    order_date DATE,
    quantity INTEGER,
    total_amount REAL,
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
    FOREIGN KEY (product_id) REFERENCES products (product_id)
);

CREATE TABLE shipping (
    shipping_id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER,
    courier TEXT,
    delivery_status TEXT,
    FOREIGN KEY (order_id) REFERENCES orders (order_id)
);

-- 3. INSERT DUMMY DATA

-- Customers
-- Note: Daniel, Angela, and Roberto purposely have NO orders to demonstrate LEFT JOIN
INSERT INTO customers (first_name, last_name, email, region) VALUES
('Maria', 'Santos', 'maria.s@email.com', 'NCR'),
('Daniel', 'Reyes', 'daniel.r@email.com', 'NCR'),
('Angela', 'Cruz', 'angela.c@email.com', 'Visayas'),
('Roberto', 'Bautista', 'roberto.b@email.com', 'Mindanao'),
('Juan', 'Dela Cruz', 'juan.d@email.com', 'Visayas'),
('Elena', 'Gomez', 'elena.g@email.com', 'NCR'),
('Miguel', 'Torres', 'miguel.t@email.com', 'NCR');

-- Products
INSERT INTO products (product_name, category, price) VALUES
('ThinkPad X1 Carbon (Laptop)', 'Electronics', 1500.00),
('Dell XPS 15 (Laptop)', 'Electronics', 1200.00),
('Logitech MX Master 3', 'Accessories', 100.00),
('Anker USB-C Hub', 'Accessories', 50.00),
('Keychron K2 Keyboard', 'Electronics', 80.00),
('Samsung 4K Monitor', 'Electronics', 350.00);

-- Orders
-- Maria has two orders, one is the "most recent"
-- Juan (Visayas) buys an accessory
-- Elena (NCR) buys Electronics
INSERT INTO orders (customer_id, product_id, order_date, quantity, total_amount) VALUES
(1, 1, '2023-09-15', 1, 1500.00), -- 1: Maria buys Laptop
(1, 3, '2023-10-25', 1, 100.00),  -- 2: Maria buys Mouse (Most recent)
(5, 4, '2023-10-02', 2, 100.00),  -- 3: Juan (Visayas) buys Hub (Accessories)
(6, 2, '2023-10-18', 1, 1200.00), -- 4: Elena (NCR) buys Laptop (Electronics)
(7, 6, '2023-10-20', 2, 700.00);  -- 5: Miguel (NCR) buys Monitor (Electronics)

-- Shipping
-- We purposely leave out order #5 from shipping to show NULLs in a LEFT JOIN
INSERT INTO shipping (order_id, courier, delivery_status) VALUES
(1, 'LBC Express', 'Delivered'),
(2, 'J&T Express', 'In Transit'),
(3, 'LBC Express', 'Delivered'),
(4, 'Ninja Van', 'Processing');

-- ==============================================================================
-- END OF SCRIPT
-- ==============================================================================