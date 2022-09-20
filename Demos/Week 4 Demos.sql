-- ------------------------------------------------------------------------------------------- --
-- --------------------------------------- Week 4 Demos -------------------------------------- --
-- ------------------------------------------------------------------------------------------- --

-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 4.1  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 1. Among charges larger than $3000 in June create 4 ranking variables based on charge amount using row_number, rank, dense_rank and percent_rank --
SELECT
	charge_no
    , charge_dt
    , charge_amt
	, ROW_NUMBER() OVER (ORDER BY charge_amt DESC) AS ROW_NUM_RANK
    , RANK() OVER (ORDER BY charge_amt DESC) AS RANK_RANK
    , DENSE_RANK() OVER (ORDER BY charge_amt DESC) DENSE_RANK_RANK
	, PERCENT_RANK() OVER (ORDER BY charge_amt DESC) PCT_RANK_RANK
FROM
	charge
WHERE
 	charge_amt > 3000
    AND MONTH(charge_dt) = 6
GROUP BY
	1, 2, 3
ORDER BY
	charge_amt desc;
    
    

-- 2. Using the same four ranking functions, rank members by how many total charges they have made --
SELECT
	member_no
    , COUNT(*)
	, ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS ROW_NUM_RANK
    , RANK() OVER (ORDER BY COUNT(*) DESC) AS RANK_RANK
    , DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) DENSE_RANK_RANK
	, PERCENT_RANK() OVER (ORDER BY COUNT(*) DESC) PCT_RANK_RANK
FROM
	charge
GROUP BY
	1
ORDER BY
	COUNT(*) DESC;



    
   
   


-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 4.2  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --    
    
-- 1. Repeat 4.1.1 but have ranking reset each new day --
 SELECT
	charge_no
    , DATE(charge_dt)
    , charge_amt
	, ROW_NUMBER() OVER (PARTITION BY DATE(charge_dt) ORDER BY charge_amt DESC) AS ROW_NUM_RANK
    , RANK() OVER (PARTITION BY DATE(charge_dt) ORDER BY charge_amt DESC) AS RANK_RANK
    , DENSE_RANK() OVER (PARTITION BY DATE(charge_dt) ORDER BY charge_amt DESC) DENSE_RANK_RANK
	, PERCENT_RANK() OVER (PARTITION BY DATE(charge_dt) ORDER BY charge_amt DESC) PCT_RANK_RANK
FROM
	charge
WHERE
 	charge_amt > 3000
    AND MONTH(charge_dt) = 6
GROUP BY
	1, 2, 3
ORDER BY
	2, 3 desc;  
 
 
-- 2. Using the same four ranking functions rank members by total charges made within each month --
SELECT
	MONTH(charge_dt)
    , member_no
    , COUNT(*)
	, ROW_NUMBER() OVER (PARTITION BY MONTH(charge_dt) ORDER BY COUNT(*) DESC) AS ROW_NUM_RANK
    , RANK() OVER (PARTITION BY MONTH(charge_dt) ORDER BY COUNT(*) DESC) AS RANK_RANK
    , DENSE_RANK() OVER (PARTITION BY MONTH(charge_dt) ORDER BY COUNT(*) DESC) DENSE_RANK_RANK
	, PERCENT_RANK() OVER (PARTITION BY MONTH(charge_dt) ORDER BY COUNT(*) DESC) PCT_RANK_RANK
FROM
	charge
GROUP BY
	1, 2
ORDER BY
	1, 3 DESC; 
    
    
    
    
-- 3. Return the month and member number of the member that had the most charges in that month.  If there was a tie return both members return both --
WITH T1 AS
	(
	SELECT
		MONTH(charge_dt) AS CHARGE_MONTH
		, member_no
		, COUNT(*) AS TOTAL_CHARGES
        , RANK() OVER (PARTITION BY MONTH(charge_dt) ORDER BY COUNT(*) DESC) AS TOTAL_CHARGES_RANK
	FROM
		charge
	GROUP BY
		1, 2
	ORDER BY
		1, 3 DESC
	)
SELECT
	CHARGE_MONTH
    , member_no
    , TOTAL_CHARGES
FROM
	T1
