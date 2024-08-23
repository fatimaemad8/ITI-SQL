-- iti_adventureworks_queries.sql

-- Part 1: ITI DB

-- 1. Count students with age
SELECT COUNT(*) FROM Students WHERE Age IS NOT NULL;

-- 2. Unique instructor names
SELECT DISTINCT Name FROM Instructors;

-- 3. Student ID, Full Name, Department
SELECT StudentID, ISNULL(FirstName + ' ' + LastName, 'Unknown') AS FullName, ISNULL(DepartmentName, 'No Department') FROM Students;

-- 4. Instructor and Department names
SELECT i.Name, ISNULL(d.Name, 'No Department') FROM Instructors i LEFT JOIN Departments d ON i.DepartmentID = d.DepartmentID;

-- 5. Student full name and course for courses with grades
SELECT s.FirstName + ' ' + s.LastName, c.CourseName FROM Students s JOIN Enrollments e ON s.StudentID = e.StudentID JOIN Courses c ON e.CourseID = c.CourseID WHERE e.Grade IS NOT NULL;

-- 6. Number of courses per topic
SELECT t.TopicName, COUNT(c.CourseID) FROM Topics t JOIN Courses c ON t.TopicID = c.TopicID GROUP BY t.TopicName;

-- 7. Max and Min salaries for instructors
SELECT MAX(Salary), MIN(Salary) FROM Instructors;

-- 8. Instructors with salaries < average
SELECT * FROM Instructors WHERE Salary < (SELECT AVG(Salary) FROM Instructors);

-- 9. Department with min salary instructor
SELECT d.Name FROM Departments d JOIN Instructors i ON d.DepartmentID = i.DepartmentID WHERE i.Salary = (SELECT MIN(Salary) FROM Instructors);

-- 10. Max two instructor salaries
SELECT DISTINCT TOP 2 Salary FROM Instructors ORDER BY Salary DESC;

-- 11. Instructor name and salary or bonus keyword
SELECT Name, ISNULL(CAST(Salary AS VARCHAR), 'Instructor Bonus') FROM Instructors;

-- 12. Average salary for instructors
SELECT AVG(Salary) FROM Instructors;

-- 13. Student first name and supervisor data
SELECT s.FirstName, su.* FROM Students s JOIN Supervisors su ON s.SupervisorID = su.SupervisorID;

-- 14. Highest two salaries in each department
WITH RankedSalaries AS (SELECT i.Name, i.Salary, d.Name AS Dept, ROW_NUMBER() OVER (PARTITION BY d.DepartmentID ORDER BY i.Salary DESC) AS Rank FROM Instructors i JOIN Departments d ON i.DepartmentID = d.DepartmentID) SELECT * FROM RankedSalaries WHERE Rank <= 2;

-- 15. Random student from each department
WITH RandomStudents AS (SELECT s.*, ROW_NUMBER() OVER (PARTITION BY d.DepartmentID ORDER BY NEWID()) AS Rank FROM Students s JOIN Departments d ON s.DepartmentID = d.DepartmentID) SELECT * FROM RandomStudents WHERE Rank = 1;

-- Part 2: AdventureWorks DB

-- 1. SalesOrderID and ShipDate within period
SELECT SalesOrderID, ShipDate FROM Sales.SalesOrderHeader WHERE ShipDate BETWEEN '2002-07-28' AND '2014-07-29';

-- 2. Products with StandardCost < $110
SELECT ProductID, Name FROM Production.Product WHERE StandardCost < 110.00;

-- 3. Products with unknown weight
SELECT ProductID, Name FROM Production.Product WHERE Weight IS NULL;

-- 4. Products with specific colors
SELECT * FROM Production.Product WHERE Color IN ('Silver', 'Black', 'Red');

-- 5. Products starting with 'B'
SELECT * FROM Production.Product WHERE Name LIKE 'B%';

-- 6. Update ProductDescription and find underscores
UPDATE Production.ProductDescription SET Description = 'Chromoly steel_High of defects' WHERE ProductDescriptionID = 3;
SELECT * FROM Production.ProductDescription WHERE Description LIKE '%_%';

-- 7. Sum of TotalDue for each OrderDate
SELECT OrderDate, SUM(TotalDue) FROM Sales.SalesOrderHeader WHERE OrderDate BETWEEN '2001-07-01' AND '2014-07-31' GROUP BY OrderDate;

-- 8. Unique HireDate of Employees
SELECT DISTINCT HireDate FROM HumanResources.Employee;

-- 9. Average of unique ListPrices
SELECT AVG(DISTINCT ListPrice) FROM Production.Product;

-- 10. Product Name and ListPrice in specified format
SELECT 'The ' + Name + ' is only! ' + CAST(ListPrice AS VARCHAR) FROM Production.Product WHERE ListPrice BETWEEN 100 AND 120 ORDER BY ListPrice;

-- 11. Transfer data to store_Archive
SELECT RowGuid, Name, SalesPersonID, Demographics INTO Sales.store_Archive FROM Sales.Store;

-- 12. Count rows in store_Archive
SELECT COUNT(*) FROM Sales.store_Archive;

-- 13. Today's date in different styles
SELECT CONVERT(VARCHAR, GETDATE(), 1), CONVERT(VARCHAR, GETDATE(), 3), FORMAT(GETDATE(), 'yyyy-MM-dd');
