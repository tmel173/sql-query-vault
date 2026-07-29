SELECT check_date
FROM Pay_Periods
WHERE check_date >= '2026-07-01'
  AND check_date < '2026-08-01'
ORDER BY check_date;