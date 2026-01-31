/*
SQL ANALYTICS PORTFOLIO - TABLE DEFINITIONS
File: 02_create_tables.sql
Purpose: Create e-commerce database schema in 'ecommerce' namespace

All tables use the ecommerce schema prefix for proper organization.
This structure supports customer analytics, revenue analysis, and time series queries.
*/

-- Drop existing tables if they exist (for clean setup)
DROP TABLE IF EXISTS ecommerce.order_items CASCADE;
DROP TABLE IF EXISTS ecommerce.subscriptions CASCADE;
DROP TABLE IF EXISTS ecommerce.orders CASCADE;
DROP TABLE IF EXISTS ecommerce.products CASCADE;
DROP TABLE IF EXISTS ecommerce.customers CASCADE;

-- =============================================================================
-- CUSTOMERS TABLE
-- =============================================================================
CREATE TABLE ecommerce.customers (
    customer_id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    signup_date DATE NOT NULL,
    customer_segment VARCHAR(20) CHECK (customer_segment IN ('VIP', 'Regular', 'New')),
    country VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_customers_signup_date ON ecommerce.customers(signup_date);
CREATE INDEX idx_customers_segment ON ecommerce.customers(customer_segment);

-- =============================================================================
-- PRODUCTS TABLE
-- =============================================================================
CREATE TABLE ecommerce.products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    category VARCHAR(50) CHECK (category IN ('Electronics', 'Clothing', 'Home', 'Books', 'Sports')),
    unit_price DECIMAL(10, 2) NOT NULL CHECK (unit_price > 0),
    cost_price DECIMAL(10, 2) NOT NULL CHECK (cost_price > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_products_category ON ecommerce.products(category);

-- =============================================================================
-- ORDERS TABLE
-- =============================================================================
CREATE TABLE ecommerce.orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES ecommerce.customers(customer_id),
    order_date DATE NOT NULL,
    order_status VARCHAR(20) CHECK (order_status IN ('Completed', 'Pending', 'Cancelled', 'Returned')),
    total_amount DECIMAL(10, 2) NOT NULL CHECK (total_amount >= 0),
    shipping_country VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_orders_customer_id ON ecommerce.orders(customer_id);
CREATE INDEX idx_orders_order_date ON ecommerce.orders(order_date);
CREATE INDEX idx_orders_status ON ecommerce.orders(order_status);

-- =============================================================================
-- ORDER_ITEMS TABLE
-- =============================================================================
CREATE TABLE ecommerce.order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES ecommerce.orders(order_id),
    product_id INTEGER NOT NULL REFERENCES ecommerce.products(product_id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price_at_purchase DECIMAL(10, 2) NOT NULL CHECK (unit_price_at_purchase > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_order_items_order_id ON ecommerce.order_items(order_id);
CREATE INDEX idx_order_items_product_id ON ecommerce.order_items(product_id);

-- =============================================================================
-- SUBSCRIPTIONS TABLE
-- =============================================================================
CREATE TABLE ecommerce.subscriptions (
    subscription_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES ecommerce.customers(customer_id),
    plan_type VARCHAR(20) CHECK (plan_type IN ('Monthly', 'Quarterly', 'Annual')),
    start_date DATE NOT NULL,
    end_date DATE,
    monthly_value DECIMAL(10, 2) NOT NULL CHECK (monthly_value > 0),
    status VARCHAR(20) CHECK (status IN ('Active', 'Cancelled', 'Expired')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_subscriptions_customer_id ON ecommerce.subscriptions(customer_id);
CREATE INDEX idx_subscriptions_status ON ecommerce.subscriptions(status);
CREATE INDEX idx_subscriptions_start_date ON ecommerce.subscriptions(start_date);

-- =============================================================================
-- VERIFY TABLES
-- =============================================================================
SELECT 
    table_schema,
    table_name,
    (SELECT COUNT(*) 
     FROM information_schema.columns 
     WHERE columns.table_schema = tables.table_schema 
     AND columns.table_name = tables.table_name) as column_count
FROM information_schema.tables
WHERE table_schema = 'ecommerce'
ORDER BY table_name;

-- Success message
DO $$ 
BEGIN 
    RAISE NOTICE 'All ecommerce tables created successfully!';
END $$;
