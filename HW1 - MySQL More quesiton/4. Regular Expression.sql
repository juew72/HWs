-- 1.Find products containing the name 'Ford'.
/*SELECT productName 
FROM ClassicModels.Products
WHERE productName LIKE '% Ford%';*/

-- 2.List products ending in 'ship'.
/*SELECT productName
FROM ClassicModels.Products
WHERE productName LIKE '%ship';*/

-- 3.Report the number of customers in Denmark, Norway, and Sweden.
/*SELECT country, COUNT(customerName)
FROM ClassicModels.Customers
WHERE country IN ('Denmark', 'Norway', 'Sweden')
GROUP BY country;*/

/*SELECT COUNT(customerNumber)
FROM ClassicModels.Customers
WHERE country IN ('Denmark', 'Norway', 'Sweden');*/

-- 4.What are the products with a product code in the range S700_1000 to S700_1499?
/*SELECT productName, productCode
FROM ClassicModels.Products
WHERE productCode BETWEEN 'S700_1000' AND 'S700_1499';*/

/*SELECT productName, productCode
FROM ClassicModels.Products
WHERE productCode REGEXP 'S700_1[0-4][0-9][0-9]';*/

-- 5.Which customers have a digit in their name? ??;
/*SELECT customerName
FROM ClassicModels.Customers
WHERE customerName REGEXP '[0-9]';*/

-- 6.List the names of employees called Dianne or Diane.
/*SELECT CONCAT(firstName, ' ', lastName) AS name_of_employee
FROM ClassicModels.Employees
WHERE firstName IN ('Dianne', 'Diane');*/

-- 7.List the products containing ship or boat in their product name.
/*SELECT productName
FROM ClassicModels.Products;
WHERE productName LIKE '%ship%' OR productName LIKE '%boat%';*/

-- 8.List the products with a product code beginning with S700.
/*SELECT productName, productCode
FROM ClassicModels.Products
WHERE productCode LIKE 'S700%';*/

-- 9.List the names of employees called Larry or Barry.
/*SELECT CONCAT(firstName, ' ', lastName) AS 'Names'
FROM ClassicModels.Employees
WHERE firstName IN ('Larry', 'Barry');*/

-- 10.List the names of employees with non-alphabetic characters in their names. ??
/*SELECT CONCAT(firstName, ' ', lastName) AS 'names'
FROM ClassicModels.Employees
WHERE firstName LIKE '%[^a-z][^A-Z]%' OR lastName LIKE '%[^a-z][^A-Z]%';*/

-- 11.List the vendors whose name ends in Diecast.
/*SELECT productVendor
FROM ClassicModels.Products
WHERE productVendor LIKE '%Diecast';*/
