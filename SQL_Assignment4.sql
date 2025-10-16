/* Assignment-1: Calculate Simple Interest 
Objective:     Use variables and arithmetic expressions inside a PL/SQL block. 
Requirements: 
1. Declare three variables: 
o p (principal) 
o r (rate of interest) 
o t (time in years) 
2. Compute Simple Interest using: 
SI=(𝒑∗𝒓∗𝒕)/𝟏𝟎𝟎 
 
3. Display the result using DBMS_OUTPUT.PUT_LINE. 
*/

DECLARE
    v_p NUMBER(10,2);
    v_r NUMBER(5,2);
    v_t NUMBER;
    v_si FLOAT;
BEGIN
    v_p := 4500;
    v_r := 2.5;
    v_t := 2;
    v_si := (v_p*v_r*v_t)/100;/
    DBMS_OUTPUT.PUT_LINE('Simple Interest: '||v_si);
END;

/*Assignment 2: Employee Bonus Calculation 
Objective:     Practice variable declaration and IF conditions. 
Requirements: 
1. Declare variables: 
o emp_name VARCHAR2(50) 
o salary NUMBER 
o bonus NUMBER 
2. Assign values to emp_name and salary. 
3. Use conditions: 
o If salary > 50000 → bonus = 0.10 × salary 
o Else → bonus = 0.15 × salary 
4. Display employee name, salary, and bonus.
*/
DECLARE
    emp_name VARCHAR2(50);
    salary NUMBER;
    bonus NUMBER;
BEGIN
    emp_name := 'Smith';
    salary := 5000;
    IF salary > 5000 THEN
        bonus := 0.10 * salary;
    ELSE
        bonus := 0.15 * salary;
    END IF;
    DBMS_OUTPUT.PUT_LINE('Employee Name: ' || emp_name || ', ' || 'Salary: ' || salary || ', ' || 'Bonus: ' || bonus);
END;

/*Assignment-3:    Retrieve and Display Department Details 
Objective:      Use %ROWTYPE with a WHERE clause. 
Requirements: 
1. Declare a variable v_dept of type DEPARTMENTS%ROWTYPE. 
2. Take a sample department ID in variable 
3. Fetch the corresponding record into v_dept. 
4. Display department name and location.
*/

DECLARE
    v_dept Dept %ROWTYPE;
BEGIN
    SELECT * INTO v_dept FROM Dept WHERE Deptno = 20;
    DBMS_OUTPUT.PUT_LINE('Department Name: ' || V_dept.Dname || ', ' || 'Location: ' || v_dept.Loc);
END;

/*
Assignment 4: Student Marks Management 
Create a PL/SQL block using an associative array indexed by VARCHAR2 to store students’ marks and 
calculate their average score. 
 Requirements: 
1. Use an associative array where: 
o Key → Student Name 
o Value → Marks (NUMBER) 
2. Insert marks for at least 5 students. 
3. Display all student names with their marks. 
4. Calculate and print: 
o Total marks 
o Average marks 
 Hint:     Use .FIRST, .NEXT for iteration.
*/

DECLARE
    TYPE stud_marks IS TABLE OF NUMBER INDEX BY VARCHAR2(20);
    v_marks stud_marks;
    
    v_key VARCHAR2(20);
    
    total_marks NUMBER := 0;
    v_count NUMBER := 0;
    average_marks NUMBER;
    
BEGIN
    v_marks('Alice') := 90;
    v_marks('Bob') := 40;
    v_marks('Clare') := 55;
    v_marks('David') := 85;
    v_marks('Eve') := 35;
    
    v_key := v_marks.FIRST;
    WHILE v_key IS NOT NULL LOOP
        DBMS_OUTPUT.PUT_LINE('Name: ' || v_key || ', ' || 'Marks Scored: ' || v_marks(v_key));
        v_key := v_marks.NEXT(v_key);
    END LOOP;
    
    v_key := v_marks.FIRST;
    WHILE v_key IS NOT NULL LOOP
        total_marks := total_marks + v_marks(v_key);
        v_count := v_count + 1;
        v_key := v_marks.NEXT(v_key);
    END LOOP;
    
    IF v_count > 0 THEN
        average_marks := total_marks / v_count;
    ELSE
        average_marks := 0;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Total Marks: ' || total_marks);
    DBMS_OUTPUT.PUT_LINE('Average Marks: ' || average_marks);
    
END;

/*
Assignment 5:     Country–Capital Lookup 
 Objective:   Use an associative array indexed by VARCHAR2 to perform lookups. 
Requirements: 
1. Declare an associative array with: 
o Key → Country Name 
o Value → Capital City 
2. Insert at least 6 country–capital pairs. 
3. Ask the user for a country name (using &country substitution variable). 
4. Display: 
o The capital if the country exists. 
o A message “Country not found” otherwise. 
 Hint:  Use EXISTS(key) to check if the element is in the associative array.
*/

DECLARE
    TYPE t_country_capital IS TABLE OF VARCHAR2(25) INDEX BY VARCHAR2(25);
    country_capitals t_country_capital;
    country_name VARCHAR2(25) := '&country';
BEGIN
    country_capitals('INDIA') := 'DELHI';
    country_capitals('USA') := 'WASHINGTON D.C.';
    country_capitals('JAPAN') := 'TOKYO';
    country_capitals('FRANCE') := 'PARIS';
    country_capitals('GERMANY') := 'BERLIN';
    country_capitals('BRAZIL') := 'BRASILIA';
    
    IF country_capitals.EXISTS(country_name) THEN
        DBMS_OUTPUT.PUT_LINE('The capital of ' || country_name || ' is ' || country_capitals(country_name));
    ELSE
        DBMS_OUTPUT.PUT_LINE('Country not found');
    END IF;
END;
