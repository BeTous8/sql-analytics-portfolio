# SQL Analytics Portfolio

A comprehensive SQL portfolio demonstrating advanced analytical queries for e-commerce business intelligence. This project showcases data engineering and SQL expertise through real-world business scenarios.

## 📊 Project Overview

This portfolio contains 20+ production-ready SQL queries organized into four analytical categories:
- **Customer Analytics** - CLV, RFM segmentation, cohort analysis, churn prediction
- **Revenue Analysis** - YoY growth, category performance, profit margins, MRR tracking
- **Time Series Analysis** - Moving averages, seasonal patterns, trend analysis
- **Advanced Techniques** - Window functions, recursive CTEs, pivot tables, complex joins

## 🗄️ Database Schema

This project uses PostgreSQL with a separate `ecommerce` schema for logical organization.

### Schema Structure

```
PostgreSQL Database
│
└── ecommerce schema
    ├── customers (customer profiles and segments)
    ├── products (product catalog with pricing)
    ├── orders (transaction records)
    ├── order_items (line items with quantities)
    └── subscriptions (recurring revenue tracking)
```

### Entity Relationship Diagram

```
customers (1) ──< (N) orders (1) ──< (N) order_items (N) >── (1) products
    │
    └──< (N) subscriptions
```

### Tables

**ecommerce.customers**
- `customer_id` (PK) - Unique customer identifier
- `email` (UNIQUE) - Customer email address
- `first_name`, `last_name` - Customer name
- `signup_date` - Account creation date
- `customer_segment` - VIP | Regular | New
- `country` - Shipping country

**ecommerce.products**
- `product_id` (PK) - Unique product identifier
- `product_name` - Product name
- `category` - Electronics | Clothing | Home | Books | Sports
- `unit_price` - Current selling price
- `cost_price` - Cost basis for profit calculations

**ecommerce.orders**
- `order_id` (PK) - Unique order identifier
- `customer_id` (FK) - Links to customers table
- `order_date` - Transaction date
- `order_status` - Completed | Pending | Cancelled | Returned
- `total_amount` - Order total value
- `shipping_country` - Delivery destination

**ecommerce.order_items**
- `order_item_id` (PK) - Unique line item identifier
- `order_id` (FK) - Links to orders table
- `product_id` (FK) - Links to products table
- `quantity` - Units purchased
- `unit_price_at_purchase` - Historical price (captures price changes)

**ecommerce.subscriptions**
- `subscription_id` (PK) - Unique subscription identifier
- `customer_id` (FK) - Links to customers table
- `plan_type` - Monthly | Quarterly | Annual
- `start_date`, `end_date` - Subscription period
- `monthly_value` - Normalized monthly revenue
- `status` - Active | Cancelled | Expired

## 🚀 Setup Instructions

### Prerequisites
- PostgreSQL 12+ (or Supabase account)
- SQL client (psql, pgAdmin, or Supabase SQL Editor)

### Installation Steps

1. **Create the ecommerce schema:**
   ```bash
   psql your_database_url -f schema/01_create_schema.sql
   ```

2. **Create tables:**
   ```bash
   psql your_database_url -f schema/02_create_tables.sql
   ```

3. **Load sample data:**
   ```bash
   psql your_database_url -f schema/03_insert_sample_data.sql
   ```

### Using Supabase SQL Editor

1. Open Supabase Dashboard → SQL Editor
2. Run files in order:
   - `01_create_schema.sql`
   - `02_create_tables.sql`
   - `03_insert_sample_data.sql`
3. Verify tables: 
   ```sql
   SELECT table_name FROM information_schema.tables 
   WHERE table_schema = 'ecommerce';
   ```

## 📝 Query Categories

### 1. Customer Analytics (`queries/01_customer_analytics.sql`)

**Query 1: Customer Lifetime Value (CLV)**
- Calculates total spend, order frequency, and average order value per customer
- Uses window functions (DENSE_RANK) to rank customers
- **Business value**: Identifies most valuable customers for retention efforts

**Query 2: RFM Segmentation**
- Segments customers by Recency, Frequency, and Monetary value
- Uses NTILE() to create quintiles for each metric
- **Business value**: Enables targeted marketing campaigns

