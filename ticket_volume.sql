SELECT
  sd.time1,
  COALESCE(cd.number_of_issues, 0) as number_of_issues
FROM (
  SELECT 'Sprint 9' as time1
  UNION
  SELECT 'Sprint 10' as time1
  UNION
  SELECT 'Sprint 11' as time1
) AS sd
LEFT JOIN (
  SELECT
    time1,
    count(*) as number_of_issues
  FROM (
    SELECT
      'Sprint 9' as time1
    FROM issues
    WHERE
      created_date >= '2023-12-18 00:00:00.000' AND
      created_date <= '2024-01-02 23:59:59.999'

    UNION ALL

    SELECT
      'Sprint 10' as time1
    FROM issues
    WHERE
      created_date >= '2024-01-08 00:00:00.000' AND
      created_date <= '2024-02-05 23:59:59.999'

    UNION ALL

    SELECT
      'Sprint 11' as time1
    FROM issues
    WHERE
      created_date >= '2024-02-12 00:00:00.000' AND
      created_date <= '2024-02-24 23:59:59.999'
  ) AS subquery
  GROUP BY time1
) AS cd ON sd.time1 = cd.time1 OR (sd.time1 IS NULL AND cd.time1 IS NULL);
