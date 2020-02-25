/*SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));*/

-- 1. Who is at the top of the organization (i.e., reports to no one).
/*SELECT CONCAT(firstName, ' ', lastName)
FROM ClassicModels.Employees
WHERE reportsTo IS NULL;*/

-- 2. Who reports to William Patterson?
/*SELECT CONCAT(a.firstName, ' ', a.lastName) AS name
FROM ClassicModels.Employees a, ClassicModels.Employees b
WHERE a.reportsTo = b.employeeNumber AND b.firstName = 'WIlliam' AND b.lastName = 'Patterson';*/

/*SELECT CONCAT(firstName, ' ', lastName) AS 'Names'
FROM ClassicModels.Employees
WHERE reportsTo = (
SELECT employeenumber 
FROM ClassicModels.Employees
WHERE firstname = 'William' AND lastName = 'Patterson');*/

-- 3. List all the products purchased by Herkku Gifts.
/*SELECT p.productName, c.customerName
FROM ClassicModels.Customers c
LEFT JOIN ClassicModels.Orders o ON c.customerNumber = o.customerNumber
LEFT JOIN ClassicModels.OrderDetails od ON o.orderNumber = od.orderNumber
LEFT JOIN ClassicModels.Products p ON od.productCode = p.productCode
WHERE c.customerName = 'Herkku Gifts';*/

-- 4. Compute the commission for each sales representative, assuming the commission is 5% of the value of an order. 
-- Sort by employee last name and first name.
/*FROM ClassicModels.Employees e 
LEFT JOIN CLassicModels.Customers c ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN ClassicModels.Orders o ON c.customerNumber = o.customerNumber
LEFT JOIN ClassicModels.OrderDetails od ON o.orderNumber = od.orderNumber
GROUP BY e.employeeNumber
ORDER BY e.lastName, e.firstName;*/

/*SELECT SUM((p.amount * 0.05)) AS 'commission fee', CONCAT(e.firstName, ' ', e.lastName) AS 'sales representative'
FROM ClassicModels.Payments p
LEFT JOIN ClassicModels.Customers c
ON p.customerNumber = c.customerNumber
LEFT JOIN ClassicModels.Employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY CONCAT(e.firstName, ' ', e.lastName)
ORDER BY e.lastName, e.firstName;*/

-- 5. What is the difference in days between the most recent and oldest order date in the Orders file?
/*SELECT DATEDIFF(MAX(orderDate), MIN(orderDate))
FROM ClassicModels.Orders;*/

-- 6. Compute the average time between order date and ship date for each customer ordered by the largest difference.
/*SELECT AVG(time)
FROM (SELECT DATEDIFF(MAX(o.orderDate), MIN(o.orderDate)) AS 'time', o.customerNumber
FROM ClassicModels.Orders o
GROUP BY o.customerNumber) a;*/

-- 7. What is the value of orders shipped in August 2004?
/*SELECT SUM(od.quantityOrdered * od.priceEach) AS value_of_orders
FROM ClassicModels.OrderDetails od
LEFT JOIN ClassicModels.Orders o ON od.orderNumber = o.orderNumber
WHERE o.shippedDate LIKE '2004-08%'
GROUP BY o.shippedDate;*/

-- 8. Compute the total value ordered, total amount paid, and their difference for each customer for order placed in 2004 and payments received in 2004.
-- (Hint: Create view for the total paid and total ordered).
/*CREATE OR REPLACE VIEW ClassicModels.Total_Paid_AND_Total_Ordered AS
SELECT SUM(quantityOrdered * priceEach) AS order_value, SUM(amount) AS paid
FROM ClassicModels.OrderDetails od
LEFT JOIN ClassicModels.Orders o ON od.orderNumber = o.orderNumber
LEFT JOIN ClassicModels.Payments p on o.customerNumber = p.customerNumber
WHERE orderDate LIKE '2004%' AND paymentDate LIKE '2004%'
GROUP BY o.customerNumber;

SELECT *, (order_value - paid) AS difference
FROM ClassicModels.total_paid_and_total_ordered;*/

