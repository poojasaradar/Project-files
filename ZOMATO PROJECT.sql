DROP database zomato;
use  zomato;
create database zomato;
select * from country;
select * from currency;
select * from maintable;

-- ZOMATO ANALYTICS

-- DATE
SELECT STR_TO_DATE(CONCAT(`Year Opening`, '-', `Month Opening`, '-', `Day Opening`), '%Y-%m-%d') AS opening_date FROM maintable;

-- YEAR
SELECT `Year Opening` AS YEAR_ FROM MAINTABLE;

-- MONTH
SELECT `Month Opening` AS MONTH_NUMBER FROM MAINTABLE;

-- DAY
SELECT `Day Opening` AS DAY_ FROM MAINTABLE;

-- MONTH_FULL NAME
SELECT 
    CASE 
        WHEN `Month Opening` = 1 THEN 'January'
        WHEN `Month Opening` = 2 THEN 'February'
        WHEN `Month Opening` = 3 THEN 'March'
        WHEN `Month Opening` = 4 THEN 'April'
        WHEN `Month Opening` = 5 THEN 'May'
        WHEN `Month Opening` = 6 THEN 'June'
        WHEN `Month Opening` = 7 THEN 'July'
        WHEN `Month Opening` = 8 THEN 'August'
        WHEN `Month Opening` = 9 THEN 'September'
        WHEN `Month Opening` = 10 THEN 'October'
        WHEN `Month Opening` = 11 THEN 'November'
        WHEN `Month Opening` = 12 THEN 'December'
    END AS MonthFullName FROM MAINTABLE;

-- QUARTER
SELECT CASE 
WHEN `Month Opening` IN (1,2,3) THEN "Q1"
WHEN `Month Opening` IN (4,5,6) THEN "Q2"
WHEN `Month Opening` IN (7,8,9) THEN "Q3"
WHEN `Month Opening` IN (10,11,12) THEN "Q4"
END AS QUARTER
FROM MAINTABLE;

-- FINANCIAL_QUARTER
SELECT CASE  
WHEN `Month Opening` = 1 THEN "FM1"
WHEN `Month Opening` = 2 THEN "FM2"
WHEN `Month Opening` = 3 THEN "FM3"
WHEN `Month Opening` = 4 THEN "FM4"
WHEN `Month Opening` = 5 THEN "FM5"
WHEN `Month Opening` = 6 THEN "FM6"
WHEN `Month Opening` = 7 THEN "FM7"
WHEN `Month Opening` = 8 THEN "FM8"
WHEN `Month Opening` = 9 THEN "FM9"
WHEN `Month Opening` = 10 THEN "FM10"
WHEN `Month Opening` = 11 THEN "FM11"
WHEN `Month Opening` = 12 THEN "FM12"
END AS FINANCIAL_QUARTER 
FROM MAINTABLE;


-- AVERAGE_COST IN USD_DOLLERS
SELECT 
    M.Average_Cost_for_two,
    M.Currency,
    C.Currency,
    (M.Average_Cost_for_two * C.`USD Rate`) AS AVERAGE_COST_FOR2_INUSD_DOLLERS
FROM
    MAINTABLE AS M
        JOIN
    currency AS C ON M.Currency = C.Currency;


-- NUMBER OF RESTAURANTS BASED ON CITY AND COUNTRY
SELECT M.City,C.Countryname,COUNT(M.RestaurantID) AS NUMBER_RESTAURANTS FROM MAINTABLE AS M JOIN country AS C ON M.CountryCode=C.CountryID GROUP BY M.City ,C.Countryname LIMIT 10;
    

-- NUMBER OF RESTAURANTS BASED ON YEAR,QUARTER,MONTH 

SELECT COUNT(RestaurantID) AS NUMBER_RESTAURANTS,`Year Opening` AS YEAR FROM MAINTABLE  GROUP BY `Year Opening` ORDER BY NUMBER_RESTAURANTS DESC LIMIT 10 ;

