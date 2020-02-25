-- 1. Who reports to Mary Patterson?
/*SELECT CONCAT(firstName, ' ', lastName) AS employee
FROM ClassicModels.Employees
WHERE reportsTo = (
SELECT employeeNumber 
FROM ClassicModels.Employees
WHERE lastName = 'Patterson' AND firstName = 'Mary');*/

/*SELECT CONCAT(a.firstName, ' ', a.lastName) AS employee
FROM ClassicModels.Employees a, ClassicModels.Employees b
WHERE a.reportsTo = b.employeeNumber AND b.firstName = 'Mary' AND b.lastName = 'Patterson';*/

-- 2. Which payments in any month and year are more than twice the average for that month and year (i.e. compare all payments in Oct 2004 with the average payment for Oct 2004)? 
-- Order the results by the date of the payment. You will need to use the date functions.
/*SELECT DATE(paymentDate)
FROM (SELECT YEAR(paymentDate) AS yr, MONTH(paymentDate) AS m, AVG(amount) AS average
FROM ClassicModels.Payments p
GROUP BY MONTH(paymentDate), YEAR(paymentDate)) a,
(SELECT amount as amt, paymentDate
FROM ClassicModels.Payments p) b
WHERE b.amt >= 2 * a.average;*/

/*SELECT DATE(paymentDate)
FROM ClassicModels.Payments p, (SELECT AVG(amount) AS average
FROM ClassicModels.Payments p
WHERE MONTH(paymentDate) = 10 AND YEAR(paymentDate) = 2004) a
WHERE MONTH(paymentDate) = 10 AND YEAR(paymentDate) = 2004 AND amount >= 2 * a.average;*/

-- 3. Report for each product, the percentage value of its stock on hand as a percentage of the stock on hand for product line to which it belongs.
-- Order the report by product line and percentage value within product line descending. Show percentages with two decimal places.
/*SELECT productLine, productCode, ROUND((product_in_stock / productline_in_stock * 100),2) AS ratio
FROM (SELECT productLine, SUM(quantityInStock) AS productline_in_stock
FROM ClassicModels.Products
GROUP BY productLine) a,
(SELECT productCode, (quantityInStock) AS product_in_stock
FROM ClassicModels.Products
GROUP BY productCode) b
ORDER BY productLine, ratio DESC;*/

-- 4. For orders containin more than two products, report those products that constitute more than 50% of the value of the order.
/*SELECT productName, orderNumber, total_value
FROM
(SELECT a.orderNumber, cnt, total_value, productCode
FROM
(SELECT orderNumber, COUNT(productCode) AS cnt, SUM(quantityOrdered * priceEach) AS total_value
FROM ClassicModels.OrderDetails
GROUP BY orderNumber
HAVING cnt > 2) a
LEFT JOIN ClassicModels.OrderDetails od ON a.orderNumber = od.orderNumber
WHERE quantityOrdered * priceEach > 0.5 * total_value) pc
LEFT JOIN ClassicModels.Products p ON pc.productCode = p.productCode;*/

