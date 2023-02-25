-- ### App Trader

-- Your team has been hired by a new company called App Trader to help them explore and gain insights from apps that are made available through the Apple App Store and Android Play Store. App Trader is a broker that purchases the rights to apps from developers in order to market the apps and offer in-app purchase. 

-- Unfortunately, the data for Apple App Store apps and Android Play Store Apps is located in separate tables with no referential integrity.

-- #### 1. Loading the data
-- a. Launch PgAdmin and create a new database called app_trader.  

-- b. Right-click on the app_trader database and choose `Restore...`  

-- c. Use the default values under the `Restore Options` tab. 

-- d. In the `Filename` section, browse to the backup file `app_store_backup.backup` in the data folder of this repository.  

-- e. Click `Restore` to load the database.  

-- f. Verify that you have two tables:  
--     - `app_store_apps` with 7197 rows  
--     - `play_store_apps` with 10840 rows

-- #### 2. Assumptions

-- Based on research completed prior to launching App Trader as a company, you can assume the following:

-- a. App Trader will purchase apps for 10,000 times the price of the app. For apps that are priced from free up to $1.00, the purchase price is $10,000.
    
-- - For example, an app that costs $2.00 will be purchased for $20,000.
    
-- - The cost of an app is not affected by how many app stores it is on. A $1.00 app on the Apple app store will cost the same as a $1.00 app on both stores. 
    
-- - If an app is on both stores, it's purchase price will be calculated based off of the highest app price between the two stores. 

-- b. Apps earn $5000 per month, per app store it is on, from in-app advertising and in-app purchases, regardless of the price of the app.
    
-- - An app that costs $200,000 will make the same per month as an app that costs $1.00. 

-- - An app that is on both app stores will make $10,000 per month. 

-- c. App Trader will spend an average of $1000 per month to market an app regardless of the price of the app. If App Trader owns rights to the app in both stores, it can market the app for both stores for a single cost of $1000 per month.
    
-- - An app that costs $200,000 and an app that costs $1.00 will both cost $1000 a month for marketing, regardless of the number of stores it is in.

-- d. For every half point that an app gains in rating, its projected lifespan increases by one year. In other words, an app with a rating of 0 can be expected to be in use for 1 year, an app with a rating of 1.0 can be expected to last 3 years, and an app with a rating of 4.0 can be expected to last 9 years.
    
-- - App store ratings should be calculated by taking the average of the scores from both app stores and rounding to the nearest 0.5.

-- e. App Trader would prefer to work with apps that are available in both the App Store and the Play Store since they can market both for the same $1000 per month.
SELECT *
FROM app_store_apps

SELECT *
FROM play_store_apps


-- #### 3. Deliverables

-- a. Develop some general recommendations as to the price range, genre, content rating, or anything else for apps that the company should target.

-- b. Develop a Top 10 List of the apps that App Trader should buy.

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
SELECT name, price, price_per_app, ROUND(AVG(rating),2)
FROM
	(SELECT DISTINCT name, CAST(price AS numeric),
		CASE
		WHEN price BETWEEN 0 AND 1 THEN '10000'
		ELSE (price * 10000) END AS price_per_app, rating
	FROM app_store_apps
	INTERSECT
	SELECT DISTINCT name,
	CAST(REPLACE(price, '$', '') AS numeric) AS price_per_app,
		CASE
		WHEN CAST(REPLACE(price, '$', '') AS numeric) BETWEEN 0 AND 1 THEN '10000'
		ELSE (CAST(REPLACE(price, '$', '') AS numeric) * 10000) END AS price_per_app, rating
	FROM play_store_apps
	ORDER BY price_per_app DESC, name) AS subquery
GROUP BY name, price, price_per_app, rating
ORDER BY price_per_app DESC
SELECT name, price, price_per_app, ROUND(AVG(rating),2)
FROM
	(SELECT DISTINCT name, CAST(price AS numeric),
		CASE
		WHEN price BETWEEN 0 AND 1 THEN '10000'
		ELSE (price * 10000) END AS price_per_app, rating
	FROM app_store_apps
	INTERSECT
	SELECT DISTINCT name,
	CAST(REPLACE(price, '$', '') AS numeric) AS price_per_app,
		CASE
		WHEN CAST(REPLACE(price, '$', '') AS numeric) BETWEEN 0 AND 1 THEN '10000'
		ELSE (CAST(REPLACE(price, '$', '') AS numeric) * 10000) END AS price_per_app, rating
	FROM play_store_apps
	ORDER BY price_per_app DESC, name) AS subquery
