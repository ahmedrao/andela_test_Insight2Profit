CREATE TABLE publish_orders AS
SELECT
		d.SalesOrderDetailID,
		d.SalesOrderID,
		d.ProductID,
		d.OrderQty,
		d.UnitPrice,
		d.UnitPriceDiscount,
		h.OrderDate,
		h.ShipDate,
		h.OnlineOrderFlag,
		h.AccountNumber,
		h.CustomerID,
		h.SalesPersonID,
		-- 3. Rename Freight
		h.Freight AS TotalOrderFreight,
		-- 1. Calculate LeadTimeInBusinessDays exclusing weekends
		(
				date_diff('day', h.OrderDate, h.ShipDate) -- total days between 2 dates
				- (date_diff('week', h.OrderDate, h.ShipDate) * 2) -- calculates how many times calendar flipped from Sunday to Monday and subtracts 2 day
				+ CASE WHEN EXTRACT(DOW FROM h.OrderDate) = 6 THEN 1 ELSE 0 END -- the case statements are ancshor adjustments
				- CASE WHEN EXTRACT(DOW FROM h.ShipDate) = 6 THEN 1 ELSE 0 END
		) AS LeadTimeInBusinessDays,
		-- 2. TotalLineExtendedPrice
		d.OrderQty * (d.UnitPrice - d.UnitPriceDiscount)
				AS TotalLineExtendedPrice
FROM store_sales_order_detail d
JOIN store_sales_order_header h
		ON d.SalesOrderID = h.SalesOrderID;