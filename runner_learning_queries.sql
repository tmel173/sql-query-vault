-- 10 SQL practice queries for the Runners learning database

-- 1. View all runners
SELECT runner_id, first_name, last_name, gender, birth_date
FROM Runners
ORDER BY last_name, first_name;

-- 2. View all races
SELECT race_id, race_name, location, race_date, distance_km, surface_type, prize_money
FROM Races
ORDER BY race_date;

-- 3. Find all female runners
SELECT first_name, last_name
FROM Runners
WHERE gender = 'F'
ORDER BY last_name;

-- 4. Find races held in 2024
SELECT race_name, location, race_date
FROM Races
WHERE EXTRACT(YEAR FROM race_date) = 2024
ORDER BY race_date;

-- 5. Show race results with runner and race names
SELECT r.race_name,
       ru.first_name || ' ' || ru.last_name AS runner_name,
       rr.position,
       rr.finish_time,
       rr.prize_won
FROM Race_Results rr
JOIN Races r ON rr.race_id = r.race_id
JOIN Runners ru ON rr.runner_id = ru.runner_id
ORDER BY r.race_date, rr.position;

-- 6. Show the winner of each race
SELECT r.race_name,
       ru.first_name || ' ' || ru.last_name AS winner,
       rr.finish_time
FROM Race_Results rr
JOIN Races r ON rr.race_id = r.race_id
JOIN Runners ru ON rr.runner_id = ru.runner_id
WHERE rr.position = 1
ORDER BY r.race_date;

-- 7. Count runners by gender
SELECT gender, COUNT(*) AS runner_count
FROM Runners
GROUP BY gender
ORDER BY gender;

-- 8. Find races with prize money greater than 100000
SELECT race_name, location, prize_money
FROM Races
WHERE prize_money > 100000
ORDER BY prize_money DESC;

-- 9. Find runners who participated in more than one race
SELECT ru.runner_id,
       ru.first_name,
       ru.last_name,
       COUNT(*) AS races_participated
FROM Runners ru
JOIN Race_Results rr ON ru.runner_id = rr.runner_id
GROUP BY ru.runner_id, ru.first_name, ru.last_name
HAVING COUNT(*) > 1
ORDER BY races_participated DESC;

-- 10. Find total prize money won by each runner
SELECT ru.runner_id,
       ru.first_name,
       ru.last_name,
       COALESCE(SUM(rr.prize_won), 0) AS total_prize_money
FROM Runners ru
LEFT JOIN Race_Results rr ON ru.runner_id = rr.runner_id
GROUP BY ru.runner_id, ru.first_name, ru.last_name
ORDER BY total_prize_money DESC;

Select * 
from Runners
Where first_name LIKE 'Av%';

SELECT first_name, last_name, COUNT(*)
FROM runners
WHERE first_name LIKE '%rt';
GROUP BY first_name, last_name;

SELECT first_name, last_name, COUNT(*)
FROM Runners
WHERE first_name IN ('Noah', 'Albert', 'Sophia')
GROUP BY first_name, last_name;

-- Show each runner name only once
SELECT DISTINCT first_name, last_name
FROM Runners
ORDER BY last_name, first_name;
