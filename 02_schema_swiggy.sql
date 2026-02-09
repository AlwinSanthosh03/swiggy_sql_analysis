-- 1. CREATING SCHEMA, TABLES
-- 2. Dimension Date Table
CREATE TABLE swiggy.dim_date(
date_id INT auto_increment PRIMARY KEY,
Full_date DATE,
Year INT,
Month INT,
Month_name varchar(20),
Quarter INT,
Day INT,
Week INT
);
SELECT*FROM swiggy.dim_date;

-- 3. Dimension Location Table
CREATE TABLE swiggy.dim_location (
location_id INT AUTO_INCREMENT PRIMARY KEY,
State VARCHAR(100),
City VARCHAR(100),
Location VARCHAR(200)
);


-- 4.  Dimension Restaurant Table
CREATE TABLE swiggy.dim_restaurant (
restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
`Restaurant Name` VARCHAR(200)
);

-- 5. Dimension Category Table
CREATE TABLE swiggy.dim_category (
category_id INT AUTO_INCREMENT PRIMARY KEY,
Category VARCHAR(200)
);

-- 6. Dimension Dish Table
CREATE TABLE swiggy.dim_dish (
dish_id INT AUTO_INCREMENT PRIMARY KEY,
`Dish Name` VARCHAR(200)
);


-- 7. Creating Fact swiggy orders Table

CREATE TABLE fact_swiggy_orders (
order_id INT AUTO_INCREMENT PRIMARY KEY,
date_id INT,
`Price (INR)` DECIMAL(10,2),
Rating DECIMAL(4,2),
Rating_Count INT,
location_id INT,
restaurant_id INT,
category_id INT,
dish_id INT,

FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
FOREIGN KEY (location_id) REFERENCES dim_location(location_id),
FOREIGN KEY (restaurant_id) REFERENCES dim_restaurant(restaurant_id),
FOREIGN KEY (category_id) REFERENCES dim_category(category_id),
FOREIGN KEY (dish_id) REFERENCES dim_dish(dish_id)
);
-- -------------------------------------------------------------------------------
-- 8. Changing Date format in date
UPDATE swiggy.swiggy_orders
SET `Order Date` = STR_TO_DATE(`Order Date`, '%d-%m-%Y')
WHERE `Order Date` IS NOT NULL;

ALTER TABLE swiggy.swiggy_orders
MODIFY `Order Date` DATE;
