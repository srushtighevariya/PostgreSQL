CREATE TABLE departments (
  department_id   SERIAL PRIMARY KEY,
  department_name VARCHAR(50) NOT NULL,
  manager_id      INT
);

CREATE TABLE employees (
  employee_id   SERIAL PRIMARY KEY,
  first_name    VARCHAR(50) NOT NULL,
  last_name     VARCHAR(50) NOT NULL,
  department_id INT REFERENCES departments(department_id),
  hire_date     DATE NOT NULL
);

CREATE TABLE customers (
  customer_id SERIAL PRIMARY KEY,
  first_name  VARCHAR(50) NOT NULL,
  last_name   VARCHAR(50) NOT NULL,
  email       VARCHAR(100) UNIQUE NOT NULL,
  created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
  product_id SERIAL PRIMARY KEY,
  name       VARCHAR(100) NOT NULL,
  category   VARCHAR(50) NOT NULL,
  price      DECIMAL(10,2) NOT NULL,
  stock      INT NOT NULL
);

CREATE TABLE orders (
  order_id     SERIAL PRIMARY KEY,
  customer_id  INT REFERENCES customers(customer_id),
  order_date   DATE NOT NULL,
  total_amount DECIMAL(10,2) NOT NULL
);

CREATE TABLE order_items (
  order_item_id SERIAL PRIMARY KEY,
  order_id      INT REFERENCES orders(order_id),
  product_id    INT REFERENCES products(product_id),
  quantity      INT NOT NULL,
  unit_price    DECIMAL(10,2) NOT NULL
);

INSERT INTO departments (department_id, department_name) VALUES
  (1, 'Sales'),
  (2, 'Marketing'),
  (3, 'Engineering');


INSERT INTO employees (employee_id, first_name, last_name, department_id, hire_date) VALUES
  (1, 'Tom',   'Clark', 1, '2020-01-15'),
  (2, 'Lisa',  'White', 2, '2019-08-01'),
  (3, 'Mark',  'Lee',   3, '2021-03-10'),
  (4, 'Sara',  'Patel', 1, '2022-06-25'),
  (5, 'James', 'King',  2, '2023-02-18');


UPDATE departments SET manager_id = 1 WHERE department_id = 1;
UPDATE departments SET manager_id = 2 WHERE department_id = 2;
UPDATE departments SET manager_id = 3 WHERE department_id = 3;


INSERT INTO customers (customer_id, first_name, last_name, email, created_at) VALUES
  (1, 'John',  'Doe',    'john.doe@example.com',    '2024-12-01 10:00:00'),
  (2, 'Jane',  'Smith',  'jane.smith@example.com',  '2025-01-15 12:30:00'),
  (3, 'Alice', 'Johnson','alice.johnson@example.com','2025-02-20 09:45:00'),
  (4, 'Bob',   'Brown',  'bob.brown@example.com',   '2025-03-05 16:20:00'),
  (5, 'Carol', 'Davis',  'carol.davis@example.com', '2025-05-12 14:10:00');


INSERT INTO products (product_id, name, category,      price,   stock) VALUES
  (101, 'Wireless Mouse',               'Electronics',  25.99, 100),
  (102, 'Mechanical Keyboard',          'Electronics',  79.99,  50),
  (103, 'USB-C Cable',                  'Accessories',   9.99, 200),
  (104, 'HDMI Adapter',                 'Accessories',  14.99, 150),
  (105, 'Laptop Stand',                 'Office',       29.99,  30),
  (106, 'Noise Cancelling Headphones',  'Electronics', 199.99,  20);


INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
  (1001, 1, '2025-04-01', 131.97),
  (1002, 2, '2025-04-02',  79.99),
  (1003, 3, '2025-04-03',  19.98),
  (1004, 1, '2025-05-01', 199.99),
  (1005, 4, '2025-05-05',  44.97),
  (1006, 5, '2025-05-10',  79.94),
  (1007, 2, '2025-05-15', 303.95);


INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
  (1, 1001, 101, 2, 25.99),
  (2, 1001, 102, 1, 79.99),
  (3, 1002, 102, 1, 79.99),
  (4, 1003, 103, 2,  9.99),
  (5, 1004, 106, 1,199.99),
  (6, 1005, 104, 3, 14.99),
  (7, 1006, 103, 5,  9.99),
  (8, 1006, 105, 1, 29.99),
  (9, 1007, 101, 4, 25.99),
  (10,1007, 106, 1,199.99);




--------------------------- A) Basic SELECT (1–20)  -----------------------------------------------------------
-- 1. Retrieve all columns from the customers table.
select * from customers;

-- 2. List only first_name and last_name of every employee.
select employees.first_name, employees.last_name from employees;