-- 9. List the employees who report to those employees who report to Diane Murphy. Use the CONCAT function to combine the employee's first name and last name 
-- into a single field for reporting.
/*SELECT CONCAT(firstName, ' ', lastName) AS employees
FROM ClassicModels.Employees
WHERE reportsTo = (
SELECT employeeNumber
FROM ClassicModels.Employees
WHERE lastName = 'Murphy' AND firstName = 'Diane');*/

-- 10. What is the percentage value of each product in inventory sorted by the highest percentage first.
-- (Hint: Create a view first).
/*CREATE OR REPLACE VIEW ClassicModels.q10value AS
SELECT (quantityInStock * buyPrice) AS product_value
FROM ClassicModels.Products;

SELECT (product_value / s * 100 ) AS percentage
FROM ClassicModels.q10value, (
SELECT SUM(product_value) AS s
FROM ClassicModels.q10value) a
ORDER BY (product_value / s * 100 ) DESC;*/

/*SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
SELECT productLine, (SUM(quantityInStock)/totalQuantity * 100) 'percentage'
FROM ClassicModels.Products, (SELECT SUM(quantityInStock) AS 'totalQuantity' FROM ClassicModels.Products) total
GROUP BY productLine
ORDER BY (SUM(quantityInStock)/totalQuantity * 100) DESC;*/

-- 11. Write a function to convert miles per gallon to liters per 100 kilometers.
/*#DROP FUNCTION if EXISTS ClassicModels.q11function;

DELIMITER $$

CREATE FUNCTION ClassicModels.q11function(mpg DECIMAL(10,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN 
	RETURN ((100 * 3.785) / (1.609 * mpg));
END $$

SELECT ClassicModels.q11function(100);*/

-- 12. Write a procedure to increase the price of a specified product category by a given percentage. You will need to create a product table with appropriate 
-- data to test your procedure. Alternatively, load the ClassicModels database on your personal machine so you have complete access. You have to change the 
-- DELIMITER prior to creating the procedure.
/*DELIMITER $$
CREATE PROCEDURE ClassicModels.increasemsrp(IN percent FLOAT(10,2), IN pl VARCHAR(20))
BEGIN
	SELECT MSRP, MSRP * (1 + percent), pl FROM ClassicModels.Products
    WHERE productLine = pl;
END $$

CALL ClassicModels.increasemsrp(0.3, 'Classic Cars');*/

-- 13. What is the value of orders shipped in August 2004?
/*SELECT shippedDate, SUM(quantityOrdered * priceEach) AS 'values'
FROM ClassicModels.OrderDetails od
LEFT JOIN ClassicModels.Orders o ON od.orderNumber = o.orderNumber
WHERE o.shippedDate LIKE '2004-08%'
GROUP BY shippedDate;*/

/*SELECT SUM(od.quantityOrdered * od.priceEach) AS 'values'
FROM ClassicModels.OrderDetails od
LEFT JOIN ClassicModels.Orders o
ON od.orderNumber = o.orderNumber
WHERE o.shippedDate LIKE '2004-08%';*/

-- 14. What is the ratio the value of payments made to orders received for each month of 2004. (i.e., divide the value of payments made by the orders received)?
/*SELECT MONTH(orderDate), (SUM(amount)/SUM(quantityOrdered * priceEach)) AS ratio
FROM ClassicModels.Payments p
LEFT JOIN ClassicModels.Orders o ON p.customerNumber = o.customerNumber
INNER JOIN ClassicModels.OrderDetails od on o.orderNumber = od.orderNumber
WHERE YEAR(orderDate) = 2004
GROUP BY MONTH(orderDate);*/

-- 15. What is the difference in the amount received for each month of 2004 compared to 2003?
/*SELECT MONTH(p3.paymentDate), (SUM(p4.amount)-SUM(p3.amount)) AS difference
FROM ClassicModels.Payments p3, ClassicModels.Payments p4
WHERE YEAR(p3.paymentDate) = 2003 AND YEAR(p4.paymentDate) = 2004 AND MONTH(p3.paymentDate) = MONTH(p4.paymentDate)
GROUP BY MONTH(p3.paymentDate), MONTH(p4.paymentDate)
ORDER BY MONTH(p3.paymentDate) DESC, MONTH(p4.paymentDate) DESC;*/

