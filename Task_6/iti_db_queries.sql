-- iti_db_queries.sql

-- 1. View: Students with grades > 50
CREATE VIEW StudentCourseView AS
SELECT s.FirstName + ' ' + s.LastName AS FullName, c.CourseName
FROM Students s JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID WHERE e.Grade > 50;

-- 2. Encrypted view: Manager names and topics
CREATE VIEW ManagerTopicsView WITH ENCRYPTION AS
SELECT m.Name AS ManagerName, t.TopicName
FROM Managers m JOIN Topics t ON m.TopicID = t.TopicID;

-- 3. View: Instructors in 'SD' or 'Java'
CREATE VIEW InstructorDepartmentView AS
SELECT i.Name, d.Name AS DepartmentName
FROM Instructors i JOIN Departments d ON i.DepartmentID = d.DepartmentID
WHERE d.Name IN ('SD', 'Java');

-- 4. View V1: Students in Alex or Cairo
CREATE VIEW V1 AS
SELECT * FROM Students WHERE st_address IN ('Alex', 'Cairo');
DENY UPDATE ON V1 TO Public;

-- 5. View: Project names and employee counts
CREATE VIEW ProjectEmployeeCount AS
SELECT p.ProjectName, COUNT(e.EmployeeID) AS EmployeeCount
FROM CompanyDB.Projects p LEFT JOIN CompanyDB.Employees e ON p.ProjectID = e.ProjectID
GROUP BY p.ProjectName;

-- 6. Create schemas and tables
CREATE SCHEMA Company;
CREATE SCHEMA HumanResources;
CREATE TABLE Company.Department (DepartmentID INT PRIMARY KEY, Name NVARCHAR(100), Location NVARCHAR(100));
CREATE TABLE HumanResources.Employee (EmployeeID INT PRIMARY KEY, Name NVARCHAR(100), HireDate DATETIME);

-- 7. Clustered index on HireDate
CREATE CLUSTERED INDEX IX_Department_HireDate ON Company.Department(HireDate);

-- 8. Unique index on ages in Students
CREATE UNIQUE INDEX IX_Students_Age ON Students(Age);

-- 9. Generate script for all tables and views
EXEC sp_help;

-- 10. Query: Student No and first name without last char
SELECT StudentID, LEFT(FirstName, LEN(FirstName) - 1) AS FirstNameWithoutLastChar FROM Students;

-- 11. Delete grades for students in SD Department
DELETE FROM Enrollments WHERE StudentID IN (SELECT StudentID FROM Students WHERE DepartmentID = (SELECT DepartmentID FROM Departments WHERE Name = 'SD'));

-- 12. Merge statement for Transactions
MERGE INTO Transactions AS target
USING Users AS source ON target.UserID = source.UserID
WHEN MATCHED THEN UPDATE SET target.TransactionAmount = source.TransactionAmount
WHEN NOT MATCHED THEN INSERT (UserID, TransactionAmount) VALUES (source.UserID, source.TransactionAmount);

-- 13. Create login ITIStud with limited access
CREATE LOGIN ITIStud WITH PASSWORD = 'YourSecurePassword';
CREATE USER ITIStud FOR LOGIN ITIStud;
GRANT SELECT, INSERT ON Students, Courses TO ITIStud;
DENY DELETE, UPDATE ON Students, Courses TO ITIStud;
