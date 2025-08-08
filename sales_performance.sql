CREATE DATABASE practice;
USE practice;
#Create the product table first
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10.2)
);

#Insert into the table its values
INSERT INTO products(product_id, product_name, category, unit_price) VALUES
(101, 'Laptop', 'Electronics', 500.00), 
(102, 'Smartphone', 'Electronics', 300.00), 
(103, 'Headphones', 'Electronics', 30.00), 
(104, 'Keyboard', 'Electronics', 20.00), 
(105, 'Mouse', 'Electronics', 15.00);

drop table if exists sales;
drop table if exists products;


#Create the sales table
CREATE TABLE sales( 
    sales_id INT PRIMARY KEY, 
    product_id INT, 
    quantity_sold INT, 
    sales_date DATE, 
    total_price DECIMAL(10, 2), 
    FOREIGN KEY (product_id) REFERENCES Products(product_id));
    
    #Insert the values
    INSERT INTO Sales (sales_id, product_id, quantity_sold, sales_date, total_price) VALUES 
(1, 101, 5, '2024-01-01', 2500.00), 
(2, 102, 3, '2024-01-02', 900.00), 
(3, 103, 2, '2024-01-02', 60.00), 
(4, 104, 4, '2024-01-03', 80.00), 
(5, 105, 6, '2024-01-03', 90.00);

#1. Retrieve all columns from the Sales table. 
SELECT * FROM sales;

#2. Retrieve the product_name and unit_price from the Products table. 
SELECT product_name, unit_price FROM products;

#3. Retrieve the sale_id and sale_date from the Sales table. 
SELECT sales_id, sales_date FROM sales;

# Filter the Sales table to show only sales with a total_price greater than $100.
SELECT * FROM sales WHERE total_price > 100;

#5. Filter the Products table to show only products in the 'Electronics' category.
SELECT * FROM products WHERE category = 'Electronics';

#6. Retrieve the sale_id and total_price from the Sales table for sales made on January 3, 2024. 
SELECT sales_id, total_price FROM sales WHERE sales_date = '2024-01-03';

#7. Retrieve the product_id and product_name from the Products table for products with a unit_price 
#greater than $100.
SELECT product_id, product_name FROM products WHERE unit_price > 100;

#8. Calculate the total revenue generated from all sales in the Sales table. 
SELECT SUM(total_price) AS total_revenue FROM sales;

#9. Calculate the average unit_price of products in the Products table. 
SELECT AVG(unit_price) AS average_price FROM products;

#10. Calculate the total quantity_sold from the Sales table. 
SELECT SUM(quantity_sold) AS total_quantity_sold FROM sales;

#11. Count Sales Per Day from the Sales table 
SELECT sales_date, COUNT(*) AS sales_count FROM sales GROUP BY sales_date;
DESCRIBE sales;

#12. Retrieve product_name and unit_price from the Products table with the Highest Unit Price 
SELECT 
    product_name, unit_price
FROM
    products
ORDER BY unit_price DESC
LIMIT 1;

#13. Retrieve the sale_id, product_id, and total_price from the Sales table for sales with a quantity_sold 
SELECT 
    sales_id, product_id, total_price
FROM
    sales
WHERE
    quantity_sold > 4;

#14. Retrieve the product_name and unit_price from the Products table, ordering the results by unit_price 
SELECT 
    product_name, unit_price
FROM
    products
ORDER BY unit_price DESC;
#in descending order. 

#15. Retrieve the total_price of all sales, rounding the values to two decimal places. 
SELECT 
    ROUND(SUM(total_price), 2) AS total_sales
FROM
    sales;

#16. Calculate the average total_price of sales in the Sales table. 
SELECT 
    ROUND(AVG(total_price), 2) AS average_sales_price
FROM
    sales;


#17. Retrieve the sale_id and sale_date from the Sales table, formatting the sale_date as 'YYYY-MM-DD'. 
SELECT 
    sales_id,
    DATE_FORMAT(sales_date, '%y-%m-%d') AS formatted_date
FROM
    sales;

#18. Calculate the total revenue generated from sales of products in the 'Electronics' category. 
SELECT SUM(s.total_price) AS Electronics_revenue FROM sales s JOIN products p ON s.product_id = p.product_id WHERE p.category = 'Electronics';

#19. Retrieve the product_name and unit_price from the Products table, filtering the unit_price to show 
#only values between $20 and $600. 
SELECT product_name, unit_price FROM products WHERE unit_price BETWEEN 20 AND 600;

#20. Retrieve the product_name and category from the Products table, ordering the results by category in 
# order.
SELECT product_name, category FROM products ORDER BY category ASC;


#Part B

#1. Calculate the total quantity_sold of products in the 'Electronics' category. 
SELECT 
    SUM(s.quantity_sold) AS total_quantity_electronics
FROM
    sales s
        JOIN
    products p ON s.product_id = p.product_id
WHERE
    p.category = 'Electronics';