WHERE 
	TOTAL_CHARGES_RANK = 1;
	

		


	
    
    
    

-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 4.3  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 1. Return total charge amount per day for all days in June and July --
SELECT
	MONTH(charge_dt) AS CHARGE_MONTH
    , DATE(charge_dt) AS CHARGE_DATE
    , SUM(charge_amt) AS DAILY_CHARGES
FROM
	charge
WHERE
	MONTH(charge_dt) IN (6, 7)
GROUP BY
	1, 2;
    
        
-- 2. Add a column that gives the running total of daily charge amount --
SELECT
	MONTH(charge_dt) AS CHARGE_MONTH
    , DATE(charge_dt) AS CHARGE_DATE
    , SUM(charge_amt) AS DAILY_CHARGES
    , SUM(SUM(charge_amt)) OVER (ORDER BY DATE(CHARGE_DT)) AS ROLLING_SUM
FROM
	charge
WHERE
	MONTH(charge_dt) IN (6, 7)
GROUP BY
	1, 2;
    
    
-- 3. Add a column that gives the running total of daily charge amount but resets at the beginning of the new month --
SELECT
	MONTH(charge_dt) AS CHARGE_MONTH
    , DATE(charge_dt) AS CHARGE_DATE
    , SUM(charge_amt) AS DAILY_CHARGES
    , SUM(SUM(charge_amt)) OVER (PARTITION BY MONTH(charge_dt) ORDER BY DATE(CHARGE_DT)) AS ROLLING_SUM
FROM
	charge
WHERE
	MONTH(charge_dt) IN (6, 7)
GROUP BY
	1, 2;




-- 4. Return the charge number, date, month and amount of all of member 9766's charges --
SELECT
	charge_no
    , DATE(charge_dt) AS CHARGE_DATE 
    , MONTH(charge_dt) AS CHARGE_MONTH
    , charge_amt
FROM
	charge
WHERE
	member_no = 9766
ORDER BY 
	2;



-- 5. Add a column to the query that gives the grand total of all of member 9766's charges --
SELECT
	charge_no
    , DATE(charge_dt) AS CHARGE_DATE 
    , MONTH(charge_dt) AS CHARGE_MONTH
    , charge_amt
    , SUM(charge_amt) OVER () AS GRAND_TOTAL
FROM
	charge
WHERE
	member_no = 9766
ORDER BY 
	2;


    
        
-- 6. Add a column to the query that gives the grand total of all of member 9766's charges for the given month --
SELECT
	charge_no
    , DATE(charge_dt) AS CHARGE_DATE 
    , MONTH(charge_dt) AS CHARGE_MONTH
    , charge_amt
	, SUM(charge_amt) OVER (PARTITION BY MONTH(charge_dt)) AS MONTHLY_TOTAL
    , SUM(charge_amt) OVER () AS GRAND_TOTAL
FROM
	charge
WHERE
	member_no = 9766
ORDER BY 
	2;


    
    
-- 7. Add a column to the query that gives the grand total of all of member 9766's charges for the given day --
SELECT
	charge_no
    , DATE(charge_dt) AS CHARGE_DATE 
    , MONTH(charge_dt) AS CHARGE_MONTH
    , charge_amt
    , SUM(charge_amt) OVER (PARTITION BY DATE(charge_dt)) AS DAILY_TOTAL
	, SUM(charge_amt) OVER (PARTITION BY MONTH(charge_dt)) AS MONTHLY_TOTAL
    , SUM(charge_amt) OVER () AS GRAND_TOTAL
FROM
	charge
WHERE
	member_no = 9766
ORDER BY 
	2;



-- 8. For each of member 9766's charges return the charge amount along with what percentage of their monthly and grand total the charge accounted for --
WITH T1 AS
	(
    SELECT
	charge_no
    , DATE(charge_dt) AS CHARGE_DATE 
    , MONTH(charge_dt) AS CHARGE_MONTH
    , charge_amt
    , SUM(charge_amt) OVER (PARTITION BY DATE(charge_dt)) AS DAILY_TOTAL
	, SUM(charge_amt) OVER (PARTITION BY MONTH(charge_dt)) AS MONTHLY_TOTAL
    , SUM(charge_amt) OVER () AS GRAND_TOTAL
FROM
	charge
WHERE
	member_no = 9766
ORDER BY 
	2
    )
