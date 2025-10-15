-- 1. Prepare schemas for Emps, Dept table

-- Create Department Table
CREATE TABLE Dept
(
	Deptno NUMBER PRIMARY KEY,
	Dname VARCHAR2(50),
	Loc VARCHAR2(50) 
);

-- Create Employee Table
CREATE TABLE Emps
(
	Empno NUMBER PRIMARY KEY,
	Ename VARCHAR2(50),
	Job   VARCHAR2(50),
	Salary   FLOAT,
	Deptno NUMBER,	 
    CONSTRAINT fk_dept FOREIGN KEY (Deptno) REFERENCES Dept(Deptno)
);

-- Insert Values into Department Table
INSERT INTO Dept VALUES (10,'ACCOUNTING','BLR');
INSERT INTO Dept VALUES (20,'RESEARCH','DEHLI');
INSERT INTO Dept VALUES (30,'SALES','MLR');
INSERT INTO Dept VALUES (40,'OPERATIONS','CHN');

-- Insert Values into Employee Table
INSERT INTO Emps VALUES(1001,'JOHN','CLERK',800, 10);
INSERT INTO Emps VALUES(1002,'ALICE','SALESMAN',1600,30);
INSERT INTO Emps VALUES(1003,'JACK','SALESMAN',1250,30);
INSERT INTO Emps VALUES(1004,'JIM','MANAGER',2975,30);
INSERT INTO Emps VALUES(1005,'BOB','ANAYST',1250,20);
INSERT INTO Emps VALUES(1006,'CLARE','CLERK',2850,10);
INSERT INTO Emps VALUES(1007,'SIMS','MANAGER',2450,20);
INSERT INTO Emps VALUES(1008,'ADAM','ANALYST',3000,20);
INSERT INTO Emps VALUES(1009,'ZACK','MANAGER',5000,40);
INSERT INTO Emps VALUES(1010,'MARTIN','SALESMAN',1100,30);

-- 2. Checking the sub-queries

--1)Single-row Subquery
SELECT Ename, Salary 
FROM Emps 
WHERE Salary > (SELECT AVG(Salary) FROM Emps);

--2)Multi-row Subquery
 SELECT Ename, Deptno 
FROM Emps
WHERE Deptno IN (SELECT Deptno FROM Dept WHERE Loc= 'BLR');

--3)Multi-column Subquery
 SELECT Empno, Ename, Job, Deptno 
FROM Emps
WHERE (Job, Deptno) IN 
      (SELECT Job, Deptno FROM Emps WHERE Empno = 1004); 

--4)Correlated Subquery
SELECT E.Ename, E.Salary, E.Deptno 
FROM Emps E
WHERE E.Salary > (SELECT AVG(Salary) 
FROM Emps
WHERE Deptno = E.Deptno); 

--5) In the WHERE Clause
 SELECT * 
FROM Emps
WHERE Deptno IN (SELECT Deptno FROM Dept WHERE Loc= 'CHN'); 

--6) In the HAVING Claus
 SELECT Deptno, AVG(Salary) 
FROM Emps 
GROUP BY Deptno 
HAVING AVG(Salary) > (SELECT AVG(Salary) FROM Emps);

--7) In the SELECT Clause
SELECT E.Ename, 
       (SELECT Dname FROM Dept D WHERE D.Deptno = E.Deptno) AS department 
FROM Emps E;

-- 3.  Write the queries for the following requirements using joins, subqueries on the above tables

-- QUERY 1: Display employee names along with their department names
SELECT E.Ename, D.Dname
FROM Emps E
JOIN Dept D ON E.Deptno = D.Deptno;

-- QUERY 2: List all employees with their job titles and the location of their department
SELECT E.Ename, E.Job
FROM Emps E
JOIN Dept D ON E.Deptno = D.Deptno;

-- QUERY 3: Display employees who work in the SALES department
SELECT Ename
FROM Emps
WHERE Deptno = (SELECT Deptno FROM Dept WHERE Dname = 'SALES');

-- QUERY 4: List all employees along with their department name and location, including departments that have no employees
SELECT E.Ename, D.Dname, D.Loc
FROM Dept D
LEFT JOIN Emps E ON D.Deptno = E.Deptno;

-- QUERY 5: Display all departments and employees, even if some employees are not assigned to any department
SELECT D.Dname, E.Ename
FROM Dept D
FULL JOIN Emps E ON D.Deptno = E.Deptno;

-- QUERY 6: Show each department name and  total salary paid to its employees
SELECT D.Dname, SUM(E.Salary) AS Total_Salary
FROM Dept D
LEFT JOIN Emps E ON D.Deptno = E.Deptno
GROUP BY D.Dname;

-- QUERY 7: Find departments that have more than 3 employees.  Display dname and no. of employees
SELECT D.Dname, COUNT(E.Empno) AS No_Of_Employees
FROM Dept D
JOIN Emps E ON D.Deptno = E.Deptno
GROUP BY D.Dname
HAVING COUNT(E.Empno) > 3;

-- QUERY 8: Display employees who work in the same location as the ACCOUNTING department
SELECT E.Ename, D.Loc
FROM Emps E
JOIN Dept D ON E.Deptno = D.Deptno
WHERE D.Loc = (SELECT Loc FROM Dept WHERE Dname = 'ACCOUNTING');

-- QUERY 9: For each department, display the employee who has the highest salary
SELECT D.Dname, E.Ename, E.Salary
FROM Emps E
JOIN Dept D ON E.Deptno = D.Deptno
WHERE E.Salary = (SELECT MAX(Salary) FROM Emps WHERE Deptno = E.Deptno);

-- QUERY 10: List employees whose salary is greater than the average salary of their department
SELECT E.Ename, E.Salary
FROM Emps E
WHERE E.Salary > (SELECT AVG(Salary) FROM Emps WHERE Deptno = E.Deptno);
