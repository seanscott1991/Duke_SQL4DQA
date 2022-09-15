-- ------------------------------------------------------------------------------------------- --
-- ---------------------------------------  Week 2 Lab  -------------------------------------- --
-- ------------------------------------------------------------------------------------------- --

-- Instructions --

-- Use the tpch relational dataset to answer the following questions. Write your code in this
-- file after each corresponding question and include a comment with the answer to the question
-- if applicable.  Code should use syntax best practices.  Submit code at end of lab session.



-- About the tpch database --

-- The tpch relational dataset contains data on 1.5 million orders for 'parts'.  The orders table 
-- contains data on each order.  The line item table contains data on the specific parts included
-- in each order.  The customer, nation, part, partsupp, region, and supplier tables all contain
-- additional data that can be related back to the orders and line items. 







-- 1. Return all of the newest orders in the orders table --
SELECT
	*
FROM
	orders
WHERE
	o_orderdate = 
		(
		SELECT
			MAX(o_orderdate)
		FROM
			orders
		);





-- 2. Return all parts who cost more than the smallest order in the data base --
SELECT
	*
FROM
	part
WHERE
	p_retailprice < 
		(
		SELECT
			MIN(o_totalprice)
		FROM
			orders
		);






-- 3. Return all columns from the orders table as well as a column that categorizes orders into large, medium and small orders --
-- large orders are considered to have total price over $300,000, medium orders are considered to greater than $100,000 and --
-- less than or equal to $300,000 and small orders are considered to be $100,000 or less
SELECT
	*
    , CASE
		WHEN o_totalprice > 300000
			THEN "LARGE"
		WHEN o_totalprice > 100000
			THEN "MEDIUM"
		ELSE "SMALL"
	END AS "ORDER SIZE"
FROM
	orders
ORDER BY o_totalprice; 




-- 4. Using a sub query return a list of all part names who were shipped by truck and had a comment that mentioned 'package'  --
SELECT
	p_name
FROM
	part
WHERE
	p_partkey IN
		(
        SELECT 
			l_partkey 
		FROM 
			lineitem
		WHERE
			l_shipmode = 'TRUCK'
			AND l_comment LIKE '%package%'
		);
			
		





-- 5. Which part manufacturers have a lower average retail price than manufacturers 1 and 2? --
SELECT
	p_mfgr
    , AVG(p_retailprice)
FROM
	part
GROUP BY 
	1
HAVING
	AVG(p_retailprice) < ALL
		(
        SELECT
			AVG(p_retailprice)
		FROM
			part
		WHERE
			p_mfgr in ('Manufacturer#1', 'Manufacturer#2')
		GROUP BY
			p_mfgr
		);






-- 6. Write a query that show percent of total orders for each order status (results should be on one row) --
SELECT
	AVG(CASE WHEN o_orderstatus = 'P' THEN 1
		ELSE 0 END)*100 AS P_STATUS_PCT, 
	AVG(CASE WHEN o_orderstatus = 'O' THEN 1
		ELSE 0 END)*100 AS O_STATUS_PCT, 
	AVG(CASE WHEN o_orderstatus = 'F' THEN 1
		ELSE 0 END)*100 AS F_STATUS_PCT
FROM
	orders;






-- 7. Write a query that show percent of total order value for each order status (results should be on one row) --
SELECT
	SUM(CASE WHEN o_orderstatus = 'P' THEN o_totalprice
		ELSE 0 END)/SUM(o_totalprice)*100 AS P_STATUS_VALUE_PCT, 
	SUM(CASE WHEN o_orderstatus = 'O' THEN o_totalprice
		ELSE 0 END)/SUM(o_totalprice)*100 AS O_STATUS_VALUE_PCT, 
	SUM(CASE WHEN o_orderstatus = 'F' THEN o_totalprice
		ELSE 0 END)/SUM(o_totalprice)*100 AS F_STATUS_VALUE_PCT
FROM
	orders;






-- 8. Rewrite your query from #6 so that the data is now at the customer number level  --
SELECT
	o_custkey,
	AVG(CASE WHEN o_orderstatus = 'P' THEN 1
		ELSE 0 END)*100 AS P_STATUS_PCT, 
	AVG(CASE WHEN o_orderstatus = 'O' THEN 1
		ELSE 0 END)*100 AS O_STATUS_PCT, 
	AVG(CASE WHEN o_orderstatus = 'F' THEN 1
		ELSE 0 END)*100 AS F_STATUS_PCT
FROM
	orders
GROUP BY
	1;





-- 9. Join your results from #8 to the customer table (all customers should be in result set) --
SELECT
	c.*
    , pct.*
FROM
	customer c
    LEFT JOIN
		(
        SELECT
			o_custkey,
			AVG(CASE WHEN o_orderstatus = 'P' THEN 1
				ELSE 0 END)*100 AS P_STATUS_PCT, 
			AVG(CASE WHEN o_orderstatus = 'O' THEN 1
				ELSE 0 END)*100 AS O_STATUS_PCT, 
			AVG(CASE WHEN o_orderstatus = 'F' THEN 1
				ELSE 0 END)*100 AS F_STATUS_PCT
		FROM
			orders
		GROUP BY
			1
        ) pct
        ON c.c_custkey = pct.o_custkey;





-- 10. Rewrite the query from the previous problem but this time use a common table expression --
WITH pct as
	(
	SELECT
		o_custkey,
		AVG(CASE WHEN o_orderstatus = 'P' THEN 1
			ELSE 0 END)*100 AS P_STATUS_PCT, 
		AVG(CASE WHEN o_orderstatus = 'O' THEN 1
			ELSE 0 END)*100 AS O_STATUS_PCT, 
		AVG(CASE WHEN o_orderstatus = 'F' THEN 1
			ELSE 0 END)*100 AS F_STATUS_PCT
	FROM
		orders
	GROUP BY
		1
	)
SELECT
	c.*
    , pct.*
FROM
	customer c
    LEFT JOIN pct
        ON c.c_custkey = pct.o_custkey;






	
	





