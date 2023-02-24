-- Assumptions
-- Based on research completed prior to launching App Trader as a company, you can assume the following:

-- a. App Trader will purchase apps for 10,000 times the price of the app. For apps that are priced from free up to $1.00, the purchase price is $10,000.

-- For example, an app that costs $2.00 will be purchased for $20,000.

-- The cost of an app is not affected by how many app stores it is on. A $1.00 app on the Apple app store will cost the same as a $1.00 app on both stores.

-- If an app is on both stores, it's purchase price will be calculated based off of the highest app price between the two stores.

-- b. Apps earn $5000 per month, per app store it is on, from in-app advertising and in-app purchases, regardless of the price of the app.

-- An app that costs $200,000 will make the same per month as an app that costs $1.00.

-- An app that is on both app stores will make $10,000 per month.

-- c. App Trader will spend an average of $1000 per month to market an app regardless of the price of the app. If App Trader owns rights to the app in both stores, it can market the app for both stores for a single cost of $1000 per month.

-- An app that costs $200,000 and an app that costs $1.00 will both cost $1000 a month for marketing, regardless of the number of stores it is in.
-- d. For every half point that an app gains in rating, its projected lifespan increases by one year. In other words, an app with a rating of 0 can be expected to be in use for 1 year, an app with a rating of 1.0 can be expected to last 3 years, and an app with a rating of 4.0 can be expected to last 9 years.

-- App store ratings should be calculated by taking the average of the scores from both app stores and rounding to the nearest 0.5.
-- e. App Trader would prefer to work with apps that are available in both the App Store and the Play Store since they can market both for the same $1000 per month.

-- 3. Deliverables
-- a. Develop some general recommendations as to the price range, genre, content rating, or anything else for apps that the company should target.

-- b. Develop a Top 10 List of the apps that App Trader should buy.


SELECT DISTINCT(primary_genre)
FROM app_store_apps

SELECT DISTINCT(genres)
FROM play_store_apps

--Apple has 23 distinct genres

--Android has 119.  A lot of these are combinations joined by a ;  Maybe we remove these and only use the first entry per genre?
--Maybe if we only compare genres that are listed in both tables? One potential issue is Apple groups ALL games into 1 category.  Do I need to go through and reclassify every single Android genre category?
/*"Auto & Vehicles"  ??????
"Sports" - match
"Entertainment"- match
"Simulation;Education"- education
"Events" ?????
"Medical"- match
"Art & Design;Action & Adventure" ??????
"Simulation;Action & Adventure"- games
"Communication;Creativity" ????
"Casual;Brain Games" - games
"Parenting" ???????
"Entertainment;Brain Games" games
"Trivia;Education" - education
"House & Home" ??????
"Educational;Education" match
"Board;Brain Games" games
"Libraries & Demo" ??????
"Puzzle;Education" games
"Lifestyle;Education" education
"Casual;Education" education
"Finance" match
"Entertainment;Action & Adventure" ?????
"Puzzle;Brain Games" games
"Adventure" games
"Video Players & Editors;Music & Video" photo & video 
"Strategy" games
"Travel & Local;Action & Adventure" ????
"Adventure;Education" ?????
"Arcade;Action & Adventure" games
"Strategy;Education"
"Weather" match
"Books & Reference;Education" ????
"Travel & Local" ?????
"Education;Pretend Play" ????
"Casual;Creativity" games
"Casual;Pretend Play" games
"Racing" games
"Board;Pretend Play" games
"Lifestyle" match
"Simulation;Pretend Play" games
"Word" games
"Entertainment;Education" ???
"Action;Action & Adventure" games
"Casual;Music & Video" ???
"Music & Audio;Music & Video" ???
"Strategy;Action & Adventure" games
"Card;Action & Adventure" games
"Adventure;Action & Adventure" games
"Education;Music & Video" ???
"Productivity" match
"Role Playing;Action & Adventure" games
"Puzzle" games
"Adventure;Brain Games" games
"Shopping" match
"Puzzle;Action & Adventure" games
"Health & Fitness;Action & Adventure" Health & Fitness
"Music" match
"Education;Education" match
"Parenting;Music & Video" ???
"Entertainment;Pretend Play" ???
"Casino" games
"Comics;Creativity" ???
"Puzzle;Creativity" games
"Educational;Brain Games" games
"Educational" education
"News & Magazines" news
"Role Playing;Brain Games" games
"Art & Design;Creativity" ???
"Educational;Action & Adventure" ????
"Video Players & Editors" Photo & Video
"Parenting;Brain Games" games
"Photography" photo & video 
"Role Playing;Education" ???
"Video Players & Editors;Creativity" Photo & video
"Role Playing" games
"Art & Design;Pretend Play" ???
"Music;Music & Video" music
"Parenting;Education" education
"Casual" games
"Education;Creativity" education
"Arcade;Pretend Play" games
"Books & Reference" ???
"Arcade" games
"Lifestyle;Pretend Play" ???
"Educational;Creativity" ???
"Food & Drink" match
"Role Playing;Pretend Play" games
"Dating" social networking
"Strategy;Creativity" ???
"Books & Reference;Creativity"  ???
"Health & Fitness;Education" health & fitness
"Entertainment;Creativity" ????
"Communication" match
"Tools;Education" education
"Card;Brain Games" games 
"Maps & Navigation" navigation
"Action" games
"Card" games
"Sports;Action & Adventure" sports
"Art & Design" ???
"Trivia" games
"Tools" utilities
"Entertainment;Music & Video" entertainment
"Business" business
"Board;Action & Adventure" games
"Social" social networking
"Personalization" ????
"Education;Action & Adventure" education
"Racing;Pretend Play" games
"Educational;Pretend Play" educational
"Board" games
"Racing;Action & Adventure" games
"Health & Fitness" match
"Comics" book
"Casual;Action & Adventure" games
"Simulation" games
"Education;Brain Games" games
"Education" match
"Beauty" ?????*/

