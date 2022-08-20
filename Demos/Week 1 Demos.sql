-- ------------------------------------------------------------------------------------------- --
-- --------------------------------------- Week 1 Demos -------------------------------------- --
-- ------------------------------------------------------------------------------------------- --

-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 1.1  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 1. Return columns charge_dt and charge_amt from the charge table --
SELECT
	charge_dt, charge_amt
FROM
	charge;
    

-- 2. Return all columns from the charge table --
SELECT
	*
FROM
	charge;
    
    
 -- 3. Return count of rows from the charge table --   
SELECT
	count(*)
FROM
	charge;
    
    
 -- 4. Return the column charge_dt with the alias 'Charge Date' from the charge table --   
SELECT
	charge_dt as 'Charge Date'
FROM
	charge;
    

-- 5. Return all distinct values of the category_no column from the charge table --
SELECT DISTINCT
	category_no
FROM
	charge;
    
   
   


-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 1.2  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --    
    
-- 1. Return columns charge_dt and charge_amt from the charge table --
SELECT
	charge_dt, charge_amt
FROM
	charge;    
 
 
-- 2. Using a sub query return all unique values of category_no in the charge table for charges that were greater than 5000 --
SELECT DISTINCT
	category_no
FROM
	(
    SELECT
		*
	FROM
		charge
	WHERE 
		charge_amt > 5000
	) table1;
		
    
-- 3. Using an inner join return charge_dt and charge_amt from the charge table as well as the category_desc from the category table --
SELECT
	charge.charge_dt, charge.charge_amt, category.category_desc
FROM
	charge
    inner join category
		on charge.category_no = category.category_no;
	
    
    
    

-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 1.3  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 1. Return charge_amt, charge_dt and category_no from the charge table where category_no equals 4 --
SELECT
	charge_amt, charge_dt, category_no
FROM
	charge
WHERE
	category_no = 4;
    
        
-- 2. Return charge_amt, charge_dt and category_no from the charge table where category_no does not equal 4 --
SELECT
	charge_amt, charge_dt, category_no
FROM
	charge
WHERE
	category_no <> 4;
    
    
-- 3. Return count of rows in the charge table where charge_amt is greater than 5000 --
SELECT
	count(*)
FROM
	charge
WHERE
	charge_amt > 5000;
    
    
-- 4. Return count of rows in the charge table where charge_amt is between 4000 and 5000 (inclusive) --
SELECT
	count(*)
FROM
	charge
WHERE
	charge_amt BETWEEN 4000 AND 5000;
    
    
-- 5. Return charge_amt, charge_dt and category_no from the charge table where category_no equals 1, 4 or 9 --
SELECT
	charge_amt, charge_dt, category_no
FROM
	charge
WHERE
	category_no IN (1,4,9);
    
    
-- 6. Return charge_amt, charge_dt and category_no from the charge table where category_no does not equal 1, 4 or 9 --
SELECT
	charge_amt, charge_dt, category_no
FROM
	charge
WHERE
	category_no NOT IN (1,4,9);
    

-- 7. Return all columns from the member table where lastname begins with 'S' --    
SELECT
	*
FROM
	member
WHERE
	lastname LIKE 'S%';
    
    
-- 8. Return all columns from the member table where lastname ends with 'SON' --    
SELECT
	*
FROM
	member
WHERE
	lastname LIKE '%SON';
    
    
-- 9. Return all columns from the member table where lastname does not end with 'SON' --    
SELECT
	*
FROM
	member
WHERE
	lastname NOT LIKE '%SON';
    
    
-- 10. Return all columns from the corporation table where corp_name includes 'Transit' --
SELECT
	*
FROM
	corporation
WHERE
	corp_name LIKE '%Transit%';
    
    
-- 11. Return all rows from the corporation table where corp_name does not include 'Transit' -- 
SELECT
	*
FROM
	corporation
WHERE
	corp_name NOT LIKE '%Transit%';
    
    
-- 12.  Return all rows from the member table where lastname is 4 letters and the second letter is 'a' --
SELECT
	*
FROM
	member
WHERE
	lastname LIKE '_a__';
    
    
    
    
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 1.4  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 1. Return the category_no column from the charge table --
SELECT 
	category_no
FROM
	charge;
    
    
-- 2. Return all distinct values of category_no in the charge table --
SELECT 
	category_no
FROM
	charge
GROUP BY
	category_no;
    
    
-- 3. Return the frequency of each category_no in the charge table --
SELECT 
	category_no, count(*)
FROM
	charge
GROUP BY
	category_no;
    
    
-- 4. Return the frequency and average charge_amt for each category_no in the charge table --
SELECT 
	category_no, count(*), avg(charge_amt)
FROM
	charge
GROUP BY
	category_no;
    
    
-- 5. Return the average charge_amt from the charge table --
SELECT
	avg(charge_amt)
FROM
	charge;  
  
  
-- 6. Return the frequency of each category_no within each month from the charge table --
SELECT 
	month(charge_dt), category_no, count(*)
FROM
	charge
GROUP BY
	1, 2;
    
    
    
    
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 1.5  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
 
 -- 1. Return the frequency of each month in the charge table --
SELECT 
	month(charge_dt), count(*)
FROM
	charge
GROUP BY
	month(charge_dt);
 
 
-- 2. Return the frequency of each month in the charge table where category_no equals 1 or 3 --
SELECT 
	month(charge_dt), count(*)
FROM
	charge
WHERE
	category_no in (1, 3)
GROUP BY
	month(charge_dt);
    
    
-- 3. Return the frequency of each month that had at least 40000 charges of category_no 1 or 3 in the charge table --
SELECT 
	month(charge_dt), count(*)
FROM
	charge
WHERE
	category_no in (1, 3)
GROUP BY
	month(charge_dt)
HAVING
	count(*) >= 40000;




-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 1.6  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 1. Return the frequency of each category_no within each month from the charge table --
SELECT 
	month(charge_dt), category_no, count(*)
FROM
	charge
GROUP BY
	1, 2;
    
    
-- 2. Return the frequency of each category_no within each month from the charge table, results sorted by month --
SELECT 
	month(charge_dt), category_no, count(*)
FROM
	charge
GROUP BY
	1, 2
ORDER BY
	month(charge_dt);
    
    
-- 3. Return the frequency of each category_no within each month from the charge table, results sorted by month and then by frequency descending  --
SELECT 
	month(charge_dt), category_no, count(*)
FROM
	charge
GROUP BY
	1, 2
ORDER BY
	1 ASC , 3 DESC;