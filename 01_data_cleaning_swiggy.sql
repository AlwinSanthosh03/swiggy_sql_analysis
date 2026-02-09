create database Swiggy;
select * from swiggy.swiggy_orders; 

-- 1. Data Validation and Cleaning and Null check
SELECT 
    SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS null_state,
    SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS null_city,
    SUM(CASE WHEN `Restaurant name` IS NULL THEN 1 ELSE 0 END) AS null_restaurant_name,
    SUM(CASE WHEN Location IS NULL THEN 1 ELSE 0 END) AS null_location,
    SUM(CASE WHEN Category IS NULL THEN 1 ELSE 0 END) AS null_category,
    SUM(CASE WHEN `Dish Name` IS NULL THEN 1 ELSE 0 END) AS null_dish_name,
    SUM(CASE WHEN `Price (INR)` IS NULL THEN 1 ELSE 0 END) AS null_Price_INR,
    SUM(CASE WHEN Rating IS NULL THEN 1 ELSE 0 END) AS null_rating,
    SUM(CASE WHEN `Rating Count` IS NULL THEN 1 ELSE 0 END) AS null_ratingcount,
    COUNT(*) AS total_rows 
FROM swiggy.swiggy_orders;

-- ----------------------------------------------------------------------------------------------------

-- 2. Blank or empty strings
SELECT *
FROM swiggy.swiggy_orders
WHERE 
State ='' or city ='' or `Restaurant Name`='' or Location='' or Category='' or `Dish Name` ='';

-- ----------------------------------------------------------------------------------------------------

-- 3. Duplicate detection
SELECT State,City, `Order Date`,`Restaurant Name`,location, category,`Dish Name`,`Price (INR)`,
rating,`Rating Count`, count(*) AS CNT FROM swiggy.swiggy_orders
GROUP BY State,City, `Order Date`,`Restaurant Name`,location, category,`Dish Name`,`Price (INR)`,
rating,`Rating Count`
HAVING CNT>1

-- ----------------------------------------------------------------------------------------------------

-- 4. Delete duplicates using CTE + JOIN (MySQL)
USE swiggy;
WITH CTE AS (
  SELECT *,
         ROW_NUMBER() OVER (
           PARTITION BY State, City, `Order Date`, `Restaurant Name`,
                        location, category, `Dish Name`, `Price (INR)`,
                        rating, `Rating Count`
           ORDER BY (SELECT NULL)
         ) AS rn
  FROM swiggy.swiggy_orders
)
DELETE s
FROM swiggy.swiggy_orders s
JOIN CTE c
  ON s.S_no = c.S_no
WHERE c.rn > 1;

-- ----------------------------------------------------------------------------------------------------
