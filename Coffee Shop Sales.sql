CREATE DATABASE CoffeeShop;
USE CoffeeShop;
CREATE TABLE Customers (
  CustomerID INT AUTO_INCREMENT PRIMARY KEY,
  FirstName VARCHAR(100),
  LastName VARCHAR(100),
  Email VARCHAR(100),
  PhoneNumber VARCHAR(15)
);
CREATE TABLE Employees (
  EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
  FirstName VARCHAR(100),
  LastName VARCHAR(100),
  Position VARCHAR(100)
);
CREATE TABLE Products (
  ProductID INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(100),
  Category VARCHAR(50),
  Price DECIMAL(10, 2)
);
CREATE TABLE Orders (
  OrderID INT AUTO_INCREMENT PRIMARY KEY,
  CustomerID INT,
  EmployeeID INT,
  OrderDate DATETIME,
  TotalAmount DECIMAL(10, 2),
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
  FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);
CREATE TABLE OrderItems (
  OrderItemID INT AUTO_INCREMENT PRIMARY KEY,
  OrderID INT,
  ProductID INT,
  Quantity INT,
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
INSERT INTO Customers (FirstName, LastName, Email, PhoneNumber) VALUES
('John', 'Doe', 'john.doe@example.com', '123-456-7890'),
('Jane', 'Smith', 'jane.smith@example.com', '987-654-3210'),
('Emily', 'Johnson', 'emily.johnson@example.com', '555-1234-5678'),
('Michael', 'Davis', 'michael.davis@example.com', '555-8765-4321'),
('Sarah', 'Williams', 'sarah.williams@example.com', '555-1122-3344'),
('David', 'Martinez', 'david.martinez@example.com', '555-9988-7766');
INSERT INTO Employees (FirstName, LastName, Position) VALUES
('Alice', 'Brown', 'Barista'),
('Bob', 'Green', 'Manager'),
('Sophie', 'Taylor', 'Barista'),
('James', 'Lee', 'Manager'),
('Olivia', 'Wilson', 'Server');
INSERT INTO Products (Name, Category, Price) VALUES
('Espresso', 'Coffee', 2.50),
('Cappuccino', 'Coffee', 3.00),
('Croissant', 'Pastry', 1.50),
('Latte', 'Coffee', 3.50),
('Americano', 'Coffee', 2.75),
('Mocha', 'Coffee', 3.25),
('Bagel', 'Pastry', 2.00),
('Muffin', 'Pastry', 2.25),
('Iced Tea', 'Beverage', 2.50),
('Cold Brew', 'Coffee', 3.00);
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate, TotalAmount) VALUES
(1, 1, NOW(), 6.50),
(2, 2, NOW(), 7.50),
(1, 2, '2024-11-28 08:30:00', 9.50),  -- John Doe ordered a Latte and a Croissant
(2, 3, '2024-11-28 09:00:00', 12.25), -- Jane Smith ordered an Americano and a Muffin
(3, 1, '2024-11-28 09:30:00', 5.50),  -- Emily Johnson ordered an Espresso and a Bagel
(4, 4, '2024-11-28 10:00:00', 7.75);  -- Michael Davis ordered a Mocha and a Croissant
INSERT INTO OrderItems (OrderID, ProductID, Quantity) VALUES
(1, 1, 2),  -- John ordered 2 Espresso
(1, 3, 1),  -- John ordered 1 Croissant
(2, 2, 1),  -- Jane ordered 1 Cappuccino
(1, 1, 1),  -- John Doe ordered 1 Latte
(1, 3, 1),  -- John Doe ordered 1 Croissant
(2, 2, 1),  -- Jane Smith ordered 1 Americano
(2, 5, 1),  -- Jane Smith ordered 1 Muffin
(3, 1, 1),  -- Emily Johnson ordered 1 Espresso
(3, 4, 1),  -- Emily Johnson ordered 1 Bagel
(4, 3, 1),  -- Michael Davis ordered 1 Mocha
(4, 3, 1);  -- Michael Davis ordered 1 Croissant
SELECT p.Name, SUM(oi.Quantity) AS TotalSold
FROM OrderItems oi
JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY p.ProductID
ORDER BY TotalSold DESC;
SELECT 
    o.OrderDate, 
    SUM(o.TotalAmount) AS TotalSales
FROM Orders o
WHERE DATE(o.OrderDate) = '2024-11-28'
GROUP BY o.OrderDate;
ALTER TABLE Products ADD COLUMN Cost DECIMAL(10, 2);
UPDATE Products SET Cost = 1.00 WHERE Name = 'Espresso' LIMIT 1;
UPDATE Products SET Cost = 1.25 WHERE Name = 'Cappuccino' LIMIT 1;
UPDATE Products SET Cost = 0.75 WHERE Name = 'Croissant' LIMIT 1;
UPDATE Products SET Cost = 1.00 WHERE Name = 'Latte' LIMIT 1;
UPDATE Products SET Cost = 1.00 WHERE Name = 'Americano' LIMIT 1;
UPDATE Products SET Cost = 0.50 WHERE Name = 'Bagel' LIMIT 1;
UPDATE Products SET Cost = 0.75 WHERE Name = 'Muffin' LIMIT 1;
UPDATE Products SET Cost = 1.25 WHERE Name = 'Iced Tea' LIMIT 1;
UPDATE Products SET Cost = 1.50 WHERE Name = 'Cold Brew' LIMIT 1;
SELECT 
    SUM(o.TotalAmount) AS Revenue,
    SUM(oi.Quantity * p.Cost) AS COGS,  -- Cost of Goods Sold
    SUM(o.TotalAmount) - SUM(oi.Quantity * p.Cost) AS Profit
FROM OrderItems oi
JOIN Orders o ON oi.OrderID = o.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
WHERE o.OrderDate BETWEEN '2024-11-01' AND '2024-11-30';




