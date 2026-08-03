-- 10 advanced SQL practice queries for the Runners database

-- 1. Find the fastest runner in each race using window function
SELECT race_name, runner_name, finish_time, position
FROM (
    SELECT r.race_name,
           ru.first_name || ' ' || ru.last_name AS runner_name,
           rr.finish_time,
           rr.position,
           ROW_NUMBER() OVER (PARTITION BY r.race_id ORDER BY rr.finish_time) AS rn
    FROM Race_Results rr
    JOIN Races r ON rr.race_id = r.race_id
    JOIN Runners ru ON rr.runner_id = ru.runner_id
) ranked
WHERE rn = 1
ORDER BY race_name;

-- 2. Find runners who finished in the top 2 positions in at least 2 races
SELECT runner_name, top2_races
FROM (
    SELECT ru.first_name || ' ' || ru.last_name AS runner_name,
           COUNT(*) AS top2_races
    FROM Race_Results rr
    JOIN Runners ru ON rr.runner_id = ru.runner_id
    WHERE rr.position IN (1, 2)
    GROUP BY ru.runner_id, ru.first_name, ru.last_name
) t
WHERE top2_races >= 2
ORDER BY top2_races DESC;

-- 3. Compare each runner's finish time to the average finish time for that race
SELECT r.race_name,
       ru.first_name || ' ' || ru.last_name AS runner_name,
       rr.finish_time,
       AVG(rr.finish_time::time) OVER (PARTITION BY r.race_id) AS avg_finish_time_for_race
FROM Race_Results rr
JOIN Races r ON rr.race_id = r.race_id
JOIN Runners ru ON rr.runner_id = ru.runner_id
ORDER BY r.race_name, rr.position;

-- 4. Find the race with the highest prize money per kilometer
SELECT race_name, location, prize_money, distance_km,
       ROUND(prize_money / distance_km, 2) AS prize_per_km
FROM Races
ORDER BY prize_per_km DESC
LIMIT 1;

-- 5. Find runners whose birth year is before the average birth year of all runners
SELECT first_name, last_name, birth_date
FROM Runners
WHERE EXTRACT(YEAR FROM birth_date) < (
    SELECT AVG(EXTRACT(YEAR FROM birth_date))
    FROM Runners
)
ORDER BY birth_date;

-- 6. Use a CTE to find the top 3 runners by total prize money
WITH runner_prizes AS (
    SELECT ru.runner_id,
           ru.first_name || ' ' || ru.last_name AS runner_name,
           COALESCE(SUM(rr.prize_won), 0) AS total_prize_money
    FROM Runners ru
    LEFT JOIN Race_Results rr ON ru.runner_id = rr.runner_id
    GROUP BY ru.runner_id, ru.first_name, ru.last_name
)
SELECT runner_name, total_prize_money
FROM runner_prizes
ORDER BY total_prize_money DESC
LIMIT 3;

-- 7. Find races where the winner's prize money was more than the average prize money of all races
SELECT r.race_name,
       ru.first_name || ' ' || ru.last_name AS winner,
       r.prize_money AS race_prize_money
FROM Race_Results rr
JOIN Races r ON rr.race_id = r.race_id
JOIN Runners ru ON rr.runner_id = ru.runner_id
WHERE rr.position = 1
  AND r.prize_money > (
      SELECT AVG(prize_money)
      FROM Races
  )
ORDER BY r.prize_money DESC;

-- 8. Count runners by decade of birth
SELECT CONCAT(EXTRACT(YEAR FROM birth_date) / 10 * 10, 's') AS birth_decade,
       COUNT(*) AS runner_count
FROM Runners
GROUP BY CONCAT(EXTRACT(YEAR FROM birth_date) / 10 * 10, 's')
ORDER BY birth_decade;

-- 9. Find the runner with the most podium finishes (positions 1, 2, 3)
SELECT runner_name, podium_finishes
FROM (
    SELECT ru.first_name || ' ' || ru.last_name AS runner_name,
           COUNT(*) AS podium_finishes
    FROM Race_Results rr
    JOIN Runners ru ON rr.runner_id = ru.runner_id
    WHERE rr.position BETWEEN 1 AND 3
    GROUP BY ru.runner_id, ru.first_name, ru.last_name
) podium
ORDER BY podium_finishes DESC
LIMIT 1;

-- 10. Show each race with its winner and whether the winner was a male or female runner
SELECT r.race_name,
       ru.first_name || ' ' || ru.last_name AS winner,
       ru.gender,
       rr.position
FROM Race_Results rr
JOIN Races r ON rr.race_id = r.race_id
JOIN Runners ru ON rr.runner_id = ru.runner_id
WHERE rr.position = 1
ORDER BY r.race_date;
