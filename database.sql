CREATE DATABASE baris;
USE baris;



CREATE TABLE IF NOT EXISTS Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL
);


CREATE TABLE Products(
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT NULL,
    Price DECIMAL(10,2) NOT NULL,
    StockQuantity INT DEFAULT 0,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) ON DELETE SET NULL
);

CREATE TABLE Customers(
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(15),
    Address VARCHAR(255),
    RegistrationDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Orders(
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
);

CREATE TABLE OrderDetails(
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    OrderID INT,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE SET NULL
);

CREATE TABLE Employees(
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    JobTitle VARCHAR(50),
    HireDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Salary DECIMAL(10,2)
);




-- Kategorilere veri ekleme
INSERT INTO Categories (CategoryName) VALUES 
('Elektronik'), 
('Giyim'), 
('Ev Aletleri'), 
('Kitap'), 
('Oyuncak');

-- Ürünlere rastgele veri ekleme
INSERT INTO Products (ProductName, CategoryID, Price, StockQuantity) VALUES 
('Laptop', 1, 15000.99, 10), 
('T-shirt', 2, 150.50, 50), 
('Buzdolabı', 3, 7500.75, 5), 
('Roman Kitabı', 4, 120.25, 100), 
('Lego Seti', 5, 500.99, 20);

-- Müşterilere rastgele veri ekleme
INSERT INTO Customers (FirstName, LastName, PhoneNumber, Address) VALUES 
('Ahmet', 'Yılmaz', '555-1234', 'İstanbul, Türkiye'), 
('Ayşe', 'Kara', '555-5678', 'Ankara, Türkiye'), 
('Mehmet', 'Demir', '555-9012', 'İzmir, Türkiye');

-- Siparişlere rastgele veri ekleme
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES 
(1, NOW() - INTERVAL FLOOR(RAND() * 30) DAY, 0), 
(2, NOW() - INTERVAL FLOOR(RAND() * 30) DAY, 0), 
(3, NOW() - INTERVAL FLOOR(RAND() * 30) DAY, 0);

-- Sipariş detaylarına rastgele veri ekleme
INSERT INTO OrderDetails (ProductID, OrderID, Quantity, UnitPrice) VALUES 
(1, 1, 2, 15000.99), 
(2, 1, 3, 150.50), 
(3, 2, 1, 7500.75), 
(4, 2, 2, 120.25), 
(5, 3, 5, 500.99);

-- Çalışanlara rastgele veri ekleme
INSERT INTO Employees (FirstName, LastName, JobTitle, HireDate, Salary) VALUES 
('Ali', 'Can', 'Müdür', '2020-05-10', 12000.50), 
('Fatma', 'Öztürk', 'Satış Temsilcisi', '2021-07-15', 8500.00), 
('Kemal', 'Şahin', 'Teknik Destek', '2019-09-01', 9500.75);

-- Sipariş toplamlarını güncelleme
UPDATE Orders 
SET TotalAmount = (SELECT SUM(Quantity * UnitPrice) FROM OrderDetails WHERE OrderDetails.OrderID = Orders.OrderID);

-- 📌 EKLENEN VERİLERİ GÖRÜNTÜLEME
SELECT * FROM Categories;
SELECT * FROM Products;
SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;
SELECT * FROM Employees;