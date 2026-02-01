/*
======================================================
ADVANCED SQL TECHNIQUES
File: 04_advanced_techniques.sql
Purpose: Demonstrate advanced SQL patterns and functions
======================================================
*/

-- ====================================================================
-- QUERY 1: Window Function Showcase (ROW_NUMBER, RANK, DENSE_RANK)
-- ====================================================================
/*
BUSINESS QUESTION: Show the difference between ranking functions for top products
TECHNIQUES USED: Multiple window functions simultaneously
*/

WITH product_revenue AS (
    SELECT 
        p.product_id,
        p.product_name,
        p.category,
        SUM(oi.quantity * oi.unit_price_at_purchase) AS total_revenue
    FROM ecommerce.products p
    JOIN ecommerce.order_items oi ON p.product_id = oi.product_id
    JOIN ecommerce.orders o ON oi.order_id = o.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY p.product_id, p.product_name, p.category
)
SELECT 
    product_id,
    product_name,
    category,
    ROUND(total_revenue, 2) AS revenue,
    ROW_NUMBER() OVER (ORDER BY total_revenue DESC) AS row_num,
    RANK() OVER (ORDER BY total_revenue DESC) AS rank_num,
    DENSE_RANK() OVER (ORDER BY total_revenue DESC) AS dense_rank_num,
    NTILE(4) OVER (ORDER BY total_revenue DESC) AS quartile
FROM product_revenue
ORDER BY total_revenue DESC;


-- ====================================================================
-- QUERY 2: Recursive CTE - Generate Date Series
-- ====================================================================
/*
BUSINESS QUESTION: Generate a complete date series and identify days with zero orders
TECHNIQUES USED: Recursive CTE, LEFT JOIN to identify gaps
*/

WITH RECURSIVE date_series AS (
    -- Base case: start date
    SELECT DATE '2024-01-01' AS date
    
    UNION ALL
    
    -- Recursive case: add one day at a time
    SELECT date + INTERVAL '1 day'
    FROM date_series
    WHERE date < CURRENT_DATE
),
daily_orders AS (
    SELECT 
        order_date,
        COUNT(*) AS order_count,
        SUM(total_amount) AS revenue
    FROM ecommerce.orders
    WHERE order_status = 'Completed'
    GROUP BY order_date
)
SELECT 
    ds.date,
    TO_CHAR(ds.date, 'Day') AS day_name,
    COALESCE(do.order_count, 0) AS order_count,
    COALESCE(ROUND(do.revenue, 2), 0) AS revenue,
    CASE 
        WHEN do.order_count IS NULL THEN 'No Orders'
        WHEN do.order_count < 5 THEN 'Low Activity'
        ELSE 'Normal Activity'
    END AS activity_level
FROM date_series ds
LEFT JOIN daily_orders do ON ds.date = do.order_date
WHERE ds.date >= CURRENT_DATE - INTERVAL '30 days'
ORDER BY ds.date DESC;


-- ====================================================================
-- QUERY 3: PIVOT-Style Analysis (Orders by Month and Category)
-- ====================================================================
/*
BUSINESS QUESTION: Create a cross-tabulation of revenue by month and category
TECHNIQUES USED: CASE statements with GROUP BY for pivot effect
*/

SELECT 
    TO_CHAR(DATE_TRUNC('month', o.order_date), 'YYYY-MM') AS month,
    ROUND(SUM(CASE WHEN p.category = 'Electronics' THEN oi.quantity * oi.unit_price_at_purchase ELSE 0 END), 2) AS electronics_revenue,
    ROUND(SUM(CASE WHEN p.category = 'Clothing' THEN oi.quantity * oi.unit_price_at_purchase ELSE 0 END), 2) AS clothing_revenue,
    ROUND(SUM(CASE WHEN p.category = 'Home' THEN oi.quantity * oi.unit_price_at_purchase ELSE 0 END), 2) AS home_revenue,
    ROUND(SUM(CASE WHEN p.category = 'Books' THEN oi.quantity * oi.unit_price_at_purchase ELSE 0 END), 2) AS books_revenue,
    ROUND(SUM(CASE WHEN p.category = 'Sports' THEN oi.quantity * oi.unit_price_at_purchase ELSE 0 END), 2) AS sports_revenue,
    ROUND(SUM(oi.quantity * oi.unit_price_at_purchase), 2) AS total_revenue
