
-- Churned VS Not Churned Customers Count
SELECT IsChurned, COUNT(*) AS CustomerCount
FROM customer_analysis
GROUP BY IsChurned;

-- Chruned VS Active Customers Total Revenue
SELECT IsChurned,
ROUND(SUM(monetaryvalue),0) AS TotalRevenue
FROM customer_analysis
GROUP BY IsChurned;

-- Segment Wise Churn Count
SELECT Segment, ischurned ,COUNT(*) AS ChurnCount
FROM customer_analysis
GROUP BY Segment, ischurned
ORDER BY segment, ischurned;

-- Segment Wise Total Revenue
SELECT segment, ischurned,
ROUND(SUM(monetaryvalue),0) AS TotalRevenue
FROM customer_analysis
GROUP BY segment, ischurned
ORDER BY segment, ischurned;

-- Segment Wise Churn Rate
SELECT segment,
COUNT(*) AS TotalCustomers,
SUM(CASE WHEN ischurned THEN 1 ELSE 0 END) AS ChurnedCustomers,
ROUND(
    100 * SUM(CASE WHEN ischurned THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0), 2
) AS ChurnRatePercentage
FROM customer_analysis
GROUP BY segment
ORDER BY ChurnRatePercentage DESC;

-- Average Spend by Churn Status
SELECT ISCHURNED,
ROUND(AVG(monetaryvalue), 2) AS Average_Customer_Spend,
ROUND(AVG(frequency), 2) AS Average_Frequency,
ROUND(AVG(recency), 2) AS Average_Recency
FROM customer_analysis
GROUP BY ISCHURNED;

-- Recency Distribution by Segment
SELECT segment,
ischurned,
ROUND(AVG(recency), 2) AS Average_Recency,
MIN(recency) AS Min_Recency,
MAX(recency) AS Max_Recency
FROM customer_analysis
GROUP BY segment, ischurned
ORDER BY segment, ischurned;

-- Frequency Distribution by Segment
SELECT segment,
ischurned,
ROUND(AVG(frequency), 2) AS average_orders
FROM customer_analysis
GROUP BY segment, ischurned
ORDER BY segment, ischurned;


-- Revenue Distribution by Segment
SELECT segment,
ROUND(SUM(monetaryvalue), 2) AS Total_Revenue,
ROUND(100 * SUM(monetaryvalue) / SUM(SUM(monetaryvalue)) OVER(), 2) AS Revenue_Percentage
FROM customer_analysis
GROUP BY segment
ORDER BY Total_Revenue DESC;

