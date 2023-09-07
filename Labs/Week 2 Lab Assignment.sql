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







-- 1. Write a query that returns all columns and all rows from the lineitem table along with the part brand and part manufacturer columns --







-- 2.  Write a query that returns all rows from the lineitem table and include the shipping priority column --
--     from the orders table and the address column from the customer table in the result --
   
        
        
        
        
        
        
-- 3. Write a query that returns all columns from the lineitem table where ship mode is air along with --
-- the order priority (name this column " Order Priority") and the supplier address (name this column "Address") --







-- 4. Write a query that returns count of status "F" orders per delivery nation for orders in 1994, 1997, and 1998.  Order results by total orders descending--

    
    
    
    
    
    
-- 5. Write a query that returns a customer's name and address and the date of their first order (every customer in the database should be included) --







-- 6. Using set logic return all parts that have a size of at least 30 and are made by manufacturer 4 --

    
    
    
    
    
    
-- 7. Using the part supplier table and supplier table, what is the average account balance among suppliers who supply a part made out of brass --







-- 8. Using set logic return names and addresses of all customers who have never placed an urgent order --







-- 9. Write a query that returns a list of nations that the product "turquoise honeydew grey thistle thistle" was flown to (shipping mode) --
;
		





-- 10. Write a query that returns a list of nations that product "turquoise honeydew grey thistle thistle" was mailed from --

	
	




-- 11. Write a query that returns a list of nations that product "turquoise honeydew grey thistle thistle" was either mailed from or flown to --