-- NUMBER OF RESTAURANTS BASED ON QUARTER 

SELECT COUNT(RestaurantID) AS NUMBER_RESTAURANTS ,CASE
WHEN `Month Opening` IN (1,2,3) THEN "Q1"
WHEN `Month Opening` IN (4,5,6) THEN "Q2"
WHEN `Month Opening` IN (7,8,9) THEN "Q3"
WHEN `Month Opening` IN (10,11,12) THEN "Q4"
END AS QUARTER 
FROM MAINTABLE GROUP BY QUARTER ORDER BY NUMBER_RESTAURANTS DESC LIMIT 10;


-- NUMBER OF RESTAURANTS BASED ON MONTHNAME
SELECT COUNT(RestaurantID) AS NUMBER_RESTAURANTS, 
CASE
        WHEN `Month Opening` = 1 THEN 'January'
        WHEN `Month Opening` = 2 THEN 'February'
        WHEN `Month Opening` = 3 THEN 'March'
        WHEN `Month Opening` = 4 THEN 'April'
        WHEN `Month Opening` = 5 THEN 'May'
        WHEN `Month Opening` = 6 THEN 'June'
        WHEN `Month Opening` = 7 THEN 'July'
        WHEN `Month Opening` = 8 THEN 'August'
        WHEN `Month Opening` = 9 THEN 'September'
        WHEN `Month Opening` = 10 THEN 'October'
        WHEN `Month Opening` = 11 THEN 'November'
        WHEN `Month Opening` = 12 THEN 'December'
    END AS MonthFullName FROM MAINTABLE GROUP BY MONTHFULLNAME ORDER BY NUMBER_RESTAURANTS DESC LIMIT 5 ;


-- NUMBER OF RESTAURANTS BASED ON RATINGS
SELECT COUNT(RestaurantID) AS NUMBER_RESTAURANTS,Rating FROM MAINTABLE GROUP BY Rating ORDER BY NUMBER_RESTAURANTS DESC ;

-- NUMBER_RESTAURANTS BASED ON PRICE_BUCKETS
SELECT COUNT(RestaurantID) AS NUMBER_RESTAURANTS ,
CASE WHEN Average_Cost_for_two <= 500 THEN "LOW"
WHEN Average_Cost_for_two <= 1000 THEN "MEDIUM"
WHEN Average_Cost_for_two <= 2000 THEN "HIGH"
END AS PRICE_BUCKET
 FROM MAINTABLE GROUP BY PRICE_BUCKET ORDER BY NUMBER_RESTAURANTS DESC  ;


-- RESTAURANTS BASED ON HAS_TABLE_BOOKING
SELECT COUNT(RestaurantID) AS NUMBER_RESTAURANTS ,Has_Table_booking FROM MAINTABLE GROUP BY Has_Table_booking ORDER BY NUMBER_RESTAURANTS  DESC ;


-- RESTAURANTS BASED ON Has_Online_delivery
SELECT COUNT(RestaurantID) AS NUMBER_RESTAURANTS ,Has_Online_delivery FROM MAINTABLE GROUP BY Has_Online_delivery ORDER BY NUMBER_RESTAURANTS  DESC ;

-- NUMBER_RESTAURANTS BASED ON CUISINES
SELECT COUNT(RestaurantID) AS NUMBER_RESTAURANTS , Cuisines FROM MAINTABLE GROUP BY Cuisines ORDER BY NUMBER_RESTAURANTS DESC LIMIT 5;


-- KPI
-- UNIQUE RESTAURANTS 

SELECT DISTINCT( COUNT(RestaurantID)) AS UNIQUE_RESTAURANTID FROM MAINTABLE;

-- UNIQUE COUNTRYCODES
SELECT DISTINCT( COUNT(CountryID)) AS UNIQUE_COUNRTYCODE FROM country;

-- SUM_RATINGS
SELECT SUM(Rating) AS NUMBER_RATINGS FROM MAINTABLE;



 