#2. Retrieve the product_name and total_price from the Sales table, calculating the total_price as 
#quantity_sold multiplied by unit_price. 
SELECT 
    p.product_name,
    s.quantity_sold * p.unit_price AS calculated_total_price
FROM
    sales s
        JOIN
    products p ON s.product_id = p.product_id;

#3. Identify the Most Frequently Sold Product from Sales table 
SELECT 
    p.product_name, SUM(s.quantity_sold) AS total_quantity_sold
FROM
    sales s
        JOIN
    products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 1;

#4. Find the Products Not Sold from Products table 
SELECT 
    p.product_name
FROM
    products p
        LEFT JOIN
    sales s ON p.product_id = s.product_id
WHERE
    s.product_id IS NULL;

#5. Calculate the total revenue generated from sales for each product category. 
SELECT 
    p.category, SUM(s.total_price) AS total_revenue
FROM
    sales s
        JOIN
    products p ON s.product_id = p.product_id
GROUP BY p.category;

#6. Find the product category with the highest average unit price. 
SELECT 
    category, AVG(unit_price) AS avg_unit_price
FROM
    products
GROUP BY category
ORDER BY avg_unit_price DESC
LIMIT 1;

#7. Identify products with total sales exceeding 30. 
SELECT 
    p.product_name, SUM(s.total_price) AS total_sold
FROM
    sales s
        JOIN
    products p ON s.product_id = p.product_id
GROUP BY p.product_name
HAVING total_sold > 30;

#8. Count the number of sales made in each month. 
SELECT 
    MONTH(sales_date) AS sales_month, COUNT(*) AS num_sales
FROM
    sales
GROUP BY sales_month
ORDER BY sales_month;

#9. Retrieve Sales Details for Products with 'Smart' in Their Name 
SELECT 
    *
FROM
    products
WHERE
    product_name LIKE '%Smart%';

#10. Determine the average quantity sold for products with a unit price greater than $100. 
SELECT 
    p.product_name, AVG(s.quantity_sold) AS avg_qty
FROM
    sales s
        JOIN
    products p ON s.product_id = p.product_id
WHERE
    p.unit_price > 100
GROUP BY p.product_name;

#11. Retrieve the product name and total sales revenue for each product. 
SELECT 
    p.product_name,
    SUM(s.quantity_sold * p.unit_price) AS total_revenue
FROM
    sales s
        JOIN
    products p ON s.product_id = p.product_id
GROUP BY p.product_name;

#12. List all sales along with the corresponding product names. 
SELECT 
    s.*, p.product_name
FROM
    sales s
        JOIN
    products p ON s.product_id = p.product_id;

#13. Retrieve the product name and total sales revenue for each product. 
SELECT 
    p.product_name,
    SUM(s.quantity_sold * p.unit_price) AS total_revenue
FROM
    sales s
        JOIN
    products p ON s.product_id = p.product_id
GROUP BY p.product_name;

#14. Rank products based on total sales revenue. 
SELECT p.product_name, SUM(s.quantity_sold * p.unit_price) AS total_revenue, RANK() OVER (ORDER BY SUM(s.quantity_sold * p.unit_price) DESC) AS revenue_rank FROM sales s JOIN products p ON s.product_id = p.product_id GROUP BY p.product_name;

#15. Calculate the running total revenue for each product category. 
SELECT category, sales_date, sum(quantity_sold * unit_price) as daily_revenue, sum(sum(quantity_sold * unit_price)) over (partition by category order by sales_date) as running_total from sales s join products p on s.product_id = p.product_id group by category, sales_date;

#16. Categorize sales as "High", "Medium", or "Low" based on total price (e.g., > $200 is High, $100-$200 
#is Medium, < $100 is Low). 
SELECT 
    *,
    CASE
        WHEN quantity_sold * unit_price > 200 THEN 'High'
        WHEN quantity_sold * unit_price BETWEEN 100 AND 200 THEN 'Meduim'
        ELSE 'low'
    END AS sales_catgory
FROM
    sales s
        JOIN
    products p ON s.product_id = p.product_id;

#17. Identify sales where the quantity sold is greater than the average quantity sold. 
SELECT 
    *
FROM
    sales
WHERE
    quantity_sold > (SELECT 
            AVG(quantity_sold)
        FROM
            sales); 

#18. Extract the month and year from the sale date and count the number of sales for each month. 
SELECT 
    YEAR(sales_date) AS sales_year,
    MONTH(sales_date) AS sales_month,
    COUNT(*) AS num_sales
FROM
    sales
GROUP BY sales_year , sales_month
ORDER BY sales_year , sales_month;

#19. Calculate the number of days between the current date and the sale date for each sale. 
SELECT 
    sales_id,
    DATEDIFF(CURDATE(), sales_date) AS days_since_sales
FROM
    sales;

#20. Identify sales made during weekdays versus weekends.
SELECT 
    sales_id,
    sales_date,
    CASE
        WHEN DAYOFWEEK(sales_date) IN (1 , 7) THEN 'weekend'
        ELSE 'weekday'
    END AS sales_day_type
FROM
    sales;

#PART B - SQL Practice Exercises for Intermediate