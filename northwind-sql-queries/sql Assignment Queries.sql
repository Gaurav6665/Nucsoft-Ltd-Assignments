-- 1.Get the total number of orders placed by each customer:

SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id;

-- 2.Find all suppliers who provide products in the 'Seafood' category:

SELECT DISTINCT suppliers.*
FROM suppliers
INNER JOIN products ON suppliers.supplier_id = products.supplier_id
INNER JOIN categories ON products.category_id = categories.category_id
WHERE categories.category_name = 'Seafood';

-- 3.Get the total quantity of each product sold:

SELECT product_id, SUM(quantity) AS total_quantity
FROM order_details
GROUP BY product_id;

-- 4.Find the total sales (Quantity * Unit_Price) for each category of products:

SELECT categories.category_name, SUM(order_details.quantity * products.unit_price) AS total_sales
FROM order_details
INNER JOIN products ON order_details.product_id = products.product_id
INNER JOIN categories ON products.category_id = categories.category_id
GROUP BY categories.category_name;

-- 5.List the employees and the number of orders each employee has taken:

SELECT employees.employee_id, CONCAT(employees.first_name, ' ', employees.last_name) AS employee_name, COUNT(orders.order_id) AS total_orders
FROM employees
LEFT JOIN orders ON employees.employee_id = orders.employee_id
GROUP BY employees.employee_id;

-- 6.Get the customers who have placed more than 10 orders:

SELECT customers.*
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id
HAVING COUNT(orders.order_id) > 10;

-- 7.Get the top 5 most sold products:

SELECT products.*, SUM(order_details.quantity) AS total_sold
FROM products
INNER JOIN order_details ON products.product_id = order_details.product_id
GROUP BY products.product_id
ORDER BY total_sold DESC
LIMIT 5;

-- 8.Find the products that have never been ordered:

SELECT products.*
FROM products
LEFT JOIN order_details ON products.product_id = order_details.product_id
WHERE order_details.product_id IS NULL;

-- 9.Find the customers who have not placed any orders:

SELECT customers.*
FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id
WHERE orders.order_id IS NULL;


-- 10.List all 'Orders' with 'Customer' details and 'Employee' who processed it:

SELECT orders.*, customers.*, CONCAT(employees.first_name, ' ', employees.last_name) AS employee_name
FROM orders
INNER JOIN customers ON orders.customer_id = customers.customer_id
INNER JOIN employees ON orders.employee_id = employees.employee_id;

-- 11.Calculate the average product price by category:

SELECT categories.category_name, AVG(products.unit_price) AS average_price
FROM products
INNER JOIN categories ON products.category_id = categories.category_id
GROUP BY categories.category_name;

-- 12.Find the total revenue generated by each employee:

SELECT employees.employee_id, CONCAT(employees.first_name, ' ', employees.last_name) AS employee_name, SUM(order_details.quantity * products.unit_price) AS total_revenue
FROM employees
INNER JOIN orders ON employees.employee_id = orders.employee_id
INNER JOIN order_details ON orders.order_id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.product_id
GROUP BY employees.employee_id;


-- 13.List all orders shipped to 'Germany':

SELECT orders.*
FROM orders
INNER JOIN shippers ON orders.ship_via = shippers.shipper_id
WHERE shippers.country = 'Germany';


-- 14.Find the most expensive product in each category:

SELECT categories.category_name, products.product_name, products.unit_price
FROM categories
INNER JOIN products ON categories.category_id = products.category_id
WHERE products.unit_price = (
  SELECT MAX(unit_price)
  FROM products AS p
  WHERE p.category_id = products.category_id
);

-- 15.Find the total revenue for the year 2016:

SELECT SUM(order_details.quantity * products.unit_price) AS total_revenue
FROM order_details
INNER JOIN products ON order_details.product_id = products.product_id
INNER JOIN orders ON order_details.order_id = orders.order_id
WHERE YEAR(orders.order_date) = 2016;

-- 16.List all products that are discontinued:

SELECT *
FROM products
WHERE discontinued = 1;

-- 17.List all the distinct countries to which orders have been shipped:

SELECT DISTINCT ship_country
FROM orders;

-- 18.Find all employees who report to 'Andrew Fuller':

