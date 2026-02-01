/*
==================================================
REVENUE ANALYSIS QUERIES
File: 02_revenue_analysis.sql
Purpose: Demonstrate revenue-focused analytical SQL
==================================================
*/

-- ====================================================================
-- QUERY 1: Monthly Revenue with Year-over-Year Growth
-- ====================================================================
/*
BUSINESS QUESTION: How is our monthly revenue trending compared to last year?
TECHNIQUES USED: DATE_TRUNC, LAG function, percentage calculations
*/

WITH monthly_revenue AS (
    SELECT 
        DATE_TRUNC('month', order_date) AS month,
        SUM(total_amount) AS revenue
    FROM ecommerce.orders
    WHERE order_status = 'Completed'
    GROUP BY DATE_TRUNC('month', order_date)
)
SELECT 
    month,
    ROUND(revenue, 2) AS current_revenue,
    ROUND(LAG(revenue, 12) OVER (ORDER BY month), 2) AS prior_year_revenue,
    ROUND(revenue - LAG(revenue, 12) OVER (ORDER BY month), 2) AS yoy_change,
    ROUND(100.0 * (revenue - LAG(revenue, 12) OVER (ORDER BY month)) / 
          NULLIF(LAG(revenue, 12) OVER (ORDER BY month), 0), 2) AS yoy_growth_pct
FROM monthly_revenue
ORDER BY month DESC;


-- ====================================================================
-- QUERY 2: Revenue by Product Category with Percentage
-- ====================================================================
/*
BUSINESS QUESTION: Which product categories generate the most revenue?
TECHNIQUES USED: JOIN, window functions for percentage calculation
*/

WITH category_revenue AS (
    SELECT 
        p.category,
        SUM(oi.quantity * oi.unit_price_at_purchase) AS total_revenue,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(oi.quantity) AS units_sold
    FROM ecommerce.order_items oi
    JOIN ecommerce.orders o ON oi.order_id = o.order_id
    JOIN ecommerce.products p ON oi.product_id = p.product_id
    WHERE o.order_status = 'Completed'
    GROUP BY p.category
)
SELECT 
    category,
    ROUND(total_revenue, 2) AS revenue,
    ROUND(100.0 * total_revenue / SUM(total_revenue) OVER (), 2) AS revenue_percentage,
    total_orders,
    units_sold,
    ROUND(total_revenue / NULLIF(total_orders, 0), 2) AS avg_order_value
FROM category_revenue
ORDER BY total_revenue DESC;


-- ====================================================================
-- QUERY 3: Top Products by Revenue and Profit Margin
-- ====================================================================
/*
BUSINESS QUESTION: Which products are most profitable?
TECHNIQUES USED: Multiple joins, profit calculations, RANK()
*/

SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.unit_price AS current_price,
    SUM(oi.quantity) AS units_sold,
    ROUND(SUM(oi.quantity * oi.unit_price_at_purchase), 2) AS total_revenue,
    ROUND(SUM(oi.quantity * p.cost_price), 2) AS total_cost,
    ROUND(SUM(oi.quantity * (oi.unit_price_at_purchase - p.cost_price)), 2) AS total_profit,
    ROUND(100.0 * SUM(oi.quantity * (oi.unit_price_at_purchase - p.cost_price)) / 
          NULLIF(SUM(oi.quantity * oi.unit_price_at_purchase), 0), 2) AS profit_margin_pct,
    RANK() OVER (ORDER BY SUM(oi.quantity * oi.unit_price_at_purchase) DESC) AS revenue_rank
FROM ecommerce.products p
JOIN ecommerce.order_items oi ON p.product_id = oi.product_id
JOIN ecommerce.orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY p.product_id, p.product_name, p.category, p.unit_price, p.cost_price
ORDER BY total_profit DESC
LIMIT 10;


-- ====================================================================
-- QUERY 4: Average Order Value by Customer Segment
-- ====================================================================
/*
BUSINESS QUESTION: Do VIP customers spend more per order than regular customers?
TECHNIQUES USED: GROUP BY, aggregations, statistical comparison
*/

SELECT 
    c.customer_segment,
    COUNT(DISTINCT c.customer_id) AS customer_count,
    COUNT(o.order_id) AS total_orders,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value,
    ROUND(MIN(o.total_amount), 2) AS min_order_value,
    ROUND(MAX(o.total_amount), 2) AS max_order_value,
    ROUND(STDDEV(o.total_amount), 2) AS stddev_order_value,
    ROUND(SUM(o.total_amount), 2) AS total_revenue,
    ROUND(SUM(o.total_amount) / NULLIF(COUNT(DISTINCT c.customer_id), 0), 2) AS revenue_per_customer
FROM ecommerce.customers c
JOIN ecommerce.orders o ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_segment
ORDER BY avg_order_value DESC;


-- ====================================================================
-- QUERY 5: Monthly Recurring Revenue (MRR) from Subscriptions
-- ====================================================================
/*
BUSINESS QUESTION: What is our MRR trend and how much are we gaining/losing monthly?
TECHNIQUES USED: Date series, LEFT JOIN, CASE statements for status
*/

WITH monthly_subscriptions AS (
    SELECT 
        DATE_TRUNC('month', start_date) AS month,
        SUM(monthly_value) AS new_mrr
    FROM ecommerce.subscriptions
    GROUP BY DATE_TRUNC('month', start_date)
),
churned_subscriptions AS (
    SELECT 
        DATE_TRUNC('month', end_date) AS month,
        SUM(monthly_value) AS churned_mrr
    FROM ecommerce.subscriptions
    WHERE status IN ('Cancelled', 'Expired') AND end_date IS NOT NULL
    GROUP BY DATE_TRUNC('month', end_date)
)
SELECT 
    COALESCE(ms.month, cs.month) AS month,
    COALESCE(ms.new_mrr, 0) AS new_mrr,
    COALESCE(cs.churned_mrr, 0) AS churned_mrr,
    COALESCE(ms.new_mrr, 0) - COALESCE(cs.churned_mrr, 0) AS net_mrr_change
FROM monthly_subscriptions ms
FULL OUTER JOIN churned_subscriptions cs ON ms.month = cs.month
ORDER BY month DESC;
