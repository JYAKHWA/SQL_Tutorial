CREATE DATABASE SQLPractice
USE SQLPractice;
/* Employee Table                   */

DROP TABLE  IF EXISTS EmployeeDetail;
CREATE TABLE EmployeeDetail(
Emp_ID INT NOT NULL,
FirstName VARCHAR (50) NOT NULL,
LastName VARCHAR (50) NOT NULL,
Age INT NOT NULL,
Gender VARCHAR (50)
);
SELECT * FROM EmployeeDetail;

/*  Salary Table                                  */
DROP TABLE  IF EXISTS Salary;
CREATE TABLE Salary(
Emp_ID INT NOT NULL,
Position VARCHAR (50) NOT NULL,
Salary INT NOT NULL
);
SELECT * FROM Salary;

/*  Insert Data                                   */
INSERT INTO EmployeeDetail VALUES
( 001, 'Nisha', 'Puri', '23', 'Female' ),
( 002, 'Sanjay', 'Jyakhwa', '28', 'Male' ),
( 003, 'Gika', 'Pramudita', '27', 'Male' ),
( 004, 'Komal', 'Komal', '32', 'Female' ),
( 005, 'Jack', 'Ryan', '39', 'Male' ),
( 006, 'Jason', 'Statham', '29', 'Female' ),
( 007, 'Nikita', 'Karki', '30', 'Male' ),
( 008, 'Deepak', 'Aryal', '30', 'Female' ),
( 009, 'John', 'Wick', '46', 'Female' ),
( 010, 'Iron', 'Man', '41', 'Male' )
SELECT * FROM EmployeeDetail;

/*    Insert Data                                     */
INSERT INTO Salary VALUES
(001, 'Business Analyst', 35000),
(002, 'Data Analyst', 65000),
(003, 'Web Developer', 55000),
(004, 'System Architect', 72000),
(005, 'Civil Engineer', 48000),
(006, 'Doctor', 135000),
(007, 'Salesperson', 53000),
(008, 'Company Owner', 98000),
(009, 'Care Worker', 27000),
(010, 'Driver', 29000)
SELECT * FROM Salary;

/* ------------ Select and From  ---------------*/


SELECT TOP 5 * FROM EmployeeDetail;            /* top 5 selection everything                     */

SELECT DISTINCT FirstName, Gender FROM EmployeeDetail;

SELECT COUNT ( DISTINCT Gender ) AS 'GenderCount' FROM EmployeeDetail;

SELECT MAX (Salary.Salary) AS 'Max_salary', 
MIN (Salary.Salary) AS 'Min_Salary', 
AVG (Salary.Salary) AS 'Avg_Salary'
FROM Salary;

SELECT FirstName, LastName, Age FROM EmployeeDetail
WHERE Age = 30;

SELECT Emp_ID, FirstName, LastName FROM EmployeeDetail
WHERE Age <= 30 OR Gender = 'Female';

SELECT * FROM EmployeeDetail
WHERE LastName LIKE '%i%'     /* where there is i anywhere in lastname  */

SELECT * FROM EmployeeDetail
WHERE LastName LIKE 'S%h%'     /* where there is S first and h anywhere in lastname   SHOULD BE IN ORDER*/

SELECT * FROM EmployeeDetail
WHERE FirstName IN ( 'Nisha', 'Sanjay' ); /*    IN works as multplie =       */


 /*-------------------- GROPUP AND ORDER BY ------------*/

 SELECT * FROM EmployeeDetail;
 
 SELECT Gender, Age, COUNT (Gender) AS 'GenderCount' FROM EmployeeDetail
 WHERE Age >= 30
 GROUP BY Gender, Age
 ORDER BY Age;

 /*-----------------INTERMEDIATE LEVEL------------------------------------*/
 /*------------------INNER JOINS, FULL/LEFT/RIGHT OUTER JOINS----------------------------------------------------*/

 SELECT * FROM EmployeeDetail
 JOIN Salary
 ON EmployeeDetail.Emp_ID = Salary.Emp_ID;

 SELECT FirstName, LastName, Position, Salary FROM Salary
 RIGHT OUTER JOIN EmployeeDetail
 ON EmployeeDetail.Emp_ID = Salary.Emp_ID
 WHERE FirstName <> 'Deepak'
 ORDER BY Salary DESC;


 /*-------------------UNION, UNION ALL--------------------------*/

  /* Uniion ALl keeps all the records, UNUION removes the redundancy but needs to have equal no. of target list[cols]  */

