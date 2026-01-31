/*
SQL ANALYTICS PORTFOLIO - SAMPLE DATA
File: 03_insert_sample_data.sql
Purpose: Insert realistic sample data for analytics queries

Data includes:
- 50 customers across 2022-2025
- 20 products across 5 categories
- 139 orders spanning Jan 2023 - Jun 2025
- ~180 order items matching all orders
- 30 subscriptions with varied statuses
*/

-- =============================================================================
-- CUSTOMERS (50 customers, signup dates from 2022 to 2025)
-- =============================================================================

INSERT INTO ecommerce.customers (email, first_name, last_name, signup_date, customer_segment, country) VALUES
('john.smith@email.com', 'John', 'Smith', '2022-01-15', 'VIP', 'United States'),
('emily.johnson@email.com', 'Emily', 'Johnson', '2022-02-20', 'Regular', 'United States'),
('michael.brown@email.com', 'Michael', 'Brown', '2022-03-10', 'Regular', 'Canada'),
('sarah.davis@email.com', 'Sarah', 'Davis', '2022-04-05', 'New', 'United Kingdom'),
('david.wilson@email.com', 'David', 'Wilson', '2022-05-12', 'VIP', 'Australia'),
('jessica.miller@email.com', 'Jessica', 'Miller', '2022-06-18', 'Regular', 'United States'),
('james.moore@email.com', 'James', 'Moore', '2022-07-22', 'Regular', 'Canada'),
('linda.taylor@email.com', 'Linda', 'Taylor', '2022-08-30', 'New', 'United States'),
('robert.anderson@email.com', 'Robert', 'Anderson', '2022-09-14', 'VIP', 'United Kingdom'),
('jennifer.thomas@email.com', 'Jennifer', 'Thomas', '2022-10-25', 'Regular', 'Australia'),
('william.jackson@email.com', 'William', 'Jackson', '2022-11-08', 'Regular', 'United States'),
('mary.white@email.com', 'Mary', 'White', '2022-11-15', 'New', 'Canada'),
('charles.harris@email.com', 'Charles', 'Harris', '2022-11-22', 'Regular', 'United States'),
('patricia.martin@email.com', 'Patricia', 'Martin', '2022-12-01', 'VIP', 'United Kingdom'),
('daniel.thompson@email.com', 'Daniel', 'Thompson', '2022-12-10', 'Regular', 'Australia'),
('christopher.garcia@email.com', 'Christopher', 'Garcia', '2023-01-05', 'Regular', 'United States'),
('nancy.martinez@email.com', 'Nancy', 'Martinez', '2023-02-14', 'New', 'United States'),
('matthew.robinson@email.com', 'Matthew', 'Robinson', '2023-03-20', 'Regular', 'Canada'),
('betty.clark@email.com', 'Betty', 'Clark', '2023-04-18', 'VIP', 'United Kingdom'),
('anthony.rodriguez@email.com', 'Anthony', 'Rodriguez', '2023-05-25', 'Regular', 'United States'),
('donald.lewis@email.com', 'Donald', 'Lewis', '2023-06-30', 'Regular', 'Australia'),
('sandra.lee@email.com', 'Sandra', 'Lee', '2023-07-12', 'New', 'United States'),
('mark.walker@email.com', 'Mark', 'Walker', '2023-08-19', 'Regular', 'Canada'),
('ashley.hall@email.com', 'Ashley', 'Hall', '2023-09-22', 'VIP', 'United Kingdom'),
('steven.allen@email.com', 'Steven', 'Allen', '2023-10-28', 'Regular', 'Australia'),
('kimberly.young@email.com', 'Kimberly', 'Young', '2023-11-05', 'Regular', 'United States'),
('paul.hernandez@email.com', 'Paul', 'Hernandez', '2023-11-12', 'New', 'United States'),
('andrew.king@email.com', 'Andrew', 'King', '2023-11-20', 'Regular', 'Canada'),
('karen.wright@email.com', 'Karen', 'Wright', '2023-12-03', 'VIP', 'United Kingdom'),
('joshua.lopez@email.com', 'Joshua', 'Lopez', '2023-12-15', 'Regular', 'Australia'),
('kevin.hill@email.com', 'Kevin', 'Hill', '2024-01-08', 'Regular', 'United States'),
('donna.scott@email.com', 'Donna', 'Scott', '2024-02-16', 'New', 'Canada'),
('brian.green@email.com', 'Brian', 'Green', '2024-03-21', 'Regular', 'United States'),
('carol.adams@email.com', 'Carol', 'Adams', '2024-04-25', 'VIP', 'United Kingdom'),
('george.baker@email.com', 'George', 'Baker', '2024-05-30', 'Regular', 'Australia'),
('michelle.gonzalez@email.com', 'Michelle', 'Gonzalez', '2024-06-14', 'Regular', 'United States'),
('edward.nelson@email.com', 'Edward', 'Nelson', '2024-07-18', 'New', 'Canada'),
('ronald.carter@email.com', 'Ronald', 'Carter', '2024-08-22', 'Regular', 'United States'),
('laura.mitchell@email.com', 'Laura', 'Mitchell', '2024-09-27', 'VIP', 'United Kingdom'),
('jason.perez@email.com', 'Jason', 'Perez', '2024-10-31', 'Regular', 'Australia'),
('deborah.roberts@email.com', 'Deborah', 'Roberts', '2024-11-06', 'Regular', 'United States'),
('jeffrey.turner@email.com', 'Jeffrey', 'Turner', '2024-11-14', 'New', 'United States'),
('ryan.phillips@email.com', 'Ryan', 'Phillips', '2024-11-23', 'Regular', 'Canada'),
('helen.campbell@email.com', 'Helen', 'Campbell', '2024-12-05', 'VIP', 'United Kingdom'),
('gary.parker@email.com', 'Gary', 'Parker', '2024-12-18', 'Regular', 'Australia'),
('cynthia.evans@email.com', 'Cynthia', 'Evans', '2025-01-10', 'Regular', 'United States'),
('nicholas.edwards@email.com', 'Nicholas', 'Edwards', '2025-01-15', 'New', 'Canada'),
('amy.collins@email.com', 'Amy', 'Collins', '2025-01-20', 'Regular', 'United States'),
('raymond.stewart@email.com', 'Raymond', 'Stewart', '2025-01-25', 'VIP', 'United Kingdom'),
('shirley.sanchez@email.com', 'Shirley', 'Sanchez', '2025-01-27', 'Regular', 'Australia');

