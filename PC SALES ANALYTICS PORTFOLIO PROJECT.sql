/*=========================================================
PC SALES ANALYTICS PROJECT
Author: Lesson Mtileni
Database: PCSalesDB
Tool: SQL Server Management Studio (SSMS)

Objective:
Analyze PC sales data to answer business questions,
identify data quality issues, and demonstrate SQL skills.
=========================================================*/

/*=========================================================
QUESTION 1:
How many sales records exist in the dataset?
=========================================================*/

SELECT COUNT(*) AS TotalSales
FROM PC_Sales;

/*=========================================================
QUESTION 2:
View the first 10 records in the dataset.
=========================================================*/

SELECT TOP 10 *
FROM PC_Sales;


/*=========================================================
QUESTION 3:
What columns exist in the table?
=========================================================*/

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'PC_Sales';

/*=========================================================
QUESTION 4:
What is the total revenue generated?
=========================================================*/

SELECT
    SUM(Sale_Price) AS TotalRevenue
FROM PC_Sales;

/*=========================================================
QUESTION 5:
What is the total cost incurred?
=========================================================*/

SELECT
    SUM(Cost_Price) AS TotalCost
FROM PC_Sales;

/*=========================================================
QUESTION 6:
What is the total profit?
Profit = Sale Price - Cost Price
=========================================================*/

SELECT
    SUM(Sale_Price - Cost_Price) AS TotalProfit
FROM PC_Sales;

/*=========================================================
QUESTION 7:
What is the overall profit margin?
=========================================================*/

SELECT
    SUM(Sale_Price) AS TotalRevenue,
    SUM(Sale_Price - Cost_Price) AS TotalProfit,
    CAST(
        SUM(Sale_Price - Cost_Price) * 100.0
        / SUM(Sale_Price)
        AS DECIMAL(10,2)
    ) AS ProfitMarginPercent
FROM PC_Sales;

/*=========================================================
QUESTION 8:
Which salespeople generated the most revenue?
=========================================================*/

SELECT
    Sales_Person_Name,
    SUM(Sale_Price) AS Revenue
FROM PC_Sales
GROUP BY Sales_Person_Name
ORDER BY Revenue DESC;

/*=========================================================
QUESTION 9:
Top 10 salespeople by revenue.
=========================================================*/

SELECT TOP 10
    Sales_Person_Name,
    SUM(Sale_Price) AS Revenue
FROM PC_Sales
GROUP BY Sales_Person_Name
ORDER BY Revenue DESC;

/*=========================================================
QUESTION 10:
Which PC brands generate the most revenue?
=========================================================*/

SELECT
    PC_Make,
    SUM(Sale_Price) AS Revenue
FROM PC_Sales
GROUP BY PC_Make
ORDER BY Revenue DESC;


/*=========================================================
QUESTION 11:
Rank PC brands by revenue.
=========================================================*/

SELECT
    PC_Make,
    SUM(Sale_Price) AS Revenue,
    RANK() OVER
    (
        ORDER BY SUM(Sale_Price) DESC
    ) AS RevenueRank
FROM PC_Sales
GROUP BY PC_Make;


/*=========================================================
QUESTION 12:
Which PC brands generate the highest profit?
=========================================================*/

SELECT
    PC_Make,
    SUM(Sale_Price - Cost_Price) AS Profit
FROM PC_Sales
GROUP BY PC_Make
ORDER BY Profit DESC;

/*=========================================================
QUESTION 13:
How many unique customers exist?
=========================================================*/

SELECT COUNT(DISTINCT Customer_Email_Address)
       AS UniqueCustomers
FROM PC_Sales;

/*=========================================================
QUESTION 14:
Which customers purchased the most?
=========================================================*/

SELECT TOP 10
    Customer_Name,
    Customer_Surname,
    COUNT(*) AS Purchases
FROM PC_Sales
GROUP BY Customer_Name,
         Customer_Surname
ORDER BY Purchases DESC;

/*=========================================================
QUESTION 15:
Revenue by continent.
=========================================================*/

