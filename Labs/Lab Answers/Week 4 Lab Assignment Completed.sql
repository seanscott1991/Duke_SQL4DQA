-- ------------------------------------------------------------------------------------------- --
-- ---------------------------------------  Week 4 Lab  -------------------------------------- --
-- ------------------------------------------------------------------------------------------- --

-- Instructions --

-- Write your code in this file after each corresponding question and include a comment with the answer 
-- to the question if applicable.  Code should use syntax best practices.  Submit code at end of lab session.






-- 1. In the Basektball_women database, select Player first name, last name, height and position.  Rank all players by height, ties should  --
-- have the same rank with a gap after the tie.  Reset the rankings for each position.  We are only interested in players with assigned positions --
SELECT
	firstName
    , lastName
    , height
    , pos
    , RANK() OVER (PARTITION BY pos ORDER BY height DESC) AS height_rank
FROM
	players
WHERE
	pos IS NOT NULL
GROUP BY
	1, 2, 3, 4
ORDER BY
	4, 3 DESC;





-- 2. Return total University of Tennessee players drafted per year for drafts 1997 through 2007 --
SELECT
	draftYear
    , COUNT(*) AS VOLS_DRAFTED
FROM
	draft
WHERE
	draftFrom = 'University of Tennessee'
    AND draftYear BETWEEN 1997 and 2007
GROUP BY
	1
ORDER BY
	1;





-- 3. Using the previous query create a column that gives the running total of University of Tennessee Players drafted --
SELECT
	draftYear
    , COUNT(*) AS VOLS_DRAFTED
    , SUM(COUNT(*)) OVER (ORDER BY draftYear) AS RUNNING_TOTAL
FROM
	draft
WHERE
	draftFrom = 'University of Tennessee'
    AND draftYear BETWEEN 1997 and 2007
GROUP BY
	1
ORDER BY
	1;
 





-- 4. Add a column to the previous query that gives a running average of University of Tennessee players drafted each season --
SELECT
	draftYear
    , COUNT(*) AS VOLS_DRAFTED
    , SUM(COUNT(*)) OVER (ORDER BY draftYear) AS RUNNING_TOTAL
    , AVG(COUNT(*)) OVER (ORDER BY draftYear) AS RUNNING_AVG
FROM
	draft
WHERE
	draftFrom = 'University of Tennessee'
    AND draftYear BETWEEN 1997 and 2007
GROUP BY
	1
ORDER BY
	1;
			
		



-- 5. Add a column to the previous query that gives a 3 year average of University of Tennessee players drafted each season --
SELECT
	draftYear
    , COUNT(*) AS VOLS_DRAFTED
    , SUM(COUNT(*)) OVER (ORDER BY draftYear) AS RUNNING_TOTAL
    , AVG(COUNT(*)) OVER (ORDER BY draftYear) AS RUNNING_AVG
    , AVG(COUNT(*)) OVER (ORDER BY draftYear ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS THREE_YR_AVG
FROM
	draft
WHERE
	draftFrom = 'University of Tennessee'
    AND draftYear BETWEEN 1997 and 2007
GROUP BY
	1
ORDER BY
	1;





-- 6. Add a column to the previous query that shows the difference in University of Tennessee players drafted in a given year from the previous year (will need to use sub query or CTE)  --
WITH T1 AS
	(
    SELECT
		draftYear
		, COUNT(*) AS VOLS_DRAFTED
		, SUM(COUNT(*)) OVER (ORDER BY draftYear) AS RUNNING_TOTAL
		, AVG(COUNT(*)) OVER (ORDER BY draftYear) AS RUNNING_AVG
		, AVG(COUNT(*)) OVER (ORDER BY draftYear ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS THREE_YR_AVG
	FROM
		draft
	WHERE
		draftFrom = 'University of Tennessee'
		AND draftYear BETWEEN 1997 and 2007
	GROUP BY
		1
	ORDER BY
		1
        )
SELECT
	*
    , VOLS_DRAFTED - (LAG(VOLS_DRAFTED, 1) OVER (ORDER BY draftYear)) AS YR_OVER_YR_DIFF
FROM
	T1
GROUP BY
	1;