-- =============================================================================
-- PRODUCTS (20 products across 5 categories)
-- =============================================================================

INSERT INTO ecommerce.products (product_name, category, unit_price, cost_price) VALUES
('Wireless Headphones Pro', 'Electronics', 149.99, 75.00),
('Smart Watch Series 5', 'Electronics', 399.99, 200.00),
('Bluetooth Speaker', 'Electronics', 79.99, 35.00),
('USB-C Hub 7-in-1', 'Electronics', 49.99, 20.00),
('Premium Cotton T-Shirt', 'Clothing', 29.99, 10.00),
('Denim Jeans Classic Fit', 'Clothing', 79.99, 30.00),
('Winter Jacket Waterproof', 'Clothing', 149.99, 60.00),
('Running Shoes Pro', 'Clothing', 119.99, 50.00),
('Coffee Maker Deluxe', 'Home', 89.99, 40.00),
('Bedding Set Queen', 'Home', 129.99, 55.00),
('Kitchen Knife Set', 'Home', 99.99, 35.00),
('LED Desk Lamp', 'Home', 45.99, 18.00),
('Data Engineering Fundamentals', 'Books', 49.99, 15.00),
('Python for Data Analysis', 'Books', 59.99, 20.00),
('SQL Performance Tuning', 'Books', 44.99, 14.00),
('Cloud Architecture Patterns', 'Books', 54.99, 18.00),
('Yoga Mat Premium', 'Sports', 39.99, 15.00),
('Resistance Bands Set', 'Sports', 29.99, 10.00),
('Dumbbell Set 20lb', 'Sports', 79.99, 30.00),
('Exercise Bike Indoor', 'Sports', 299.99, 150.00);

-- =============================================================================
-- ORDERS (139 orders: Jan 2023 - Jun 2025, sorted chronologically)
-- Statuses: ~90% Completed, plus Cancelled/Returned/Pending
-- =============================================================================

