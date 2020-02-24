-- 1.Prepare a list of offices sorted by country, state, city
/*SELECT * 
FROM ClassicModels.Offices
ORDER BY country, state, city;*/

-- 2.How many employees are there in the company?
/*SELECT COUNT(employeeNumber)
FROM ClassicModels.Employees;*/

-- 3.What is the total of payments received?
/*SELECT SUM(amount) AS total_payment
FROM ClassicModels.Payments;*/

-- 4.List the product lines that contain 'Cars'.
/*SELECT productLine
FROM ClassicModels.ProductLines
WHERE productLine LIKE '%Cars%';*/

-- 5.Report total payments for October 28, 2004.
/*SELECT SUM(amount)
FROM ClassicModels.Payments
WHERE paymentDate LIKE '%2004-10-28%'*/;

-- 6.Report those payments greater than $100,000.
/*SELECT *
FROM ClassicModels.Payments
WHERE amount > 100000;*/

-- 7.List the products in each product line.
/*SELECT DISTINCT productLine
FROM ClassicModels.ProductLines;*/

-- 8.How many products in each product line?
/*SELECT productLine, count(quantityInStock)
FROM ClassicModels.Products
GROUP BY productLine;*/

-- 9.What is the minimum payment received?
/*SELECT MIN(amount)
FROM ClassicModels.Payments;*/

-- 10.List all payments greater than twice the average payment.
SELECT amount
FROM ClassicModels.Payments
WHERE amount > 2 * (
SELECT AVG(amount) AS average
FROM ClassicModels.Payments);

-- 11.What is the average percentage markup of the MSRP on buyPrice?
/*SELECT AVG((MSRP - buyPrice)/ buyPrice * 100) AS 'average percentage markup of the MSRP on buyPrice'
FROM ClassicModels.Products;*/

-- 12.How many distinct products does ClassicModels sell?
/*SELECT COUNT(DISTINCT productName)
FROM ClassicModels.Products;*/

-- 13.Report the name and city of customers who don't have sales representatives?
/*SELECT customerName, city 
FROM ClassicModels.Customers
WHERE salesRepEmployeeNumber IS NULL;*/

-- 14.What are the names of executives with VP or Manager in their title? Use the Concat function to combine the employee's first name and the last name into a single field for reporting.
/*SELECT CONCAT(firstName, ' ', lastName)  AS name
FROM ClassicModels.Employees
WHERE jobTitle LIKE '%VP%' or jobTitle LIKE '%Manager%';*/

-- 15.Which orders have a value greater than $5,000?
/*SELECT orderNumber, (quantityOrdered * priceEach) AS 'value'
FROM ClassicModels.OrderDetails
WHERE (quantityOrdered * priceEach)  > 5000;*/
/*SELECT o.orderNumber,p.amount FROM ClassicModels.Orders o,ClassicModels.Payments p 
WHERE o.customerNumber = p.customerNumber 
AND P.amount > 5000;*/
