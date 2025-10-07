-- ------------------------------------------------------------------------------------------- --
-- --------------------------------------- Week 2 Demos -------------------------------------- --
-- ------------------------------------------------------------------------------------------- --

-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 2.1  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 1. Select all columns in the charge table --
SELECT
	*
FROM
	charge;
    

-- 2. Select all columns in the category table --
SELECT
	*
FROM
	category;
    
    
 -- 3. Select the charge date and category number columns in charge table and join in the category description column from the category table --   
SELECT
	charge.charge_dt
    , charge.category_no
    , category.category_desc
FROM
	charge
    INNER JOIN category
		ON charge.category_no = category.category_no;
        

-- 4. Select all columns in the provider table --
SELECT
	*
FROM
	provider;
	
    
 -- 5. Select all columns in charge table and join in the provider name column from the provider table --   
SELECT
	charge.*
    , provider.provider_name
FROM
	charge
    INNER JOIN provider
		ON charge.provider_no = provider.provider_no;
    


    
   
   


-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 2.2  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --    
    
-- 1. Select all columns in the statement table --
SELECT
	*
FROM
	statement;   
    

-- 2. Select all columns in the charge table --
SELECT
	*
FROM
	charge;  

 
-- 3. Select all columns in the charge table and join in the statement date column from the statement table --
SELECT
	charge.*
    , statement.statement_dt
FROM
	charge
    INNER JOIN statement
		ON charge.statement_no = statement.statement_no;
		
    
-- 4. Select all columns in the charge table and join in the statement date column from the statement table using a left join --
SELECT
	charge.*
    , statement.statement_dt
FROM
	charge
    LEFT JOIN statement
		ON charge.statement_no = statement.statement_no;
        

-- 5. Select all columns in the charge table and join in the statement date column from the statement table using a right join --
SELECT
	charge.*
    , statement.*
FROM
	statement
--  RIGHT JOIN charge
   --  INNER JOIN charge
    LEFT JOIN charge
		ON charge.statement_no = statement.statement_no;        

    

    
    
    
    

    
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 2.3  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --


-- 1. Select all columns in the charge table and join in the statement date column from the statement table using a left join --
SELECT
	charge.*
    , statement.statement_dt
FROM
	charge 
    LEFT JOIN statement 
		ON charge.statement_no = statement.statement_no;
        

-- 2. Now select all columns in the charge table and join in the statement date column from the statement table using a left join and table aliases --
SELECT
	c.*
    , s.statement_dt
FROM
	charge c
    LEFT JOIN statement s
		ON c.statement_no = s.statement_no;
    
 
    
    
    
    
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 2.4  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
 
-- 1. Select all columns in the charge table and join in the statement date column from the statement table and the provider name column from the provider table --
SELECT
	c.*
    , s.statement_dt as "Statement Date"
	, p.provider_name
FROM
	charge c
    LEFT JOIN statement s
		ON c.statement_no = s.statement_no
	INNER JOIN provider p
		ON c.provider_no = p.provider_no;
        
        
-- 2.  Select the charge number, charge date, provider name, and member first and last name for all charges--
SELECT
	c.charge_no
	, c.charge_dt
    , p.provider_name
    , m.firstname
    , m.lastname
FROM
	charge c
	INNER JOIN provider p
		ON c.provider_no = p.provider_no
	INNER JOIN member m
		ON c.member_no = m.member_no;
		





-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 2.5  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 1. Union rows in the charge table where charge category equals 2 with rows in the charge table where provider number equals 500  --
SELECT
	*
FROM
	charge
WHERE
	category_no = 2
    
UNION 

SELECT
	*
FROM
	charge
WHERE
	provider_no = 500;
    
    
-- 2. Union rows in the charge table where charge category equals 2 with rows in the charge table where provider number equals 500 (keep duplicates) --
SELECT
	*
FROM
	charge
WHERE
	category_no = 2
    
UNION ALL

SELECT
	*
FROM
	charge
WHERE
	provider_no = 500;


-- 3. Return all rows in the charge table where category number equals 2 excluding rows where provider number equals 500 --
SELECT
	*
FROM
	charge
WHERE
	category_no = 2
    
EXCEPT  

SELECT
	*
FROM
	charge
WHERE
	provider_no = 500;
    
    
-- 4. Return all rows in the charge table where category number equals 2 and where provider number equals 500 --
SELECT
	*
FROM
	charge
WHERE
	category_no = 2
    
INTERSECT  

SELECT
	*
FROM
	charge
WHERE
	provider_no = 500;
    
     