-- 16. Write a procedure to report the amount ordered in a specific month and year for customers containing a specified character string in their name.
/*DELIMITER $$
CREATE PROCEDURE ClassicModels.q16amount (IN m VARCHAR(45), IN y VARCHAR(45), IN c VARCHAR(45))
BEGIN
SELECT customerName, amount
FROM ClassicModels.Payments p
INNER JOIN ClassicModels.Customers c ON p.customerNumber = c.customerNumber
WHERE MONTH(paymentDate) = m AND YEAR(paymentDate) = y AND customerName LIKE c;
END $$

CALL ClassicModels.q16amount(1, 2005, '%ea%');*/

-- 17. Write a procedure to change the credit limit of all customers in a specified country by a specified percentage.
/*#DROP PROCEDURE IF EXISTS ClassicModels.q17creditlimit;

DELIMITER $$
CREATE PROCEDURE ClassicModels.q17creditlimit (IN percent VARCHAR(45), IN countryname VARCHAR(45))
BEGIN
SELECT customerName, creditLimit, (creditLimit * (1 + percent)) AS newCredit
FROM ClassicModels.Customers
WHERE country = countryname;
END $$

CALL ClassicModels.q17creditlimit(0.2, 'France');*/

-- 18. Basket of goods analysis: a common retail analytics task is to analyze each basket or order to learn what products are often purchased together. 
-- Report the names of products that apprear in the same order ten or more times.

-- 19. ABC reporting: Compute the revenue generated by each customer based on their orders. Also, show each customer's revenue as a percentage of total revenue. 
-- Sorted by customer name.
/*CREATE OR REPLACE VIEW ClassicModels.q19value AS
SELECT customerNumber, SUM(quantityOrdered * priceEach) AS revenue
FROM ClassicModels.OrderDetails od
LEFT JOIN ClassicModels.Orders o ON od.orderNumber = o.orderNumber
GROUP BY customerNumber;

SELECT customerNumber, revenue, (revenue/s * 100) AS 'percentage(%)'
FROM ClassicModels.q19value, (SELECT SUM(revenue) AS s
FROM ClassicModels.q19value) a
ORDER BY customerNumber;*/

/*SELECT customerNumber, revenue, (revenue / r) AS 'difference(%)'
FROM
(SELECT o.customerNumber, SUM(quantityOrdered * priceEach) AS revenue
FROM ClassicModels.OrderDetails od
LEFT JOIN ClassicModels.Orders o ON od.orderNumber = o.orderNumber
GROUP BY o.customerNumber) a, 
(SELECT SUM(quantityOrdered * priceEach) AS r
FROM ClassicModels.OrderDetails) b
ORDER BY customerNumber;*/

-- 20. Compute the profit generated by each customer based on their orders. Also, show each customer's profit as a percentage of total profit. 
-- Sorted by profit descending.
/*SELECT customerNumber, profit, profit/p AS 'percentage(%)'
FROM
(SELECT customerNumber, SUM(quantityOrdered * (priceEach - buyPrice)) AS profit
FROM ClassicModels.Products p
RIGHT JOIN ClassicModels.OrderDetails od ON p.productCode = od.productCode
RIGHT JOIN ClassicModels.Orders o ON od.orderNumber = o.orderNumber
GROUP BY customerNumber) a, 
(SELECT SUM(quantityOrdered * (priceEach - buyPrice)) AS p
FROM ClassicModels.Products p
RIGHT JOIN ClassicModels.OrderDetails od ON p.productCode = od.productCode) b
ORDER BY profit;*/

-- 21. Compute the revenue generated by each sales representative based on the orders from the customers they serve.
/*SELECT CONCAT(firstName, ' ', lastName) AS employee, SUM(quantityOrdered * priceEach) AS revenue
FROM ClassicModels.OrderDetails od
LEFT JOIN ClassicModels.Orders o ON od.orderNumber = o.orderNumber
LEFT JOIN ClassicModels.Customers c ON o.customerNumber = c.customerNumber
LEFT JOIN ClassicModels.Employees e ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY e.employeeNumber;*/

