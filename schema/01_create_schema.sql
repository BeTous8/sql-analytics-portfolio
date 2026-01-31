/*
SQL ANALYTICS PORTFOLIO - SCHEMA CREATION
File: 01_create_schema.sql
Purpose: Create separate ecommerce schema for portfolio project

This demonstrates PostgreSQL schema management for organizing
different business domains within the same database instance.
*/

-- Create the ecommerce schema
CREATE SCHEMA IF NOT EXISTS ecommerce;

-- Verify schema was created
SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name = 'ecommerce';

-- Set search path to include ecommerce schema (optional)
-- SET search_path TO ecommerce, public;

-- Display success message
DO $$ 
BEGIN 
    RAISE NOTICE 'Schema "ecommerce" created successfully!';
END $$;
