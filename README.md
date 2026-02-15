# andela_test_Insight2Profit

# SQL-Based Sales Data Mart

## Overview
I have implemented SQL-based analytical solution following a **raw -> store -> publish** layered architecture.

All transformations are written in SQL and are fully reproducible.


## Technology
- SQL
- Designed and tested using DuckDB
- 
## Data Layers

### Raw Layer
- Purpose: ingestion and data profiling
- Tables:
  - raw_products
  - raw_sales_order_header
  - raw_sales_order_detail

### Store Layer
- Purpose: data typing and cleansing
- Tables:
  - store_products
  - store_sales_order_header
  - store_sales_order_detail

### Publish Layer
- Purpose: business logic
- Tables:
  - publish_product
  - publish_orders

## Transformations

### Product Master
- NULL colors replaced with `N/A`
- Product categories inferred from subcategories using business rules

### Sales Orders
- Orders joined with order headers
- Lead time calculated in **business days (excluding weekends)**
- Extended line revenue calculated at order-line level

## Analysis

### 1. Highest Revenue Color by Year
Identifies the product color generating the highest revenue each year using window functions.

### 2. Average Lead Time by Product Category
Calculates operational lead-time efficiency by product category.

## How to Run

1. Install DuckDB
2. Open DuckDB cli
3. Run SQL scripts in below iorder:

**sql**
.read sql/01_raw_load.sql

.read sql/02_store_layer.sql

.read sql/03_publish_product.sql

.read sql/04_publish_orders.sql

.read sql/05_analysis.sql

