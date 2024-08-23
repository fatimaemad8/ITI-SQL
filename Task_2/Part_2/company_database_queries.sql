-- Company Database SQL Queries

-- 1. Display All Employees' Data
SELECT * FROM EMPLOYEE;

-- 2. Display Employee Names and Salaries
SELECT FNAME, LNAME, SALARY FROM EMPLOYEE;

-- 3. Display Departments and Their Managers
SELECT DNAME, MGRSSN FROM DEPARTMENT;

-- 4. Display Projects and Their Locations
SELECT PNAME, PLOCATION FROM PROJECT;

-- 5. Display Employees Working on a Specific Project
SELECT E.FNAME, E.LNAME 
FROM EMPLOYEE E
JOIN WORKS_ON W ON E.SSN = W.ESSN
WHERE W.PNO = 'project_number';  -- Replace with actual project number

-- 6. Display Dependents of a Specific Employee
SELECT DEPENDENT_NAME, RELATIONSHIP 
FROM DEPENDENT 
WHERE ESSN = 'employee_ssn';  -- Replace with actual employee SSN

-- 7. Count Employees in Each Department
SELECT D.DNAME, COUNT(E.SSN) AS EmployeeCount
FROM DEPARTMENT D
LEFT JOIN EMPLOYEE E ON D.DNUMBER = E.DNO
GROUP BY D.DNAME;

-- 8. Display Employees with Their Department Names
SELECT E.FNAME, E.LNAME, D.DNAME 
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DNO = D.DNUMBER;

-- 9. Display All Projects with Their Associated Departments
SELECT P.PNAME, D.DNAME 
FROM PROJECT P
JOIN DEPARTMENT D ON P.DNUM = D.DNUMBER;

-- 10. Find Employees with a Specific Relationship to Dependents
SELECT E.FNAME, E.LNAME, D.DEPENDENT_NAME, D.RELATIONSHIP 
FROM EMPLOYEE E
JOIN DEPENDENT D ON E.SSN = D.ESSN
WHERE D.RELATIONSHIP = 'specific_relationship';  -- Replace with actual relationship
