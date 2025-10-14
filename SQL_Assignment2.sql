---------------------------------------------------------------------ONLINE STORE INVENTORY----------------------------------------------------------------------------------

-- Create Database
CREATE DATABASE Online_Store_Inventory;

-- Create Products Table 
CREATE TABLE Products (
  Product_ID NUMBER PRIMARY KEY,
  Product_Name VARCHAR2(15) NOT NULL,
  Product_Category VARCHAR2(10) NOT NULL,
  Price Number(10,2) CHECK(Price > 0),
  Stock_Quantity NUMBER DEFAULT 0
);

-- Create Customers Table
CREATE TABLE Customers (
  Customer_ID NUMBER PRIMARY KEY,
  Customer_Fname VARCHAR2(15) NOT NULL,
  Customer_Lname VARCHAR2(10) NOT NULL,
  Email_Address VARCHAR2(20) UNIQUE,
  Phone_Number VARCHAR2(15)
);

-- Create Orders Table
CREATE TABLE Orders (
  Order_ID NUMBER PRIMARY KEY,
  Customer_ID NUMBER NOT NULL,
  Order_Date DATE DEFAULT SYSDATE,
  Total_Amount FLOAT,
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

-- INSERT INTO EMPLOYEE VALUES (1, 'Clark', 'Sales');
