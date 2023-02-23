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

SELECT * 
FROM app_store_apps
LIMIT 3

SELECT * 
FROM play_store_apps
LIMIT 3

SELECT DISTINCT(primary_genre)
FROM app_store_apps

--Apple has 23 distinct genres

SELECT DISTINCT (genres)
FROM play_store_apps

--Android has 119.  A lot of these are combinations joined by a ;  Maybe we remove these and only use the first entry per genre?
--Maybe if we only compare genres that are listed in both tables?  
SELECT DISTINCT genres AS genre, SUM(review_count) as total_reviews
FROM play_store_apps
WHERE genres IN ('Shopping', 'Games', 'Education', 'Reference', 'Business', 'Social Networking', 'Food & Drink', 'Sports', 'Catalogs', 'Weather', 'Book', 'Music', 'Entertainment', 'Medical', 'Utilities', 'Travel', 'Navigation', 'Photo & Video', 'Finance', 'Health & Fitness', 'News', 'Productivity', 'Lifestyle')
GROUP BY genre
ORDER BY total_reviews DESC

--Should I use LIKE to pull those out instead?

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

--That expanded the Android categories to 67 variations on the Apple 13.  Is that even helpful?

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
	WHEN genres LIKE '%Social Networking%' THEN 'Social Networking'
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

/*Not sure if this last column even makes sense?
SUM(CAST(review_count AS bigint))/AVG(CAST(rating AS bigint)) AS avg_reviews_per_rating
SUM(CAST(review_count AS bigint))/AVG(CAST(rating AS bigint)) AS avg_reviews_per_rating*/