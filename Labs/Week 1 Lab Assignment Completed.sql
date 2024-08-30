-- ------------------------------------------------------------------------------------------- --
-- ---------------------------------------  Week 1 Lab  -------------------------------------- --
-- ------------------------------------------------------------------------------------------- --

-- Instructions --

-- Use the tpch relational dataset to answer the following questions. Write your code  
-- in this file after each corresponding question and include a comment with the answer 
-- to the question if applicable.  Submit code at end of lab session.



-- About the tpch database --

-- The tpch relational dataset contains data on 1.5 million orders for 'parts'.  The orders table 
-- contains data on each order.  The line item table contains data on the specific parts included
-- in each order.  The customer, nation, part, partsupp, region, and supplier tables all contain
-- additional data that can be related back to the orders and line items. 





-- 1. What are the distinct values of the order priority column in the orders table? --
SELECT DISTINCT
	o_orderpriority
FROM
	orders;
    
-- 4-NOT SPECIFIED
-- 1-URGENT
-- 5-LOW
-- 3-MEDIUM
-- 2-HIGH




-- 2. What are the dates of the first and last orders in the order table?  Write a query that returns these dates and names the columns "First Order Date" and "Last Order Date". --
SELECT
	MIN(o_orderdate) as "First Order Date"
    , MAX(o_orderdate) as "Last Order Date"
FROM
	orders;
    
-- First order date is 1/1/1992 and last order date is 8/1/1998




-- 3. How Many Orders were placed in 1994? --
SELECT
	count(*)
FROM
	orders
WHERE
	-- YEAR(o_orderdate) = 1994;
    o_orderdate LIKE '1994%'

-- 227664



-- 4. Write a query that returns all columns from the orders table for orders with an order status of 'F’. --
SELECT
	*
FROM
	orders
WHERE
	o_orderstatus = 'F';




-- 5. How many orders have a total price above $200,000? --
SELECT
	count(*)
FROM
	orders
WHERE
	o_totalprice > 200000;

-- 463338



-- 6. What is the average price for orders with order priority of '3-MEDIUM' or higher (priority)?  Use IN in your query. --
SELECT
	AVG(o_totalprice)
FROM
	orders
WHERE
	o_orderpriority IN ('3-MEDIUM', '2-HIGH', '1-URGENT');
    
-- $153017.29




-- 7. Using the part table, what is the most expensive part whose name begins with 'p'? --
SELECT
	p_name
    , p_retailprice
FROM
	part
WHERE
	p_name LIKE 'p%'
ORDER BY
	p_retailprice DESC
LIMIT
	1;
    
-- puff light beige misty forest




-- 8. Using the part table, what is the least expensive part that has a part type that is not considered small? --
SELECT
	p_name
    , p_retailprice
FROM
	part
WHERE
	p_type NOT LIKE '%SMALL%'
ORDER BY
	p_retailprice ASC;
    
-- burlywood plum powder puff mint and purple light green metallic khaki





-- 9. Write a query that shows count and average price per order status.  Give names to the count and average columns and round the prices to 2 decimal places --
SELECT
	o_orderstatus
    , count(*) AS "Total Orders"
    , ROUND(AVG(o_totalprice), 2) AS "Average Price"
FROM
	orders
GROUP BY 
	1;






-- 10. In the part table, price per pound is considered to be the retail price divided by the part size.  Which manufacturer has the highest price per pound? --
SELECT
	p_mfgr,
    avg(p_retailprice / p_size)
FROM
	part
GROUP BY 
	1
ORDER BY 
	2 DESC
    ;







-- 11. Write a query that shows total orders per order priority category and order status among orders with an order status of 'F' or 'P'.  Order results by order totals descending.  Please use numeric placeholders in your query.  --
SELECT
	o_orderpriority
    , o_orderstatus
    , count(*)
FROM
	orders
WHERE
	o_orderstatus in ('F', 'P')
GROUP BY 
	1, 2
ORDER BY 
	3 DESC;
    
 -- or --   
SELECT
	o_orderpriority
    , o_orderstatus
    , count(*)
FROM
	orders
GROUP BY 
	1, 2
HAVING
	o_orderstatus in ('F', 'P')
ORDER BY 
	3 DESC;







-- 12. Return the frequency of orders in each month in 1997 that had at least 800 total orders. Please filter to orders whose comment mentions "excuses" --
SELECT
	MONTH(o_orderdate)
    , count(*)
FROM
	orders
WHERE
	YEAR(o_orderdate) = 1997
	AND o_comment like "%excuses%"
GROUP BY
	1
HAVING
	count(*) >= 800;







-- 13. Return the first 50 orders that had an urget priority --
SELECT
	*
FROM
	orders
WHERE
	o_orderpriority = '1-URGENT'
ORDER BY
	o_orderdate
LIMIT
	50;
    
    
    
    
    


-- 14. Return the order status of the most recently placed order --
SELECT
	o_orderstatus
FROM
	orders
ORDER BY
	o_orderdate DESC
LIMIT
	1;