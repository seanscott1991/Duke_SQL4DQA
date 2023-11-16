-- ------------------------------------------------------------------------------------------- --
-- -------------------------------  STA 690 Midterm Assignment  ------------------------------ --
-- ------------------------------------------------------------------------------------------- --

-- Instructions --

-- Use the Credit relational dataset to answer the following questions. Write your code in this
-- file after each corresponding question and include a comment with the answer to the question
-- if applicable.  Code should use syntax best practices.  Submit code by EOD 9/30/22.







-- 1. Return all columns from the charge table for charges less than $300 --
SELECT
	*
FROM
	charge
WHERE
	charge_amt < 300
;

    




-- 2. Return count of members who made a category 3 charge in September --
SELECT
	COUNT(DISTINCT member_no)
FROM
	charge
WHERE
	MONTH(charge_dt) = 9
	AND category_no = 3;
  
-- 2154 --
  
  
  
  
  
 -- 3. Among charges from categories 6, 7, 8, and 9 return the average and total charge amounts from the charge table, give the columns aliases --   
SELECT
	AVG(charge_amt) as "Average Charge"
    , SUM(charge_amt) as "Total Charge"
FROM
	charge
WHERE
	category_no in (6, 7, 8, 9);
  
  
  
  
    
 -- 4. Return count of all members whose first name ends with 'EY' --   
SELECT
	COUNT(*)
FROM
	member
WHERE
	firstname LIKE '%EY';
    
-- 385 --
    




-- 5. Return average charge amount by month from the charge table --
SELECT 
	month(charge_dt)
    , AVG(charge_amt)
FROM
	charge
GROUP BY
	1;





-- 6. Return average charge amount by month from the charge table among charges with category 3, 4, and 6 --
SELECT 
	month(charge_dt)
    , AVG(charge_amt)
FROM
	charge
WHERE
	category_no in (3, 4, 6)
GROUP BY
	1;





-- 7. Return average charge amount by month from the charge table among charges with category 3, 4 and 6. --
-- Include only months that have an average charge amount higher than the entire table's average charge amount --
SELECT 
	month(charge_dt)
    , AVG(charge_amt)
FROM
	charge
WHERE
	category_no in (3, 4, 6)
GROUP BY
	1
HAVING 
	AVG(charge_amt) > 
		(
        SELECT
			AVG(charge_amt)
		FROM
			charge
		)
;





-- 8. Return all columns for charges in September.  Comment how many charges are included in result set --
SELECT
	*
FROM
	charge
WHERE
	MONTH(charge_dt) = 9;
    
-- 402512 --





-- 9. Update your question #8 query to include a left join with the statement table --
-- Comment how many rows are included in your result set --
SELECT
	*
FROM
	charge
    LEFT JOIN statement
		ON charge.statement_no = statement.statement_no
WHERE
	MONTH(charge_dt) = 9;
  
-- 402512 --  
-- 163440.  This number represents the number of september charges that have an associated statement in the statement table --





-- 10. Update your question #8 query to include an inner join with the statement table --
-- Comment how many rows are included in your result set and why it differs from your row count in question 9 --
SELECT
	*
FROM
	charge
    INNER JOIN statement
		ON charge.statement_no = statement.statement_no
WHERE
	MONTH(charge_dt) = 9;

-- 163440.  This number represents the number of september charges that have an associated statement in the statement table --
-- It differs from row count in question 9 because not all charges are present in the statement table --




-- 11. Return average charge amount per provider region ordered from lowest to highest average charge amount --
SELECT
	r.region_name
    , AVG(charge_amt)
FROM
	charge c
    INNER JOIN provider p
		ON c.provider_no = p.provider_no
	INNER JOIN region r
		ON p.region_no = r.region_no
GROUP BY
	1
ORDER BY
	2;





-- 12. Return total category 10 charges per member region ordered from most to least charges --
SELECT
	r.region_name
    , COUNT(*)
FROM
	charge c
    INNER JOIN member m
		ON c.member_no = m.member_no
	INNER JOIN region r
		ON m.region_no = r.region_no
WHERE
	c.category_no = 10
GROUP BY
	1
ORDER BY
	2 DESC;





-- 13. Return all payments that are larger than the largest charge in the charge table and have a payment date in October --
SELECT
	*
FROM
	payment
WHERE
	payment_amt > 
		(
		SELECT
			MAX(charge_amt)
		FROM
			charge
		)
	AND MONTH(payment_dt) = 10
;





-- 14. Return all provider names who have total charge amounts lower than providers 'Prov. Boston Ma' and 'Prov. Apex Petr' --
SELECT
	p.provider_name
    , SUM(c.charge_amt)
FROM
	charge c
    INNER JOIN provider p
		ON c.provider_no = p.provider_no
GROUP BY
	1
HAVING
	SUM(c.charge_amt) < ALL
		(
		SELECT
			SUM(charge_amt)
		FROM
			charge c
			INNER JOIN provider p
				ON c.provider_no = p.provider_no
		WHERE
			p.provider_name IN ('Prov. Boston Ma', 'Prov. Apex Petr')
		GROUP BY
			p.provider_name
            );





-- 15. Using an inner join and a sub query filter the charge table to only charges linked with providers with 'Famous' in their name --
SELECT
	*