SELECT
    Continent,
    SUM(Sale_Price) AS Revenue
FROM PC_Sales
GROUP BY Continent
ORDER BY Revenue DESC;


/*=========================================================
QUESTION 16:
Revenue by country.
=========================================================*/

SELECT
    Country_or_State,
    SUM(Sale_Price) AS Revenue
FROM PC_Sales
GROUP BY Country_or_State
ORDER BY Revenue DESC;

/*=========================================================
QUESTION 17:
Top 10 cities by revenue.
=========================================================*/

SELECT TOP 10
    Province_or_City,
    SUM(Sale_Price) AS Revenue
FROM PC_Sales
GROUP BY Province_or_City
ORDER BY Revenue DESC;


/*=========================================================
QUESTION 18:
Revenue by payment method.
=========================================================*/

SELECT
    Payment_Method,
    SUM(Sale_Price) AS Revenue
FROM PC_Sales
GROUP BY Payment_Method
ORDER BY Revenue DESC;

/*=========================================================
QUESTION 19:
How many sales were made using each payment method?
=========================================================*/

SELECT
    Payment_Method,
    COUNT(*) AS TotalTransactions
FROM PC_Sales
GROUP BY Payment_Method
ORDER BY TotalTransactions DESC;


/*=========================================================
QUESTION 20:
How many records have missing ship dates?
=========================================================*/

SELECT
    COUNT(*) AS MissingShipDates
FROM PC_Sales
WHERE Ship_Date = 'N/A';

/*=========================================================
QUESTION 21:
What percentage of records have missing ship dates?
=========================================================*/

SELECT
    COUNT(*) AS MissingShipDates,
    CAST(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM PC_Sales)
        AS DECIMAL(10,2)
    ) AS MissingPercentage
FROM PC_Sales
WHERE Ship_Date = 'N/A';

/*=========================================================
QUESTION 22:
Which payment method has the highest percentage
of missing ship dates?
=========================================================*/

SELECT
    Payment_Method,
    COUNT(*) AS TotalOrders,

    SUM(
        CASE
            WHEN Ship_Date = 'N/A'
            THEN 1
            ELSE 0
        END
    ) AS MissingShipDates,

    CAST(
        SUM(
            CASE
                WHEN Ship_Date = 'N/A'
                THEN 1
                ELSE 0
            END
        ) * 100.0
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS MissingPercentage

FROM PC_Sales
GROUP BY Payment_Method
ORDER BY MissingPercentage DESC;

/*=========================================================
QUESTION 23:
Create a reusable revenue summary using a CTE.
=========================================================*/

WITH BrandRevenue AS
(
    SELECT
        PC_Make,
        SUM(Sale_Price) AS Revenue
    FROM PC_Sales
    GROUP BY PC_Make
)

SELECT *
FROM BrandRevenue
ORDER BY Revenue DESC;


/*=========================================================
QUESTION 24:
Create a reusable view showing brand revenue.
=========================================================*/

CREATE VIEW vw_BrandRevenue
AS
SELECT
    PC_Make,
    SUM(Sale_Price) AS Revenue
FROM PC_Sales
GROUP BY PC_Make;
GO

SELECT *
FROM vw_BrandRevenue
ORDER BY Revenue DESC;


/*=========================================================
QUESTION 25:
Create a stored procedure that returns
the Top 10 PC brands by revenue.
=========================================================*/

CREATE PROCEDURE usp_TopBrands
AS
BEGIN

    SELECT TOP 10
        PC_Make,
        SUM(Sale_Price) AS Revenue
    FROM PC_Sales
    GROUP BY PC_Make
    ORDER BY Revenue DESC;

END;
GO


EXEC usp_TopBrands;


✓ SQL Server
✓ Data Exploration
✓ Data Quality Analysis
✓ Aggregations
✓ GROUP BY
✓ ORDER BY
✓ CASE Statements
✓ Window Functions
✓ CTEs
✓ Views
✓ Stored Procedures
✓ Business Analysis
✓ Revenue Analysis
✓ Profit Analysis
✓ Root Cause Investigation




















































































































































































































































































