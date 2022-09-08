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







-- 1. Write a query that returns all columns and all rows from the lineitem table along with the part type and part name columns --






-- 2. Write a query that returns all columns and all rows from the lineitem table along with --
-- the order priority (name this column "Priority") and the supplier address (name this column "Address") --







-- 3.  Write a query that returns all rows from the lineitem table that had shipmode of RAIL and include the shipping priority column --
--     from the orders table and the name column from the customer table in the result --






-- 4. Write a query that returns a customers name and their most recent order date (every customer in the database should be included) --






-- 5. Write a query that returns count of "URGENT" orders per delivery nation for orders in 1995.  Order results by total orders descending--






-- 6. Using set logic return all rows in the line item table where ship mode is truck and line status is F --






-- 7. Using set logic return names of all customers who did not place an order in 1997 --






-- 8. Using the part supplier table and supplier table, what is the average account balance among suppliers who supply part 'black lemon dim steel yellow' --






-- 9. Write a query that returns a list of nations that product "hot spring dodger dim light" was mailed to(shipping mode) --

		




-- 10. Write a query that returns a list of nations that product "hot spring dodger dim light" was flown from --

	
	



-- 11. Write a query that returns a list of nations that product "hot spring dodger dim light" was either mailed to or flown from --





