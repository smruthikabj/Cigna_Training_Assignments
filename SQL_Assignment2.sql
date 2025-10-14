-- Create Database
--CREATE DATABASE Online_Store_Inventory;

-- Create Products Table 
CREATE TABLE Products (
  Product_ID NUMBER PRIMARY KEY,
  Product_Name VARCHAR2(15) NOT NULL,
  Product_Category VARCHAR2(20) NOT NULL,
  Price Number(10,2) CHECK(Price > 0),
  Stock_Quantity NUMBER DEFAULT 0
);

-- Create Customers Table
CREATE TABLE Customers (
  Customer_ID NUMBER PRIMARY KEY,
  Customer_Fname VARCHAR2(15) NOT NULL,
  Customer_Lname VARCHAR2(10) NOT NULL,
  Email_Address VARCHAR2(30) UNIQUE,
  Phone_Number VARCHAR2(15)
);

-- Create Orders Table
CREATE TABLE Orders (
  Order_ID NUMBER PRIMARY KEY,
  Customer_ID NUMBER NOT NULL,
  Order_Date DATE DEFAULT SYSDATE,
  Total_Amount FLOAT CHECK (Total_Amount >= 0),
  CONSTRAINT fk_customer FOREIGN KEY (Customer_ID) REFERENCES Customers (Customer_ID)
);

-- Create Order-Details Table
CREATE TABLE OrderDetails (
  Order_Detail_ID NUMBER PRIMARY KEY,
  Order_ID NUMBER NOT NULL,
  Product_ID NUMBER NOT NULL,
  Quantity NUMBER CHECK (Quantity > 0),
  CONSTRAINT fk_order FOREIGN KEY (Order_ID) REFERENCES Orders (Order_ID),
  CONSTRAINT fk_product FOREIGN KEY (Product_ID) REFERENCES Products (Product_ID)
);

-- Inserting Values Into Products TABLE
INSERT INTO Products VALUES (101, 'Laptop', 'Electronics', 55000, 25);
INSERT INTO Products VALUES (102, 'Headphones', 'Accessories', 2500, 50);

-- Inserting Values Into Customers TABLE
INSERT INTO Customers VALUES (201, 'John', 'Doe', 'johndoe26@gmail.com', '9876543120');
INSERT INTO Customers VALUES (202, 'David', 'Brown', 'davidbrown8@example.com', '9123456780');

-- Inserting Values Into Orders TABLE
INSERT INTO Orders (Order_ID, Customer_ID, Order_Date, Total_Amount) VALUES (301, 201, SYSDATE, 0);
INSERT INTO Orders (Order_ID, Customer_ID, Order_Date, Total_Amount) VALUES (302, 202, SYSDATE, 0);

-- Inserting Values Into OrderDetails TABLE
INSERT INTO OrderDetails VALUES (401, 301, 101, 1);
INSERT INTO OrderDetails VALUES (402, 302, 102, 2

--QUERY 1: Retrieve products with low stock (eg: less than 20 units)
SELECT *
FROM Products
WHERE Stock_Quantity < 20;

-- QUERY 2: Calculate the total amount spent by each customer
-- QUERY 3: Update product stock quantities after orders are placed to reflect purchased items
