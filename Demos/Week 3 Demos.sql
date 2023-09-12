-- ------------------------------------------------------------------------------------------- --
-- --------------------------------------- Week 3 Demos -------------------------------------- --
-- ------------------------------------------------------------------------------------------- --

-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 3.1  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 1. Return all of the newest charges in the charge table --
SELECT
	*
FROM
	charge
WHERE
	charge_dt = 
		(
		SELECT
			MAX(charge_dt)
		FROM
			charge
		)
;
    
        
-- 2. Return all charges in the charge table that had an above average charge amount --
SELECT
	*
FROM
	charge
WHERE
	charge_amt > 
		(
		SELECT
			AVG(charge_amt)
		FROM
			charge
		)
;
    
   
   


-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 3.2  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --    
    
-- 1. List of members who have made a charge of category 10 --
SELECT
	CONCAT(firstname, ' ', lastname) as "Member Full Name"
FROM
	member
WHERE
	member_no IN 
		(
        SELECT
			member_no
		FROM
			charge
		WHERE
			category_no = 10
		)
;
 

-- 2. List of members who have never made a charge of category 10 --
SELECT
	CONCAT(firstname, ' ', lastname) as "Member Full Name"
FROM
	member
WHERE
	member_no NOT IN 
		(
        SELECT
			member_no
		FROM
			charge
		WHERE
			category_no = 10
		)
;
	
    
    
    
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 3.3  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 1. List of members who have made a charge of category 10 --
SELECT
	CONCAT(firstname, ' ', lastname) as "Member Full Name"
FROM
	member
WHERE
	member_no = ANY 
		(
        SELECT
			member_no
		FROM
			charge
		WHERE
			category_no = 10
		)
; 
 
        
-- 2. List of members who have never made a charge of category 10 --
SELECT
	CONCAT(firstname, ' ', lastname) as "Member Full Name"
FROM
	member
WHERE
	member_no <> ALL 
		(
        SELECT
			member_no
		FROM
			charge
		WHERE
			category_no = 10
		)
;


-- 3.  Which regions have higher member populations than regions 8, 9, and 7?  (region numbers are fine) --
SELECT
	region_no
    , COUNT(*)
FROM
	member
GROUP BY 
	region_no
HAVING
	COUNT(*) > ALL
		(
        SELECT
			COUNT(*)
		FROM
			member
		WHERE
			region_no in (8, 9, 7)
		GROUP BY
			region_no
		)
;

-- For Reference --
SELECT
	region_no
    , COUNT(*)
FROM
	member
GROUP BY
	region_no
ORDER BY 
	2 DESC;
    
    
    
    
    
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 3.4  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 1. Return all charges for statements due in september  --
SELECT
	*
FROM
	charge
WHERE
	(member_no, statement_no) IN 
		(
        SELECT
			member_no
            , statement_no
		FROM
			statement
		WHERE
			MONTH(statement_dt) = 9
		)
;

    
    
    
    
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 3.5  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 1. List of members who have made a charge of category 10 (Repeat of demo 3.2.1) --
SELECT
	CONCAT(firstname, ' ', lastname) as "Member Full Name"
FROM
	member m
    INNER JOIN
		(
        SELECT DISTINCT
			member_no
		FROM
			charge
		WHERE
			category_no = 10
		) sb_qry
        ON m.member_no = sb_qry.member_no
;


-- 2. Filter the charge table to only members who are from a European Region --
SELECT
	*
FROM
	charge c
    INNER JOIN 
		(
        SELECT 
			m.member_no 
		FROM
			member m
			INNER JOIN region r
				on m.region_no = r.region_no
		WHERE
			r.region_name LIKE '%Europea%'
		) europea_members
        ON c.member_no = europea_members.member_no
;

        
-- 2. Join in aggregated information (as opposed to grouping by several columns) --
SELECT
	m.*
    , cat_7_counts.CAT_7_CHARGES
	, cat_4_counts.CAT_4_CHARGES
    , cat_9_counts.CAT_9_CHARGES
