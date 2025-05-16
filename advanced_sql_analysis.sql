-- Create tables
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50)
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    sale_date DATE,
    amount DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert sample data into products
INSERT INTO products VALUES
(1, 'Laptop', 'Electronics'),
(2, 'Mobile', 'Electronics'),
(3, 'Shoes', 'Footwear');

-- Insert sample data into sales
INSERT INTO sales VALUES
(101, 1, 1, '2024-01-10', 50000.00),
(102, 1, 1, '2024-01-15', 52000.00),
(103, 2, 2, '2024-01-20', 30000.00),
(104, 3, 3, '2024-01-25', 4500.00),
(105, 1, 1, '2024-02-01', 51000.00),
(106, 2, 1, '2024-02-10', 15000.00);

--Window Function — Running Total
SELECT sale_date, product_id, amount,
       SUM(amount) OVER (PARTITION BY product_id ORDER BY sale_date) AS running_total
FROM sales;

--Subquery — Top-Selling Product
SELECT product_id, amount
FROM sales
WHERE product_id = (
    SELECT product_id
    FROM sales
    GROUP BY product_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
);

--CTE (Common Table Expression) — Monthly Sales
WITH monthly_sales AS (
    SELECT product_id, DATE_FORMAT(sale_date, '%Y-%m') AS sale_month, SUM(amount) AS total_sales
    FROM sales
    GROUP BY product_id, sale_month
)
SELECT * FROM monthly_sales;

