/*
=====================================================
CUSTOMER ANALYTICS QUERIES
File: 01_customer_analytics.sql
Purpose: Demonstrate customer-focused analytical SQL
=====================================================
*/

-- ====================================================================
-- QUERY 1: Customer Lifetime Value (CLV) Calculation
-- ====================================================================
/*
BUSINESS QUESTION: What is the lifetime value of each customer, and who are our top customers?
TECHNIQUES USED: Aggregations, window functions (DENSE_RANK), subqueries
EXPECTED OUTPUT: Customer ID, name, total spent, order count, avg order value, rank
*/

WITH customer_summary AS (
    SELECT 
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        c.email,
        c.signup_date,
        c.customer_segment,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(o.total_amount) AS lifetime_value,
        AVG(o.total_amount) AS avg_order_value,
        MAX(o.order_date) AS last_order_date,
        CURRENT_DATE - MAX(o.order_date) AS days_since_last_order
    FROM ecommerce.customers c
    LEFT JOIN ecommerce.orders o ON c.customer_id = o.customer_id AND o.order_status = 'Completed'
    GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.signup_date, c.customer_segment
)
SELECT 
    customer_id,
    customer_name,
    email,
    customer_segment,
    total_orders,
    ROUND(lifetime_value, 2) AS lifetime_value,
    ROUND(avg_order_value, 2) AS avg_order_value,
    last_order_date,
    days_since_last_order,
    DENSE_RANK() OVER (ORDER BY lifetime_value DESC) AS value_rank
FROM customer_summary
WHERE lifetime_value IS NOT NULL
ORDER BY lifetime_value DESC
LIMIT 20;


-- ====================================================================
-- QUERY 2: RFM Segmentation (Recency, Frequency, Monetary)
-- ====================================================================
/*
BUSINESS QUESTION: How can we segment customers by their purchasing behavior?
TECHNIQUES USED: Multiple CTEs, window functions (NTILE), CASE statements
EXPECTED OUTPUT: Customer segments with RFM scores (1-5 for each metric)
*/

WITH rfm_calc AS (
    SELECT 
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        CURRENT_DATE - MAX(o.order_date) AS recency_days,
        COUNT(DISTINCT o.order_id) AS frequency,
        SUM(o.total_amount) AS monetary
    FROM ecommerce.customers c
    LEFT JOIN ecommerce.orders o ON c.customer_id = o.customer_id AND o.order_status = 'Completed'
    GROUP BY c.customer_id, c.first_name, c.last_name
    HAVING COUNT(o.order_id) > 0
),
rfm_scores AS (
    SELECT 
        customer_id,
        customer_name,
        recency_days,
        frequency,
        ROUND(monetary, 2) AS monetary,
        -- Lower recency is better (recent purchases), so reverse the score
        5 - NTILE(5) OVER (ORDER BY recency_days) + 1 AS r_score,
        NTILE(5) OVER (ORDER BY frequency) AS f_score,
        NTILE(5) OVER (ORDER BY monetary) AS m_score
    FROM rfm_calc
)
SELECT 
    customer_id,
    customer_name,
    recency_days,
    frequency,
    monetary,
    r_score,
    f_score,
    m_score,
    (r_score + f_score + m_score) AS total_score,
    CASE 
        WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champions'
        WHEN r_score >= 3 AND f_score >= 3 AND m_score >= 3 THEN 'Loyal Customers'
        WHEN r_score >= 4 AND f_score <= 2 THEN 'Recent Customers'
        WHEN r_score <= 2 AND f_score >= 3 THEN 'At Risk'
        WHEN r_score <= 2 AND f_score <= 2 THEN 'Lost'
        ELSE 'Potential Loyalists'
    END AS customer_segment
FROM rfm_scores
ORDER BY total_score DESC, monetary DESC;


-- ====================================================================
-- QUERY 3: Cohort Retention Analysis
-- ====================================================================
/*
BUSINESS QUESTION: What percentage of customers return to make additional purchases by signup cohort?
TECHNIQUES USED: CTEs, DATE_TRUNC, LEFT JOIN, window functions
EXPECTED OUTPUT: Signup month cohort with retention % in subsequent months
*/