FROM
	member m
	LEFT JOIN 
		(SELECT
			member_no
            , COUNT(*) AS CAT_7_CHARGES
		FROM
			charge
		WHERE
			category_no = 7
		GROUP BY 
			member_no
		) cat_7_counts
        ON m.member_no = cat_7_counts.member_no
	LEFT JOIN 
		(SELECT
			member_no
            , COUNT(*) AS CAT_4_CHARGES
		FROM
			charge
		WHERE
			category_no = 4
		GROUP BY 
			member_no
		) cat_4_counts
        ON m.member_no = cat_4_counts.member_no
	LEFT JOIN 
		(SELECT
			member_no
            , COUNT(*) AS CAT_9_CHARGES
		FROM
			charge
		WHERE
			category_no = 9
		GROUP BY 
			member_no
		) cat_9_counts
        ON m.member_no = cat_9_counts.member_no
;





-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 3.6  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 1. Recode demo 3.3.3 using CTEs --
WITH T1 AS
	(
	SELECT
		COUNT(*)
	FROM
		member
	WHERE
		region_no in (8, 9, 7)
	GROUP BY
		region_no
	)
SELECT
	region_no
    , COUNT(*)
FROM
	member
GROUP BY 
	region_no
HAVING
	COUNT(*) > ALL 
		(SELECT * FROM T1)
;
    
  
  
-- 2. Recode demo 3.6.2 using CTEs --
WITH cat_7_counts AS
	(
    SELECT
		member_no
		, COUNT(*) AS CAT_7_CHARGES
	FROM
		charge
	WHERE
		category_no = 7
	GROUP BY 
		member_no
),
cat_4_counts AS
	(
    SELECT
		member_no
		, COUNT(*) AS CAT_4_CHARGES
	FROM
		charge
	WHERE
		category_no = 4
	GROUP BY 
		member_no
),
cat_9_counts AS
	(SELECT
		member_no
		, COUNT(*) AS CAT_9_CHARGES
	FROM
		charge
	WHERE
		category_no = 9
	GROUP BY 
		member_no
)
SELECT
	m.*
    , cat_7_counts.CAT_7_CHARGES
	, cat_4_counts.CAT_4_CHARGES
    , cat_9_counts.CAT_9_CHARGES
FROM
	member m
	LEFT JOIN cat_7_counts
        ON m.member_no = cat_7_counts.member_no
	LEFT JOIN cat_4_counts
        ON m.member_no = cat_4_counts.member_no
	LEFT JOIN cat_9_counts
        ON m.member_no = cat_9_counts.member_no
;






-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 3.7  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 1. Categorize charges into small medium and large charge size based on charge amount  --
SELECT
	*
    , CASE
		WHEN charge_amt > 3500
			THEN "HIGH"
		WHEN charge_amt > 2000
			THEN "MEDIUM"
		ELSE "SMALL"
	END AS "Charge Size"
FROM
	charge
;
    

-- 2. Add a new charge category column to the charge table based on existing category values  --
SELECT
	*
    , CASE
		WHEN category_no IN (1, 3, 5, 7, 9) 
			THEN "ODD"
		WHEN category_no IN (2, 4, 6, 8, 10)
			THEN "EVEN"
		ELSE "NA"
	END AS "Category Group"
FROM
	charge
    ;
    




-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 3.8  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 1. Return total charges for charge categories 7, 4, and 9 --
SELECT
	 SUM(CASE WHEN category_no = 7 THEN 1
 		ELSE 0 END) AS CAT_7_CHARGES,
         
 	SUM(CASE WHEN category_no = 4 THEN 1
 		ELSE 0 END) AS CAT_4_CHARGES,
         
 	SUM(CASE WHEN category_no = 9 THEN 1
 		ELSE 0 END) AS CAT_9_CHARGES
