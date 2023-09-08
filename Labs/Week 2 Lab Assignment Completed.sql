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







-- 1. Write a query that returns all columns and all rows from the lineitem table along with the part brand and part manufacturer columns --
SELECT
	l.*
    , p.p_brand
	, p.p_mfgr
FROM
	lineitem l
    INNER JOIN part p
		ON l.l_partkey = p.p_partkey;






-- 2.  Write a query that returns all rows from the lineitem table and include the shipping priority column --
--     from the orders table and the address column from the customer table in the result --
SELECT
	l.*
	, o.o_shippriority
    , c.c_address
FROM
	lineitem l
    INNER JOIN orders o
		ON l.l_orderkey = o.o_orderkey
    INNER JOIN customer c
		ON o.o_custkey = c.c_custkey;   
        
        
        
        
        
        
-- 3. Write a query that returns all columns from the lineitem table where ship mode is air along with --
-- the order priority (name this column " Order Priority") and the supplier address (name this column "Address") --
SELECT
	l.*
    , o.o_orderpriority AS " Order Priority"
	, s.s_address AS "Address"
FROM
	lineitem l
    INNER JOIN orders o
		ON l.l_orderkey = o.o_orderkey
	INNER JOIN supplier s
		ON l.l_suppkey = s.s_suppkey
    WHERE
		l.l_shipmode = 'AIR';






-- 4. Write a query that returns count of status "F" orders per delivery nation for orders in 1994, 1997, and 1998.  Order results by total orders descending--
SELECT
	n.n_name
    , COUNT(*)
FROM
	orders o
    INNER JOIN customer c
		ON o.o_custkey = c.c_custkey
	INNER JOIN nation n
		ON c.c_nationkey = n.n_nationkey
 WHERE
 	o.o_orderstatus = "F"
     AND YEAR(o.o_orderdate) IN (1994, 1997, 1998)
GROUP BY
	1
ORDER BY
	2 DESC;
    
    
    
    
    
    
-- 5. Write a query that returns a customer's name and address and the date of their first order (every customer in the database should be included) --
SELECT
	c.c_name
	, c.c_address
    , MIN(o.o_orderdate)
FROM
	customer c
    LEFT JOIN orders o
		on c.c_custkey = o.o_custkey
GROUP BY
	1, 2;






-- 6. Using set logic return all parts that have a size of at least 30 and are made by manufacturer 4 --
SELECT
	*
FROM
	part
WHERE
	p_size >= 30
    
INTERSECT

SELECT 
	*
FROM
	part
WHERE
	p_mfgr = "Manufacturer#4";
    
    
    
    
    
    
-- 7. Using the part supplier table and supplier table, what is the average account balance among suppliers who supply a part made out of brass --
SELECT
	AVG(s.s_acctbal)
FROM
	supplier s
    INNER JOIN 	partsupp ps
        ON s.s_suppkey = ps.ps_suppkey
	INNER JOIN part p
        ON ps.ps_partkey = p.p_partkey    
WHERE
	p.p_type LIKE '%BRASS%';






-- 8. Using set logic return names and addresses of all customers who have never placed an urgent order --
SELECT 
	c.c_name
	, c.c_address
FROM
	customer c
    
EXCEPT

SELECT
	c.c_name
    , c.c_address
FROM
	customer c
    INNER JOIN orders o
		ON c.c_custkey = o.o_custkey	
WHERE
	o.o_orderstatus = '1-URGENT';






-- 9. Write a query that returns a list of nations that the product "turquoise honeydew grey thistle thistle" was flown to (shipping mode) --
SELECT DISTINCT
	n.n_name
FROM
	lineitem l
    INNER JOIN orders o
		ON l.l_orderkey = o.o_orderkey
	INNER JOIN customer c
		ON o.o_custkey = c.c_custkey
	INNER JOIN nation n
		ON c.c_nationkey = n.n_nationkey
	INNER JOIN part p
		ON l.l_partkey = p.p_partkey
WHERE 
	p.p_name = "turquoise honeydew grey thistle thistle"
    and l.l_shipmode = "AIR";
		





-- 10. Write a query that returns a list of nations that product "turquoise honeydew grey thistle thistle" was mailed from --
SELECT DISTINCT
	 n.n_name
FROM
	lineitem l
 	INNER JOIN part p
 		ON l.l_partkey = p.p_partkey
	INNER JOIN partsupp ps
 		ON p.p_partkey = ps.ps_partkey
	INNER JOIN supplier s
 		ON ps.ps_suppkey = s.s_suppkey
 	INNER JOIN nation n
 		ON s.s_nationkey = n.n_nationkey
WHERE 
	p.p_name = "turquoise honeydew grey thistle thistle"
    and l.l_shipmode = "MAIL";
	
	




-- 11. Write a query that returns a list of nations that product "turquoise honeydew grey thistle thistle" was either mailed from or flown to --
SELECT DISTINCT
	n.n_name
FROM
	lineitem l
    INNER JOIN orders o
		ON l.l_orderkey = o.o_orderkey
	INNER JOIN customer c
		ON o.o_custkey = c.c_custkey
	INNER JOIN nation n
		ON c.c_nationkey = n.n_nationkey
	INNER JOIN part p
		ON l.l_partkey = p.p_partkey
WHERE 
	p.p_name = "turquoise honeydew grey thistle thistle"
    and l.l_shipmode = "AIR"
    
UNION

SELECT DISTINCT
	 n.n_name
FROM
	lineitem l
 	INNER JOIN part p
 		ON l.l_partkey = p.p_partkey
	INNER JOIN partsupp ps
 		ON p.p_partkey = ps.ps_partkey
	INNER JOIN supplier s
 		ON ps.ps_suppkey = s.s_suppkey
 	INNER JOIN nation n
 		ON s.s_nationkey = n.n_nationkey
WHERE 
	p.p_name = "turquoise honeydew grey thistle thistle"
    and l.l_shipmode = "MAIL";
