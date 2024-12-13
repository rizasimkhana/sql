-- Create the ecommerce database
CREATE DATABASE ecommerce;

-- Use the ecommerce database
USE ecommerce;

-- Create the customers table
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    address VARCHAR(255) NOT NULL
);

-- Create the products table
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT
);

-- Create the orders table
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);
-- Insert sample customers data
INSERT INTO customers (name, email, address)
VALUES 
('Alice Johnson', 'alice@example.com', '123 Main St, Cityville'),
('Bob Smith', 'bob@example.com', '456 Oak St, Townsville'),
('Charlie Brown', 'charlie@example.com', '789 Pine St, Villagetown');
-- Insert sample products data
INSERT INTO products (name, price, description)
VALUES
('Product A', 50.00, 'A high-quality product'),
('Product B', 30.00, 'Affordable and reliable'),
('Product C', 40.00, 'Stylish and durable product');
-- Insert sample orders data
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES 
(1, '2024-12-01', 120.00),  -- Alice ordered
(2, '2024-12-05', 200.00),  -- Bob ordered
(1, '2024-12-10', 180.00),  -- Alice ordered
(3, '2024-11-30', 160.00);  -- Charlie ordered

1.Retrieve all customers who have placed an order in the last 30 days:

SELECT DISTINCT c.name, c.email
FROM customers c
JOIN orders o ON c.id = o.customer_id
WHERE o.order_date >= CURDATE() - INTERVAL 30 DAY;

2.Get the total amount of all orders placed by each customer:

SELECT c.name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id;

3.Update the price of Product C to 45.00:

UPDATE products
SET price = 45.00
WHERE name = 'Product C';

4.Add a new column discount to the products table:

ALTER TABLE products
ADD COLUMN discount DECIMAL(5, 2) DEFAULT 0.00;

5.Retrieve the top 3 products with the highest price:

SELECT name, price
FROM products
ORDER BY price DESC
LIMIT 3;

6.Get the names of customers who have ordered Product A:

SELECT DISTINCT c.name,p.name as product
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN products p ON p.id = o.customer_id
WHERE p.name = 'Product A';

7.Join the orders and customers tables to retrieve the customer's name and order date for each order:

SELECT c.name AS customer_name, o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.id;

8.Retrieve the orders with a total amount greater than 150.00:

SELECT *
FROM orders
WHERE total_amount > 150.00;


9.Normalize the database by creating a separate table for order items and updating the orders table to reference the order_items table:
-- Create order_items table
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Insert example order items (assuming some products are part of orders)

-- Update orders table to remove product-related information (if needed)
-- In this case, the product information is now in the order_items table.

INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES
(1, 1, 2, 50.00),  -- Alice ordered 2 of Product A
(1, 2, 1, 30.00),  -- Alice ordered 1 of Product B
(2, 1, 3, 50.00),  -- Bob ordered 3 of Product A
(2, 3, 2, 40.00);  -- Bob ordered 2 of Product C


10.Retrieve the average total of all orders:

SELECT AVG(total_amount) AS average_order_amount
FROM orders;
