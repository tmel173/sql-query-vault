*/find young female runners born after 1996 /*

SELECT 
    first_name,
    last_name,
    TO_NUMBER(TO_CHAR(CURRENT_DATE, 'YYYY'), '9999') - TO_NUMBER(TO_CHAR(birth_date, 'YYYY'), '9999') AS age
FROM Runners
WHERE gender = 'F'
  AND birth_date > '1996-01-01'
ORDER BY AGE ASC;

SELECT 
    first_name,
    location,
    prize_money
    FROM Races
    WHERE surface_type = 'Trail'
    AND prize_money > 100000
    ORDER BY prize_money DESC; 



select 
    race_name,
    race_id,
    finish_time
from Races_Results
where finish_time < '00:20:00'
order by finish_time asc;
    

Select runner_id,
       UPPER(SUBSTRING(TRIM(last_name),1,1)) || LOWER(SUBSTRING(TRIM(last_name),2)) AS last_name,
         UPPER(SUBSTRING(TRIM(first_name),1,1)) || LOWER(SUB
STRING(TRIM(first_name),2)) AS first_name,
         TO_NUMBER(TO_CHAR(birth_date, 'YYYY'), '9999') AS birth_year,
         TO_NUMBER(TO_CURRENT_DATE, 'YYYY'), '9999') - TO_NUMBER(TO_CHAR(birth_date, 'YYYY'), '9999') AS age

Select * 
from Runners
Where first_name LIKE 'Av%'

Select runner_id AS "Runner ID",
       TRIM(first_name) AS "Cleaned First Name",
       UPPER(last_name) AS "Uppercase Last Name",
       CONCAT(first_name, ' ', last_name) AS "Full Name",
       LENGTH(last_name) AS "Last Name Length",
       SUBSTRING(first_name, 1, 3) AS "First Name Initials",
       REPLACE(first_name, 'a', '@') AS "First Name with replaced a"

FROM Runners
WHERE LENGTH(First_name) > 3 
  AND SUBSTRING(first_name, 1, 2) = 'Li';

/*Working with conditional statements and logical operators*/
SELECT race_name
FROM Races
WHERE TO_CHAR(race_date, 'YYYY') = '2024'
 AND TO_NUMBER(TO_CHAR(race_date, 'MM'), '99') BETWEEN 1 AND 6;

SELECT
    race_name,
    distance_km,
    CASE
        WHEN distance_km < 10 THEN 'Short'
        WHEN distance_km BETWEEN 10 AND 21 THEN 'Medium'
        WHEN distance_km BETWEEN 22 AND 44 THEN 'Long'
        ELSE 'Marathon'
    END AS race_category
FROM Races;  

SELECT 
    race_name,
    distance_km,
    CASE
        WHEN distance_km < 10 THEN 'Short'
        WHEN distance_km BETWEEN 10 AND 21 THEN 'Medium'
        WHEN distance_km BETWEEN 22 AND 44 THEN 'Long'
        ELSE 'Marathon'
    END AS race_category
FROM Races;  

SELECT 
    runner_id,
    first_name,
    last_name,
    gender,
    CASE gender
        WHEN 'M' THEN 'Male'
        WHEN 'F' THEN 'Female'
        ELSE 'Not Specified'
    END AS gender_full
FROM Runners;

