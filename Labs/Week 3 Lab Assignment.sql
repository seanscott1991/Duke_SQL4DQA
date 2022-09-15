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







-- 1. Return all of the newest orders in the orders table --






-- 2. Return all parts who cost more than the smallest order in the data base --






-- 3. Return all columns from the orders table as well as a column that categorizes orders into large, medium and small orders --
-- large orders are considered to have total price over $300,000, medium orders are considered to greater than $100,000 and --
-- less than or equal to $300,000 and small orders are considered to be $100,000 or less
 





-- 4. Using a sub query return a list of all part names who were shipped by truck and had a comment that mentioned 'package'  --

			
		



-- 5. Which part manufacturers have a lower average retail price than manufacturers 1 and 2? --






-- 6. Write a query that show percent of total orders for each order status (results should be on one row) --






-- 7. Write a query that show percent of total order value for each order status (results should be on one row) --






-- 8. Rewrite your query from #6 so that the data is now at the customer number level  --






-- 9. Join your results from #8 to the customer table (all customers should be in result set) --






-- 10. Rewrite the query from the previous problem but this time use a common table expression --







	
	