--Android Top Apps by review count
SELECT DISTINCT genres, SUM(review_count) AS total_reviews
FROM play_store_apps
WHERE review_count IS NOT NULL
GROUP BY genres
ORDER BY total_reviews DESC


--Apple Top Apps by review count
SELECT DISTINCT primary_genre, SUM(CAST(review_count AS bigint)) AS total_reviews
FROM app_store_apps
WHERE review_count IS NOT NULL
GROUP BY primary_genre
ORDER BY total_reviews DESC


SELECT DISTINCT genres AS genre, SUM(review_count) AS total_reviews
FROM play_store_apps
WHERE genres LIKE '%Shopping%'
OR genres LIKE '%Game%'
OR genres LIKE '%Education%'
OR genres LIKE '%Reference%'
OR genres LIKE '%Business%'
OR genres LIKE '%Social Networking%'
OR genres LIKE '%Food & Drink%'
OR genres LIKE '%Sports%'
OR genres LIKE '%Catalogs%'
OR genres LIKE '%Weather%'
OR genres LIKE '%Book%'
OR genres LIKE '%Music%'
OR genres LIKE '%Entertainment%'
OR genres LIKE '%Medical%'
OR genres LIKE '%Utilities%'
OR genres LIKE '%Travel%'
OR genres LIKE '%Navigation%'
OR genres LIKE '%Photo%'
OR genres LIKE '%Video%'
OR genres LIKE '%Finance%'
OR genres LIKE '%Health%'
OR genres LIKE '%Fitness%'
OR genres LIKE '%News%'
OR genres LIKE '%Productivity%'
OR genres LIKE '%Lifestyle%'
GROUP BY genre
ORDER BY total_reviews DESC

--That expanded the Android categories to 67 variations on the Apple 13, however many of these probably represent duplicates. Is that even helpful?

SELECT DISTINCT primary_genre AS genre, SUM(CAST(review_count AS bigint)) AS review_sum, AVG(CAST(rating AS bigint)) AS avg_rating  
FROM app_store_apps
GROUP BY genre
UNION ALL
SELECT  
CASE 
	WHEN genres LIKE '%Shopping%' THEN 'Shopping'
	WHEN genres LIKE '%Game%' THEN 'Game'
	WHEN genres LIKE '%Education%' THEN 'Education'
	WHEN genres LIKE '%Reference%' THEN 'Reference'
	WHEN genres LIKE '%Business%' THEN 'Business'
	WHEN genres LIKE '%Social%' THEN 'Social Networking'
	WHEN genres LIKE '%Food & Drink%' THEN 'Food & Drink'
	WHEN genres LIKE '%Sports%' THEN 'Sports'
	WHEN genres LIKE '%Catalogs%' THEN 'Catalogs'
	WHEN genres LIKE '%Weather%' THEN 'Weather'
	WHEN genres LIKE '%Book%' THEN 'Books'
	WHEN genres LIKE '%Music%' THEN 'Music'
	WHEN genres LIKE '%Entertainment%' THEN 'Entertainment'
	WHEN genres LIKE '%Medical%' THEN 'Medical'
	WHEN genres LIKE '%Utilities%' THEN 'Utilities'
	WHEN genres LIKE '%Travel%' THEN 'Travel'
	WHEN genres LIKE '%Navigation%' THEN 'Navigation'
	WHEN genres LIKE '%Photo%' THEN 'Photo & Video'
	WHEN genres LIKE '%Video%' THEN 'Photo & Video'
	WHEN genres LIKE '%Finance%' THEN 'Finance'
	WHEN genres LIKE '%Health%' THEN 'Health'
	WHEN genres LIKE '%Fitness%' THEN 'Fitness'
	WHEN genres LIKE '%News%' THEN 'News'
	WHEN genres LIKE '%Productivity%' THEN 'Productivity'
	WHEN genres LIKE '%Lifestyle%' THEN 'Lifestyle' 
	END AS genre,
