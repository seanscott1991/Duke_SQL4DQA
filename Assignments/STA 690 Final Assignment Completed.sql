-- ------------------------------------------------------------------------------------------- --
-- -------------------------------   STA 690 Final Assignment   ------------------------------ --
-- ------------------------------------------------------------------------------------------- --

-- Instructions --

-- Write your code in this file after each corresponding question and include a comment with the answer --
-- to the question if applicable.  Code should use syntax best practices.  Submit code by EOD 10/14/22. --






-- 1. Use the Credit database. For each region, return which member owes the credit card company the most and the --
-- amount that they owe.  Amount owed is calculated as total charges minus total payments, which are found in the --
-- payment table.  If a member is not present in the payments table then they have not made any payments and they --
-- owe the full amount of their charges.  Final query should include a region name column, a member first name --
-- column, a member last name column, and an amount owed column. --
WITH T1 AS
	(
    SELECT
		member_no
        , SUM(charge_amt) AS TOTAL_CHARGES
	FROM
		charge
	GROUP BY
		1
	),
T2 AS
	(
    SELECT
		member_no
        , SUM(payment_amt) AS TOTAL_PAYMENTS
	FROM
		payment
	GROUP BY
		1
	),
T3 AS
	(
	SELECT
		T1.*
        , m.firstname
        , m.lastname
        , T2.TOTAL_PAYMENTS
        , T1.TOTAL_CHARGES - COALESCE(T2.TOTAL_PAYMENTS, 0) AS AMT_OWED
        , r.region_name
	FROM
		T1
        LEFT JOIN T2
			ON T1.member_no = T2.member_no
		INNER JOIN member m
			ON T1.member_no = m.member_no
		INNER JOIN region r
			ON m.region_no = r.region_no
	),
T4 AS
	(
    SELECT
		*
        , RANK() OVER (PARTITION BY region_name ORDER BY AMT_OWED DESC) AS OWED_RANK
	FROM
		T3
    )
SELECT 
	region_name
    , firstname
    , lastname
    , AMT_OWED
FROM
	T4
WHERE
	OWED_RANK = 1;







-- 2. Use the Credit database.  Please return the 5 days that had the highest week over week charges increase. --
-- This is calculated as the difference between a day's total charges minus the total charges from the day a week prior. --
-- We are only interested in charges from members that are associated with a corporation. Output should be ordered by week over --
-- week charges increase descending and include a date column and a column for the week over week charges increase amount. --
WITH T1 AS
	(
	SELECT 
		DATE(charge_dt) AS CHRG_DT
		, SUM(charge_amt) AS TOTAL_CHARGE
	FROM
		charge ch
		INNER JOIN member m
			on ch.member_no = m.member_no
		INNER JOIN corporation co
			on m.corp_no = co.corp_no
	GROUP BY
		1
	),
T2 AS
	(
	SELECT
		*
        , TOTAL_CHARGE - LAG(TOTAL_CHARGE, 7) OVER (ORDER BY CHRG_DT) AS PREV_WEEK_CHRG_DIFF
	FROM
		T1
	GROUP BY
		1, 2
	)
SELECT 
	CHRG_DT
	, PREV_WEEK_CHRG_DIFF
FROM
	T2
ORDER BY 
	2 DESC
LIMIT
	5;











-- 3. Use the credit database. The "Corp. Imperial RestaurantsAg." corporation is interested in looking at all charges they have --
-- made in the meals category.  They would like to know, on average, how many days pass between days that included a meals charge --
-- of theirs. Their meals related charges tend to come in bunches, so they are not interested in gaps between charges that --
-- occured on the same day, only the gaps between the days themselves. --
WITH T1 AS
	(
	SELECT DISTINCT 
		DATE(CHARGE_DT) AS CHARGE_DATE
	FROM
		charge ch
		INNER JOIN member m
			ON ch.member_no = m.member_no
		INNER JOIN corporation co
			ON m.corp_no = co.corp_no
		INNER JOIN category c
			ON c.category_no = ch.category_no
	WHERE
		co.corp_name = 'Corp. Imperial RestaurantsAg.'
		 AND c.category_desc = 'Meals'
	ORDER BY 
		1
    ),
T2 AS
	(
	SELECT
		CHARGE_DATE
		, CHARGE_DATE - LAG(CHARGE_DATE, 1) OVER (ORDER BY CHARGE_DATE) AS CHARGE_DATE_DIFF
	FROM
		T1
	GROUP BY
		1
	)
SELECT
	AVG(CHARGE_DATE_DIFF)
FROM
	T2;










-- 4. Use the credit database.  The credit card company is interested in analyzing basic differences between charges that have been --
-- connected to a statement versus charges that have not.  Please return total charges and average charge amount for both groups of --
-- charges.  Output should include 3 columns and 2 rows.  A column containing a categorical variable seperating the two groups, a --
-- total charges column and an average charge amount column. --
WITH T1 AS
	(
	SELECT
		s.*
        , c.charge_amt AS CHARGE_AMT
		, CASE
			WHEN s.statement_no IS NULL THEN "NO STATEMENT"
			ELSE "STATEMENT"
		END AS STATEMENT_FLAG
	FROM
		charge c
		LEFT JOIN statement s
			ON c.statement_no = s.statement_no
	)
SELECT
	STATEMENT_FLAG
    , COUNT(*)
    , AVG(CHARGE_AMT)
FROM 
	T1
GROUP BY
	1;








