-- 1. Inserting data into the dim_date table
INSERT INTO dim_date
(
    Full_date,
    Year,
    Month,
    Month_name,
    Quarter,
    Day,
    Week
)
SELECT DISTINCT
    `Order Date`                             AS Full_date,
    YEAR(`Order Date`)                      AS Year,
    MONTH(`Order Date`)                     AS Month,
    MONTHNAME(`Order Date`)                 AS Month_name,
    QUARTER(`Order Date`)                   AS Quarter,
    DAY(`Order Date`)                       AS Day,
    WEEK(`Order Date`)                      AS Week
FROM swiggy.swiggy_orders
WHERE `Order Date` IS NOT NULL;
select * from swiggy.dim_date;

-- 2. Inserting data into the dim_location table
INSERT INTO swiggy.dim_location
(State,
City,
Location)
SELECT DISTINCT 
State AS State,
City AS City,
Location AS Location
FROM swiggy.swiggy_orders;
SELECT * FROM swiggy.dim_location;

-- 3. Inserting data into the dim_category table
INSERT INTO swiggy.dim_category
(Category)
SELECT DISTINCT
Category as Category 
FROM swiggy.swiggy_orders;
SELECT*FROM swiggy.dim_category;

-- 4. Inserting data into the dim_dish table
INSERT INTO swiggy.dim_dish
(`Dish Name`)
SELECT DISTINCT
`Dish Name` as `Dish Name` 
FROM swiggy.swiggy_orders;
SELECT*FROM swiggy.dim_dish;

-- 5. Inserting data into the dim_restaurant table
INSERT INTO swiggy.dim_restaurant
(`Restaurant Name`)
SELECT DISTINCT
`Restaurant Name` as `Restaurant Name` 
FROM swiggy.swiggy_orders;
SELECT*FROM swiggy.dim_restaurant;

-- 6. Inserting data into the fact_swiggy_orders table
INSERT INTO swiggy.fact_swiggy_orders
(date_id,
`Price (INR)`,
Rating,
Rating_Count,
location_id,
restaurant_id,
category_id,
dish_id)
SELECT DISTINCT
d.date_id,
s.`Price (INR)`,
s.Rating,
s.`Rating Count`,
l.location_id,
r.restaurant_id,
c.category_id,
di.dish_id
FROM swiggy.swiggy_orders s 

-- Date dimension
JOIN dim_date d ON d.Full_date = s.`Order Date`
-- Location dimension
JOIN dim_location l ON l.City = s.City AND l.State = s.State AND l.Location = s.Location

-- Restaurant dimension
JOIN dim_restaurant r
ON r.`Restaurant Name` = s.`Restaurant Name`

-- Category dimension
JOIN dim_category c
ON c.Category = s.Category

-- Restaurant dish 
JOIN dim_dish di
ON di.`Dish Name` = s.`Dish Name`

-- 7. Joining all table into the fact_swiggy_orders
SELECT * FROM swiggy.fact_swiggy_orders f
JOIN dim_date d ON f.date_id = d.date_id
JOIN dim_location l on f.location_id = l.location_id
JOIN dim_restaurant r on f.restaurant_id = r.restaurant_id
JOIN dim_category c on f.category_id = c.category_id
JOIN dim_dish di ON f.dish_id = di.dish_id;