FROM
	charge c
    INNER JOIN 
		(
        SELECT 
			provider_no 
		FROM
			provider
		WHERE
			provider_name LIKE '%Famous%'
		) famous_prov
        ON c.provider_no = famous_prov.provider_no
;





-- 16. Return total charge amount per month, please have results in one row --
SELECT
	SUM(CASE WHEN MONTH(charge_dt) = 6 THEN charge_amt
		ELSE 0 END) AS JUNE_CHARGES,
	SUM(CASE WHEN MONTH(charge_dt) = 7 THEN charge_amt
		ELSE 0 END) AS JULY_CHARGES,
	SUM(CASE WHEN MONTH(charge_dt) = 8 THEN charge_amt
		ELSE 0 END) AS AUGUST_CHARGES,
	SUM(CASE WHEN MONTH(charge_dt) = 9 THEN charge_amt
		ELSE 0 END) AS SEPTEMBER_CHARGES,
	SUM(CASE WHEN MONTH(charge_dt) = 10 THEN charge_amt
		ELSE 0 END) AS OCTOBER_CHARGES
FROM
	charge;
	




-- 17. Convert your results to show percentage of total charges for each month.  Round results to 1 decimal place --
SELECT
	ROUND(SUM(CASE WHEN MONTH(charge_dt) = 6 THEN charge_amt
		ELSE 0 END)/SUM(charge_amt)*100, 1) AS JUNE_CHARGES_PCT,
	ROUND(SUM(CASE WHEN MONTH(charge_dt) = 7 THEN charge_amt
		ELSE 0 END)/SUM(charge_amt)*100, 1) AS JULY_CHARGES_PCT,
	ROUND(SUM(CASE WHEN MONTH(charge_dt) = 8 THEN charge_amt
		ELSE 0 END)/SUM(charge_amt)*100, 1) AS AUGUST_CHARGES_PCT,
	ROUND(SUM(CASE WHEN MONTH(charge_dt) = 9 THEN charge_amt
		ELSE 0 END)/SUM(charge_amt)*100, 1) AS SEPTEMBER_CHARGES_PCT,
	ROUND(SUM(CASE WHEN MONTH(charge_dt) = 10 THEN charge_amt
		ELSE 0 END)/SUM(charge_amt)*100, 1) AS OCTOBER_CHARGES_PCT
FROM
	charge;





-- 18. Convert results to show the same information but at the provider_no level and join your results to the provider table using a sub query --
SELECT
	m.*
    , sb_qry.*
FROM
	member m
    LEFT JOIN
		(
        SELECT
			member_no,
			ROUND(SUM(CASE WHEN MONTH(charge_dt) = 6 THEN charge_amt
				ELSE 0 END)/SUM(charge_amt)*100, 1) AS JUNE_CHARGES_PCT,
			ROUND(SUM(CASE WHEN MONTH(charge_dt) = 7 THEN charge_amt
				ELSE 0 END)/SUM(charge_amt)*100, 1) AS JULY_CHARGES_PCT,
			ROUND(SUM(CASE WHEN MONTH(charge_dt) = 8 THEN charge_amt
				ELSE 0 END)/SUM(charge_amt)*100, 1) AS AUGUST_CHARGES_PCT,
			ROUND(SUM(CASE WHEN MONTH(charge_dt) = 9 THEN charge_amt
				ELSE 0 END)/SUM(charge_amt)*100, 1) AS SEPTEMBER_CHARGES_PCT,
			ROUND(SUM(CASE WHEN MONTH(charge_dt) = 10 THEN charge_amt
				ELSE 0 END)/SUM(charge_amt)*100, 1) AS OCTOBER_CHARGES_PCT
		FROM
			charge
		GROUP BY
			1
        ) sb_qry
        ON m.member_no = sb_qry.member_no;





-- 19. Rewrite the same query from problem 18 but leverage common table expressions --
WITH sb_qry AS
	(
    SELECT
			member_no,
			ROUND(SUM(CASE WHEN MONTH(charge_dt) = 6 THEN charge_amt
				ELSE 0 END)/SUM(charge_amt)*100, 1) AS JUNE_CHARGES_PCT,
			ROUND(SUM(CASE WHEN MONTH(charge_dt) = 7 THEN charge_amt
				ELSE 0 END)/SUM(charge_amt)*100, 1) AS JULY_CHARGES_PCT,
			ROUND(SUM(CASE WHEN MONTH(charge_dt) = 8 THEN charge_amt
				ELSE 0 END)/SUM(charge_amt)*100, 1) AS AUGUST_CHARGES_PCT,
			ROUND(SUM(CASE WHEN MONTH(charge_dt) = 9 THEN charge_amt
				ELSE 0 END)/SUM(charge_amt)*100, 1) AS SEPTEMBER_CHARGES_PCT,
			ROUND(SUM(CASE WHEN MONTH(charge_dt) = 10 THEN charge_amt
				ELSE 0 END)/SUM(charge_amt)*100, 1) AS OCTOBER_CHARGES_PCT
		FROM
			charge
		GROUP BY
			1
    )
SELECT
	m.*
    , sb_qry.*
FROM
	member m
    LEFT JOIN
		sb_qry
        ON m.member_no = sb_qry.member_no;





