# E-commerce Churn & Retention Opportunity (End-to-End Analytics Project)

## Overview
This project analyzes customer churn and retention opportunities for an e-commerce business using transactional purchase data. The goal is to identify where churn is concentrated, quantify revenue risk, and prioritize retention efforts using customer segmentation and clear business metrics.

The workflow is end-to-end:
**Python (cleaning + feature engineering) → PostgreSQL (storage + analysis queries) → Power BI (business dashboard)**

---

## Business Questions
- What is the overall churn rate and how does it vary by customer value segment?
- Where is churn concentrated (customer count vs. revenue impact)?
- Which segment represents the highest revenue risk (total and per churned customer)?
- How strongly is churn associated with one-time vs repeat purchasing behavior?
- How does revenue trend over time?

---

## Dataset
Transactional e-commerce dataset with the following fields:

- `InvoiceNo` (order/invoice id)
- `StockCode` (product id)
- `Description` (product description)
- `Quantity`
- `InvoiceDate`
- `UnitPrice`
- `CustomerID`
- `Country`

Derived:
- `TotalPrice = Quantity * UnitPrice`

---

## Tools Used
- **Python (pandas)**: data cleaning, transformations, feature engineering, customer-level aggregation (RFM), churn flagging, exporting analysis-ready datasets.
- **PostgreSQL**: relational storage, reproducible analysis with SQL (segment churn, revenue at risk, trends).
- **Power BI**: interactive dashboard and storytelling for business decisions.
- **Git/GitHub**: version control, project documentation, portfolio presentation.

---

## Methodology

### 1) Data Cleaning (Python)
Performed cleaning to make the dataset suitable for churn/retention analysis:

- Converted `InvoiceDate` to datetime
- Dropped rows with missing `CustomerID` (required for customer tracking)
  - Nulls found: `CustomerID` = 135,080; `Description` = 1,454 (not critical)
- Removed duplicates
- Removed invalid transactions:
  - Filtered out `Quantity <= 0` (returns/cancellations)
  - Filtered out `UnitPrice <= 0`
- Created `TotalPrice = Quantity * UnitPrice`
- Cast `CustomerID` to integer

Output: **~397,884 cleaned transaction rows**

---

### 2) Customer-Level Feature Engineering (Python)
Built a customer-level dataset for segmentation and churn modeling.

Aggregations per customer:
- `FirstPurchase` = first transaction date
- `LastPurchase` = most recent transaction date
- `TotalOrders` = distinct invoice count
- `TotalSpent` = sum of `TotalPrice`

RFM features:
- `Recency` = days since last purchase
- `Frequency` = number of orders
- `Monetary` = total spend

Snapshot date:
- `snapshot_date = max(InvoiceDate) + 1 day`

Output: **4,338 customers**

---

### 3) Churn Definition (Assumption)
Churn is defined as:

**Customer is churned if they have not purchased in the last 90 days**  
`IsChurned = Recency > 90`

This definition is simple, explainable, and appropriate for a transactional retail dataset where repeat purchases are expected over time.

---

### 4) Segmentation
Customers were segmented into three value tiers using quantile-based binning on `Monetary`:

- **Low**, **Medium**, **High** (roughly equal-sized customer groups)

This allows fair comparison across segments while keeping the logic easy to explain.

---

### 5) Key Metrics and Analysis (SQL + Power BI)
Metrics reproduced and validated through SQL in PostgreSQL and visualized in Power BI:

- Overall churn rate
- Churn rate by segment
- Revenue contribution by segment
- Churn concentration (customer count by segment and churn status)
- **Revenue at risk (total churned revenue) by segment**
- **Revenue at risk per churned customer** (efficiency metric)
- Revenue trend over time (monthly)

---

## Dashboard (Power BI)
The dashboard focuses on decision-making, not just reporting:

- **Low-Value Customers Exhibit Highest Churn Rates**
- **High-Value Customers Drive Majority of Revenue**
- **Total Revenue at Risk (Churned Revenue) by Segment**
- **Revenue at Risk per Churned Customer**
- **Churn is Heavily Concentrated in Low-Value Segment**
- **Majority of Revenue is by Repeat Customers**
- **Revenue Trend by Month (transactions table)**

> Add dashboard screenshot here:
`/assets/dashboard.png`

---

## Summary Insights (from analysis)
- Churn is concentrated in the **low-value segment** by customer count.
- The **high-value segment** contributes the majority of revenue and also represents the largest **total revenue at risk** among churned customers.
- **Revenue at risk per churned customer** is highest in the high-value segment, indicating high return per recovered customer.
- Repeat customers contribute the majority of revenue; churn is strongly associated with one-time purchasing behavior.
- Monthly revenue trends provide business context and seasonality signals.

---

## Assumptions and Limitations
- Churn is defined using a **90-day inactivity** threshold; other thresholds may change the churn rate.
- Returns/cancellations were removed by filtering out `Quantity <= 0`, which simplifies revenue calculations.
- Analysis excludes rows without `CustomerID`, so results apply to identified customers.
- “Revenue at risk” reflects **historical spend of churned customers**, not guaranteed future revenue.

---

## Repository Structure
- `/notebooks/` — Python cleaning + feature engineering
- `/data/` — cleaned exports (optional to include depending on size)
- `/sql/` — PostgreSQL table definitions and analysis queries
- `/powerbi/` — Power BI report file (or instructions to reproduce)
- `/assets/` — dashboard image(s)

---

## How to Reproduce (High Level)
1. Run Python notebook to:
   - clean transactions
   - build customer-level table
   - export `cleaned_ecommerce_data.csv` and `customer_analysis.csv`
2. Create PostgreSQL tables and import CSVs
3. Run SQL queries for churn/segment metrics
4. Build Power BI visuals using the imported tables

---

## Contact
Chand Saleem  
GitHub: https://github.com/chandsaleem
