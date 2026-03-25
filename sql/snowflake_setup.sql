-- ==========================================================================================
-- Instacart Snowflake Setup Script
-- ==========================================================================================
-- This script:
-- Creates warehouse, database, schemas, and raw tables
-- Creates dbt user and role
-- Grants necessary permissions
-- Note:
-- No credentials are stored in this file



-- ==========================================================================================
-- Step 1: Create warehouse, database, schema, and tables
-- ==========================================================================================

USE ROLE SYSADMIN;

CREATE WAREHOUSE IF NOT EXISTS COMPUTE_WH;
USE WAREHOUSE COMPUTE_WH;

CREATE DATABASE IF NOT EXISTS INSTACART;
CREATE SCHEMA IF NOT EXISTS INSTACART.RAW;
CREATE SCHEMA IF NOT EXISTS INSTACART.DEV;

USE DATABASE INSTACART;
USE SCHEMA RAW;

CREATE OR REPLACE TABLE aisles (
    aisle_id INT,
    aisle STRING
);

CREATE OR REPLACE TABLE departments (
    department_id INT,
    department STRING
);

CREATE OR REPLACE TABLE order_products_prior (
    order_id INT,
    product_id INT,
    add_to_cart_order INT,
    reordered INT
);

CREATE OR REPLACE TABLE order_products_train (
    order_id INT,
    product_id INT,
    add_to_cart_order INT,
    reordered INT
);

CREATE OR REPLACE TABLE orders (
    order_id INT,
    user_id INT,
    eval_set STRING,
    order_number INT,
    order_dow INT,
    order_hour_of_the_day INT,
    days_since_prior_order FLOAT
);

CREATE OR REPLACE TABLE products (
    product_id INT,
    product_name STRING,
    aisle_id INT,
    department_id INT
);

-- ==========================================================================================
-- Step 2: Create a new role and user and assign the role to sysadmin
-- ==========================================================================================

USE ROLE USERADMIN;

CREATE ROLE IF NOT EXISTS INSTACART_TRANSFORM;
GRANT ROLE INSTACART_TRANSFORM TO ROLE SYSADMIN;

CREATE USER IF NOT EXISTS dbt_instacart
  LOGIN_NAME='dbt_instacart'
  MUST_CHANGE_PASSWORD=TRUE
  DEFAULT_WAREHOUSE='COMPUTE_WH'
  DEFAULT_ROLE=INSTACART_TRANSFORM
  DEFAULT_NAMESPACE='INSTACART.DEV'
  COMMENT='dbt user will be used for data transformation';

-- IMPORTANT: Set password manually after user creation
-- Example:
-- ALTER USER dbt_instacart SET PASSWORD = '<your_password>';
  
GRANT ROLE INSTACART_TRANSFORM TO USER dbt_instacart;

-- ==========================================================================================
-- Step 3: Grant privileges
-- ==========================================================================================

USE ROLE SECURITYADMIN; 

GRANT USAGE ON WAREHOUSE COMPUTE_WH TO ROLE INSTACART_TRANSFORM;
GRANT OPERATE ON WAREHOUSE COMPUTE_WH TO ROLE INSTACART_TRANSFORM;


--GRANT ALL ON WAREHOUSE COMPUTE_WH TO ROLE INSTACART_TRANSFORM;
GRANT USAGE ON DATABASE INSTACART TO ROLE INSTACART_TRANSFORM;
GRANT USAGE ON SCHEMA INSTACART.RAW TO ROLE INSTACART_TRANSFORM;
GRANT USAGE ON SCHEMA INSTACART.DEV TO ROLE INSTACART_TRANSFORM;

GRANT SELECT ON ALL TABLES IN SCHEMA INSTACART.RAW TO ROLE INSTACART_TRANSFORM;
GRANT SELECT ON FUTURE TABLES IN SCHEMA INSTACART.RAW TO ROLE INSTACART_TRANSFORM;

GRANT CREATE TABLE ON SCHEMA INSTACART.DEV TO ROLE INSTACART_TRANSFORM;
GRANT CREATE VIEW ON SCHEMA INSTACART.DEV TO ROLE INSTACART_TRANSFORM;
GRANT CREATE MATERIALIZED VIEW ON SCHEMA INSTACART.DEV TO ROLE INSTACART_TRANSFORM;