-- 22. Compute the profit generated by each sales representative based on the orders from the customers they serve. Sorted by profit generated descending.
/*FROM ClassicModels.Products p
INNER JOIN ClassicModels.OrderDetails od ON p.productCode = od.productCode
LEFT JOIN ClassicModels.Orders o ON od.orderNumber = o.orderNumber
LEFT JOIN ClassicModels.Customers c ON o.customerNumber = c.customerNumber
LEFT JOIN ClassicModels.Employees e ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY employeeNumber
ORDER BY SUM((priceEach - buyPrice) *quantityOrdered) DESC;*/

-- 23. Compute the revenue generated by each product, sorted by product name.
/*SELECT productName, SUM(quantityOrdered * priceEach) AS Revenue
FROM ClassicModels.OrderDetails od
LEFT JOIN ClassicModels.Products p ON od.productCode = p.productCode
GROUP BY p.productCode
ORDER BY productName;*/

-- 24. Compute the profit generated by each product line, sorted by profit descending.
/*SELECT productLine, SUM(quantityInStock * (priceEach - buyPrice)) AS Profit
FROM ClassicModels.OrderDetails od
INNER JOIN ClassicModels.Products p ON od.productCode = p.productCode
GROUP BY productLine
ORDER BY SUM(quantityInStock * (priceEach - buyPrice)) DESC;*/

-- 25. Same as Last Year(SALY) analysis: Compute the ratio for each product of sales for 2003 versus 2004.
/*SELECT p03.productName, p3/p4 AS ratio
FROM (SELECT productName, SUM((quantityOrdered * priceEach)) AS p3
FROM ClassicModels.OrderDetails od
INNER JOIN ClassicModels.Orders o ON od.orderNumber = o.orderNumber
INNER JOIN ClassicModels.Products p on od.productCode = p.productCode
WHERE YEAR(orderDate) = 2003
GROUP BY p.productCode) p03,
(SELECT productName, SUM((quantityOrdered * priceEach)) AS p4
FROM ClassicModels.OrderDetails od
INNER JOIN ClassicModels.Orders o ON od.orderNumber = o.orderNumber
INNER JOIN ClassicModels.Products p on od.productCode = p.productCode
WHERE YEAR(orderDate) = 2004
GROUP BY p.productCode) p04;*/

-- 26. Compute the ratio of payments for each customer for 2003 versus 2004.
/*SELECT p3.customerName, sum_03/sum_04 AS ratio_of_payments
FROM (SELECT customerName, SUM(amount) AS sum_03
FROM ClassicModels.Payments p
INNER JOIN ClassicModels.Customers c ON p.customerNumber = c.customerNumber
WHERE YEAR(paymentDate) = 2003
GROUP BY c.customerNumber) p3,
(SELECT customerName, SUM(amount) AS sum_04
FROM ClassicModels.Payments p
INNER JOIN ClassicModels.Customers c ON p.customerNumber = c.customerNumber
WHERE YEAR(paymentDate) = 2004
GROUP BY c.customerNumber) p4;*/

-- 27. Find the products sold in 2003 but not 2004.
/*SELECT DISTINCT p.productCode
FROM ClassicModels.Products p
INNER JOIN ClassicModels.OrderDetails od ON p.productCode = od.productCode
INNER JOIN ClassicModels.Orders o ON od.orderNumber = o.orderNumber
WHERE YEAR(orderDate) = 2003 AND p.productCode NOT IN (SELECT DISTINCT p.productCode
FROM ClassicModels.Products p
INNER JOIN ClassicModels.OrderDetails od ON p.productCode = od.productCode
INNER JOIN ClassicModels.Orders o ON od.orderNumber = o.orderNumber
WHERE YEAR(orderDate) = 2004)*/

-- 28. Find the customers without payments in 2003.
/*SELECT customerName, amount
FROM ClassicModels.Payments p
INNER JOIN ClassicModels.Customers c on p.customerNumber = c.customerNumber
WHERE paymentDate NOT LIKE '2003%';*/
