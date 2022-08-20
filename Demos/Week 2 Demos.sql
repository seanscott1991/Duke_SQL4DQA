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
	charge;
	
    
 -- 5. Select all columns in charge table and join in the provider name column from the provider table --   
SELECT
	charge.*
    , provider.provider_name
FROM
	charge
    INNER JOIN provider
		ON charge.provider_no = provider.provider_no;
    

-- 5.  --

    
   
   


-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 2.2  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --    
    
-- 1.  --
   
 
 
-- 2.  --

		
    
-- 3.  --

	
    
    
    

-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 2.3  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 1.  --

    
        
-- 2.  --

    
    
-- 3.  --

    
    
-- 4.  --

    
    
-- 5.  --

    
    
-- 6.  --

    

-- 7.  --    

    
    
-- 8.  --    

    
    
-- 9.  --    

    
    
    
    
    
    
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 2.4  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 1.  --

    
        
-- 2.  --

    
    
-- 3.  --

    
    
-- 4.  --

    
    
-- 5.  --

    
    
-- 6.  --

    

-- 7.  --    

    
    
-- 8.  --    

    
    
-- 9.  --   
    
    
    
    
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 2.5  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
 
-- 1.  --

    
        
-- 2.  --

    
    
-- 3.  --

    
    
-- 4.  --

    
    
-- 5.  --

    
    
-- 6.  --

    

-- 7.  --    

    
    
-- 8.  --    

    
    
-- 9.  --   




-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Demo Set 2.6  -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 1.  --

    
        
-- 2.  --

    
    
-- 3.  --

    
    
-- 4.  --

    
    
-- 5.  --

    
    
-- 6.  --

    

-- 7.  --    

    
    
-- 8.  --    

    
    
-- 9.  --   