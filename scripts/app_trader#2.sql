/*Desired fields:
1. Name - inner join to find apps in both stores
2. Purchase price- price of app x $10,000, unless app is less than $1, then $10,000
3. Longevity- average rating between both stores to the nearest 0.5, then for every half point an added year of longevity
4. Advertising cost- longevity(years) x 1000(advertising costs) x 12(months per year)
5. App earnings- longevity (years) x 5000 (earnings) x 12 (months per year)
6. Net earnings- app earnings - (purchase price + advertising cost)*/

--Step 1: Find names in both tables

SELECT DISTINCT a.name
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
ON a.name=p.name
ORDER BY name

--Step 2: Find purchase price

SELECT DISTINCT name,
	CASE WHEN GREATEST(a.price, REPLACE(p.price, '$', '') :: numeric) > 1 
	THEN GREATEST(a.price, REPLACE(p.price, '$', '') :: numeric) * 10000 :: money
	WHEN GREATEST (a.price, REPLACE(p.price, '$', ''):: numeric) <= 1 
	THEN 10000 :: money
	END AS purchase_price
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
USING(name)
ORDER BY name

--Step 3: Find longevity

SELECT DISTINCT name,
	CASE WHEN GREATEST(a.price, REPLACE(p.price, '$', '') :: numeric) > 1 
		THEN GREATEST(a.price, REPLACE(p.price, '$', '') :: numeric) * 10000 :: money
		WHEN GREATEST (a.price, REPLACE(p.price, '$', ''):: numeric) <= 1 
		THEN 10000 :: money
		END AS purchase_price,
	2 * ROUND((a.rating+p.rating)/2 * 2, 0)/2 + 1 AS longevity
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
USING(name)
ORDER BY name

--Step 4: Find advertising cost. Trying to add CTE like walkthrough

SELECT DISTINCT name,
	CASE WHEN GREATEST(a.price, REPLACE(p.price, '$', '') :: numeric) > 1 
		THEN GREATEST(a.price, REPLACE(p.price, '$', '') :: numeric) * 10000 :: money
		WHEN GREATEST (a.price, REPLACE(p.price, '$', ''):: numeric) <= 1 
		THEN 10000 :: money
		END AS purchase_price,
	2 * ROUND((a.rating+p.rating)/2 * 2, 0)/2 + 1 AS longevity,
	(2 * ROUND((a.rating+p.rating)/2 * 2, 0)/2 + 1) * 1000 * 12 AS advertising_cost
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
USING(name)
ORDER BY name

--Step 4 PART 2: Find advertising cost. Trying to add CTE like walkthrough

with cte AS (SELECT DISTINCT name,
	CASE WHEN GREATEST(a.price, REPLACE(p.price, '$', '') :: numeric) > 1 
		THEN GREATEST(a.price, REPLACE(p.price, '$', '') :: numeric) * 10000 :: money
		WHEN GREATEST (a.price, REPLACE(p.price, '$', ''):: numeric) <= 1 
		THEN 10000 :: money
		END AS purchase_price,
	2 * ROUND((a.rating+p.rating)/2 * 2, 0)/2 + 1 AS longevity
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
USING(name)
ORDER BY name
	)
SELECT *, longevity * 1000 * 12 AS advertising_cost
FROM cte



--Step 5: Find app earnings

with cte AS (SELECT DISTINCT name,
	CASE WHEN GREATEST(a.price, REPLACE(p.price, '$', '') :: numeric) > 1 
		THEN GREATEST(a.price, REPLACE(p.price, '$', '') :: numeric) * 10000 :: money
		WHEN GREATEST (a.price, REPLACE(p.price, '$', ''):: numeric) <= 1 
		THEN 10000 :: money
		END AS purchase_price,
	2 * ROUND((a.rating+p.rating)/2 * 2, 0)/2 + 1 AS longevity
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
USING(name)
ORDER BY name
	)
SELECT *, longevity * 1000 * 12 AS advertising_cost,
longevity * 5000 * 12 AS app_earnings
FROM cte


--Step 6: Find net earning

with cte AS (SELECT DISTINCT name,
	CASE WHEN GREATEST(a.price, REPLACE(p.price, '$', '') :: numeric) > 1 
		THEN GREATEST(a.price, REPLACE(p.price, '$', '') :: numeric) * 10000 :: money
			 +((2 * ROUND((a.rating + p.rating)/2 * 2, 0) / 2 + 1) * 12 * 1000) :: money 
		WHEN GREATEST (a.price, REPLACE(p.price, '$', ''):: numeric) <= 1 
		THEN 10000 :: money
			 +((2 * ROUND((a.rating + p.rating)/2 * 2, 0) / 2 + 1) * 12 * 1000) :: money 
		END AS cost,
	2 * ROUND((a.rating+p.rating)/2 * 2, 0)/2 + 1 AS longevity,
	(2 * ROUND((a.rating+p.rating)/2 * 2, 0)/2 + 1)	* 10000 * 12 :: money AS earnings	 
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
USING(name)
ORDER BY name
	)
SELECT name, cost, longevity, earnings, (earnings-cost) AS net_earnings
FROM cte
ORDER BY net_earnings DESC;