SELECT employees.*
FROM employees
INNER JOIN employees AS manager ON employees.reports_to = manager.employee_id
WHERE manager.last_name = 'Fuller' AND manager.first_name = 'Andrew';

-- 19.Find the customers who have spent more than $5000 in total:

SELECT customers.customer_id, CONCAT(customers.contact_name, ' (', customers.company_name, ')') AS customer_name, SUM(order_details.quantity * products.unit_price) AS total_spent
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
INNER JOIN order_details ON orders.order_id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.product_id
GROUP BY customers.customer_id
HAVING total_spent > 5000;

-- 20.List the top 5 employees who have processed the most orders:

SELECT employees.employee_id, CONCAT(employees.first_name, ' ', employees.last_name) AS employee_name, COUNT(orders.order_id) AS total_orders
FROM employees
INNER JOIN orders ON employees.employee_id = orders.employee_id
GROUP BY employees.employee_id
ORDER BY total_orders DESC
LIMIT 5;


-- 21.Get the list of customers who have ordered the 'Chai' product:

SELECT customers.*
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
INNER JOIN order_details ON orders.order_id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.product_id
WHERE products.product_name = 'Chai';

-- 22.Get the employees who have processed orders for the 'Chai' product:

SELECT employees.*
FROM employees
INNER JOIN orders ON employees.employee_id = orders.employee_id
INNER JOIN order_details ON orders.order_id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.product_id
WHERE products.product_name = 'Chai';

-- 23.Find the most common shipping country:

SELECT ship_country, COUNT(*) AS count
FROM orders
GROUP BY ship_country
ORDER BY count DESC
LIMIT 1;

-- 24.Find the order with the highest total cost:

SELECT orders.*, SUM(order_details.quantity * products.unit_price) AS total_cost
FROM orders
INNER JOIN order_details ON orders.order_id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.product_id
GROUP BY orders.order_id
ORDER BY total_cost DESC
LIMIT 1;

-- 25.Find the employees who have processed more than 100 orders:

SELECT employees.*
FROM employees
INNER JOIN orders ON employees.employee_id = orders.employee_id
GROUP BY employees.employee_id
HAVING COUNT(orders.order_id) > 100;

-- 26.Find the customer who has ordered the most 'Chai' product:

SELECT customers.*, SUM(order_details.quantity) AS total_chai_ordered
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
INNER JOIN order_details ON orders.order_id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.product_id
WHERE products.product_name = 'Chai'
GROUP BY customers.customer_id
ORDER BY total_chai_ordered DESC
LIMIT 1;

-- 27.Find the average quantity of products ordered in each order:

SELECT order_id, AVG(quantity) AS average_quantity
FROM order_details
GROUP BY order_id;

-- 28.Find the top 3 most popular categories of products ordered:

SELECT categories.category_name, COUNT(*) AS order_count
FROM categories
INNER JOIN products ON categories.category_id = products.category_id
INNER JOIN order_details ON products.product_id = order_details.product_id
GROUP BY categories.category_name
ORDER BY order_count DESC
LIMIT 3;

-- 29.Find the month in the year 2016 with the highest total sales:

SELECT MONTH(order_date) AS month, SUM(order_details.quantity * products.unit_price) AS total_sales
FROM orders
INNER JOIN order_details ON orders.order_id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.product_id
WHERE YEAR(order_date) = 2016
GROUP BY MONTH(order_date)
ORDER BY total_sales DESC
LIMIT 1;

-- 30.Find the employee who processed the most orders in August 2016:

SELECT employees.*, COUNT(orders.order_id) AS total_orders
FROM employees
INNER JOIN orders ON employees.employee_id = orders.employee_id
WHERE YEAR(orders.order_date) = 2016 AND MONTH(orders.order_date) = 8
GROUP BY employees.employee_id
ORDER BY total_orders DESC
LIMIT 1;

-- 31.Find the top 3 customers who have ordered the most products:

SELECT customers.customer_id, CONCAT(customers.contact_name, ' (', customers.company_name, ')') AS customer_name, COUNT(order_details.product_id) AS total_products_ordered
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
INNER JOIN order_details ON orders.order_id = order_details.order_id
GROUP BY customers.customer_id
ORDER BY total_products_ordered DESC
LIMIT 3;

-- 32.Find the employees who have not processed any orders:

