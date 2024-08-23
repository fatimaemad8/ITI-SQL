-- employee_queries.sql

-- 1. Department id, name and manager name
SELECT d.department_id, d.name AS department_name, m.id AS manager_id, m.name AS manager_name
FROM departments d JOIN employees m ON d.manager_id = m.id;

-- 2. Departments and their projects
SELECT d.name AS department_name, p.name AS project_name
FROM departments d JOIN projects p ON d.department_id = p.department_id;

-- 3. Dependents associated with employees
SELECT e.*, d.*
FROM employees e JOIN dependents d ON e.id = d.employee_id;

-- 4. Projects in Cairo or Alex
SELECT p.id AS project_id, p.name AS project_name, p.location
FROM projects p WHERE p.location IN ('Cairo', 'Alex');

-- 5. Projects starting with "A"
SELECT * FROM projects WHERE name LIKE 'A%';

-- 6. Employees in department 30 with salary 1000-2000
SELECT * FROM employees WHERE department_id = 30 AND salary BETWEEN 1000 AND 2000;

-- 7. Employees in department 10 working on "AL Rabwah"
SELECT e.name
FROM employees e JOIN project_assignments pa ON e.id = pa.employee_id
JOIN projects p ON pa.project_id = p.id
WHERE e.department_id = 10 AND pa.hours_per_week >= 10 AND p.name = 'AL Rabwah';

-- 8. Employees supervised by Kamel Mohamed
SELECT e.name
FROM employees e JOIN employees s ON e.supervisor_id = s.id
WHERE s.name = 'Kamel Mohamed';

-- 9. Employees and their projects, sorted by project name
SELECT e.name AS employee_name, p.name AS project_name
FROM employees e JOIN project_assignments pa ON e.id = pa.employee_id
JOIN projects p ON pa.project_id = p.id
ORDER BY p.name;

-- 10. Projects in Cairo with department details
SELECT p.id AS project_id, d.name AS department_name, m.last_name AS manager_last_name, d.address, m.birthdate
FROM projects p JOIN departments d ON p.department_id = d.department_id
JOIN employees m ON d.manager_id = m.id WHERE p.location = 'Cairo';

-- 11. All managers
SELECT * FROM employees WHERE role = 'Manager';

-- 12. All employees and dependents
SELECT e.*, d.* FROM employees e LEFT JOIN dependents d ON e.id = d.employee_id;

-- 13. Insert personal data as a new employee
INSERT INTO employees (ssn, supervisor_ssn, department_id, salary) VALUES (102672, 112233, 30, 3000);

-- 14. Insert friend's data as a new employee
INSERT INTO employees (ssn, department_id) VALUES (102660, 30);

-- 15. Upgrade salary by 20%
UPDATE employees SET salary = salary * 1.2 WHERE ssn = 102672;