-- 3. Select name and price from products.
select products.name,products.price from products;

-- 4. Show distinct category values from products.
select distinct products.category from products;

-- 5. How many rows are there in the orders table?
select count(orders.order_id) from orders;
select count(*) from orders;

-- 6. Find the average price of all products.
select avg(products.price) as Average_price from products ;

-- 7. What is the minimum unit_price in order_items?
select min(order_items.unit_price) as min_unit_price from order_items;

-- 8. What is the maximum total_amount in orders?
select max(orders.total_amount) as max_total_amount from orders;

-- 9. Count the number of customers created after January 1, 2025.
select count(*) from customers where created_at > '2025-01-01';

-- 10. Calculate the sum of all stock in the products table.
select sum(products.stock) from products;

-- 11. Select email from customers where it contains “example.com”.
select customers.email from customers where email like '%example.com';

-- 12. Retrieve orders placed on ‘2025-05-01’.
select orders.order_id from orders where order_date = '2025-05-01';

-- 13. Find employees hired before 2021.
select * from employees where hire_date < '2021-01-01';

-- 14. Show products with a price greater than 50.
select products.name, price from products where price > 50;

-- 15. List customers whose last_name starts with ‘D’.
select customers.last_name from customers where last_name like 'D%';

-- 16. Return all orders with total_amount between 50 and 200.
select orders.order_id from orders where total_amount between 50 and 200;

-- 17. Display products sorted by stock descending.
select products.product_id from products order by stock desc ;

-- 18. Show the top 3 most expensive products.
select * from products order by price desc limit 3;

-- 19. Retrieve all customers but only first 2 rows.
select * from customers limit 2;

-- 20. Fetch all employees, skipping the first 2 records.
select * from employees offset 2;



-- ------------------B) ORDER BY & LIMIT/OFFSET (21–30)----------------------------------------
-- 21. List products ordered by price ascending.
select * from products order by price;

-- 22. Show customers ordered by created_at descending.
select * from customers order by created_at desc ;

-- 23. Retrieve orders sorted by order_date (oldest first).
select * from orders order by order_date ;

-- 24. Get the 5 most recent orders.
select * from orders order by order_date desc limit 5;

-- 25. Show employees sorted by last_name, then first_name.
select * from employees order by last_name;
select * from employees order by first_name;
select * from employees order by last_name,first_name;

-- 26. List products in category ‘Electronics’ ordered by stock descending.
select * from products where category = 'Electronics' order by stock desc ;

-- 27. Display customers, limit 3, offset 1.
select * from customers limit 3 offset 1;

-- 28. Fetch orders with highest total_amount, limit 2.
select * from orders order by total_amount desc limit 2;

-- 29. Show departments ordered alphabetically.
select * from departments order by department_name;

-- 30. Retrieve order_items sorted by quantity descending.
select * from order_items order by quantity desc ;




-- -------------------------------C) Comparison Operators in WHERE (31–45)----------------------------------
-- 31. Customers with customer_id = 3.
select * from customers where customer_id = 3;

-- 32. Products with price >= 100.
select * from products where price >= 100;

-- 33. Orders where total_amount <> 79.99.
select * from orders where total_amount <> 79.99;

-- 34. Employees whose department_id <= 2.
select * from departments where department_id <= 2;

-- 35. Order_items with quantity < 3.
select * from order_items where quantity < 3;

-- 36. Products with stock BETWEEN 30 AND 100.
select * from products where stock > 30 and stock < 100;

-- 37. Orders not on ‘2025-04-01’.
select * from orders where order_date <> '2025-04-01';

-- 38. Customers created on or after ‘2025-02-01’.
select * from customers where created_at >= '2025-02-01 00:00:00';

-- 39. Products where category = ‘Office’.
select * from products where category = 'Office';

-- 40. Orders with total_amount > average order total.
select * from orders where total_amount > (select avg(total_amount) from orders);

-- 41. Employees hired = exactly ‘2022-06-25’.
select * from employees where hire_date = '2022-06-25';

-- 42. Products where name LIKE ‘%Headphones%’.
select * from products where name like '%Headphones';

-- 43. Customers with email NOT LIKE ‘%example.com’.
select * from customers where email not like '%example.com';

-- 44. Orders with order_id IN (1001, 1004, 1007).
select * from orders where order_id in (1001,1004,1007);

-- 45. Products with product_id NOT IN (101, 103).
select * from products where product_id not in (101,103);



-- -------------------------------------D) Logical Operators (46–55)---------------------------------------------
-- 46. Customers with first_name = ‘John’ AND last_name = ‘Doe’.
select * from customers where first_name = 'John' and last_name = 'Doe';