INSERT INTO ecommerce.orders (customer_id, order_date, order_status, total_amount, shipping_country) VALUES
-- January 2023
(1, '2023-01-05', 'Completed', 229.98, 'United States'),
(5, '2023-01-10', 'Completed', 399.99, 'Australia'),
(9, '2023-01-15', 'Completed', 149.99, 'United Kingdom'),
(14, '2023-01-22', 'Completed', 179.98, 'United Kingdom'),
-- February 2023
(1, '2023-02-03', 'Completed', 119.99, 'United States'),
(2, '2023-02-10', 'Completed', 59.99, 'United States'),
(19, '2023-02-14', 'Completed', 449.98, 'United Kingdom'),
(6, '2023-02-22', 'Completed', 89.99, 'United States'),
-- March 2023
(5, '2023-03-05', 'Completed', 149.99, 'Australia'),
(8, '2023-03-10', 'Completed', 75.98, 'United States'),
(14, '2023-03-12', 'Completed', 299.99, 'United Kingdom'),
(3, '2023-03-18', 'Completed', 54.99, 'Canada'),
(9, '2023-03-25', 'Completed', 399.99, 'United Kingdom'),
-- April 2023
(1, '2023-04-05', 'Completed', 399.99, 'United States'),
(7, '2023-04-12', 'Completed', 49.99, 'Canada'),
(10, '2023-04-15', 'Completed', 79.99, 'Australia'),
(24, '2023-04-20', 'Cancelled', 399.99, 'United Kingdom'),
-- May 2023
(5, '2023-05-03', 'Completed', 119.98, 'Australia'),
(12, '2023-05-08', 'Completed', 99.99, 'Canada'),
(14, '2023-05-12', 'Completed', 119.99, 'United Kingdom'),
(11, '2023-05-22', 'Completed', 79.99, 'United States'),
-- June 2023
(9, '2023-06-05', 'Completed', 94.98, 'United Kingdom'),
(13, '2023-06-12', 'Completed', 79.99, 'United States'),
(1, '2023-06-15', 'Completed', 99.99, 'United States'),
(6, '2023-06-25', 'Completed', 59.99, 'United States'),
-- July 2023
(5, '2023-07-04', 'Completed', 99.99, 'Australia'),
(13, '2023-07-08', 'Completed', 99.98, 'United States'),
(14, '2023-07-12', 'Completed', 399.99, 'United Kingdom'),
(3, '2023-07-20', 'Cancelled', 39.99, 'Canada'),
-- August 2023
(1, '2023-08-05', 'Completed', 99.98, 'United States'),
(20, '2023-08-10', 'Completed', 149.99, 'United States'),
(9, '2023-08-14', 'Completed', 149.99, 'United Kingdom'),
(17, '2023-08-15', 'Completed', 59.98, 'United States'),
(4, '2023-08-22', 'Completed', 449.98, 'United Kingdom'),
-- September 2023
(5, '2023-09-03', 'Completed', 109.98, 'Australia'),
(14, '2023-09-12', 'Completed', 135.98, 'United Kingdom'),
(22, '2023-09-15', 'Completed', 399.99, 'United States'),
(19, '2023-09-22', 'Completed', 149.99, 'United Kingdom'),
(25, '2023-09-25', 'Completed', 79.99, 'Australia'),
-- October 2023
(1, '2023-10-02', 'Pending', 59.99, 'United States'),
(8, '2023-10-05', 'Completed', 149.99, 'United States'),
(9, '2023-10-10', 'Completed', 299.99, 'United Kingdom'),
(15, '2023-10-15', 'Completed', 45.99, 'Australia'),
(24, '2023-10-18', 'Completed', 79.99, 'United Kingdom'),
(29, '2023-10-25', 'Completed', 399.99, 'United Kingdom'),
-- November 2023
(5, '2023-11-02', 'Completed', 199.98, 'Australia'),
(14, '2023-11-07', 'Completed', 149.99, 'United Kingdom'),
(10, '2023-11-10', 'Completed', 104.98, 'Australia'),
(4, '2023-11-12', 'Completed', 189.98, 'United Kingdom'),
(29, '2023-11-18', 'Completed', 339.98, 'United Kingdom'),
(21, '2023-11-20', 'Completed', 39.99, 'Australia'),
(1, '2023-11-25', 'Completed', 129.99, 'United States'),
-- December 2023 (Holiday)
(5, '2023-12-02', 'Completed', 479.98, 'Australia'),
(9, '2023-12-06', 'Completed', 269.98, 'United Kingdom'),
(12, '2023-12-08', 'Completed', 109.98, 'Canada'),
(14, '2023-12-10', 'Completed', 109.98, 'United Kingdom'),
(19, '2023-12-14', 'Completed', 399.99, 'United Kingdom'),
(24, '2023-12-20', 'Completed', 129.99, 'United Kingdom'),
(2, '2023-12-28', 'Completed', 149.99, 'United States'),
-- January 2024
(1, '2024-01-05', 'Completed', 195.98, 'United States'),
(5, '2024-01-10', 'Cancelled', 89.99, 'Australia'),
(9, '2024-01-15', 'Completed', 59.99, 'United Kingdom'),
(7, '2024-01-15', 'Completed', 99.98, 'Canada'),
(31, '2024-01-22', 'Completed', 129.99, 'United States'),
-- February 2024
(14, '2024-02-05', 'Completed', 99.99, 'United Kingdom'),
(5, '2024-02-12', 'Completed', 299.99, 'Australia'),
(16, '2024-02-15', 'Completed', 399.99, 'United States'),
(3, '2024-02-18', 'Completed', 109.98, 'Canada'),
(32, '2024-02-25', 'Completed', 49.99, 'Canada'),
-- March 2024
(1, '2024-03-04', 'Completed', 39.99, 'United States'),
(9, '2024-03-11', 'Completed', 99.99, 'United Kingdom'),
(20, '2024-03-12', 'Completed', 119.99, 'United States'),
(14, '2024-03-18', 'Returned', 399.99, 'United Kingdom'),
(29, '2024-03-25', 'Completed', 79.99, 'United Kingdom'),
(11, '2024-03-25', 'Completed', 149.99, 'United States'),
-- April 2024
(5, '2024-04-03', 'Completed', 129.98, 'Australia'),
(19, '2024-04-10', 'Completed', 149.99, 'United Kingdom'),
(24, '2024-04-17', 'Pending', 299.99, 'United Kingdom'),
(22, '2024-04-18', 'Returned', 129.99, 'United States'),
(34, '2024-04-28', 'Completed', 399.99, 'United Kingdom'),
-- May 2024
(1, '2024-05-06', 'Completed', 399.99, 'United States'),
(14, '2024-05-13', 'Completed', 79.99, 'United Kingdom'),
(9, '2024-05-20', 'Completed', 109.98, 'United Kingdom'),
(35, '2024-05-31', 'Completed', 39.99, 'Australia'),
-- June 2024
(5, '2024-06-04', 'Completed', 149.99, 'Australia'),
(14, '2024-06-11', 'Completed', 79.98, 'United Kingdom'),
(36, '2024-06-18', 'Completed', 89.99, 'United States'),
(19, '2024-06-25', 'Completed', 49.99, 'United Kingdom'),
-- July 2024
(1, '2024-07-03', 'Completed', 109.98, 'United States'),
(5, '2024-07-11', 'Completed', 399.99, 'Australia'),
(9, '2024-07-18', 'Completed', 119.99, 'United Kingdom'),
(34, '2024-07-25', 'Completed', 79.99, 'United Kingdom'),
-- August 2024
(14, '2024-08-02', 'Completed', 79.99, 'United Kingdom'),
(1, '2024-08-09', 'Completed', 129.98, 'United States'),
(5, '2024-08-15', 'Completed', 129.98, 'Australia'),
(29, '2024-08-22', 'Completed', 149.99, 'United Kingdom'),
(38, '2024-08-28', 'Completed', 44.99, 'United States'),
-- September 2024
(9, '2024-09-04', 'Completed', 54.99, 'United Kingdom'),
(14, '2024-09-11', 'Completed', 89.99, 'United Kingdom'),
(24, '2024-09-18', 'Completed', 119.99, 'United Kingdom'),
(39, '2024-09-29', 'Pending', 399.99, 'United Kingdom'),
-- October 2024
(5, '2024-10-03', 'Completed', 179.98, 'Australia'),
(1, '2024-10-10', 'Completed', 399.99, 'United States'),
(9, '2024-10-17', 'Completed', 179.98, 'United Kingdom'),
(34, '2024-10-22', 'Completed', 89.99, 'United Kingdom'),
(40, '2024-10-31', 'Completed', 49.99, 'Australia'),
-- November 2024
(5, '2024-11-02', 'Completed', 439.98, 'Australia'),
(14, '2024-11-07', 'Completed', 129.99, 'United Kingdom'),
(1, '2024-11-12', 'Completed', 179.98, 'United States'),
(41, '2024-11-15', 'Completed', 149.99, 'United States'),
(9, '2024-11-20', 'Completed', 79.99, 'United Kingdom'),
(29, '2024-11-26', 'Completed', 79.99, 'United Kingdom'),
-- December 2024 (Holiday)
(5, '2024-12-02', 'Completed', 239.98, 'Australia'),
(14, '2024-12-06', 'Completed', 399.99, 'United Kingdom'),
(1, '2024-12-10', 'Completed', 349.98, 'United States'),
(44, '2024-12-12', 'Completed', 149.99, 'United Kingdom'),
(9, '2024-12-16', 'Completed', 159.98, 'United Kingdom'),
(24, '2024-12-22', 'Completed', 145.98, 'United Kingdom'),
(34, '2024-12-28', 'Completed', 149.99, 'United Kingdom'),
-- January 2025
(5, '2025-01-04', 'Completed', 399.99, 'Australia'),
(14, '2025-01-10', 'Completed', 119.99, 'United Kingdom'),
(1, '2025-01-16', 'Completed', 149.98, 'United States'),
(46, '2025-01-22', 'Completed', 29.99, 'United States'),
-- February 2025
(9, '2025-02-05', 'Completed', 129.99, 'United Kingdom'),
(5, '2025-02-12', 'Completed', 179.98, 'Australia'),
(14, '2025-02-20', 'Completed', 54.99, 'United Kingdom'),
-- March 2025
(1, '2025-03-06', 'Completed', 149.99, 'United States'),
(9, '2025-03-14', 'Completed', 149.99, 'United Kingdom'),
(19, '2025-03-22', 'Completed', 399.99, 'United Kingdom'),
-- April 2025
(5, '2025-04-04', 'Completed', 149.99, 'Australia'),
(14, '2025-04-12', 'Completed', 299.99, 'United Kingdom'),
(29, '2025-04-20', 'Completed', 29.99, 'United Kingdom'),
-- May 2025
(1, '2025-05-08', 'Completed', 79.99, 'United States'),
(9, '2025-05-16', 'Completed', 89.99, 'United Kingdom'),
(5, '2025-05-24', 'Completed', 399.99, 'Australia'),
-- June 2025
(14, '2025-06-05', 'Completed', 149.99, 'United Kingdom'),
(1, '2025-06-12', 'Completed', 189.98, 'United States'),
(5, '2025-06-20', 'Completed', 179.98, 'Australia'),
(24, '2025-06-28', 'Completed', 54.99, 'United Kingdom');

