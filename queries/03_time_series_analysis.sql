/*
====================================================
TIME SERIES ANALYSIS QUERIES
File: 03_time_series_analysis.sql
Purpose: Demonstrate time-series analytical SQL
====================================================
*/

-- ====================================================================
-- QUERY 1: Moving Averages (7-day and 30-day)
-- ====================================================================
/*
BUSINESS QUESTION: What are the smoothed trends in daily order volume?
TECHNIQUES USED: Window functions with ROWS BETWEEN, date aggregation
*/

WITH daily_orders AS (
    SELECT 
        order_date,
        COUNT(*) AS order_count,
        SUM(total_amount) AS daily_revenue
    FROM ecommerce.orders
    WHERE order_status = 'Completed'
    GROUP BY order_date
)
SELECT 
    order_date,
    order_count,
    ROUND(daily_revenue, 2) AS daily_revenue,
    ROUND(AVG(order_count) OVER (
        ORDER BY order_date 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ), 2) AS moving_avg_7day_orders,
    ROUND(AVG(daily_revenue) OVER (
        ORDER BY order_date 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ), 2) AS moving_avg_7day_revenue,
    ROUND(AVG(order_count) OVER (
        ORDER BY order_date 
        ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
    ), 2) AS moving_avg_30day_orders,
    ROUND(AVG(daily_revenue) OVER (
        ORDER BY order_date 
        ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
    ), 2) AS moving_avg_30day_revenue
FROM daily_orders
ORDER BY order_date DESC
LIMIT 90;


-- ====================================================================
-- QUERY 2: Year-over-Year Daily Comparison
-- ====================================================================
/*
BUSINESS QUESTION: How does each day compare to the same day last year?
TECHNIQUES USED: LAG function with 365-day offset, date functions
*/

WITH daily_metrics AS (
    SELECT 
        order_date,
        COUNT(*) AS orders,
        SUM(total_amount) AS revenue
    FROM ecommerce.orders
    WHERE order_status = 'Completed'
    GROUP BY order_date
)
SELECT 
    order_date,
    orders AS current_orders,
    revenue AS current_revenue,
    LAG(orders, 365) OVER (ORDER BY order_date) AS prior_year_orders,
    LAG(revenue, 365) OVER (ORDER BY order_date) AS prior_year_revenue,
    orders - LAG(orders, 365) OVER (ORDER BY order_date) AS order_diff,
    ROUND(revenue - LAG(revenue, 365) OVER (ORDER BY order_date), 2) AS revenue_diff,
    ROUND(100.0 * (revenue - LAG(revenue, 365) OVER (ORDER BY order_date)) / 
          NULLIF(LAG(revenue, 365) OVER (ORDER BY order_date), 0), 2) AS yoy_growth_pct
FROM daily_metrics
WHERE order_date >= CURRENT_DATE - INTERVAL '90 days'
ORDER BY order_date DESC;


-- ====================================================================
-- QUERY 3: Cumulative Revenue by Month
-- ====================================================================
/*
BUSINESS QUESTION: What is our year-to-date cumulative revenue each month?
TECHNIQUES USED: SUM() OVER with ORDER BY (running total)
*/

WITH monthly_revenue AS (
    SELECT 
        DATE_TRUNC('month', order_date) AS month,
        EXTRACT(YEAR FROM order_date) AS year,
        SUM(total_amount) AS monthly_revenue
    FROM ecommerce.orders
    WHERE order_status = 'Completed'
    GROUP BY DATE_TRUNC('month', order_date), EXTRACT(YEAR FROM order_date)
)
SELECT 
    month,
    year,
    ROUND(monthly_revenue, 2) AS monthly_revenue,
    ROUND(SUM(monthly_revenue) OVER (
        PARTITION BY year 
        ORDER BY month
    ), 2) AS cumulative_revenue_ytd,
    ROUND(AVG(monthly_revenue) OVER (
        PARTITION BY year 
        ORDER BY month
    ), 2) AS avg_revenue_ytd
FROM monthly_revenue
ORDER BY month DESC;


-- ====================================================================
-- QUERY 4: Seasonal Patterns (Quarterly Comparison)
-- ====================================================================
/*
BUSINESS QUESTION: Which quarters perform best and how consistent is the pattern?
TECHNIQUES USED: EXTRACT, CASE statements, multiple aggregations
*/

SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(QUARTER FROM order_date) AS quarter,
    COUNT(*) AS total_orders,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS avg_order_value,
    COUNT(DISTINCT customer_id) AS unique_customers,
    CASE EXTRACT(QUARTER FROM order_date)
        WHEN 1 THEN 'Q1 - Winter'
        WHEN 2 THEN 'Q2 - Spring'
        WHEN 3 THEN 'Q3 - Summer'
        WHEN 4 THEN 'Q4 - Holiday'
    END AS quarter_label
FROM ecommerce.orders
WHERE order_status = 'Completed'
GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(QUARTER FROM order_date)
ORDER BY year DESC, quarter;


-- ====================================================================
-- QUERY 5: Day-of-Week Analysis
-- ====================================================================
/*
BUSINESS QUESTION: Which days of the week are busiest for orders?
TECHNIQUES USED: EXTRACT(DOW), TO_CHAR, aggregations
*/

SELECT 
    EXTRACT(DOW FROM order_date) AS day_number,
    TO_CHAR(order_date, 'Day') AS day_name,
    COUNT(*) AS total_orders,
    ROUND(AVG(total_amount), 2) AS avg_order_value,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_total_orders
FROM ecommerce.orders
WHERE order_status = 'Completed'
GROUP BY EXTRACT(DOW FROM order_date), TO_CHAR(order_date, 'Day')
ORDER BY day_number;