WITH customer_cohorts AS (
    SELECT 
        customer_id,
        DATE_TRUNC('month', signup_date) AS cohort_month
    FROM ecommerce.customers
),
customer_orders AS (
    SELECT 
        o.customer_id,
        DATE_TRUNC('month', o.order_date) AS order_month
    FROM ecommerce.orders o
    WHERE o.order_status = 'Completed'
),
cohort_data AS (
    SELECT 
        cc.cohort_month,
        co.order_month,
        COUNT(DISTINCT co.customer_id) AS customers_active,
        (SELECT COUNT(DISTINCT customer_id) FROM customer_cohorts WHERE cohort_month = cc.cohort_month) AS cohort_size,
        EXTRACT(MONTH FROM AGE(co.order_month, cc.cohort_month)) AS months_since_signup
    FROM customer_cohorts cc
    LEFT JOIN customer_orders co ON cc.customer_id = co.customer_id
    WHERE co.order_month IS NOT NULL
    GROUP BY cc.cohort_month, co.order_month
)
SELECT 
    cohort_month,
    cohort_size,
    months_since_signup,
    customers_active,
    ROUND(100.0 * customers_active / NULLIF(cohort_size, 0), 2) AS retention_percentage
FROM cohort_data
WHERE months_since_signup <= 12  -- First year retention
ORDER BY cohort_month, months_since_signup;


-- ====================================================================
-- QUERY 4: New vs Returning Customer Analysis
-- ====================================================================
/*
BUSINESS QUESTION: What portion of our revenue comes from new vs returning customers?
TECHNIQUES USED: CTEs, window functions (ROW_NUMBER), GROUP BY
EXPECTED OUTPUT: Monthly breakdown of new/returning customer metrics
*/

WITH customer_order_sequence AS (
    SELECT 
        o.order_id,
        o.customer_id,
        o.order_date,
        o.total_amount,
        ROW_NUMBER() OVER (PARTITION BY o.customer_id ORDER BY o.order_date) AS order_sequence
    FROM ecommerce.orders o
    WHERE o.order_status = 'Completed'
)
SELECT 
    DATE_TRUNC('month', order_date) AS order_month,
    COUNT(DISTINCT CASE WHEN order_sequence = 1 THEN customer_id END) AS new_customers,
    COUNT(DISTINCT CASE WHEN order_sequence > 1 THEN customer_id END) AS returning_customers,
    SUM(CASE WHEN order_sequence = 1 THEN total_amount ELSE 0 END) AS new_customer_revenue,
    SUM(CASE WHEN order_sequence > 1 THEN total_amount ELSE 0 END) AS returning_customer_revenue,
    ROUND(AVG(CASE WHEN order_sequence = 1 THEN total_amount END), 2) AS avg_new_customer_order,
    ROUND(AVG(CASE WHEN order_sequence > 1 THEN total_amount END), 2) AS avg_returning_customer_order
FROM customer_order_sequence
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY order_month DESC;


-- ====================================================================
-- QUERY 5: Customer Churn Identification
-- ====================================================================
/*
BUSINESS QUESTION: Which high-value customers are at risk of churning (no purchase in 180+ days)?
TECHNIQUES USED: CTEs, CURRENT_DATE calculations, CASE statements
EXPECTED OUTPUT: At-risk customers with their historical value and days inactive
*/

WITH customer_activity AS (
    SELECT 
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        c.email,
        c.customer_segment,
        MAX(o.order_date) AS last_order_date,
        CURRENT_DATE - MAX(o.order_date) AS days_inactive,
        COUNT(o.order_id) AS total_orders,
        SUM(o.total_amount) AS lifetime_value
    FROM ecommerce.customers c
    LEFT JOIN ecommerce.orders o ON c.customer_id = o.customer_id AND o.order_status = 'Completed'
    GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.customer_segment
)
SELECT 
    customer_id,
    customer_name,
    email,
    customer_segment,
    last_order_date,
    days_inactive,
    total_orders,
    ROUND(lifetime_value, 2) AS lifetime_value,
    CASE 
        WHEN days_inactive >= 365 THEN 'Critical - Lost'
        WHEN days_inactive >= 180 THEN 'High Risk'
        WHEN days_inactive >= 90 THEN 'Medium Risk'
        ELSE 'Active'
    END AS churn_risk
FROM customer_activity
WHERE days_inactive >= 180
  AND lifetime_value > 100  -- Focus on valuable customers
ORDER BY lifetime_value DESC, days_inactive DESC;
