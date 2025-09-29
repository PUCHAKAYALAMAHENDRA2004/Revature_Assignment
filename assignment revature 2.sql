use puchakay;
-- Q1. Create a table with a primary key.
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50)
);

-- Q2. Add a UNIQUE constraint to employee email.
ALTER TABLE employee
ADD COLUMN email VARCHAR(100) UNIQUE;

-- Q3. Add a NOT NULL constraint to emp_name.
ALTER TABLE employee
MODIFY emp_name VARCHAR(50) NOT NULL;

-- Q4. Add a DEFAULT value of 25 for age.
ALTER TABLE employee
ALTER age SET DEFAULT 25;


-- Q5. Create a CHECK constraint on salary (> 0).
ALTER TABLE employee
ADD CONSTRAINT chk_salary CHECK (salary > 0);

-- Q6. Add a FOREIGN KEY between employees and departments.
ALTER TABLE employee
ADD CONSTRAINT fk_dept FOREIGN KEY (dept_id) REFERENCES departments(dept_id);

-- Q7. Drop a constraint (example: chk_salary).
ALTER TABLE employee
DROP CONSTRAINT chk_salary;

-- Q8. Create a view to show employee names and salaries.
CREATE VIEW emp_salaries AS
SELECT emp_name, salary FROM employee;

-- Q9. Create a view to display department-wise employee count.
CREATE VIEW dept_emp_count AS
SELECT dept_id, COUNT(*) AS emp_count
FROM employee
GROUP BY dept_id;

-- Q10. Retrieve data from the view emp_salaries.
SELECT * FROM emp_salaries;

-- Q11. Update a view to include employee age.
CREATE OR REPLACE VIEW emp_salaries AS
SELECT emp_name, salary, age FROM employee;

-- Q12. Drop a view.
DROP VIEW emp_salaries;

-- Q13. Create a procedure to get all employees.
DELIMITER //
CREATE PROCEDURE GetAllEmployees()
BEGIN
    SELECT * FROM employee;
END //
DELIMITER ;

-- Q14. Call the procedure GetAllEmployees.
CALL GetAllEmployees();

-- Q15. Create a procedure to get employees of a department (with IN parameter).
DELIMITER //
CREATE PROCEDURE GetEmployeesByDept(IN dep INT)
BEGIN
    SELECT * FROM employee WHERE dept_id = dep;
END //
DELIMITER ;

-- Q16. Create a procedure to get the average salary (with OUT parameter).
DELIMITER //
CREATE PROCEDURE GetAvgSalary(OUT avgSal DECIMAL(10,2))
BEGIN
    SELECT AVG(salary) INTO avgSal FROM employee;
END //
DELIMITER ;

-- Q17. Create a procedure to increase salary by 10% for a given department.
DELIMITER //
CREATE PROCEDURE IncreaseSalary(IN dep INT)
BEGIN
    UPDATE employee
    SET salary = salary * 1.10
    WHERE dept_id = dep;
END //
DELIMITER ;

-- Q18. Create a procedure to insert a new employee.
DELIMITER //
CREATE PROCEDURE InsertEmployee(
    IN id INT, IN name VARCHAR(50), IN dept INT, IN sal DECIMAL(10,2), IN ageVal INT
)
BEGIN
    INSERT INTO employee(emp_id, emp_name, dept_id, salary, age)
    VALUES(id, name, dept, sal, ageVal);
END //
DELIMITER ;

-- Q19. Create a procedure to delete an employee by ID.
DELIMITER //
CREATE PROCEDURE DeleteEmployee(IN empId INT)
BEGIN
    DELETE FROM employee WHERE emp_id = empId;
END //
DELIMITER ;

-- Q20. Create a procedure to get the highest paid employee.
DELIMITER //
CREATE PROCEDURE GetHighestPaidEmployee()
BEGIN
    SELECT * FROM employee
    WHERE salary = (SELECT MAX(salary) FROM employee);
END //
DELIMITER ;
