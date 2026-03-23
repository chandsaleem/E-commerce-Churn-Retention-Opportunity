CREATE TABLE transactions (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description VARCHAR(255),
    Quantity INT,
    InvoiceDate TIMESTAMP,
    UnitPrice NUMERIC(10, 3),
    CustomerID INT,
    Country VARCHAR(100),
    TotalPrice NUMERIC(12, 3)
);


CREATE TABLE customer_analysis (
    CustomerID INT PRIMARY KEY,
    FirstPurchaseDate TIMESTAMP,
    LastPurchaseDate TIMESTAMP,
    TotalOrders INT,
    TotalSpent NUMERIC(12, 3),
    Recency INT,
    Frequency INT,
    MonetaryValue NUMERIC(12, 3),
    IsChurned BOOLEAN,
    Segment VARCHAR(20)
);


COPY transactions 
FROM '/Users/chandsaleem/Documents/Developer/SQL/Churn Analysis/CSV/cleaned_transactions.csv' 
DELIMITER ',' CSV HEADER;

COPY customer_analysis
FROM '/Users/chandsaleem/Documents/Developer/SQL/Churn Analysis/CSV/customer_analysis.csv' 
DELIMITER ',' CSV HEADER;


SELECT COUNT(*) FROM transactions;
SELECT COUNT(*) FROM customer_analysis;