GROUP BY name, price, price_per_app, rating
ORDER BY price_per_app DESC
--Group working on this one...
SELECT name, price, price_per_app,
	(SELECT AVG(app_store_apps.rating + play_store_apps.rating)/2 AS avg_rating
	 FROM app_store_apps
	FULL JOIN play_store_apps
	ON app_store_apps.rating=play_store_apps.rating)
FROM
	(SELECT DISTINCT name, CAST(price AS numeric) AS price,
		CASE
		WHEN price BETWEEN 0 AND 1 THEN '10000'
		ELSE (price * 10000) END AS price_per_app
	FROM app_store_apps
	 	INTERSECT
	SELECT DISTINCT name,
	CAST(REPLACE(price, '$', '') AS numeric) AS price,
		CASE
		WHEN CAST(REPLACE(price, '$', '') AS numeric) BETWEEN 0 AND 1 THEN '10000'
		ELSE (CAST(REPLACE(price, '$', '') AS numeric) * 10000) END AS price_per_app
	 	FROM play_store_apps
	 	ORDER BY price_per_app DESC, name) AS subquery
GROUP BY name, price, price_per_app, avg_rating
ORDER BY price_per_app ASC
SELECT DISTINCT name, CAST(price AS numeric) AS price,
		CASE
		WHEN price BETWEEN 0 AND 1 THEN '10000'
		ELSE (price * 10000) END AS price_per_app,
		'Apple' AS store
	FROM app_store_apps
	 	UNION ALL
	SELECT DISTINCT name,
	CAST(REPLACE(price, '$', '') AS numeric) AS price,
		CASE
		WHEN CAST(REPLACE(price, '$', '') AS numeric) BETWEEN 0 AND 1 THEN '10000'
		ELSE (CAST(REPLACE(price, '$', '') AS numeric) * 10000) END AS price_per_app,
		'Android' AS store
	 	FROM play_store_apps
	 	ORDER BY price_per_app DESC, name
		
		
---Messed up Main Query		
SELECT name, price, price_per_app,
	(SELECT AVG(app_store_apps.rating + play_store_apps.rating)/2
				FROM app_store_apps
				FULL JOIN play_store_apps
				ON app_store_apps.rating=play_store_apps.rating), (SELECT DISTINCT REPLACE(LOWER(category),'_',' ')
		FROM play_store_apps
		UNION
	SELECT DISTINCT REPLACE(LOWER(primary_genre),'&','and')
		FROM app_store_apps) AS genre
FROM
	(SELECT DISTINCT name, CAST(price AS numeric),
		CASE
		WHEN price BETWEEN 0 AND 1 THEN '10000'
		ELSE (price * 10000) END AS price_per_app
	 	FROM app_store_apps) AS subquery1
UNION
SELECT DISTINCT name,
	(CAST(REPLACE(price, '$', '') AS numeric)) AS price,
		CASE
		WHEN CAST(REPLACE(price, '$', '') AS numeric) BETWEEN 0 AND 1 THEN '10000'
		ELSE (CAST(REPLACE(price, '$', '') AS numeric) * 10000) END AS price_per_app, content_rating
FROM play_store_apps
WHERE name IN
	(SELECT name
	FROM app_store_apps
	INTERSECT
	SELECT name
	FROM play_store_apps)
		