-- 47. Orders with total_amount > 50 OR < 20.
select * from orders where total_amount > 50 or total_amount < 20;

-- 48. Products where category = ‘Electronics’ AND stock > 20.
select * from products where category = 'Electronics' and stock >20;

-- 49. Employees hired before 2021 OR after 2022.
select * from employees where hire_date < '2021-01-01' or hire_date > '2022-01-01';

-- 50. Customers whose email ends in ‘.com’ AND created after 2025-01-01.
select * from customers where email like '%.com' and created_at > '2025-01-01';

-- 51. Products NOT in category ‘Accessories’.
select * from products where category not in ('Accessories');
select * from products where category <> 'Accessories';

-- 52. Orders where NOT (total_amount BETWEEN 50 AND 200).
select * from orders where total_amount between 50 and 200;

-- 53. Customers with (first_name = ‘Alice’ OR first_name = ‘Bob’).
 select * from customers where first_name = 'Alice' or first_name = 'Bob';

-- 54. Products with (stock < 50 AND price > 25).
select * from products where stock < 50 and price > 25;

-- 55. Orders where order_date >= ‘2025-05-01’ AND total_amount >= 100.
select * from orders where order_date >= '2025-05-01' and total_amount >= 100;




-- -------------------------------------E) INNER, LEFT, RIGHT, FULL & CROSS JOINs (56–80)-------------------------------------------
-- 56. List each order and its customer’s name (inner join).

-- 57. For every order, show all products ordered (inner join order_items⇢products).

-- 58. Show all customers and any orders they’ve placed (left join).

-- 59. List all orders and customers; include orders with no matching customer (right join).

-- 60. Return every department and its manager’s name (inner join employees⇢departments).

-- 61. Show all departments even if they have no employees (left join).

-- 62. List every product and order_items, even if a product was never ordered (left join).

-- 63. Show all customers and orders, even if no orders exist (full join).
-- 64. List departments that have no manager (left join + IS NULL).
-- 65. Show order_items for orders with no matching product (right join + IS NULL).
-- 66. Perform a cross join between products and departments (no ON clause).
-- 67. Count how many orders each customer has made (inner join + GROUP BY).
-- 68. For each product, count how many times it appears in orders (inner join + GROUP BY).
-- 69. Show employees and their department names (inner join).
-- 70. List orders with customer name and item count (join + COUNT + GROUP BY).
-- 71. Retrieve customers who have placed orders totaling over 200 (join + HAVING).
-- 72. Find products never ordered (left join + IS NULL filter).
-- 73. Display each employee and how many orders they’ve processed (join through a hypothetical order_assignees table).
-- 74. Show order date and product name for every item sold (multi-table join).
-- 75. List each department and the total salary of its employees (join + SUM).
-- 76. Combine products and accessories category using a self-join on category (self‐join).
-- 77. Find pairs of customers who signed up on the same day (self‐join on created_at).
-- 78. Show each order with customer and department of the manager who handled the sale (3-table join).
-- 79. Cross join customers and departments to create all possible pairs.
-- 80. List each order, product, and supplier (assume a suppliers table and join chain).


-- --------------------------------------F) Combined Filtering, Ordering & Joins (81–100)-----------------------------------------
-- 81. Customers with orders over 100, sorted by last order date.
-- 82. Top 5 customers by total spend (join + SUM + ORDER BY + LIMIT).
-- 83. Products low in stock (< 20) and ordered in the last month.
-- 84. Employees in Sales or Marketing department hired after 2020.
-- 85. Orders between 2025-04-01 and 2025-05-01 for ‘Electronics’ products.
-- 86. Customers without orders, ordered by sign-up date.
-- 87. Sum of quantities for each product, only if > 10 sold.
-- 88. Average order total per customer, sorted descending.
-- 89. Products priced above category average (subquery + comparison).
-- 90. Orders containing both ‘Wireless Mouse’ and ‘USB-C Cable’.
-- 91. Show customers who placed more than one order in May 2025.
-- 92. List the second highest priced product (use OFFSET).
-- 93. Find the earliest hire_date in each department.
-- 94. Customers whose last order was more than 30 days ago.
-- 95. Departments with fewer than 3 employees.
-- 96. Products with a name containing ‘Adapter’ OR ‘Cable’, sorted by price.
-- 97. Orders joined with items where quantity ≥ 3, sorted by quantity.
-- 98. Employees who are not managers (left join departments + IS NULL).
-- 99. Show all orders with total_amount ≠ sum of their order_items (join + GROUP BY + HAVING).
-- 100. List customers and their last order’s total_amount using a window function (e.g., ROW_NUMBER()).
