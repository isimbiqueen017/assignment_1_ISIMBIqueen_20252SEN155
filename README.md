# Sunrise Supermarket Database

## Project Overview

**Sunrise Supermarket Database** is a MySQL database project designed to manage customers, products, orders, and order items in a supermarket.

The project demonstrates how SQL can be used to store, organize, retrieve, and analyze supermarket sales data.

## Technologies Used

* MySQL 8.0+
* SQL
* MySQL Workbench / phpMyAdmin
* Git and GitHub

## Database Name

```sql
sunrise_supermarket
```

## Database Structure

The database contains four main tables:

### 1. Customers

Stores information about supermarket customers.

| Column        | Description        |
| ------------- | ------------------ |
| customer_id   | Unique customer ID |
| customer_name | Customer's name    |
| email         | Customer's email   |
| city          | Customer's city    |

### 2. Products

Stores information about products sold by the supermarket.

| Column       | Description         |
| ------------ | ------------------- |
| product_id   | Unique product ID   |
| product_name | Name of the product |
| category     | Product category    |
| price        | Product price       |

### 3. Orders

Stores customer order information.

| Column      | Description                             |
| ----------- | --------------------------------------- |
| order_id    | Unique order ID                         |
| customer_id | ID of the customer who placed the order |
| order_date  | Date the order was placed               |

### 4. Order Items

Stores the products included in each order.

| Column        | Description          |
| ------------- | -------------------- |
| order_item_id | Unique order-item ID |
| order_id      | ID of the order      |
| product_id    | ID of the product    |
| quantity      | Quantity purchased   |

## Relationships

The database uses the following relationships:

```text
Customers
    |
    | 1
    |
    |----< Orders
              |
              | 1
              |
              |----< Order_Items >---- Products
```

* One customer can place many orders.
* One order can contain many order items.
* One product can appear in many order items.

## SQL Concepts Demonstrated

This project demonstrates several important SQL concepts:

### JOIN

Used to combine information from multiple tables.

Examples:

* `INNER JOIN`
* `LEFT JOIN`

### Common Table Expressions (CTE)

The `WITH` statement is used to create temporary result sets that can be used by another query.

Example:

```sql
WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * p.price) AS total_spending
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN products p
        ON oi.product_id = p.product_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT *
FROM customer_spending;
```

### Window Functions

The project demonstrates:

* `RANK()`
* `ROW_NUMBER()`
* `SUM() OVER()`
* `LAG()`

These functions are useful for analyzing sales and customer activity without collapsing the result into a single row per group.

### Date Functions

The project uses:

```sql
DATEDIFF()
```

to calculate the number of days between customer orders.

## Main Queries

The project includes queries for:

1. Displaying customers and their orders using `INNER JOIN`.
2. Displaying products purchased in each order.
3. Finding customers who have or have not placed orders using `LEFT JOIN`.
4. Finding customers whose spending is above the average.
5. Ranking customers according to their total spending.
6. Numbering each customer's orders chronologically.
7. Calculating running total revenue.
8. Calculating the number of days between consecutive customer orders.

## Installation and Setup

### Step 1: Install MySQL

Install **MySQL 8.0 or later**.

### Step 2: Open MySQL Workbench

Open MySQL Workbench or another MySQL-compatible database tool.

### Step 3: Run the SQL Script

Open the project SQL file and execute the complete script.

The script will:

1. Create the database.
2. Select the database.
3. Create the tables.
4. Insert customers.
5. Insert products.
6. Insert orders.
7. Insert order items.
8. Execute analytical queries.

### Step 4: Select the Database

You can manually select the database using:

```sql
USE sunrise_supermarket;
```

## Requirements

MySQL **8.0+** is recommended because the project uses:

* CTEs
* Window functions
* `RANK()`
* `ROW_NUMBER()`
* `LAG()`
* `SUM() OVER()`

## Learning Objectives

After completing this project, the learner should be able to:

* Create a relational database.
* Create tables using SQL.
* Define primary keys.
* Define foreign keys.
* Insert records into tables.
* Retrieve data using `SELECT`.
* Combine tables using `JOIN`.
* Use CTEs for complex queries.
* Use window functions for data analysis.
* Calculate customer spending.
* Rank customers based on sales.
* Analyze order dates.
* Calculate running revenue.

## Project Files

```text
sunrise-supermarket/
│
├── sunrise_supermarket.sql
└── README.md
```

## Example Database Query

To display all customers:

```sql
SELECT *
FROM customers;
```

To display all products:

```sql
SELECT *
FROM products;
```

To display orders with customer names:

```sql
SELECT
    c.customer_name,
    o.order_id,
    o.order_date
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id;
```

## Conclusion

The Sunrise Supermarket Database project provides a practical example of how MySQL can be used to manage supermarket information.

It combines database design, data insertion, relationships, joins, CTEs, and window functions to perform useful sales and customer analysis.

## Author

**ISIMBI Queen**

## License

This project is created for educational and academic purposes.