FROM ecommerce.orders o
JOIN ecommerce.order_items oi ON o.order_id = oi.order_id
JOIN ecommerce.products p ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY DATE_TRUNC('month', o.order_date)
ORDER BY month DESC
LIMIT 12;


-- ====================================================================
-- QUERY 4: Complex Multi-Level Aggregation with GROUPING SETS
-- ====================================================================
/*
BUSINESS QUESTION: Show revenue breakdowns at multiple aggregation levels simultaneously
TECHNIQUES USED: GROUPING SETS for subtotals and grand totals
*/

SELECT 
    COALESCE(p.category, 'ALL CATEGORIES') AS category,
    COALESCE(c.country, 'ALL COUNTRIES') AS country,
    COUNT(DISTINCT o.order_id) AS order_count,
    ROUND(SUM(oi.quantity * oi.unit_price_at_purchase), 2) AS total_revenue,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value
FROM ecommerce.orders o
JOIN ecommerce.order_items oi ON o.order_id = oi.order_id
JOIN ecommerce.products p ON oi.product_id = p.product_id
JOIN ecommerce.customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'Completed'
GROUP BY GROUPING SETS (
    (p.category, c.country),  -- By category and country
    (p.category),              -- By category only
    (c.country),               -- By country only
    ()                         -- Grand total
)
ORDER BY 
    CASE WHEN category = 'ALL CATEGORIES' THEN 1 ELSE 0 END,
    category,
    CASE WHEN country = 'ALL COUNTRIES' THEN 1 ELSE 0 END,
    country;


-- ====================================================================
-- QUERY 5: Advanced Join - Customers Who Bought Same Products
-- ====================================================================
/*
BUSINESS QUESTION: Find customers who purchased the same products (product affinity)
TECHNIQUES USED: Self-join, HAVING clause, complex filtering
*/

WITH customer_products AS (
    SELECT DISTINCT
        o.customer_id,
        oi.product_id,
        c.first_name || ' ' || c.last_name AS customer_name
    FROM ecommerce.orders o
    JOIN ecommerce.order_items oi ON o.order_id = oi.order_id
    JOIN ecommerce.customers c ON o.customer_id = c.customer_id
    WHERE o.order_status = 'Completed'
)
SELECT 
    cp1.customer_id AS customer_1_id,
    cp1.customer_name AS customer_1_name,
    cp2.customer_id AS customer_2_id,
    cp2.customer_name AS customer_2_name,
    COUNT(DISTINCT cp1.product_id) AS shared_products,
    ARRAY_AGG(DISTINCT p.product_name ORDER BY p.product_name) AS product_names
FROM customer_products cp1
JOIN customer_products cp2 ON cp1.product_id = cp2.product_id 
    AND cp1.customer_id < cp2.customer_id  -- Avoid duplicates
JOIN ecommerce.products p ON cp1.product_id = p.product_id
GROUP BY cp1.customer_id, cp1.customer_name, cp2.customer_id, cp2.customer_name
HAVING COUNT(DISTINCT cp1.product_id) >= 2  -- At least 2 products in common
ORDER BY shared_products DESC, cp1.customer_id
LIMIT 20;


-- ====================================================================
-- QUERY 6: BONUS - Percentile Analysis
-- ====================================================================
/*
BUSINESS QUESTION: What are the percentile breakdowns for order values?
TECHNIQUES USED: PERCENTILE_CONT, statistical analysis
*/

SELECT 
    ROUND(MIN(total_amount), 2) AS minimum,
    ROUND(PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_amount), 2) AS p25_percentile,
    ROUND(PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY total_amount), 2) AS median,
    ROUND(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_amount), 2) AS p75_percentile,
    ROUND(PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY total_amount), 2) AS p90_percentile,
    ROUND(PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY total_amount), 2) AS p95_percentile,
    ROUND(MAX(total_amount), 2) AS maximum,
    ROUND(AVG(total_amount), 2) AS mean,
    ROUND(STDDEV(total_amount), 2) AS std_dev
FROM ecommerce.orders
WHERE order_status = 'Completed';
