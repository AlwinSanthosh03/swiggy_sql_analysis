# Swiggy SQL Data Analysis Project

This project focuses on analyzing Swiggy food order data using SQL to extract meaningful business insights. The objective is to clean raw transactional data, design a structured data model, and perform in-depth analysis to understand customer ordering behavior, revenue trends, and product performance.

---

## 📌 Project Objectives
- Perform data validation and cleaning on raw Swiggy order data
- Remove duplicates and standardize date formats
- Design a STAR SCHEMA data model for analytical reporting
- Generate KPIs and business insights using SQL queries

---

## 🛠️ Tools & Technologies
- MySQL
- SQL (CTE, Window Functions, Joins)
- Git & GitHub

---

## 🧹 Data Cleaning & Preparation
The following steps were performed to ensure data quality:
- Checked for NULL values across all important columns
- Identified and validated blank or empty string values
- Detected duplicate records using GROUP BY
- Removed duplicates using ROW_NUMBER() with CTE
- Created a surrogate primary key for safe deletions
- Standardized order date format using STR_TO_DATE()

---

## 🏗️ Data Model Design
A **STAR SCHEMA** was implemented to support analytical queries.

### Dimension Tables
- `dim_date` – Date, month, quarter, year analysis
- `dim_location` – State, city, and location details
- `dim_restaurant` – Restaurant information
- `dim_category` – Cuisine / category details
- `dim_dish` – Dish-level information

### Fact Table
- `fact_swiggy_orders`
  - Stores transactional measures such as price, rating, and rating count
  - Connected to all dimension tables using foreign keys

---

## 📊 Key Performance Indicators (KPIs)
- Total number of Swiggy orders
- Total revenue (in INR millions)
- Average dish price
- Average customer rating

---

## 📈 Business Analysis Performed
- Monthly, quarterly, and yearly order trends
- Weekly ordering behavior analysis
- Top 10 cities by order volume
- Revenue contribution by state
- Top restaurants by revenue
- Category-wise order distribution
- Most ordered dishes
- Cuisine performance based on orders and ratings
- **Price Range Analysis (INR)**:
  - Under 100
  - 100–199
  - 200–299
  - 300–499
  - 500+

This segmentation helps understand customer spending behavior.

---

## 📁 Project Structure
