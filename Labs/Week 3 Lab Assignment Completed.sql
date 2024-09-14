-- ------------------------------------------------------------------------------------------- --
-- ---------------------------------------  Week 3 Lab  -------------------------------------- --
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







-- 1. Return all parts with a below average retail price --
SELECT
	*
FROM
	part
WHERE
	p_retailprice <
		(
		SELECT
			AVG(p_retailprice)
		FROM
			part
		);





-- 2. Return all customers who have an account balance smaller than the smallest order with status of 'P' in the data base --
SELECT
	*
FROM
	customer
WHERE
	c_acctbal < 
		(
		SELECT
			MIN(o_totalprice)
		FROM
			orders
		WHERE
			o_orderstatus = 'P'
		);






-- 3. Return all columns from the customers table as well as a column that categorizes account balances into small, medium, large --
-- and extra large balances.  Extra large balances are considered to be over $8k, large balances are considered to be larger than $6k --
-- and less than or equal to $8k, medium balances are considered to be larger than $3k and less than or equal to $6k, and small orders are --
-- considered to be $3k or less. --
SELECT
	*
    , CASE
		WHEN c_acctbal > 8000
			THEN "EXTRA LARGE"
		WHEN c_acctbal > 6000
			THEN "LARGE"
		WHEN c_acctbal > 3000
			THEN "MEDIUM"
		ELSE "SMALL"
	END AS "ACCOUNT BALANCE SIZE"
FROM
	customer
ORDER BY 
	c_acctbal; 




-- 4. Using a sub query return a list of all nations who have a customer with a '988' area code and an account balance of at least $9,500  --
SELECT
	n_name
FROM
	nation
WHERE
	n_nationkey IN
		(
        SELECT 
			c_nationkey 
		FROM 
			customer
		WHERE
			c_phone LIKE '988%'
			AND c_acctbal >= 9500
		);
			
		





-- 5. Which customer market segments have a higher total account balance than the automobile and building segments? --
SELECT
	 c_mktsegment
    , SUM(c_acctbal)
FROM
	customer
GROUP BY 
	1
HAVING
	SUM(c_acctbal) > ALL
		(
        SELECT
			 SUM(c_acctbal)
		FROM
			customer
		 WHERE
			 c_mktsegment in ('AUTOMOBILE', 'BUILDING')
		 GROUP BY
			c_mktsegment
		);






-- 6. Write a query that show percent of total orders for each order priority (results should be on one row) --
SELECT
	AVG(CASE WHEN o_orderpriority = '1-URGENT' THEN 1
		ELSE 0 END)*100 AS URGENT_PCT, 
        
	AVG(CASE WHEN o_orderpriority = '2-HIGH' THEN 1
		ELSE 0 END)*100 AS HIGH_PCT, 
        
	AVG(CASE WHEN o_orderpriority = '3-MEDIUM' THEN 1
		ELSE 0 END)*100 AS MEDIUM_PCT,
        
	AVG(CASE WHEN o_orderpriority = '4-NOT SPECIFIED' THEN 1
		ELSE 0 END)*100 AS NOT_SPEC_PCT,
        
	AVG(CASE WHEN o_orderpriority = '5-LOW' THEN 1
		ELSE 0 END)*100 AS LOW_PCT
FROM
	orders;






-- 7. Write a query that show percent of total order value for each order priority (results should be on one row) --
SELECT
	SUM(CASE WHEN o_orderpriority = '1-URGENT' THEN o_totalprice
		ELSE 0 END)/SUM(o_totalprice)*100 AS URGENT_VALUE_PCT, 
        
	SUM(CASE WHEN o_orderpriority = '2-HIGH' THEN o_totalprice
		ELSE 0 END)/SUM(o_totalprice)*100 AS HIGH_VALUE_PCT, 
        
	SUM(CASE WHEN o_orderpriority = '3-MEDIUM' THEN o_totalprice
		ELSE 0 END)/SUM(o_totalprice)*100 AS MEDIUM_VALUE_PCT,
        
	SUM(CASE WHEN o_orderpriority = '4-NOT SPECIFIED' THEN o_totalprice
		ELSE 0 END)/SUM(o_totalprice)*100 AS NOT_SPEC_VALUE_PCT,
        
	SUM(CASE WHEN o_orderpriority = '5-LOW' THEN o_totalprice
		ELSE 0 END)/SUM(o_totalprice)*100 AS LOW_VALUE_PCT
FROM
	orders;






-- 8. Rewrite your query from #6 so that the data is now at the customer number level  --
SELECT
	o_custkey,
	AVG(CASE WHEN o_orderpriority = '1-URGENT' THEN 1
		ELSE 0 END)*100 AS URGENT_PCT, 
        
	AVG(CASE WHEN o_orderpriority = '2-HIGH' THEN 1
		ELSE 0 END)*100 AS HIGH_PCT, 
        
	AVG(CASE WHEN o_orderpriority = '3-MEDIUM' THEN 1
		ELSE 0 END)*100 AS MEDIUM_PCT,
        
	AVG(CASE WHEN o_orderpriority = '4-NOT SPECIFIED' THEN 1
		ELSE 0 END)*100 AS NOT_SPEC_PCT,
        
	AVG(CASE WHEN o_orderpriority = '5-LOW' THEN 1
		ELSE 0 END)*100 AS LOW_PCT
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
			AVG(CASE WHEN o_orderpriority = '1-URGENT' THEN 1
				ELSE 0 END)*100 AS URGENT_PCT, 
				
			AVG(CASE WHEN o_orderpriority = '2-HIGH' THEN 1
				ELSE 0 END)*100 AS HIGH_PCT, 
				
			AVG(CASE WHEN o_orderpriority = '3-MEDIUM' THEN 1
				ELSE 0 END)*100 AS MEDIUM_PCT,
				
			AVG(CASE WHEN o_orderpriority = '4-NOT SPECIFIED' THEN 1
				ELSE 0 END)*100 AS NOT_SPEC_PCT,
				
			AVG(CASE WHEN o_orderpriority = '5-LOW' THEN 1
				ELSE 0 END)*100 AS LOW_PCT
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
		AVG(CASE WHEN o_orderpriority = '1-URGENT' THEN 1
			ELSE 0 END)*100 AS URGENT_PCT, 
        
		AVG(CASE WHEN o_orderpriority = '2-HIGH' THEN 1
			ELSE 0 END)*100 AS HIGH_PCT, 
			
		AVG(CASE WHEN o_orderpriority = '3-MEDIUM' THEN 1
			ELSE 0 END)*100 AS MEDIUM_PCT,
			
		AVG(CASE WHEN o_orderpriority = '4-NOT SPECIFIED' THEN 1
			ELSE 0 END)*100 AS NOT_SPEC_PCT,
			
		AVG(CASE WHEN o_orderpriority = '5-LOW' THEN 1
			ELSE 0 END)*100 AS LOW_PCT
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






	
	