--  SELECT * FROM EmployeeDetail
  --UNION
  --SELECT * FROM Salary;

  DROP TABLE IF EXISTS  EmployeeTest;
  CREATE TABLE EmployeeTest (
  Emp_ID INT NOT NULL,
  FirstName varchar (50) NOT NULL,
  LastName VARCHAR (50) NOT NULL,
  Age INT NOT NULL,
  Gender VARCHAR (50) NOT NULL
  );


  INSERT INTO EmployeeTest VALUES 
  (101, 'Shreya', 'Kharel', 23, 'Female'),
  (102, 'Kushal', 'Puri', 33, 'Male'),
  (103, 'Saroj', 'Rimal', 29, 'Male'),
  (104, 'Albina', 'Jyakhwa', 23, 'Female'),
  (105, 'Nisha', 'Puri', 23, 'Female');

    SELECT * FROM EmployeeDetail
--	SELECT * FROM EmployeeTest
	SELECT * FROM Salary

  SELECT Emp_ID, FirstName, Age   /* Selected cols in both tables must be same number and type */
  FROM EmployeeDetail
  UNION
  SELECT Emp_ID, Position, Salary
  FROM Salary
  ORDER BY Emp_ID;


   /*-------------------CASE STATEMENTS [Conditions]--------------------------*/

   SELECT FirstName, LastName, Gender, Age,
   CASE
		WHEN Age = 30 THEN 'Aged 30'
		WHEN Age < 25 THEN 'Young'
		WHEN Age > 30 THEN 'Old'
		ELSE 'Your Age Range'
	END
   FROM EmployeeDetail
   WHERE Age > 20
   ORDER BY Age;

   --Salary Raise---
   SELECT FirstName, LastName, Position, Salary,
   CASE
		WHEN Position = 'System Architect' THEN Salary + ( Salary * 0.10 )
		WHEN Position = 'Data Analyst' THEN Salary + ( Salary * 0.25 )
		WHEN Position = 'Company Owner' THEN Salary + ( Salary * 0.35 )
		WHEN Position = 'Business Analyst' THEN Salary + ( Salary * 0.15 )
		ELSE Salary + (Salary * 0.05)
   END AS 'Final Salary'
   FROM EmployeeDetail
   JOIN Salary
   ON EmployeeDetail.Emp_ID = Salary.Salary

   SELECT Position, AVG (Salary) AS 'Avg Salary'
   FROM EmployeeDetail
   JOIN Salary
   ON EmployeeDetail.Emp_ID = Salary.Emp_ID
   GROUP BY Position
   HAVING AVG (Salary) > 50000
   ORDER BY 'Avg Salary';


   SELECT Det.Emp_ID, Det.FirstName, Det.LastName, Sal.Position, Sal.Salary, Test.Age
   FROM EmployeeDetail Det
   LEFT JOIN Salary Sal
   ON Det.Emp_ID = Sal.Emp_ID
   LEFT JOIN EmployeeTest Test
   ON Det.Emp_ID = Test.Emp_ID

   --SELECT * FROM EmployeeTest;

   /*------------------------Partition By----------------*/

    SELECT FirstName, LastName, Gender, Position, Salary,
	COUNT (Gender) OVER (PARTITION BY Gender) AS 'Total Gender'
	FROM EmployeeDetail Det
	JOIN Salary Sal
	ON Det.Emp_ID = Sal.Emp_ID
	ORDER BY Salary;

	
    SELECT FirstName, LastName, Gender, Position, Salary, COUNT (Gender) 
	FROM EmployeeDetail Det
	JOIN Salary Sal
	ON Det.Emp_ID = Sal.Emp_ID
	GROUP BY FirstName, LastName, Gender, Position, Salary
	ORDER BY Salary;

	SELECT COUNT (Gender)   /* Same as Partition By */
	FROM EmployeeDetail Det
	JOIN Salary Sal
	ON Det.Emp_ID = Sal.Emp_ID
	GROUP BY Gender
	ORDER BY Gender;