FROM
	charge
;


-- 2. Return total charges for charge categories 7, 4, and 9 but use short hand transformation --
SELECT
	SUM(category_no = 7) AS CAT_7_CHARGES,
         
 	SUM(category_no = 4) AS CAT_4_CHARGES,
         
 	SUM(category_no = 9) AS CAT_9_CHARGES
FROM
	charge
;



-- 3. Return total charges for charge categories 7, 4, and 9 grouped by member number  --
SELECT
	member_no,
	AVG(CASE WHEN category_no = 7 THEN 1
		ELSE 0 END) AS CAT_7_CHARGES,
	AVG(CASE WHEN category_no = 4 THEN 1
		ELSE 0 END) AS CAT_4_CHARGES,
	AVG(CASE WHEN category_no = 9 THEN 1
		ELSE 0 END) AS CAT_9_CHARGES ,
	AVG(category_no = 7)
FROM
	charge
GROUP BY
	member_no
;
    
    
    
    
    
-- 4. Leverage the above query as a subquery and join it to all member information in the member table --   
SELECT
	m.*
    , c.*
FROM
	member m
    LEFT JOIN 
		(
        SELECT
			member_no,
			SUM(CASE WHEN category_no = 7 THEN 1
				ELSE 0 END) AS CAT_7_CHARGES,
			SUM(CASE WHEN category_no = 4 THEN 1
				ELSE 0 END) AS CAT_4_CHARGES,
			SUM(CASE WHEN category_no = 9 THEN 1
				ELSE 0 END) AS CAT_9_CHARGES 
		FROM
			charge
		GROUP BY
			member_no
		) c
        ON m.member_no = c.member_no
;
    
    
-- 5. Rewrite the above query using common table expressions --   
WITH c AS
	(
    SELECT
		member_no,
		SUM(CASE WHEN category_no = 7 THEN 1
			ELSE 0 END) AS CAT_7_CHARGES,
		SUM(CASE WHEN category_no = 4 THEN 1
			ELSE 0 END) AS CAT_4_CHARGES,
		SUM(CASE WHEN category_no = 9 THEN 1
			ELSE 0 END) AS CAT_9_CHARGES 
	FROM
		charge
	GROUP BY
		member_no
	)
SELECT 
	m.*
    , c.*
FROM
	member m
    LEFT JOIN c
		ON m.member_no = c.member_no
;





-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 3.9  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --


-- 1. Return total orders and percent of total orders for each order status (use tpch database) --
SELECT
  o_orderstatus
  , COUNT(*)
  , COUNT(*) / (SELECT COUNT(*) FROM orders) * 100 AS PCT_TOTAL
FROM 
	orders
GROUP BY 
	1;
    
    
-- 2. Return total order value and percent of total order value for each order status (use tpch database) --
SELECT
  o_orderstatus
  , SUM(o_totalprice)
  , SUM(o_totalprice) / (SELECT SUM(o_totalprice) FROM orders) * 100 AS PCT_TOTAL
FROM 
	orders
GROUP BY 
	1;
    
    
-- 3. Instead of using a group by aggregation use a CTE to return percent of total order value for each order status (use tpch database) --
WITH price_sum as
(
select SUM(o_totalprice) from orders
)

SELECT
	SUM(CASE WHEN o_orderstatus = 'P' THEN o_totalprice
		ELSE 0 END)/(select * from price_sum) * 100 AS P_STATUS_VALUE_PCT, 
        
	SUM(CASE WHEN o_orderstatus = 'O' THEN o_totalprice
		ELSE 0 END)/(select * from price_sum) * 100 AS O_STATUS_VALUE_PCT, 
        
	SUM(CASE WHEN o_orderstatus = 'F' THEN o_totalprice
		ELSE 0 END)/(select * from price_sum) * 100 AS F_STATUS_VALUE_PCT
FROM
	orders;