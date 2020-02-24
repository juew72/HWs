-- 1.List products sold by order date.
/*SELECT p.productName, o.orderDate
FROM ClassicModels.Products p
LEFT JOIN ClassicModels.OrderDetails od
ON p.productCode = od.productCode
RIGHT JOIN ClassicModels.Orders o
ON od.orderNumber = o.orderNumber
ORDER BY o.orderDate;*/

-- 2.List the order dates in descending order for orders for the 1940 Ford Pickup Truck.
/*SELECT p.productName, o.orderDate
FROM ClassicModels.Products p
LEFT JOIN ClassicModels.OrderDetails od
ON p.productCode = od.productCode
LEFT JOIN ClassicModels.Orders o
ON od.orderNumber = o.orderNumber
WHERE p.productName = '1940 Ford Pickup Truck'
ORDER BY o.orderDate DESC;*/

-- 3.List the names of customers and their corresponding order number where a particular order from that customer has a value greater than $25,000?
/*SELECT c.customerName, o.orderNumber
FROM ClassicModels.Customers c
RIGHT JOIN ClassicModels.Payments p
ON c.customerNumber = p.customerNumber
RIGHT JOIN ClassicModels.Orders o
ON p.customerNumber = o.customerNumber
WHERE p.amount > 25000;*/

-- 4.Are there any products that appear on all orders?
/*SELECT od.productCode, COUNT(od.orderNumber)
FROM ClassicModels.OrderDetails od
GROUP BY od.productCode
HAVING COUNT(od.orderNumber) IN (
SELECT COUNT(DISTINCT orderNumber) 
FROM ClassicModels.OrderDetails);*/

-- 5.List the names of products sold at less than 80% of the MSRP.
/*SELECT p.productName
FROM ClassicModels.Products p
INNER JOIN ClassicModels.OrderDetails od
ON p.productCode = od.productCode
WHERE od.priceEach < 0.8 * p.MSRP;*/

-- 6.Reports those products that have benn sold with a markup of 100% or more(i.e., the priceEach is at least twice the buyPrice)
/*SELECT p.productName
FROM ClassicModels.Products p
INNER JOIN ClassicModels.OrderDetails od
ON p.productCode = od.productCode
WHERE od.priceEach >= 2 * p.buyPrice;*/

-- 7.List the products ordered on a Monday.
/*SELECT p.productName
FROM ClassicModels.Products p
INNER JOIN ClassicModels.OrderDetails od
ON p.productCode = od.productCode
INNER JOIN ClassicModels.Orders o
ON od.orderNumber = o.orderNumber
WHERE DAYOFWEEK(o.orderDate) = 1;*/

-- 8.What is the quantity on hand for products listed on 'On Hold' orders?
/*SELECT p.productName, p.quantityInStock
FROM ClassicModels.Products p
INNER JOIN ClassicModels.OrderDetails od
ON p.productCode = od.productCode
INNER JOIN ClassicModels.Orders o
ON od.orderNumber = o.orderNumber
WHERE o.status = 'On Hold';*/