/*-----------------------------ADVANCED TUTORIAL-------------------------------------*/
/*-------------------------------------------------------------------------------------*/

---------------Common Table Expression (CTEs)--------------------
------created only in memory, like a subquery and not stored anywhere-----------Select should be  right after CTE

WITH CTE_Employee AS
( SELECT FirstName, LastName, Gender, Position, Salary,
COUNT (Gender) OVER (PARTITION BY Gender) AS TOTAL_GENDER,
AVG (Salary) OVER (PARTITION BY Gender) AS AVERAGE_SALARY
FROM EmployeeDetail Det
JOIN Salary Sal
ON Det.Emp_ID = Sal.Emp_ID
WHERE Sal.Salary < 52000
)
SELECT FirstName, LastName, AVERAGE_SALARY, TOTAL_GENDER, Position, Salary
FROM CTE_Employee
ORDER BY FirstName;


------------Temp Tables-------------------

DROP TABLE IF EXISTS #TEMP_EMPLOYEE;
CREATE TABLE  #TEMP_EMPLOYEE (
Emp_ID INT NOT NULL PRIMARY KEY,
First_Name VARCHAR (50) NOT NULL,
Last_Name VARCHAR (50) NOT NULL,
Position VARCHAR (50) NOT NULL,
Salary INT NOT NULL
);
SELECT * FROM #TEMP_EMPLOYEE;

INSERT INTO #TEMP_EMPLOYEE VALUES
(111, 'Birendra', 'Nepal', 'Admin', 180000),
(112, 'Gita', 'Bhandari', 'HR', 47800);

--INSERT INTO #TEMP_EMPLOYEE
--SELECT Emp_ID, First_Name, Last_Name, Position, Salary
--FROM Salary; --------------------This is the method, here, doesn't work since the table values and definition do not match between two tables.
 
  CREATE TABLE #TEMP_EMP2 (
  Position VARCHAR (50) NOT NULL,
  Employees_Per_Position INT NOT NULL,
  Avg_Age INT NOT NULL,
  Avg_Salary INT NOT NULL
  );
  SELECT * FROM #TEMP_EMP2;

  INSERT INTO #TEMP_EMP2 
  SELECT Position, COUNT (Position), AVG (Age), AVG (Salary)
  FROM EmployeeDetail Det
  JOIN Salary Sal
  ON Det.Emp_ID = Sal.Emp_ID
  GROUP BY Position
  ORDER BY Position;
  SELECT * FROM #TEMP_EMP2;


  /*-----------------------------STRING FUNCTIONS-------------------------------------*/
  ---------------------Trim, Replace, LTRIM, RTRIM, Substring, Lower, Upper---------------
  DROP TABLE IF EXISTS Errors;
  CREATE TABLE Errors (
  EmployeeID VARCHAR (50) PRIMARY KEY NOT NULL,
  FirstName VARCHAR (50) NOT NULL,
  LastName VARCHAR (50)	NOT NULL
  );
 
  INSERT INTO Errors VALUES 
  ('157 ', 'Paul', 'Norman'),
  (' 175', 'Helen', 'White'),
  ('198', 'Kena', 'Brown');
 SELECT * FROM Errors;