SELECT employees.*
FROM employees
LEFT JOIN orders ON employees.employee_id = orders.employee_id
WHERE orders.order_id IS NULL;

-- 33.Find the suppliers who supply the top 5 most sold products:

SELECT suppliers.supplier_id, suppliers.company_name, COUNT(order_details.product_id) AS total_sold_products
FROM suppliers
INNER JOIN products ON suppliers.supplier_id = products.supplier_id
INNER JOIN order_details ON products.product_id = order_details.product_id
GROUP BY suppliers.supplier_id, suppliers.company_name
ORDER BY total_sold_products DESC
LIMIT 5;

-- 34.Find the customers who have ordered products from all categories:

SELECT customers.customer_id, CONCAT(customers.contact_name, ' (', customers.company_name, ')') AS customer_name
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
INNER JOIN order_details ON orders.order_id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.product_id
GROUP BY customers.customer_id, customers.contact_name, customers.company_name
HAVING COUNT(DISTINCT products.category_id) = (SELECT COUNT(*) FROM categories);

-- 35.Find the total sales for each year:

SELECT YEAR(order_date) AS order_year, SUM(order_details.quantity * products.unit_price) AS total_sales
FROM orders
INNER JOIN order_details ON orders.order_id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.product_id
GROUP BY YEAR(order_date);

--36.Classify customers based on their total order amounts such that total order amounts > 5000 should be classified as 'High Value', if > 1000 then as 'Medium Value' and otherwise as 'Low Value':

SELECT customers.customer_id, CONCAT(customers.contact_name, ' (', customers.company_name, ')') AS customer_name,
  SUM(order_details.quantity * products.unit_price) AS total_order_amount,
  CASE
    WHEN SUM(order_details.quantity * products.unit_price) > 5000 THEN 'High Value'
    WHEN SUM(order_details.quantity * products.unit_price) > 1000 THEN 'Medium Value'
    ELSE 'Low Value'
  END AS classification
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
INNER JOIN order_details ON orders.order_id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.product_id
GROUP BY customers.customer_id, customers.contact_name, customers.company_name;

-- 37.Classify products based on their sales volume such that TotalQuantity > 1000 is classified as 'High Sales'. If TotalQuantity > 500, it is classified as 'Medium Sales', and for all other cases, it is classified as 'Lower Sales':

SELECT products.product_id, products.product_name, SUM(order_details.quantity) AS total_quantity,
  CASE
    WHEN SUM(order_details.quantity) > 1000 THEN 'High Sales'
    WHEN SUM(order_details.quantity) > 500 THEN 'Medium Sales'
    ELSE 'Lower Sales'
  END AS sales_category
FROM products
INNER JOIN order_details ON products.product_id = order_details.product_id
GROUP BY products.product_id, products.product_name;

-- 38.Classify employees based on the number of orders they have processed such that NumberOfOrders > 100 is classified as 'High Performing'. If NumberOfOrders > 50, it is classified as 'Medium Performing', and for all other cases, it is classified as 'Lower Performing':

SELECT employees.employee_id, CONCAT(employees.first_name, ' ', employees.last_name) AS employee_name,
  COUNT(orders.order_id) AS number_of_orders,
  CASE
    WHEN COUNT(orders.order_id) > 100 THEN 'High Performing'
    WHEN COUNT(orders.order_id) > 50 THEN 'Medium Performing'
    ELSE 'Lower Performing'
  END AS performance_category
FROM employees
LEFT JOIN orders ON employees.employee_id = orders.employee_id
GROUP BY employees.employee_id, employee_name;Classify products based on their sales volume such that TotalQuantity > 1000 is classified as 'High Sales'. If TotalQuantity > 500, it is classified as 'Medium Sales', and for all other cases, it is classified as 'Lower Sales':

SELECT products.product_id, products.product_name, SUM(order_details.quantity) AS total_quantity,
  CASE
    WHEN SUM(order_details.quantity) > 1000 THEN 'High Sales'
    WHEN SUM(order_details.quantity) > 500 THEN 'Medium Sales'
    ELSE 'Lower Sales'
  END AS sales_category
FROM products
INNER JOIN order_details ON products.product_id = order_details.product_id
GROUP BY products.product_id, products.product_name;
