 -- 1. Employees all over the world. Can you tell me the top three cities that we have employees?
SELECT o.city, COUNT(CONCAT(e.firstName, ' ', e.lastName)) AS 'employee count' 
FROM ClassicModels.Employees e
LEFT JOIN ClassicModels.Offices o
ON e.officeCode = o.officeCode
GROUP BY o.city
LIMIT 3;

-- 2. For company products, each product has inventory and buy price, msrp. 
-- Assume that every product is sold on msrp price. 
-- Can you write a query to tell company executives: profit margin on each productlines
SELECT SUM(quantityInStock * (MSRP - buyPrice))/SUM(quantityInStock * MSRP) AS 'Profit Margin', productLine
FROM ClassicModels.Products
GROUP BY productLine;


-- 3. company wants to award the top 3 sales rep They look at who produces the most sales revenue.
-- can you write a query to help find the employees.(use p*q)
/*SELECT CONCAT(e.firstName, ' ', e.lastName), sum(p.amount)
FROM ClassicModels.Employees e
LEFT JOIN ClassicModels.Customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN ClassicModels.Payments p
ON c.customerNumber = p.customerNumber
GROUP BY CONCAT(e.firstName, ' ', e.lastName)
ORDER BY p.amount DESC
LIMIT 3;*/


-- if we want to promote the employee to a manager, what do you think are the tables to be updated
-- In this case the jobTitle,reportsTo inside the Employees table can be changed.

-- An employee is leaving the company, write a stored procedure to handle the case. 
-- 1). Make the current employee inactive, 
-- 2). Replaced with its manager employeenumber in order table. 
-- First, Need to create one more columns, which could be named like 'status'. This column has time 
-- value included so that to try to check if the employee is inactive(i.e. if the person is former employee
-- or still in this company) can be checked.
-- Then obtain the leaving person's employeenumber and change the employeenumber in all other table.

-- Ask to provide a table to show for each employee in a certain department how many times their 
-- Salary changes 
/*SELECT COUNT(DISTINCT es.salary), d.department_name
FROM Employee_salary es
LEFT JOIN Employee e
ON es.employee_id = e.employee_id
LEFT JOIN Department d
ON d.department_id = e.department_id
GROUP BY e.employee_id, d.department_id;*/

-- Ask to provide a table to show for each department the top 3 salary with employee name 
-- and employee has not left the company.
/*SELECT  d.department_name,es.salary, e.employee_name
FROM Employee_salary es
LEFT JOIN Employee e
ON es.employee_id = e.employee_id
LEFT JOIN Department d
ON d.department_id = e.department_id
WHERE e.term_date IS NOT NULL
GROUP BY d.department_id
ORDER BY e.current_salary
LIMIT 3;*/
