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







-- 1. Write a query that returns all columns and all rows from the lineitem table along with the part type and part name columns --
SELECT
	l.*
    , p.p_name
	, p.p_type
FROM
	lineitem l
    INNER JOIN part p
		ON l.l_partkey = p.p_partkey;






-- 2. Write a query that returns all columns and all rows from the lineitem table along with --
-- the order priority (name this column "Priority") and the supplier address (name this column "Address") --
SELECT
	l.*
    , o.o_orderpriority AS "Priority"
	, s.s_address AS "Address"
FROM
	lineitem l
    INNER JOIN orders o
		ON l.l_orderkey = o.o_orderkey
	INNER JOIN supplier s
		ON l.l_suppkey = s.s_suppkey;






-- 3.  Write a query that returns all rows from the lineitem table that had shipmode of RAIL and include the order priority column --
--     from the orders table and the name column from the customer table in the result --
SELECT
	l.*
	, o.o_orderpriority
    , c.c_name
FROM
	lineitem l
    INNER JOIN orders o
		ON l.l_orderkey = o.o_orderkey
    INNER JOIN customer c
		ON o.o_custkey = c.c_custkey    
WHERE
	l.l_shipmode = 'RAIL';






-- 4. Write a query that returns a customers name and their most recent order date (every customer in the database should be included) --
SELECT
	c.c_name
    , MAX(o.o_orderdate)
FROM
	customer c
    LEFT JOIN orders o
		on c.c_custkey = o.o_custkey
GROUP BY
	1;





-- 5. Write a query that returns count of "URGENT" orders per delivery nation for orders in 1995.  Order results by total orders descending--
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
 	o.o_orderpriority = "1-URGENT"
     AND YEAR(o.o_orderdate) = 1995
GROUP BY
	1
ORDER BY
	2 DESC;




-- 6. Using set logic return all rows in the line item table where ship mode is truck and line status is F --
SELECT
	*
FROM
	lineitem
WHERE
	l_shipmode = "TRUCK"
    
INTERSECT

SELECT 
	*
FROM
	lineitem
WHERE
	l_linestatus = "F";





-- 7. Using set logic return names of all customers who did not place an order in 1997 --
SELECT 
	c.c_name
FROM
	customer c
    
EXCEPT

SELECT
	c.c_name
FROM
	customer c
    INNER JOIN orders o
		ON c.c_custkey = o.o_custkey	
WHERE
	YEAR(o.o_orderdate) = 1997;





-- 8. Using the part supplier table, part table and supplier table, what is the average account balance among suppliers who supply part 'black lemon dim steel yellow' --
SELECT
	AVG(s.s_acctbal)
FROM
	supplier s
    INNER JOIN 	partsupp ps
        ON s.s_suppkey = ps.ps_suppkey
	INNER JOIN part p
        ON ps.ps_partkey = p.p_partkey    
WHERE
	p.p_name = 'black lemon dim steel yellow';






-- 9. Write a query that returns a list of nations that product "hot spring dodger dim light" was mailed to (shipping mode) --
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
	p.p_name = "hot spring dodger dim light"
    and l.l_shipmode = "MAIL";
		





-- 10. Write a query that returns a list of nations that product "bisque indian plum turquoise sienna" was flown from --
SELECT DISTINCT
	 n.n_name
FROM
	lineitem l
 	INNER JOIN part p
 		ON l.l_partkey = p.p_partkey
	INNER JOIN supplier s
 		ON l.l_suppkey = s.s_suppkey
 	INNER JOIN nation n
 		ON s.s_nationkey = n.n_nationkey
WHERE 
	p.p_name = "bisque indian plum turquoise sienna"
    and l.l_shipmode = "AIR";
	
	




-- 11. Write a query that returns a list of nations that product "hot spring dodger dim light" was either mailed to or flown from --
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
	p.p_name = "hot spring dodger dim light"
    and l.l_shipmode = "MAIL"
    
UNION

SELECT DISTINCT
	 n.n_name
FROM
	lineitem l
 	INNER JOIN part p
 		ON l.l_partkey = p.p_partkey
	INNER JOIN supplier s
 		ON l.l_suppkey = s.s_suppkey
 	INNER JOIN nation n
 		ON s.s_nationkey = n.n_nationkey
WHERE 
	p.p_name = "hot spring dodger dim light"
    and l.l_shipmode = "AIR";