--Almost right? rounding
	(SELECT ((ROUND((app_store_apps.rating + play_store_apps.rating)/2)*2,0)/2)	
	
--Size	
SELECT DISTINCT name,price,rating,primary_genre,size_bytes
FROM app_store_apps
UNION ALL
SELECT DISTINCT name,CAST(REPLACE(price, '$', '') AS numeric) AS price,rating,genres,size
FROM play_store_apps
WHERE rating IS NOT NULL
ORDER BY size_bytes
--Content rating
SELECT DISTINCT content_rating
FROM app_store_apps
UNION ALL
SELECT DISTINCT content_rating
FROM play_store_apps
--Genre refined
SELECT DISTINCT REPLACE(LOWER(category),'_',' ')
FROM play_store_apps
UNION
SELECT DISTINCT REPLACE(LOWER(primary_genre),'&','and')
FROM app_store_apps AS genre
--Main working query
SELECT name, price, price_per_app,
	(SELECT AVG(app_store_apps.rating + play_store_apps.rating) AS avg_rating
	 FROM app_store_apps
	FULL JOIN play_store_apps
	ON app_store_apps.rating=play_store_apps.rating)
FROM
	(SELECT DISTINCT name, CAST(price AS numeric) AS price,
		CASE
		WHEN price BETWEEN 0 AND 1 THEN '10000'
		ELSE (price * 10000) END AS price_per_app
	FROM app_store_apps
	 	UNION
	SELECT DISTINCT name,
	CAST(REPLACE(price, '$', '') AS numeric) AS price,
		CASE
		WHEN CAST(REPLACE(price, '$', '') AS numeric) BETWEEN 0 AND 1 THEN '10000'
		ELSE (CAST(REPLACE(price, '$', '') AS numeric) * 10000) END AS price_per_app
	 	FROM play_store_apps
	 	ORDER BY price_per_app DESC, name) AS subquery
WHERE name IN
	(SELECT name
	FROM app_store_apps
	INTERSECT
	SELECT name
	FROM play_store_apps)
GROUP BY name, price, price_per_app, avg_rating
ORDER BY price_per_app ASC
--Trying to add genre
	
SELECT name, price, price_per_app,
	(SELECT AVG(app_store_apps.rating + play_store_apps.rating) AS avg_rating
	 FROM app_store_apps
	FULL JOIN play_store_apps
	ON app_store_apps.rating=play_store_apps.rating),
	 (SELECT DISTINCT REPLACE(LOWER(category),'_',' ')
		FROM play_store_apps
		UNION
		SELECT DISTINCT REPLACE(LOWER(primary_genre),'&','and')
		FROM app_store_apps) AS genre
FROM
	(SELECT DISTINCT name, CAST(price AS numeric) AS price,
		CASE
		WHEN price BETWEEN 0 AND 1 THEN '10000'
		ELSE (price * 10000) END AS price_per_app, primary_genre
	FROM app_store_apps
	 	UNION
	SELECT DISTINCT name,
	CAST(REPLACE(price, '$', '') AS numeric) AS price,
		CASE
		WHEN CAST(REPLACE(price, '$', '') AS numeric) BETWEEN 0 AND 1 THEN '10000'
		ELSE (CAST(REPLACE(price, '$', '') AS numeric) * 10000) END AS price_per_app, category
	 	FROM play_store_apps
	 	ORDER BY price_per_app DESC, name) AS subquery
WHERE name IN
	(SELECT name
	FROM app_store_apps
	INTERSECT
	SELECT name
	FROM play_store_apps)
GROUP BY name, price, price_per_app, avg_rating
ORDER BY price_per_app ASC
LIMIT 10
--longevity
SELECT rating,
	 	CASE
	 	WHEN rating = 0 THEN '1'
	 	WHEN rating <=0.5 THEN '2'
	 	WHEN rating <=1 THEN '3'
	 	WHEN rating <=1.5 THEN '4'
	 	WHEN rating <=2 THEN '5'
	 	WHEN rating <=2.5 THEN '6'
	 	WHEN rating <=3 THEN '7'
	 	WHEN rating <=3.5 THEN '8'
	 	WHEN rating <=4 THEN '9'
	 	WHEN rating <=4.5 THEN '10'
	 	WHEN rating <=5 THEN '11'
	 	END AS longevity
FROM app_store_apps
UNION
SELECT rating,
	 	CASE
	 	WHEN rating = 0 THEN '1'
	 	WHEN rating <=0.5 THEN '2'
	 	WHEN rating <=1 THEN '3'
	 	WHEN rating <=1.5 THEN '4'
	 	WHEN rating <=2 THEN '5'
	 	WHEN rating <=2.5 THEN '6'
	 	WHEN rating <=3 THEN '7'
	 	WHEN rating <=3.5 THEN '8'
	 	WHEN rating <=4 THEN '9'
	 	WHEN rating <=4.5 THEN '10'
	 	WHEN rating <=5 THEN '11'
	 	END AS longevity
FROM play_store_apps
-------------------------------------------------------------------------------------------
