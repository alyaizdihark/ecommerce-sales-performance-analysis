CREATE DATABASE ecommerce;
SELECT * FROM sales;
SELECT COUNT(*) AS total_data FROM sales;

-- DATA CLEANSING & DATA PREPARATION
-- 1. Data type check
DESCRIBE sales;

-- 2. Missing values check
SELECT
    SUM(Order_ID IS NULL) AS order_id_null,
    SUM(Order_Date IS NULL) AS order_date_null,
    SUM(Customer_Name IS NULL) AS customer_name_null,
    SUM(Customer_Segment IS NULL) AS customer_segment_null,
    SUM(Country IS NULL) AS country_null,
    SUM(Region IS NULL) AS region_null,
    SUM(Product_Category IS NULL) AS product_category_null,
    SUM(Product_Name IS NULL) AS product_name_null,
    SUM(Quantity IS NULL) AS quantity_null,
    SUM(Unit_Price IS NULL) AS unit_price_null,
    SUM(Discount_Percent IS NULL) AS discount_null,
    SUM(Total_Sales IS NULL) AS total_sales_null,
    SUM(Shipping_Cost IS NULL) AS shipping_cost_null,
    SUM(Profit IS NULL) AS profit_null,
    SUM(Payment_Method IS NULL) AS payment_method_null
FROM sales;

-- 3. Duplicate check
SELECT Order_ID, 
	COUNT(*) Total
FROM sales
GROUP BY Order_ID
HAVING Total>1;

-- 4. Extra spaces check
SELECT Customer_Name 
FROM sales 
WHERE Customer_Name LIKE '%  %';

-- 5. Values check
SELECT * FROM sales WHERE Quantity<0;
SELECT * FROM sales WHERE Unit_Price<0;
SELECT * FROM sales WHERE Total_Sales<0;



-- KPIs
-- 1. Total Profit
SELECT ROUND(SUM(Profit), 2) AS Total_Profit FROM sales;
-- 2. Profit Margin
SELECT SUM(Profit) / SUM(Total_Sales) AS Profit_Margin FROM sales;
-- 3. Total Revenue
SELECT ROUND(SUM(Total_Sales), 2) AS Total_Revenue FROM sales;
-- 4. Total Orders
SELECT COUNT(DISTINCT Order_ID) AS Total_Order FROM sales;
-- 5. Average Order Value
SELECT ROUND(SUM(Total_Sales) / COUNT(DISTINCT Order_ID), 2) AS Average_Order_Value FROM sales;




-- Sales Trend
-- How do monthly revenue and profit trends change over time?
SELECT
    YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month,
    ROUND(SUM(Total_Sales), 2) AS Total_Revenue,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM sales
GROUP BY Year, Month
ORDER BY Year, Month;

-- Product Performance Analysis
-- Which product contributes is the most profitable? 
SELECT Product_Name,
	Product_Category,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM sales
GROUP BY Product_Name, Product_Category
ORDER BY Total_Profit DESC
LIMIT 10;

-- Customer Segment Analysis 
-- Which customer segment is the most profitable? 
SELECT Customer_Segment, 
	ROUND(SUM(Profit), 2) AS Total_Profit
FROM sales
GROUP BY Customer_Segment
ORDER BY Total_Profit DESC;

-- Regional Analysis
-- Which country generate the highest sales and profit? 
SELECT
    Country,
    Region, 
    ROUND(SUM(Total_Sales), 2) AS Total_Revenue,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM sales
GROUP BY Country, Region
ORDER BY Total_Revenue DESC;

-- Payment Method Analysis  
-- Which payment methods are most preferred by customers?
SELECT Payment_Method,
    COUNT(*) AS Total_Order
FROM sales
GROUP BY Payment_Method 
ORDER BY Total_Order DESC;

-- Discount Analysis
-- How does profit vary across different discount levels?
SELECT Discount_Percent,
	ROUND(AVG(Profit), 2) AS Avg_Profit
FROM sales
GROUP BY Discount_Percent
ORDER BY Discount_Percent;