-- =============================================================================
-- ORDER ITEMS (each row references order_id by insertion sequence above)
-- total_amount of each order = SUM(quantity * unit_price_at_purchase)
-- =============================================================================

INSERT INTO ecommerce.order_items (order_id, product_id, quantity, unit_price_at_purchase) VALUES
-- Order 1: C1, $229.98
(1, 1, 1, 149.99), (1, 3, 1, 79.99),
-- Order 2: C5, $399.99
(2, 2, 1, 399.99),
-- Order 3: C9, $149.99
(3, 7, 1, 149.99),
-- Order 4: C14, $179.98
(4, 1, 1, 149.99), (4, 18, 1, 29.99),
-- Order 5: C1, $119.99
(5, 8, 1, 119.99),
-- Order 6: C2, $59.99
(6, 14, 1, 59.99),
-- Order 7: C19, $449.98
(7, 2, 1, 399.99), (7, 4, 1, 49.99),
-- Order 8: C6, $89.99
(8, 9, 1, 89.99),
-- Order 9: C5, $149.99
(9, 1, 1, 149.99),
-- Order 10: C8, $75.98
(10, 12, 1, 45.99), (10, 5, 1, 29.99),
-- Order 11: C14, $299.99
(11, 20, 1, 299.99),
-- Order 12: C3, $54.99
(12, 16, 1, 54.99),
-- Order 13: C9, $399.99
(13, 2, 1, 399.99),
-- Order 14: C1, $399.99
(14, 2, 1, 399.99),
-- Order 15: C7, $49.99
(15, 13, 1, 49.99),
-- Order 16: C10, $79.99
(16, 3, 1, 79.99),
-- Order 17: C24 (Cancelled), $399.99
(17, 2, 1, 399.99),
-- Order 18: C5, $119.98
(18, 3, 1, 79.99), (18, 17, 1, 39.99),
-- Order 19: C12, $99.99
(19, 11, 1, 99.99),
-- Order 20: C14, $119.99
(20, 8, 1, 119.99),
-- Order 21: C11, $79.99
(21, 6, 1, 79.99),
-- Order 22: C9, $94.98
(22, 13, 1, 49.99), (22, 15, 1, 44.99),
-- Order 23: C13, $79.99
(23, 6, 1, 79.99),
-- Order 24: C1, $99.99
(24, 11, 1, 99.99),
-- Order 25: C6, $59.99
(25, 14, 1, 59.99),
-- Order 26: C5, $99.99
(26, 11, 1, 99.99),
-- Order 27: C13, $99.98
(27, 15, 1, 44.99), (27, 16, 1, 54.99),
-- Order 28: C14, $399.99
(28, 2, 1, 399.99),
-- Order 29: C3 (Cancelled), $39.99
(29, 17, 1, 39.99),
-- Order 30: C1, $99.98
(30, 15, 1, 44.99), (30, 16, 1, 54.99),
-- Order 31: C20, $149.99
(31, 1, 1, 149.99),
-- Order 32: C9, $149.99
(32, 1, 1, 149.99),
-- Order 33: C17, $59.98 (qty 2)
(33, 5, 2, 29.99),
-- Order 34: C4, $449.98
(34, 2, 1, 399.99), (34, 4, 1, 49.99),
-- Order 35: C5, $109.98
(35, 6, 1, 79.99), (35, 5, 1, 29.99),
-- Order 36: C14, $135.98
(36, 9, 1, 89.99), (36, 12, 1, 45.99),
-- Order 37: C22, $399.99
(37, 2, 1, 399.99),
-- Order 38: C19, $149.99
(38, 7, 1, 149.99),
-- Order 39: C25, $79.99
(39, 19, 1, 79.99),
-- Order 40: C1 (Pending), $59.99
(40, 14, 1, 59.99),
-- Order 41: C8, $149.99
(41, 7, 1, 149.99),
-- Order 42: C9, $299.99
(42, 20, 1, 299.99),
-- Order 43: C15, $45.99
(43, 12, 1, 45.99),
-- Order 44: C24, $79.99
(44, 3, 1, 79.99),
-- Order 45: C29, $399.99
(45, 2, 1, 399.99),
-- Order 46: C5, $199.98
(46, 1, 1, 149.99), (46, 4, 1, 49.99),
-- Order 47: C14, $149.99
(47, 7, 1, 149.99),
-- Order 48: C10, $104.98
(48, 14, 1, 59.99), (48, 15, 1, 44.99),
-- Order 49: C4, $189.98
(49, 9, 1, 89.99), (49, 11, 1, 99.99),
-- Order 50: C29, $339.98
(50, 20, 1, 299.99), (50, 17, 1, 39.99),
-- Order 51: C21, $39.99
(51, 17, 1, 39.99),
-- Order 52: C1, $129.99
(52, 10, 1, 129.99),
-- Order 53: C5, $479.98
(53, 2, 1, 399.99), (53, 3, 1, 79.99),
-- Order 54: C9, $269.98
(54, 1, 1, 149.99), (54, 8, 1, 119.99),
-- Order 55: C12, $109.98
(55, 3, 1, 79.99), (55, 18, 1, 29.99),
-- Order 56: C14, $109.98
(56, 13, 1, 49.99), (56, 14, 1, 59.99),
-- Order 57: C19, $399.99
(57, 2, 1, 399.99),
-- Order 58: C24, $129.99
(58, 10, 1, 129.99),
-- Order 59: C2, $149.99
(59, 7, 1, 149.99),
-- Order 60: C1, $195.98
(60, 1, 1, 149.99), (60, 12, 1, 45.99),
-- Order 61: C5 (Cancelled), $89.99
(61, 9, 1, 89.99),
-- Order 62: C9, $59.99
(62, 14, 1, 59.99),
-- Order 63: C7, $99.98
(63, 4, 1, 49.99), (63, 13, 1, 49.99),
-- Order 64: C31, $129.99
(64, 10, 1, 129.99),
-- Order 65: C14, $99.99
(65, 11, 1, 99.99),
-- Order 66: C5, $299.99
(66, 20, 1, 299.99),
-- Order 67: C16, $399.99
(67, 2, 1, 399.99),
-- Order 68: C3, $109.98
(68, 18, 1, 29.99), (68, 19, 1, 79.99),
-- Order 69: C32, $49.99
(69, 13, 1, 49.99),
-- Order 70: C1, $39.99
(70, 17, 1, 39.99),
-- Order 71: C9, $99.99
(71, 11, 1, 99.99),
-- Order 72: C20, $119.99
(72, 8, 1, 119.99),
-- Order 73: C14 (Returned), $399.99
(73, 2, 1, 399.99),
-- Order 74: C29, $79.99
(74, 3, 1, 79.99),
-- Order 75: C11, $149.99
(75, 1, 1, 149.99),
-- Order 76: C5, $129.98
(76, 3, 1, 79.99), (76, 4, 1, 49.99),
-- Order 77: C19, $149.99
(77, 1, 1, 149.99),
-- Order 78: C24 (Pending), $299.99
(78, 20, 1, 299.99),
-- Order 79: C22 (Returned), $129.99
(79, 10, 1, 129.99),
-- Order 80: C34, $399.99
(80, 2, 1, 399.99),
-- Order 81: C1, $399.99
(81, 2, 1, 399.99),
-- Order 82: C14, $79.99
(82, 19, 1, 79.99),
-- Order 83: C9, $109.98
(83, 5, 1, 29.99), (83, 3, 1, 79.99),
-- Order 84: C35, $39.99
(84, 17, 1, 39.99),
-- Order 85: C5, $149.99
(85, 7, 1, 149.99),
-- Order 86: C14, $79.98
(86, 4, 1, 49.99), (86, 18, 1, 29.99),
-- Order 87: C36, $89.99
(87, 9, 1, 89.99),
-- Order 88: C19, $49.99
(88, 13, 1, 49.99),
-- Order 89: C1, $109.98
(89, 13, 1, 49.99), (89, 14, 1, 59.99),
-- Order 90: C5, $399.99
(90, 2, 1, 399.99),
-- Order 91: C9, $119.99
(91, 8, 1, 119.99),
-- Order 92: C34, $79.99
(92, 3, 1, 79.99),
-- Order 93: C14, $79.99
(93, 6, 1, 79.99),
-- Order 94: C1, $129.98
(94, 3, 1, 79.99), (94, 4, 1, 49.99),
-- Order 95: C5, $129.98
(95, 9, 1, 89.99), (95, 17, 1, 39.99),
-- Order 96: C29, $149.99
(96, 1, 1, 149.99),
-- Order 97: C38, $44.99
(97, 15, 1, 44.99),
-- Order 98: C9, $54.99
(98, 16, 1, 54.99),
-- Order 99: C14, $89.99
(99, 9, 1, 89.99),
-- Order 100: C24, $119.99
(100, 8, 1, 119.99),
-- Order 101: C39 (Pending), $399.99
(101, 2, 1, 399.99),
-- Order 102: C5, $179.98
(102, 11, 1, 99.99), (102, 3, 1, 79.99),
-- Order 103: C1, $399.99
(103, 2, 1, 399.99),
-- Order 104: C9, $179.98
(104, 1, 1, 149.99), (104, 18, 1, 29.99),
-- Order 105: C34, $89.99
(105, 9, 1, 89.99),
-- Order 106: C40, $49.99
(106, 4, 1, 49.99),
-- Order 107: C5, $439.98
(107, 2, 1, 399.99), (107, 17, 1, 39.99),
-- Order 108: C14, $129.99
(108, 10, 1, 129.99),
-- Order 109: C1, $179.98
(109, 7, 1, 149.99), (109, 5, 1, 29.99),
-- Order 110: C41, $149.99
(110, 1, 1, 149.99),
-- Order 111: C9, $79.99
(111, 6, 1, 79.99),
-- Order 112: C29, $79.99
(112, 3, 1, 79.99),
-- Order 113: C5, $239.98
(113, 1, 1, 149.99), (113, 9, 1, 89.99),
-- Order 114: C14, $399.99
(114, 2, 1, 399.99),
-- Order 115: C1, $349.98
(115, 20, 1, 299.99), (115, 13, 1, 49.99),
-- Order 116: C44, $149.99
(116, 7, 1, 149.99),
-- Order 117: C9, $159.98
(117, 3, 1, 79.99), (117, 19, 1, 79.99),
-- Order 118: C24, $145.98
(118, 11, 1, 99.99), (118, 12, 1, 45.99),
-- Order 119: C34, $149.99
(119, 1, 1, 149.99),
-- Order 120: C5, $399.99
(120, 2, 1, 399.99),
-- Order 121: C14, $119.99
(121, 8, 1, 119.99),
-- Order 122: C1, $149.98
(122, 11, 1, 99.99), (122, 4, 1, 49.99),
-- Order 123: C46, $29.99
(123, 5, 1, 29.99),
-- Order 124: C9, $129.99
(124, 10, 1, 129.99),
-- Order 125: C5, $179.98
(125, 7, 1, 149.99), (125, 5, 1, 29.99),
-- Order 126: C14, $54.99
(126, 16, 1, 54.99),
-- Order 127: C1, $149.99
(127, 1, 1, 149.99),
-- Order 128: C9, $149.99
(128, 7, 1, 149.99),
-- Order 129: C19, $399.99
(129, 2, 1, 399.99),
-- Order 130: C5, $149.99
(130, 1, 1, 149.99),
-- Order 131: C14, $299.99
(131, 20, 1, 299.99),
-- Order 132: C29, $29.99
(132, 5, 1, 29.99),
-- Order 133: C1, $79.99
(133, 6, 1, 79.99),
-- Order 134: C9, $89.99
(134, 9, 1, 89.99),
-- Order 135: C5, $399.99
(135, 2, 1, 399.99),
-- Order 136: C14, $149.99
(136, 1, 1, 149.99),
-- Order 137: C1, $189.98
(137, 7, 1, 149.99), (137, 17, 1, 39.99),
-- Order 138: C5, $179.98
(138, 10, 1, 129.99), (138, 4, 1, 49.99),
-- Order 139: C24, $54.99
(139, 16, 1, 54.99);

