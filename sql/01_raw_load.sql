CREATE TABLE raw_products AS
SELECT * FROM read_csv_auto('data/raw/products.csv');

CREATE TABLE raw_sales_order_header AS
SELECT * FROM read_csv_auto('data/raw/sales_order_header.csv');

CREATE TABLE raw_sales_order_detail AS
SELECT * FROM read_csv_auto('data/raw/sales_order_detail.csv');