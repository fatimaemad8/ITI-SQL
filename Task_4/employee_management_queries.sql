-- employee_management_queries.sql

-- 1. Female dependents of female employees and male dependents of male employees
SELECT d.dependent_name, e.gender
FROM dependents d
JOIN employees e ON d.employee_id = e.employee_id
WHERE (e.gender = d.gender);

-- 2. Total hours per week for each project
SELECT p.name AS project_name, SUM(pa.hours_per_week) AS total_hours
FROM projects p
JOIN project_assignments pa ON p.project_id = pa.project_id
GROUP BY p.name;

-- 3. Data of the department with the smallest employee ID
SELECT d.*
FROM departments d
WHERE d.department_id = (SELECT MIN(department_id) FROM employees);

-- 4. Department name and max, min, avg salary of employees
SELECT d.name AS department_name, MAX(e.salary), MIN(e.salary), AVG(e.salary)
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.name;

-- 5. Managers with no dependents
SELECT e.name
FROM employees e
WHERE e.role = 'Manager' AND NOT EXISTS (SELECT 1 FROM dependents d WHERE d.employee_id = e.employee_id);

-- 6. Departments with average salary less than overall average
SELECT d.department_id, d.name, COUNT(e.employee_id) AS employee_count
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.name
HAVING AVG(e.salary) < (SELECT AVG(salary) FROM employees);

-- 7. Employee names and project names ordered by department and name
SELECT e.name AS employee_name, p.name AS project_name
FROM employees e
JOIN project_assignments pa ON e.employee_id = pa.employee_id
JOIN projects p ON pa.project_id = p.project_id
ORDER BY e.department_id, e.last_name, e.first_name;

-- 8. Max 2 salaries using subquery
SELECT salary FROM employees
WHERE salary IN (SELECT DISTINCT salary FROM employees ORDER BY salary DESC LIMIT 2);

-- 9. Employees with names similar to any dependent name
SELECT e.name
FROM employees e
JOIN dependents d ON e.name LIKE CONCAT('%', d.dependent_name, '%');

-- 10. Employee number and name if at least one has dependents
SELECT e.employee_id, e.name
FROM employees e
WHERE EXISTS (SELECT 1 FROM dependents d WHERE d.employee_id = e.employee_id);

-- DML Operations

-- Insert new department "DEPT IT" with id 100
INSERT INTO departments (department_id, name, manager_id, start_date)
VALUES (100, 'DEPT IT', 112233, '2006-11-01');

-- Update Mrs. Noha Mohamed's record
UPDATE departments SET manager_id = 968574 WHERE department_id = 100;

-- Update your record to be department 20 manager
UPDATE employees SET role = 'Manager', department_id = 20 WHERE ssn = 102672;

-- Update employee number 102660 to be supervised by you
UPDATE employees SET supervisor_id = 102672 WHERE employee_id = 102660;

-- Delete Mr. Kamel Mohamed's data if no dependents or projects
DELETE FROM employees WHERE ssn = 223344 AND NOT EXISTS (
    SELECT 1 FROM dependents d WHERE d.employee_id = 223344
) AND NOT EXISTS (
    SELECT 1 FROM departments d WHERE d.manager_id = 223344
) AND NOT EXISTS (
    SELECT 1 FROM employees e WHERE e.supervisor_id = 223344
) AND NOT EXISTS (
    SELECT 1 FROM project_assignments pa WHERE pa.employee_id = 223344
);

-- Update salaries of employees in Project ‘Al Rabwah’ by 30%
UPDATE employees SET salary = salary * 1.3
WHERE employee_id IN (SELECT pa.employee_id FROM project_assignments pa JOIN projects p ON pa.project_id = p.project_id WHERE p.name = 'Al Rabwah');
