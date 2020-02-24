-- 1.Report the account representative for each customer.
/*SELECT c.customerName, CONCAT(e.firstName, ' ', e.lastName) AS 'representative'
FROM ClassicModels.Customers c
LEFT JOIN ClassicModels.Employees e
ON c.salesRepEmployeeNumber = e.employeeNumber;*/

-- 2.Report total payments for Atelier graphique.
/*SELECT sum(p.amount) AS 'total_payments'
FROM ClassicModels.Payments p
LEFT JOIN ClassicModels.Customers c
ON p.customerNumber = c.customerNumber
WHERE c.customerName = 'Atelier Graphique';*/

-- 3.Report the total payments by date.
/*SELECT  paymentDate, SUM(amount) AS 'total_payment'
FROM ClassicModels.Payments
GROUP BY paymentDate
ORDER BY paymentDate DESC;*/

-- 4.Report the products that have not been sold.
/*SELECT p.productName
FROM ClassicModels.Products p
LEFT JOIN ClassicModels.OrderDetails od
ON p.productCode = od.productCode
LEFT JOIN ClassicModels.Orders o
ON od.orderNumber = o.orderNumber
WHERE o.status = 'Cancelled';*/

-- 5.List the amount paid by each customer.
/*SELECT c.customerName, sum(p.amount) AS 'amount_paid'
FROM ClassicModels.Customers c
LEFT JOIN ClassicModels.Payments p
ON p.customerNumber = c.customerNumber
GROUP BY c.customerName
ORDER BY sum(p.amount) DESC;*/

-- 6.How many orders have been placed by Herkku Gifts?
/*SELECT c.customerName, o.orderNumber
FROM ClassicModels.Customers c
LEFT JOIN ClassicModels.Orders o
ON c.customerNumber = o.customerNumber
WHERE customerName = 'Herkku Gifts';*/

-- 7.Who are the employees in Boston?
/*SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'employees'
FROM ClassicModels.Employees e
LEFT JOIN ClassicModels.Offices o
ON e.officeCode = o.officeCode
WHERE o.city = 'Boston';*/

-- 8.Report those payments greater than $100,000. Sort the report so the customer who made the highest payment appears first.
/*SELECT SUM(p.amount), c.customerName
FROM ClassicModels.Payments p
LEFT JOIN ClassicModels.Customers c
ON p.customerNumber = c.customerNumber
GROUP BY c.customerName
HAVING SUM(p.amount) > 100000
ORDER BY SUM(p.amount) DESC;*/

-- 9.List the value of 'On Hold' orders.
/*SELECT o.orderNumber, p.amount AS value_of_on_hold
FROM ClassicModels.Payments p
RIGHT JOIN ClassicModels.Orders o
ON p.customerNumber = o.customerNumber
WHERE o.status = 'On Hold';*/

-- 10.Report the number of orders 'On Hold' for each customer.
/*SELECT c.customerName, COUNT(p.amount) AS number_of_orders_on_hold
FROM ClassicModels.Orders o
LEFT JOIN ClassicModels.Payments p
ON o.customerNumber = p.customerNumber
LEFT JOIn ClassicModels.Customers c
ON o.customerNumber = c.customerNumber
WHERE o.status = 'On Hold'
GROUP BY o.customerNumber;*/