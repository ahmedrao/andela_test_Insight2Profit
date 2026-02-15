CREATE TABLE publish_product AS
SELECT
	ProductID,
	ProductDesc,
	ProductNumber,
	MakeFlag,
	-- Transofrmation 1: Replace NULL Color
	COALESCE(Color, 'N/A') AS Color,
	SafetyStockLevel,
	ReorderPoint,
	StandardCost,
	ListPrice,
	Size,
	SizeUnitMeasureCode,
	Weight,
	WeightUnitMeasureCode,
	ProductSubCategoryName,
	-- Transformation 2: Enhance ProductCategoryName
	COALESCE(
		ProductCategoryName,
		CASE
			WHEN ProductSubCategoryName IN ('Gloves','Shorts','Socks','Tights','Vests')
				THEN 'Clothing'

			WHEN ProductSubCategoryName IN ('Locks','Lights','Headsets','Helmets','Pedals','Pumps')
				THEN 'Accessories'

			WHEN ProductSubCategoryName ILIKE '%Frames%'
				OR ProductSubCategoryName IN ('Wheels','Saddles')
				THEN 'Components'
		END
	) AS ProductCategoryName

FROM store_products;
