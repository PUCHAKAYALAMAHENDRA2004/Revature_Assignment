use puchakay;
DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

INSERT INTO departments VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Sales');


 
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2),
    age INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
 
INSERT INTO employee VALUES
(101, 'Raj', 1, 60000, 30),
(102, 'Priya', 2, 45000, 28),
(103, 'Kiran', 3, 70000, 35),
(104, 'Meena', 1, 50000, 26),
(105, 'Anil', 4, 40000, 29),
(106, 'Divya', 2, 55000, 32),
(107, 'Arjun', 3, 80000, 40),
(108, 'Neha', 4, 42000, 27);
-- Q1. Find employees earning more than the average salary.
 SELECT*
 FROM employee
 WHERE salary>(SELECT AVG(salary) FROM employee);
 -- Q2. Get the employee with the highest salary.
 SELECT*
 FROM employee
 WHERE salary=(SELECT MAX(salary) FROM employee);
 -- Q3. Find employees working in the same department as 'Raj'.
SELECT *
FROM employee
WHERE dept_id = (SELECT dept_id FROM employee WHERE emp_name = 'Raj');
-- Q4. Get departments where at least one employee earns more than 60,000.
SELECT dept_name
FROM departments
WHERE dept_id IN (SELECT dept_id FROM employee WHERE salary > 60000);
-- Q5. Find employees younger than the oldest HR employee.
SELECT*
FROM employee
WHERE age<(SELECT MAX(age) FROM employee WHERE dept_id=(SELECT dept_id FROM departments WHERE dept_name='HR'));
-- Q6. Retrieve employees whose salary is equal to the minimum salary in the company.
SELECT*
FROM employee
WHERE salary=(SELECT MIN(salary) FROM employee);
-- Q7. Get employees who earn more than 'Meena'.
SELECT*
FROM employee
WHERE salary>(SELECT salary FROM employee WHERE emp_name='Meena');
-- Q8. Find employees whose salary is greater than the average salary of their department.
SELECT* 
FROM employee e
WHERE salary>(SELECT AVG(salary) FROM employee WHERE dept_id=e.dept_id);
-- Q9. Get departments that have more than 2 employees.
SELECT *
FROM departments
WHERE dept_id IN (SELECT dept_id FROM employee GROUP BY dept_id HAVING COUNT(emp_id) >=2);
-- Q10. Find the second highest salary.
SELECT MAX(salary)
FROM employee
WHERE salary < (SELECT MAX(salary) FROM employee);
-- Q11. List employees who earn the same salary as someone in HR.
SELECT*
FROM employee
WHERE salary IN (SELECT salary FROM employee WHERE dept_id=(SELECT dept_id FROM departments WHERE dept_name='HR'));
-- Q12. Find employees who are older than the youngest Finance employee.
SELECT*
FROM employee
WHERE age>(SELECT MIN(age) FROM employee WHERE dept_id=(SELECT dept_id FROM departments WHERE dept_name='Finance'));
-- Q13. Get department names where the average salary is above 55,000.
SELECT dept_name
FROM departments
WHERE dept_id IN (SELECT dept_id FROM employee GROUP BY dept_id HAVING AVG(salary) > 55000);

-- Q14. Find employees whose salary is higher than at least one Sales employee.
SELECT*
FROM employee
WHERE salary>(SELECT MIN(salary) FROM employee WHERE dept_id=(SELECT dept_id FROM departments WHERE dept_name='sales'));
-- Q15. Retrieve employees who are in departments that Raj is not part of.
SELECT dept_id FROM employee WHERE emp_name = 'Raj';
SELECT *
FROM employee
WHERE dept_id != 1; 
-- Q16. Get the department of the employee with the lowest salary.
SELECT dept_name
FROM departments
WHERE dept_id = (SELECT dept_id FROM employee WHERE salary = (SELECT MIN(salary) FROM employee));

-- Q17. Find employees who earn more than the average salary of the whole company but less than the max salary.
SELECT *
FROM employee
WHERE salary > (SELECT AVG(salary) FROM employee)
  AND salary < (SELECT MAX(salary) FROM employee);

-- Q18. List employees who are the only ones in their department (single-member departments
SELECT *
FROM employee e1
WHERE (SELECT COUNT(*) FROM employee e2 WHERE e2.dept_id = e1.dept_id) = 1;


-- Q19. Find employees whose department has the highest average salary.
SELECT *
FROM employee
WHERE dept_id = (
    SELECT dept_id
    FROM employee
    GROUP BY dept_id
    ORDER BY AVG(salary) DESC
    LIMIT 1
);

-- Q20. Get employees who earn more than the average salary of HR but work in other departments.
SELECT *
FROM employee
WHERE salary > (SELECT AVG(salary) FROM employee WHERE dept_id = 2) 
  AND dept_id != 2;





