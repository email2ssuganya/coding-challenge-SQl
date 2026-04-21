-- =========================
-- DAY 28: DDL COMMANDS
-- =========================

-- Create Table
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    PatientName VARCHAR(50),
    Age INT,
    Gender VARCHAR(10),
    AdmissionDate DATE
);

-- Add Column
ALTER TABLE Patients
ADD DoctorAssigned VARCHAR(50);

-- Modify Column
ALTER TABLE Patients
MODIFY PatientName VARCHAR(100);

-- Rename Table
RENAME TABLE Patients TO Patient_Info;

-- TRUNCATE (delete data only)
TRUNCATE TABLE Patient_Info;

-- DROP (delete table completely)
-- DROP TABLE Patient_Info;


-- =========================
-- DAY 29: CONSTRAINTS
-- =========================

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    BookName VARCHAR(100),
    ISBN VARCHAR(20) UNIQUE
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    BookID INT,
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- DELETE specific rows
DELETE FROM Orders WHERE OrderID = 1;

-- TRUNCATE all rows
TRUNCATE TABLE Orders;


-- =========================
-- DAY 30: CLAUSES & OPERATORS
-- =========================

-- DISTINCT
SELECT DISTINCT Department FROM Students;

-- NULL / NOT NULL
SELECT * FROM Students WHERE Email IS NULL;
SELECT * FROM Students WHERE Email IS NOT NULL;

-- IN
SELECT * FROM Students WHERE Course IN ('Math', 'Science');

-- BETWEEN
SELECT * FROM Students WHERE GPA BETWEEN 3.0 AND 4.0;

-- NOT BETWEEN
SELECT * FROM Students WHERE GPA NOT BETWEEN 2.0 AND 3.0;


-- =========================
-- DAY 31: SORTING & AGGREGATES
-- =========================

-- Top 3 products
SELECT * FROM Products
ORDER BY Price DESC
LIMIT 3;

-- Aggregates
SELECT COUNT(*) FROM Sales;
SELECT SUM(Amount) FROM Sales;
SELECT AVG(Amount) FROM Sales;
SELECT MAX(Amount) FROM Sales;
SELECT MIN(Amount) FROM Sales;

-- GROUP BY + HAVING
SELECT DepartmentID, COUNT(*) AS TotalEmployees
FROM Employees
GROUP BY DepartmentID
HAVING COUNT(*) > 10;


-- =========================
-- DAY 32: JOINS & UNION
-- =========================

-- INNER JOIN
SELECT s.StudentName, c.CourseName
FROM Students s
INNER JOIN Courses c
ON s.CourseID = c.CourseID;

-- LEFT JOIN
SELECT s.StudentName, e.CourseID
FROM Students s
LEFT JOIN Enrollments e
ON s.StudentID = e.StudentID;

-- RIGHT JOIN
SELECT s.StudentName, e.CourseID
FROM Students s
RIGHT JOIN Enrollments e
ON s.StudentID = e.StudentID;

-- UNION
SELECT Name FROM Current_Employees
UNION
SELECT Name FROM Past_Employees;

-- UNION ALL
SELECT Name FROM Current_Employees
UNION ALL
SELECT Name FROM Past_Employees;


-- =========================
-- DAY 33: FUNCTIONS
-- =========================

-- String Functions
SELECT UPPER(Name) FROM Employees;
SELECT LOWER(Name) FROM Employees;
SELECT SUBSTRING(Name, 1, 3) FROM Employees;
SELECT CONCAT(FirstName, ' ', LastName) AS FullName FROM Employees;

-- Date Functions
SELECT YEAR(NOW());
SELECT DATEDIFF(NOW(), HireDate) FROM Employees;

-- User Defined Function
DELIMITER //
CREATE FUNCTION GetFullName(first VARCHAR(50), last VARCHAR(50))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    RETURN CONCAT(first, ' ', last);
END //
DELIMITER ;


-- =========================
-- DAY 34: PROCEDURES & VIEWS
-- =========================

-- Stored Procedure
DELIMITER //
CREATE PROCEDURE GetEmployee(IN emp_id INT)
BEGIN
    SELECT * FROM Employees WHERE EmployeeID = emp_id;
END //
DELIMITER ;

-- Simple View
CREATE VIEW Employee_View AS
SELECT Name, Department FROM Employees;

-- Complex View
CREATE VIEW Employee_Details AS
SELECT e.Name, d.DepartmentName, s.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
JOIN Salaries s ON e.EmployeeID = s.EmployeeID;


-- =========================
-- DAY 35: TRIGGERS & TRANSACTIONS
-- =========================

-- Trigger
CREATE TRIGGER before_delete_orders
BEFORE DELETE ON Orders
FOR EACH ROW
INSERT INTO Order_History
VALUES (OLD.OrderID, OLD.BookID);

-- DCL
GRANT SELECT ON Employees TO 'junior_user';
REVOKE SELECT ON Employees FROM 'junior_user';

-- TCL
START TRANSACTION;

SAVEPOINT sp1;

UPDATE Accounts SET Balance = Balance - 1000 WHERE ID = 1;
UPDATE Accounts SET Balance = Balance + 1000 WHERE ID = 2;

-- ROLLBACK TO sp1;
COMMIT;