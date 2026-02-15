-- 1: Which color generated the highest revenue each year?
SELECT year, color, revenue
FROM (
  SELECT
    EXTRACT(YEAR FROM o.OrderDate) AS year,
    p.Color,
    SUM(o.TotalLineExtendedPrice) AS revenue,
    ROW_NUMBER() OVER (
      PARTITION BY EXTRACT(YEAR FROM o.OrderDate)
      ORDER BY SUM(o.TotalLineExtendedPrice) DESC
    ) AS rn
  FROM publish_orders o
  JOIN publish_product p
    ON o.ProductID = p.ProductID
  GROUP BY year, p.Color
) ranked
WHERE rn = 1
ORDER BY year;


-- 2: What is the average LeadTimeInBusinessDays by ProductCategoryName?
SELECT
  p.ProductCategoryName,
  ROUND(AVG(o.LeadTimeInBusinessDays), 2) AS AvgLeadTimeInBusinessDays
FROM publish_orders o
JOIN publish_product p
  ON o.ProductID = p.ProductID
GROUP BY p.ProductCategoryName
ORDER BY AvgLeadTimeInBusinessDays;