SELECT
	charge_amt
    , (charge_amt / MONTHLY_TOTAL)*100 AS PCT_MONTH
    , (charge_amt / GRAND_TOTAL)*100 AS PCT_TOTAL
FROM
	T1;
    
    


    
    
    
    
    
    
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 4.4  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    
 
 -- 1. Return total charge amount per day for all days in June and July --
SELECT
	MONTH(charge_dt) AS CHARGE_MONTH
    , DATE(charge_dt) AS CHARGE_DATE
    , SUM(charge_amt) AS DAILY_CHARGES
FROM
	charge
WHERE
	MONTH(charge_dt) IN (6, 7)
GROUP BY
	1, 2;
    
    
    
    
-- 2. Add a column that gives the running 3 day average daily charge amount  --
SELECT
	MONTH(charge_dt) AS CHARGE_MONTH
    , DATE(charge_dt) AS CHARGE_DATE
    , SUM(charge_amt) AS DAILY_CHARGES
    , AVG(SUM(charge_amt)) OVER (ORDER BY DATE(charge_dt) ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS ROLLING_3DAY_AVG
FROM
	charge
WHERE
	MONTH(charge_dt) IN (6, 7)
GROUP BY
	1, 2;
    


    
    
    
    
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 4.5  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
 
-- 1. Return charge number, date, and amount for all of member 9766's September charges --     
SELECT
	charge_no
    , charge_dt
    , charge_amt
FROM
	charge
WHERE
	member_no = 9766
    AND category_no = 9
ORDER BY
	2;
	
            
-- 2. Add columns that give member 9766's previous and following charges relative to current charge --    
SELECT
	charge_no
    , charge_dt
    , charge_amt
    , LAG(charge_amt, 1) OVER (ORDER BY charge_dt) PREV_CHARGE
    , LEAD(charge_amt, 1) OVER (ORDER BY charge_dt) NEXT_CHARGE
FROM
	charge
WHERE
	member_no = 9766
    AND category_no = 9
GROUP BY
	1, 2, 3
ORDER BY
	2;
    
    
    
-- 3. Return total charge amount per day for all days in June and July --
SELECT
	MONTH(charge_dt) AS CHARGE_MONTH
    , DATE(charge_dt) AS CHARGE_DATE
    , SUM(charge_amt) AS DAILY_CHARGES
FROM
	charge
WHERE
	MONTH(charge_dt) IN (6, 7)
GROUP BY
	1, 2;
    
  
  
  
-- 4. Add columns that show the preceding and following total daily charges for each day --
WITH table1 AS 
	(
    SELECT
		MONTH(charge_dt) AS CHARGE_MONTH
		, DATE(charge_dt) AS CHARGE_DATE
		, SUM(charge_amt) AS DAILY_CHARGES
	FROM
		charge
	WHERE
		MONTH(charge_dt) IN (6, 7)
	GROUP BY
		1, 2
	)
SELECT
	 CHARGE_MONTH
    , CHARGE_DATE
    , DAILY_CHARGES
    , LAG(DAILY_CHARGES, 1) OVER (ORDER BY CHARGE_DATE) AS PREV_DAY_TOTAL
    , LEAD(DAILY_CHARGES, 1) OVER (ORDER BY CHARGE_DATE) AS NEXT_DAY_TOTAL
FROM
	table1
GROUP BY
	1, 2, 3;
    



-- 5. Return charge date, total charge amount and the percentage increase or decrease in total charge amount for the day from the previous day --
WITH table1 AS 
	(
    SELECT
		DATE(charge_dt) AS CHARGE_DATE
		, SUM(charge_amt) AS DAILY_CHARGES
	FROM
		charge
	GROUP BY
		1
	)
SELECT
	CHARGE_DATE
	, DAILY_CHARGES
	,  ROUND(   
			(DAILY_CHARGES -  (LAG(DAILY_CHARGES, 1) OVER (ORDER BY CHARGE_DATE)) )  / DAILY_CHARGES *100
						, 2) AS PCT_CHANGE
FROM
	table1
GROUP BY
	1, 2;
   
    
    
     





    
        
