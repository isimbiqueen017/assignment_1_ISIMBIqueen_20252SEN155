
CREATE DATABASE sunrise_supermarket;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50)
);


CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);



CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


INSERT INTO customers VALUES
(1, 'Samuel Niyonzima', 'samuel@gmail.com', 'Kigali'),
(2, 'Diane Mukamana', 'diane@gmail.com', 'Musanze'),
(3, 'Patrick Habimana', 'patrick@gmail.com', 'Huye'),
(4, 'Aline Uwase', 'aline@gmail.com', 'Rubavu'),
(5, 'David Tuyishime', 'david@gmail.com', 'Kigali');



INSERT INTO products VALUES
(1, 'Maize Flour', 'Food', 2200),
(2, 'Beans', 'Food', 1900),
(3, 'Yogurt', 'Dairy', 1700),
(4, 'Butter', 'Dairy', 4200),
(5, 'Washing Powder', 'Household', 3000),
(6, 'Shampoo', 'Personal Care', 3500),
(7, 'Buns', 'Bakery', 1200),
(8, 'Sunflower Oil', 'Food', 5200);



INSERT INTO orders VALUES
(1, 1, '2026-09-01'),
(2, 2, '2026-09-03'),
(3, 3, '2026-09-04'),
(4, 4, '2026-09-06'),
(5, 5, '2026-09-07'),
(6, 1, '2026-09-09'),
(7, 2, '2026-09-10'),
(8, 3, '2026-09-12'),
(9, 4, '2026-09-13'),
(10, 5, '2026-09-14'),
(11, 1, '2026-09-16'),
(12, 2, '2026-09-17'),
(13, 3, '2026-09-18'),
(14, 4, '2026-09-19'),
(15, 5, '2026-09-20');



INSERT INTO order_items VALUES
(1, 1, 1, 3),
(2, 1, 3, 2),

(3, 2, 2, 4),
(4, 2, 7, 3),

(5, 3, 4, 2),
(6, 3, 5, 1),

(7, 4, 6, 3),
(8, 4, 8, 2),

(9, 5, 1, 2),
(10, 5, 7, 2),

(11, 6, 8, 3),
(12, 6, 3, 1),

(13, 7, 1, 5),
(14, 7, 5, 2),

(15, 8, 2, 2),
(16, 8, 6, 3),

(17, 9, 4, 1),
(18, 9, 7, 4),

(19, 10, 8, 2),
(20, 10, 5, 2),

(21, 11, 1, 4),
(22, 11, 3, 1),

(23, 12, 2, 3),
(24, 12, 7, 4),

(25, 13, 4, 2),
(26, 13, 6, 1),

(27, 14, 8, 3),
(28, 14, 5, 2),

(29, 15, 1, 2),
(30, 15, 3, 3);




SELECT
    o.order_id,
    c.customer_name,
    c.city,
    o.order_date
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
ORDER BY o.order_date;



SELECT
    oi.order_item_id,
    oi.order_id,
    p.product_name,
    p.category,
    p.price,
    oi.quantity
FROM order_items oi
INNER JOIN products p
    ON oi.product_id = p.product_id
ORDER BY oi.order_id;



SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    o.order_id,
    o.order_date
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_date;



WITH customer_totals AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * p.price) AS total_spend
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN products p
        ON oi.product_id = p.product_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    customer_id,
    customer_name,
    total_spend
FROM customer_totals
WHERE total_spend > (
    SELECT AVG(total_spend)
    FROM customer_totals
)
ORDER BY total_spend DESC;


WITH customer_totals AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * p.price) AS total_spent
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN products p
        ON oi.product_id = p.product_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    customer_id,
    customer_name,
    total_spent,
    RANK() OVER (
        ORDER BY total_spent DESC
    ) AS spending_rank
FROM customer_totals
ORDER BY spending_rank;