SUM(CAST(review_count AS bigint)) AS review_sum, AVG(CAST(rating AS bigint)) AS avg_rating
FROM play_store_apps
GROUP BY genre
ORDER BY review_sum DESC, avg_rating DESC

--Issues- duplicate android counts with the case statement?  does review sum even matter? should i pull out the different types of gaming instead, since those won't be in this calculation?? 

/*Not sure if this column would even make sense?
SUM(CAST(review_count AS bigint))/AVG(CAST(rating AS bigint)) AS avg_reviews_per_rating*/

/*SELECT DISTINCT name
FROM app_store_apps
INTERSECT
SELECT DISTINCT name
FROM play_store_apps

SELECT DISTINCT name
FROM app_store_apps
UNION ALL
SELECT DISTINCT name
FROM play_store_apps

SELECT DISTINCT LOWER(TRIM(name))
FROM app_store_apps
UNION
SELECT DISTINCT LOWER(TRIM(name))
FROM play_store_apps


SELECT * 
FROM app_store_apps
LIMIT 3

SELECT * 
FROM play_store_apps
LIMIT 3 

SELECT CAST(price AS money)  
	CASE
	WHEN price BETWEEN 0 AND 1 THEN '10000'
	ELSE (price * 10000) END AS price_per_app
FROM app_store_apps
UNION
SELECT CAST(price AS float),  
	CASE
	WHEN CAST(price AS float) BETWEEN 0 AND 1 THEN '10000'
	ELSE ((CAST(price AS float) * 10000)) END AS price_per_app
FROM play_store_apps

SELECT name, CAST(price AS money)
FROM play_store_apps
ORDER BY price DESC

CASE
	WHEN price BETWEEN 0 AND 1 THEN '10000'
	ELSE (price * 10000) END AS price_per_app

--Calculating price per app for both tables, adding column for app store
SELECT DISTINCT name, 'Apple', CAST(price AS numeric), 
CASE
	WHEN price BETWEEN 0 AND 1 THEN '10000'
	ELSE (price * 10000) END AS price_per_app
FROM app_store_apps
UNION
SELECT DISTINCT name, 'Android',
CAST(REPLACE(price, '$', '') AS numeric) AS price_per_app,
CASE
	WHEN CAST(REPLACE(price, '$', '') AS numeric) BETWEEN 0 AND 1 THEN '10000'
	ELSE (CAST(REPLACE(price, '$', '') AS numeric) * 10000) END AS price_per_app 
	FROM play_store_apps
ORDER BY price_per_app DESC, name


SELECT name, price, store, price_per_app
FROM (SELECT DISTINCT name, 'Apple' AS store , CAST(price AS numeric), 
CASE
	WHEN price BETWEEN 0 AND 1 THEN '10000'
	ELSE (price * 10000) END AS price_per_app
FROM app_store_apps
UNION
SELECT DISTINCT name, 'Android' AS store,
CAST(REPLACE(price, '$', '') AS numeric) AS price_per_app,
CASE
	WHEN CAST(REPLACE(price, '$', '') AS numeric) BETWEEN 0 AND 1 THEN '10000'
	ELSE (CAST(REPLACE(price, '$', '') AS numeric) * 10000) END AS price_per_app 
	FROM play_store_apps
ORDER BY price_per_app DESC, name) AS subquery
GROUP BY subquery.name, subquery.price, subquery.store, subquery.price_per_app
HAVING store = 'Android' AND store = 'Apple'



SELECT name, price, store, price_per_app
FROM (SELECT DISTINCT name, 'Apple' AS store , CAST(price AS numeric), 
CASE
	WHEN price BETWEEN 0 AND 1 THEN '10000'
	ELSE (price * 10000) END AS price_per_app
FROM app_store_apps
UNION
SELECT DISTINCT name, 'Android' AS store,
CAST(REPLACE(price, '$', '') AS numeric) AS price_per_app,
CASE
	WHEN CAST(REPLACE(price, '$', '') AS numeric) BETWEEN 0 AND 1 THEN '10000'
	ELSE (CAST(REPLACE(price, '$', '') AS numeric) * 10000) END AS price_per_app 
	FROM play_store_apps
ORDER BY price_per_app DESC, name) AS subquery
GROUP BY subquery.name, subquery.price, subquery.store, subquery.price_per_app
HAVING store = 'Android' AND store = 'Apple'



SELECT DISTINCT name, 'Apple' AS store , CAST(price AS numeric), 
CASE
	WHEN price BETWEEN 0 AND 1 THEN '10000'
	ELSE (price * 10000) END AS price_per_app
FROM app_store_apps, (SELECT DISTINCT name, 'Android' AS store,
CAST(REPLACE(price, '$', '') AS numeric) AS price_per_app,
CASE
	WHEN CAST(REPLACE(price, '$', '') AS numeric) BETWEEN 0 AND 1 THEN '10000'
	ELSE (CAST(REPLACE(price, '$', '') AS numeric) * 10000) END AS price_per_app 
	FROM play_store_apps) AS android_subquery
	
	

SELECT name, CAST(price AS numeric), 
CASE
	WHEN price BETWEEN 0 AND 1 THEN '10000'
	ELSE (price * 10000) END AS price_per_app
FROM (SELECT DISTINCT name, 'Apple' AS store , CAST(price AS numeric), 
CASE
	WHEN price BETWEEN 0 AND 1 THEN '10000'
	ELSE (price * 10000) END AS price_per_app
FROM app_store_apps
INTERSECT
SELECT DISTINCT name, 'Android' AS store,
CAST(REPLACE(price, '$', '') AS numeric) AS price_per_app,
CASE
	WHEN CAST(REPLACE(price, '$', '') AS numeric) BETWEEN 0 AND 1 THEN '10000'
	ELSE (CAST(REPLACE(price, '$', '') AS numeric) * 10000) END AS price_per_app 
	FROM play_store_apps
ORDER BY price_per_app DESC, name)) AS both_apps*/

