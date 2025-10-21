-- ------------------------------------------------------------------------------------------- --
-- --------------------------------------- Week 3 Demos -------------------------------------- --
-- ------------------------------------------------------------------------------------------- --

-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 3.1  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 1. Create a table called person that has the columns person_id, firstname, and age.  Person_id is the primary key  --
CREATE TABLE person_c
	(
    person_id SMALLINT(11),
    firstname VARCHAR(20),
    age INT(11),
    gender varchar(1),
    CONSTRAINT pk_person PRIMARY KEY (person_id)
    );
    
    







-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 3.2  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --    
    
-- 1. Insert rows into the person table for Bill who is 24 years old and Margory who is 31 years old.  --
INSERT INTO person
	(person_id, firstname, age)
VALUES 
	(1, 'Bill', 24),
    (2, 'Margory', 31);
  
 
 

	

		
    

-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 3.3  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 1. Let's update the data.  Turns out Bill is actually 23 and he likes to go by William --
UPDATE person
SET
	firstname = 'William',
    age = 23
WHERE
	person_id = 1;
        


    
    

    
    
    
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 3.4  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    
 
 -- 1. William and Margory aren't getting along too well so one of them has to leave the table.  Let's delete William. --
DELETE FROM person
WHERE person_id = 1;
    

    


    
    
    
    
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 3.5  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
 
-- 1. Use the DESCRIBE statement to examine the charge table in the Credit database --     
DESCRIBE charge;
	
            

    
  
  
  
    
    
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 3.6  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 1. Return a list of all tables in the Credit database (schema) --
SELECT 
	*
FROM 
	information_schema.tables
WHERE
	TABLE_SCHEMA = 'Credit';
    
    
    
    
-- 2. Return all rows and all columns from the columns view --
SELECT 
	*
FROM 
	information_schema.columns;
    
    
  
  
    
-- 3. Return all columns in the Credit database (schema) from the columns view --
SELECT 
	*
FROM 
	information_schema.columns
WHERE
	TABLE_SCHEMA = 'Credit';    
    
    
    
    
    
    
-- 4. Return a list of all tables in the Credit database (schema) that have 'member' information in them --
-- SELECT DISTINCT
-- 	TABLE_NAME
SELECT
	*
FROM
	information_schema.columns
WHERE
	TABLE_SCHEMA = 'Credit'
    AND COLUMN_NAME LIKE '%member%';
    
    

    
    






-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 3.7  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 1. Create a View that holds aggregated monthly charge amount figures at the member number level --
CREATE VIEW member_charge_amts 
AS
	SELECT
		MONTH(charge_dt) AS CHARGE_MONTH
        , member_no
        , SUM(charge_amt) AS TOTAL_CHARGES
	FROM
		charge
	GROUP BY
		1, 2;
    
    

-- 2. Pull all rows from your new view for the month of June --
SELECT
	*
FROM
	member_charge_amts
WHERE
	CHARGE_MONTH = 6;


    
    





    
   
   

  

   
    
    
     





    
        