**Query 3: Cohort Retention Analysis**
- Tracks customer retention by signup month
- Shows percentage who return to purchase in subsequent months
- **Business value**: Measures effectiveness of onboarding and engagement

**Query 4: New vs Returning Customer Revenue**
- Breaks down monthly revenue by customer type
- Compares average order values between segments
- **Business value**: Informs acquisition vs retention budget allocation

**Query 5: Customer Churn Identification**
- Identifies high-value customers at risk (180+ days inactive)
- Calculates historical value and days inactive
- **Business value**: Enables proactive win-back campaigns

### 2. Revenue Analysis (`queries/02_revenue_analysis.sql`)

**Query 1: Monthly Revenue with YoY Growth**
- Compares monthly revenue to prior year same month
- Uses LAG() function for year-over-year calculations
- **Business value**: Tracks growth trends and seasonality

**Query 2: Revenue by Product Category**
- Shows category contribution with percentages
- Includes order volume and average order value
- **Business value**: Guides inventory and marketing decisions

**Query 3: Top Products by Revenue and Profit**
- Ranks products by revenue and calculates profit margins
- Identifies best-selling vs most profitable products
- **Business value**: Optimizes product mix and pricing

**Query 4: Average Order Value by Customer Segment**
- Compares spending patterns across VIP/Regular/New customers
- Includes statistical metrics (min, max, stddev)
- **Business value**: Validates customer segmentation strategy

**Query 5: Monthly Recurring Revenue (MRR)**
- Tracks subscription revenue trends
- Shows new MRR, churned MRR, and net change
- **Business value**: Critical for SaaS and subscription businesses

### 3. Time Series Analysis (`queries/03_time_series_analysis.sql`)

**Query 1: Moving Averages (7-day and 30-day)**
- Smooths daily order volume and revenue volatility
- Uses ROWS BETWEEN for window frames
- **Business value**: Identifies underlying trends vs noise

**Query 2: Year-over-Year Daily Comparison**
- Compares each day to same day last year
- Uses LAG() with 365-day offset
- **Business value**: Measures growth at granular level

**Query 3: Cumulative Revenue by Month**
- Shows year-to-date cumulative revenue
- Tracks progress toward annual goals
- **Business value**: Enables in-year forecasting

**Query 4: Seasonal Patterns (Quarterly)**
- Analyzes quarterly performance trends
- Labels quarters for business context (Q4 = Holiday)
- **Business value**: Informs inventory and staffing planning

**Query 5: Day-of-Week Analysis**
- Shows which days generate most orders/revenue
- Calculates percentage of total for each day
- **Business value**: Optimizes marketing timing and operations

### 4. Advanced Techniques (`queries/04_advanced_techniques.sql`)

**Query 1: Window Function Showcase**
- Demonstrates ROW_NUMBER, RANK, DENSE_RANK, NTILE
- Shows differences between ranking methods
- **Technical depth**: Multiple window functions simultaneously

**Query 2: Recursive CTE - Date Series**
- Generates complete date range dynamically
- Identifies days with zero orders
- **Technical depth**: Recursive CTEs for complex data generation

**Query 3: PIVOT-Style Analysis**
- Creates cross-tabulation of revenue by month and category
- Uses CASE statements for pivot effect
- **Technical depth**: Matrix-style reporting without PIVOT function

**Query 4: Multi-Level Aggregation with GROUPING SETS**
- Shows subtotals and grand totals simultaneously
- Multiple aggregation levels in single query
- **Technical depth**: Advanced grouping for hierarchical reports

**Query 5: Product Affinity Analysis**
- Finds customers who bought same products (self-join)
- Uses ARRAY_AGG for list aggregation
- **Technical depth**: Complex multi-table joins with aggregation

**Query 6: Percentile Analysis**
- Statistical distribution of order values
- Uses PERCENTILE_CONT for quartiles and beyond
- **Technical depth**: Statistical functions for data analysis

## 🎯 Skills Demonstrated