--Using intersect instead of union in the FROM statement
SELECT name, MAX(price), price_per_app
FROM 
	(SELECT DISTINCT name, CAST(price AS numeric), 
		CASE
		WHEN price BETWEEN 0 AND 1 THEN '10000'
		ELSE (price * 10000) END AS price_per_app
	FROM app_store_apps
	INTERSECT
	SELECT DISTINCT name, 
	CAST(REPLACE(price, '$', '') AS numeric) AS price_per_app,
		CASE
		WHEN CAST(REPLACE(price, '$', '') AS numeric) BETWEEN 0 AND 1 THEN '10000'
		ELSE (CAST(REPLACE(price, '$', '') AS numeric) * 10000) END AS price_per_app 
	FROM play_store_apps
	ORDER BY price_per_app DESC, name) AS subquery
GROUP BY name, price_per_app
ORDER BY price_per_app DESC


SELECT name, MAX(price), price_per_app
FROM 
	(SELECT DISTINCT name, CAST(price AS numeric), 
		CASE
		WHEN price BETWEEN 0 AND 1 THEN '10000'
		ELSE (price * 10000) END AS price_per_app
	FROM app_store_apps
	INTERSECT
	SELECT DISTINCT name, 
	CAST(REPLACE(price, '$', '') AS numeric) AS price_per_app,
		CASE
		WHEN CAST(REPLACE(price, '$', '') AS numeric) BETWEEN 0 AND 1 THEN '10000'
		ELSE (CAST(REPLACE(price, '$', '') AS numeric) * 10000) END AS price_per_app 
	FROM play_store_apps
	ORDER BY price_per_app DESC, name) AS subquery
GROUP BY name, price_per_app
ORDER BY price_per_app DESC



SELECT name, MAX(price), price_per_app
FROM 
	(SELECT DISTINCT name, CAST(price AS numeric), 
		CASE
		WHEN price BETWEEN 0 AND 1 THEN '10000'
		ELSE (price * 10000) END AS price_per_app
	FROM app_store_apps
	INTERSECT
	SELECT DISTINCT name, 
	CAST(REPLACE(price, '$', '') AS numeric) AS price_per_app,
		CASE
		WHEN CAST(REPLACE(price, '$', '') AS numeric) BETWEEN 0 AND 1 THEN '10000'
		ELSE (CAST(REPLACE(price, '$', '') AS numeric) * 10000) END AS price_per_app 
	FROM play_store_apps
	ORDER BY price_per_app DESC, name) AS subquery
GROUP BY name, price_per_app
ORDER BY price_per_app DESC

--Finished through C
SELECT name, price, price_per_app
FROM 
	(SELECT DISTINCT name, CAST(price AS numeric), 
		CASE
		WHEN price BETWEEN 0 AND 1 THEN '10000'
		ELSE (price * 10000) END AS price_per_app
	FROM app_store_apps
	INTERSECT
	SELECT DISTINCT name, 
	CAST(REPLACE(price, '$', '') AS numeric) AS price_per_app,
		CASE
		WHEN CAST(REPLACE(price, '$', '') AS numeric) BETWEEN 0 AND 1 THEN '10000'
		ELSE (CAST(REPLACE(price, '$', '') AS numeric) * 10000) END AS price_per_app 
	FROM play_store_apps
	ORDER BY price_per_app DESC, name) AS subquery
ORDER BY price_per_app DESC

