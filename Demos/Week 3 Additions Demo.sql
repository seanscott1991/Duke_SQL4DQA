-- Use CTEs to replace aggregations in result set transformation --
WITH price_sum as
(
select SUM(o_totalprice) from orders
)

SELECT
	SUM(CASE WHEN o_orderstatus = 'P' THEN o_totalprice
		ELSE 0 END)/(select * from price_sum) AS P_STATUS_VALUE_PCT, 
        
	SUM(CASE WHEN o_orderstatus = 'O' THEN o_totalprice
		ELSE 0 END)/(select * from price_sum) AS O_STATUS_VALUE_PCT, 
        
	SUM(CASE WHEN o_orderstatus = 'F' THEN o_totalprice
		ELSE 0 END)/(select * from price_sum) AS F_STATUS_VALUE_PCT
FROM
	orders;
    
    
    
    
    
-- Group by percent of whole order count --
SELECT
  o_orderstatus
  , COUNT(*)
  , COUNT(*) / (SELECT COUNT(*) FROM orders) * 100 AS PCT_TOTAL
FROM 
	orders
GROUP BY 
	1;
    
    
    
-- Group by percent of whole order value --
SELECT
  o_orderstatus
  , SUM(o_totalprice)
  , SUM(o_totalprice) / (SELECT SUM(o_totalprice) FROM orders) * 100 AS PCT_TOTAL
FROM 
	orders
GROUP BY 
	1;