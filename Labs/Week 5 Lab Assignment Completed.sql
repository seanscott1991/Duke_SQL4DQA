-- ------------------------------------------------------------------------------------------- --
-- ---------------------------------------  Week 5 Lab  -------------------------------------- --
-- ------------------------------------------------------------------------------------------- --

-- Instructions --

-- Write your code in this file after each corresponding question and include a comment with the answer 
-- to the question if applicable.  Code should use syntax best practices.  Submit code at end of lab session.






-- 1. Using the draft table in Basketball_women, return the school that had the most players drafted into the WNBA league  --
-- for each year.  If there is a tie, return the school that had the lowest average 'draftOverall' value for --
-- that year.  Output should include only 2 columns, year and school. --
WITH T1 AS
	(
	SELECT
		draftYear
        , draftFrom
        , COUNT(*) AS TOTAL_DRAFTED
        , AVG(draftOverall) AS AVG_PLACE_DRAFTED
        , RANK() OVER (PARTITION BY draftYear ORDER BY COUNT(*) DESC, AVG(draftOverall)) AS DRAFT_RANK
	FROM
		draft
	WHERE
		lgID = 'WNBA'
	GROUP BY
		1, 2
	ORDER BY
		1, 3 DESC, 4
	)
SELECT
	draftYear
    , draftFrom
FROM
	T1
WHERE
	DRAFT_RANK = 1;






-- 2. Use the Credit database. I have a theory that months that saw growth in average charge amount from the previous month have a higher --
-- percentage of category 7 charges than months that saw decline.  Please return percentage of category 7 charges for months that saw -- 
-- growth in average charge amount as well as those that saw decline --
WITH T1 AS
	(
	SELECT
		MONTH(charge_dt) AS CHARGE_MONTH
		, AVG(Charge_amt) AS AVG_CHARGE_AMT
		, COUNT(*) AS CHARGE_COUNT
        , SUM(category_no = 7) AS TOTAL_CAT7_CHARGES
	FROM
		charge
	GROUP BY
		1
	),
T2 AS
	(
	SELECT
		*
		, CASE
			WHEN AVG_CHARGE_AMT > (LAG(AVG_CHARGE_AMT, 1) OVER (ORDER BY CHARGE_MONTH)) 
				THEN "GROWTH"
			WHEN AVG_CHARGE_AMT < (LAG(AVG_CHARGE_AMT, 1) OVER (ORDER BY CHARGE_MONTH))
				THEN "DECLINE"
			ELSE "NA" END
			AS AVG_CHARGE_GROWTH
	FROM
		T1
	GROUP BY
		1, 2, 3, 4
	)
SELECT
	AVG_CHARGE_GROWTH
    , ROUND( (SUM(TOTAL_CAT7_CHARGES) / SUM(CHARGE_COUNT)) * 100, 2) AS CAT_7_PCT
FROM
	T2
GROUP BY
	1
HAVING
	AVG_CHARGE_GROWTH NOT LIKE 'NA';





-- 3. Use the Credit database.  The credit card company likes to mail special offers to members who were in the first $100,000 of the company's charges --
-- each month.  Return the count of how many offers must be mailed to each region each month.  A member should be only sent 1 offer per month.  Please --
-- order results by month and then by offers sent descending --
WITH T1 AS
	(
	SELECT
		c.member_no
		, c.charge_dt
		, MONTH(c.charge_dt) AS CHARGE_MONTH
		, c.charge_amt
		, r.region_name
		, SUM(c.charge_amt) OVER (PARTITION BY MONTH(c.charge_dt) ORDER BY c.charge_dt ROWS UNBOUNDED PRECEDING) AS RUNNING_TOTAL
	FROM
		charge c
		LEFT JOIN member m
			ON c.member_no = m.member_no
		LEFT JOIN region r
			ON m.region_no = r.region_no
	GROUP BY
		1, 2, 3, 4, 5
	ORDER BY
		2
	),
T2 AS
	(
	SELECT DISTINCT 
		CHARGE_MONTH
        , member_no
		, region_name
	FROM
		T1
	WHERE 
		RUNNING_TOTAL < 100000 )
SELECT
	CHARGE_MONTH
	, region_name
    , COUNT(*) AS OFFERS_SENT
FROM 
	T2
GROUP BY
	1, 2
ORDER BY
	1, 3 DESC;
	
 





-- 4. Using the draft table in Basketball_women, create output that shows how many times a given school --
-- was among the top 3 schools for most players drafted into the WNBA for a given draft year.  --
WITH T1 AS 
	(
    SELECT
		draftYear
        , draftFrom
        , COUNT(*) AS TOTAL_DRAFTED
        , RANK() OVER (PARTITION BY draftYear ORDER BY COUNT(*) DESC) AS DRAFT_RANK
	FROM
		draft
	WHERE
		lgID = 'WNBA'
	GROUP BY
		1, 2
	ORDER BY
		1, 3 DESC
	)	
SELECT
	draftFrom
	, COUNT(*) AS TOP_3_APPEARANCES
FROM
	T1
WHERE 
	DRAFT_RANK <= 3
GROUP BY
	1
ORDER BY
	2 DESC;

			
		



-- 5. Use the orders table in the tpch database.  What 6 quarter period had the highest total order price?  Query result should be --
-- 3 columns and 1 row.  The first value should be the first quarter of the period.  The second value should be the last quarter of --
-- period and the third value should be the total order price of the period. --
WITH T1 AS
	(
	SELECT
		CONCAT(YEAR(o_orderdate), ' - ', QUARTER(o_orderdate)) AS QTR
		, SUM(o_totalprice) AS QRTLY_TOTALPRICE
	FROM
		orders
	GROUP BY
		1
	ORDER BY
		1
	),
T2 AS
	(	
	SELECT
		*
        , SUM(QRTLY_TOTALPRICE) OVER (ORDER BY QTR ROWS BETWEEN CURRENT ROW AND 5 FOLLOWING) AS SIX_QTR_TOTAL
         , LEAD(QTR, 5) OVER (ORDER BY QTR) AS LAST_QTR
	FROM 
		T1
	GROUP BY
		1, 2
	)	
SELECT
	QTR AS FIRST_QTR
    , LAST_QTR
    , SIX_QTR_TOTAL
FROM
	T2
WHERE 
    SIX_QTR_TOTAL = (SELECT MAX(SIX_QTR_TOTAL) FROM T2);  