### SQL Techniques
- ✅ **Window Functions**: ROW_NUMBER, RANK, DENSE_RANK, NTILE, LAG, LEAD
- ✅ **Aggregations**: SUM, AVG, COUNT, MIN, MAX, STDDEV, PERCENTILE_CONT
- ✅ **CTEs (Common Table Expressions)**: Multiple levels, recursive CTEs
- ✅ **Joins**: INNER, LEFT, FULL OUTER, self-joins
- ✅ **Subqueries**: Correlated and non-correlated
- ✅ **Date/Time Functions**: DATE_TRUNC, EXTRACT, AGE, INTERVAL
- ✅ **CASE Statements**: Complex conditional logic
- ✅ **GROUPING SETS**: Multi-level aggregations
- ✅ **Array Functions**: ARRAY_AGG for list aggregation
- ✅ **Statistical Functions**: PERCENTILE_CONT, STDDEV

### Business Analytics
- ✅ Customer Lifetime Value (CLV) calculation
- ✅ RFM segmentation and customer scoring
- ✅ Cohort analysis and retention metrics
- ✅ Churn prediction and identification
- ✅ Revenue trend analysis (YoY, MoM)
- ✅ Product performance and profitability
- ✅ Subscription/MRR tracking
- ✅ Time series analysis and forecasting
- ✅ Seasonal pattern detection
- ✅ Cross-selling and product affinity

### Database Design
- ✅ PostgreSQL schema organization
- ✅ Proper indexing strategy
- ✅ Foreign key relationships
- ✅ CHECK constraints for data quality
- ✅ Normalized data model

## 📈 Sample Query Results

### Customer Lifetime Value Top 10
```
customer_id | customer_name | lifetime_value | order_count | avg_order_value | value_rank
----------- | ------------- | -------------- | ----------- | --------------- | ----------
1001        | John Smith    | $4,523.00      | 12          | $376.92         | 1
1045        | Sarah Davis   | $3,890.00      | 8           | $486.25         | 2
...
```

### Revenue by Category
```
category    | revenue     | revenue_pct | total_orders | avg_order_value
----------- | ----------- | ----------- | ------------ | ---------------
Electronics | $125,432.00 | 42.5%       | 523          | $239.87
Clothing    | $89,234.00  | 30.2%       | 892          | $100.04
...
```

## 🔗 Repository Structure

```
sql-analytics-portfolio/
├── schema/
│   ├── 01_create_schema.sql       # Creates ecommerce schema
│   ├── 02_create_tables.sql       # Table definitions
│   └── 03_insert_sample_data.sql  # Sample data
├── queries/
│   ├── 01_customer_analytics.sql  # 5 customer-focused queries
│   ├── 02_revenue_analysis.sql    # 5 revenue-focused queries
│   ├── 03_time_series_analysis.sql# 5 time-series queries
│   └── 04_advanced_techniques.sql # 6 advanced SQL queries
├── results/
│   └── (screenshots of query outputs)
├── README.md
└── .gitignore
```

## 🛠️ Technologies Used

- **Database**: PostgreSQL 14+ (Supabase compatible)
- **Query Language**: SQL (PostgreSQL dialect)
- **Schema Organization**: PostgreSQL schemas
- **Data Volume**: 50+ customers, 20+ products, 100+ orders (sample dataset)

## 📚 Learning Resources

If you want to understand the techniques used in this portfolio:
- [PostgreSQL Window Functions Documentation](https://www.postgresql.org/docs/current/tutorial-window.html)
- [SQL Style Guide](https://www.sqlstyle.guide/)
- [Mode Analytics SQL Tutorial](https://mode.com/sql-tutorial/)

## 📧 Contact

**Benjamin Tousifar**
- Email: [Your Email]
- LinkedIn: [linkedin.com/in/benjamin-tousifar-44054a112/](https://www.linkedin.com/in/benjamin-tousifar-44054a112/)
- GitHub: [github.com/BeTous8](https://github.com/BeTous8)

## 📄 License

This project is open source and available for portfolio purposes.

---

*Built as part of a data engineering job search portfolio. Demonstrates production-ready SQL skills for analytics and business intelligence roles.*
