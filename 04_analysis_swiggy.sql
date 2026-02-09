-- Real queries start
-- KPI

-- 1. Total No. of Swiggy Orders 
SELECT COUNT(*) AS Total_orders
FROM swiggy.fact_swiggy_orders;

-- 2. Total revenue of swiggy orders in million
SELECT 
    CONCAT(
        '₹',
        ROUND(SUM(`Price (INR)`) / 1000000, 2),
        ' MILLION'
    ) AS Total_Revenue
FROM swiggy.fact_swiggy_orders;

-- 3. Average dish content
SELECT 
    CONCAT(
        '₹',
        ROUND(AVG(`Price (INR)`), 2)
    ) AS Average_dish_content
FROM swiggy.fact_swiggy_orders;

-- 4. Average Rating
SELECT AVG(Rating) as Average_Rating
FROM swiggy.fact_swiggy_orders;

--  Deep Dive Business Analysis

-- 6. Monthly Order trends
SELECT d.Year, d.Month,d.Month_name,count(*) as Total_orders
FROM swiggy.fact_swiggy_orders f JOIN swiggy.dim_date d
GROUP BY d.Year, d.Month,d.Month_name
ORDER BY Total_orders DESC;

-- 7. Monthly Order trends
SELECT d.Year, d.Month,d.Month_name,count(*) as Total_orders
FROM swiggy.fact_swiggy_orders f JOIN swiggy.dim_date d
GROUP BY d.Year, d.Month,d.Month_name
ORDER BY Total_orders DESC;

-- 8. Quarterly Sales trends
SELECT d.Year, d.Quarter,round(sum(`Price (INR)`),0) as Monthly_Revenue
FROM swiggy.fact_swiggy_orders f JOIN swiggy.dim_date d
GROUP BY d.Year, d.Quarter
ORDER BY d.Quarter;

-- 9. Yearly Order trends
SELECT d.Year,COUNT(DISTINCT f.order_id) AS Total_orders
FROM swiggy.fact_swiggy_orders f JOIN swiggy.dim_date d
GROUP BY d.Year;

-- 10. Weekly Order Trends
SELECT 
    DAYNAME(d.full_date) AS Day_name,
    COUNT(DISTINCT f.order_id) AS Total_orders
FROM fact_swiggy_orders f
JOIN dim_date d 
    ON f.date_id = d.date_id
GROUP BY 
    DAYOFWEEK(d.full_date),
    DAYNAME(d.full_date)
ORDER BY 
    DAYOFWEEK(d.full_date)DESC;

-- 11. TOP Ten Cities Order by VOlume

SELECT l.City, COUNT(DISTINCT f.order_id) AS Total_orders
FROM swiggy.dim_location l JOIN swiggy.fact_swiggy_orders f
ON l.location_id = f.location_id
GROUP BY l.City
ORDER BY Total_orders DESC
LIMIT 10;

-- 12. Revenue Contribution by States

SELECT l.State, round(sum(`Price (INR)`),0) as State_Revenue
FROM swiggy.dim_location l JOIN swiggy.fact_swiggy_orders f
ON l.location_id = f.location_id
GROUP BY l.State
ORDER BY State_Revenue DESC;

-- 13. Top 10 restaurants by Order
SELECT r.`Restaurant Name`,round(sum(`Price (INR)`),0) as Total_Revenue
FROM swiggy.dim_restaurant r JOIN swiggy.fact_swiggy_orders f
ON r.restaurant_id = f.restaurant_id
GROUP BY r.`Restaurant Name`
ORDER BY Total_Revenue DESC
LIMIT 10;

-- 14. Total Order by Category

SELECT c.Category, COUNT(DISTINCT f.order_id) AS Total_orders
FROM swiggy.dim_category c JOIN swiggy.fact_swiggy_orders f
ON c.category_id = f.category_id
GROUP BY c.Category
ORDER BY Total_orders DESC
LIMIT 10;

-- 15. Most ordered dish

SELECT di.`Dish Name`, COUNT(DISTINCT f.order_id) AS Total_orders
FROM swiggy.dim_dish di JOIN swiggy.fact_swiggy_orders f
ON di.dish_id=f.dish_id
GROUP BY di.`Dish Name`
ORDER BY Total_orders DESC
LIMIT 10;


-- 16. Cusine Performance (Orders + Avg Rating)
SELECT c.Category, 
	COUNT(DISTINCT f.order_id) AS Total_orders,
	ROUND(AVG(f.Rating),2) AS Average_rating
FROM swiggy.dim_category c JOIN swiggy.fact_swiggy_orders f
ON c.category_id = f.category_id
GROUP BY c.Category
ORDER BY Total_orders DESC
LIMIT 10;

-- 17. Price Band Distribution (INR)

SELECT 
	CASE
		WHEN ROUND(`Price (INR)`,2)<100 THEN 'UNDER 100'
        WHEN ROUND(`Price (INR)`,2) BETWEEN 100 AND 199  THEN '100 -199'
        WHEN ROUND(`Price (INR)`,2) BETWEEN 200 AND 299  THEN '200 -299'
        WHEN ROUND(`Price (INR)`,2) BETWEEN 300 AND 499  THEN '300 -499'
        ELSE '500+'
	END AS Price_Range,
		COUNT(order_id) AS Total_Order
FROM swiggy.fact_swiggy_orders
GROUP BY 
	CASE
		WHEN ROUND(`Price (INR)`,2)<100 THEN 'UNDER 100'
        WHEN ROUND(`Price (INR)`,2) BETWEEN 100 AND 199  THEN '100 -199'
        WHEN ROUND(`Price (INR)`,2) BETWEEN 200 AND 299  THEN '200 -299'
        WHEN ROUND(`Price (INR)`,2) BETWEEN 300 AND 499  THEN '300 -499'
        ELSE '500+'
	END
ORDER BY Total_Order DESC;


-- 18. Rating Count Distribution

SELECT f.Rating, COUNT(*) AS Rating_Count
from swiggy.fact_swiggy_orders f
GROUP BY f.Rating
ORDER BY Rating_Count DESC;

-- 19. Distribution of dish ratings from 1–5
SELECT di.`Dish Name`, 
	COUNT(DISTINCT f.order_id) AS Total_orders,
	ROUND(AVG(f.Rating),2) AS Average_rating
FROM swiggy.dim_dish di JOIN swiggy.fact_swiggy_orders f
ON di.dish_id = f.dish_id
GROUP BY di.`Dish Name`
ORDER BY Total_orders DESC
LIMIT 10;