-- =============================================================================
-- SUBSCRIPTIONS (30 subscriptions with varied plans, statuses, and dates)
-- =============================================================================

INSERT INTO ecommerce.subscriptions (customer_id, plan_type, start_date, end_date, monthly_value, status) VALUES
(1, 'Annual', '2023-01-01', NULL, 29.99, 'Active'),
(2, 'Monthly', '2023-07-01', '2024-01-01', 9.99, 'Cancelled'),
(5, 'Monthly', '2023-03-01', '2023-09-01', 9.99, 'Cancelled'),
(5, 'Annual', '2024-01-01', NULL, 29.99, 'Active'),
(9, 'Quarterly', '2023-06-01', NULL, 24.99, 'Active'),
(14, 'Annual', '2023-04-01', '2024-04-01', 29.99, 'Expired'),
(14, 'Annual', '2024-07-01', NULL, 29.99, 'Active'),
(19, 'Annual', '2023-09-01', NULL, 29.99, 'Active'),
(24, 'Monthly', '2023-11-01', '2024-05-01', 9.99, 'Cancelled'),
(29, 'Monthly', '2024-02-01', NULL, 9.99, 'Active'),
(3, 'Quarterly', '2024-01-01', '2024-07-01', 24.99, 'Expired'),
(4, 'Monthly', '2023-05-01', '2023-08-01', 9.99, 'Cancelled'),
(6, 'Annual', '2024-03-01', NULL, 29.99, 'Active'),
(7, 'Monthly', '2024-04-01', '2024-10-01', 9.99, 'Cancelled'),
(8, 'Monthly', '2024-01-01', '2024-04-01', 9.99, 'Cancelled'),
(10, 'Annual', '2024-06-01', NULL, 29.99, 'Active'),
(11, 'Quarterly', '2024-05-01', NULL, 24.99, 'Active'),
(13, 'Quarterly', '2024-08-01', '2025-02-01', 24.99, 'Expired'),
(15, 'Annual', '2024-11-01', NULL, 29.99, 'Active'),
(16, 'Monthly', '2024-08-01', '2024-12-01', 9.99, 'Cancelled'),
(20, 'Monthly', '2024-09-01', '2025-01-01', 9.99, 'Expired'),
(21, 'Annual', '2024-05-01', NULL, 29.99, 'Active'),
(22, 'Quarterly', '2024-03-01', '2024-09-01', 24.99, 'Expired'),
(25, 'Monthly', '2024-12-01', NULL, 9.99, 'Active'),
(31, 'Quarterly', '2024-04-01', '2024-10-01', 24.99, 'Expired'),
(34, 'Monthly', '2024-06-01', NULL, 9.99, 'Active'),
(36, 'Monthly', '2024-07-01', '2024-11-01', 9.99, 'Cancelled'),
(39, 'Quarterly', '2024-10-01', NULL, 24.99, 'Active'),
(44, 'Monthly', '2025-01-01', NULL, 9.99, 'Active'),
(46, 'Monthly', '2025-02-01', NULL, 9.99, 'Active');

-- =============================================================================
-- VERIFY DATA
-- =============================================================================

DO $$
DECLARE
    customer_count INT;
    product_count INT;
    order_count INT;
    item_count INT;
    sub_count INT;
BEGIN
    SELECT COUNT(*) INTO customer_count FROM ecommerce.customers;
    SELECT COUNT(*) INTO product_count FROM ecommerce.products;
    SELECT COUNT(*) INTO order_count FROM ecommerce.orders;
    SELECT COUNT(*) INTO item_count FROM ecommerce.order_items;
    SELECT COUNT(*) INTO sub_count FROM ecommerce.subscriptions;

    RAISE NOTICE 'Data loaded successfully:';
    RAISE NOTICE '  Customers: %', customer_count;
    RAISE NOTICE '  Products: %', product_count;
    RAISE NOTICE '  Orders: %', order_count;
    RAISE NOTICE '  Order Items: %', item_count;
    RAISE NOTICE '  Subscriptions: %', sub_count;
END $$;
