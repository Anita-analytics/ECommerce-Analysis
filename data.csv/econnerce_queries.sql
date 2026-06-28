-- E-Commerce Sales Analysis SQL Queries
-- Database: ecommerce_db

USE ecommerce_db;

-- =============================================
-- TABLE CREATION
-- =============================================

CREATE TABLE IF NOT EXISTS orders (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description VARCHAR(255),
    Quantity INT,
    InvoiceDate VARCHAR(50),
    UnitPrice DECIMAL(10,2),
    CustomerID VARCHAR(20),
    Country VARCHAR(50)
);

-- =============================================
-- BASIC ANALYSIS
-- =============================================

-- 1. Total Revenue
SELECT ROUND(SUM(Quantity * UnitPrice), 2) AS Total_Revenue
FROM orders;

-- 2. Total Orders
SELECT COUNT(DISTINCT InvoiceNo) AS Total_Orders
FROM orders;

-- 3. Total Customers
SELECT COUNT(DISTINCT CustomerID) AS Total_Customers
FROM orders;

-- =============================================
-- SALES ANALYSIS
-- =============================================

-- 4. Top 10 Countries by Revenue
SELECT Country, 
ROUND(SUM(Quantity * UnitPrice), 2) AS Revenue
FROM orders
GROUP BY Country
ORDER BY Revenue DESC
LIMIT 10;

-- 5. Top 10 Best Selling Products
SELECT Description, 
SUM(Quantity) AS Total_Quantity
FROM orders
GROUP BY Description
ORDER BY Total_Quantity DESC
LIMIT 10;

-- 6. Monthly Revenue Trend
SELECT 
    YEAR(InvoiceDate) AS Year,
    MONTH(InvoiceDate) AS Month,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Revenue
FROM orders
GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate)
ORDER BY Year, Month;

-- 7. Top 10 Customers by Revenue
SELECT CustomerID,
ROUND(SUM(Quantity * UnitPrice), 2) AS Revenue
FROM orders
GROUP BY CustomerID
ORDER BY Revenue DESC
LIMIT 10;

-- 8. Day Wise Sales
SELECT DAYNAME(InvoiceDate) AS Day,
ROUND(SUM(Quantity * UnitPrice), 2) AS Revenue
FROM orders
GROUP BY DAYNAME(InvoiceDate)
ORDER BY Revenue DESC;

-- 9. Average Order Value
SELECT ROUND(AVG(Quantity * UnitPrice), 2) AS Avg_Order_Value
FROM orders;

-- 10. Most Profitable Month
SELECT MONTHNAME(InvoiceDate) AS Month,
ROUND(SUM(Quantity * UnitPrice), 2) AS Revenue
FROM orders
GROUP BY MONTHNAME(InvoiceDate)
ORDER BY Revenue DESC
LIMIT 1;