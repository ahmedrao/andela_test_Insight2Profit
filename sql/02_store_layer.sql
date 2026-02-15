CREATE TABLE store_products AS
SELECT
	ProductID::BIGINT AS ProductID,
	ProductDesc,
	ProductNumber,
	MakeFlag,
	Color,
	SafetyStockLevel,
	ReorderPoint,
	StandardCost,
	ListPrice,
	Size,
	SizeUnitMeasureCode,
	Weight,
	WeightUnitMeasureCode,
	ProductCategoryName,
	ProductSubCategoryName
FROM raw_products;


CREATE TABLE store_sales_order_header AS
SELECT
	SalesOrderID::BIGINT AS SalesOrderID,
	-- handle mixed formats like '2021-06' and '2021-05-31'
	CAST(
		CASE
			WHEN LENGTH(OrderDate) = 7 THEN OrderDate || '-01'
			ELSE OrderDate
		END
		AS DATE
	) AS OrderDate,
	ShipDate,
	OnlineOrderFlag,
	AccountNumber,
	CustomerID,
	SalesPersonID,
	Freight
FROM raw_sales_order_header;


CREATE TABLE store_sales_order_detail AS
SELECT
	SalesOrderDetailID::BIGINT AS SalesOrderDetailID,
	SalesOrderID::BIGINT AS SalesOrderID,
	ProductID::BIGINT AS ProductID,
	OrderQty,
	UnitPrice,
	UnitPriceDiscount
FROM raw_sales_order_detail;
