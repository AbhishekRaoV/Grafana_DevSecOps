SELECT
  sd.time1,
  COALESCE(cd_bug.total_hours, 0) as total_hours_bug,
  COALESCE(cd_requirement.total_hours, 0) as total_hours_requirement,
  CASE
    WHEN COALESCE(cd_bug.total_hours, 0) + COALESCE(cd_requirement.total_hours, 0) = 0 THEN 0
    ELSE ROUND((COALESCE(cd_bug.total_hours, 0) / (COALESCE(cd_bug.total_hours, 0) + COALESCE(cd_requirement.total_hours, 0))) * 100, 2)
  END as percentage_bug,
  CASE
    WHEN COALESCE(cd_bug.total_hours, 0) + COALESCE(cd_requirement.total_hours, 0) = 0 THEN 0
    ELSE ROUND((COALESCE(cd_requirement.total_hours, 0) / (COALESCE(cd_bug.total_hours, 0) + COALESCE(cd_requirement.total_hours, 0))) * 100, 2)
  END as percentage_requirement

FROM (
  SELECT 'Sprint 10' as time1
  UNION
  SELECT 'Sprint 11' as time1
  UNION
  SELECT 'Sprint 12' as time1
) AS sd
LEFT JOIN (
  SELECT
    time1,
    COALESCE(ROUND(SUM(TIMESTAMPDIFF(HOUR, created_date, updated_date)), 2), 0) as total_hours
  FROM (
    SELECT
      'Sprint 10' as time1,
      created_date,
      updated_date
    FROM issues
    WHERE
      created_date >= '2024-01-08 00:00:00.000' AND
      created_date <= '2024-02-05 23:59:59.999' AND status = 'DONE' AND type = 'BUG'

    UNION ALL

    SELECT
      'Sprint 11' as time1,
      created_date,
      updated_date
    FROM issues
    WHERE
      created_date >= '2024-02-07 00:00:00.000' AND
      created_date <= '2024-03-01 23:59:59.999' AND status = 'DONE' AND type = 'BUG'

    UNION ALL

    SELECT
      'Sprint 12' as time1,
      created_date,
      updated_date
    FROM issues
    WHERE
      created_date >= '2024-03-04 00:00:00.000' AND
      created_date <= '2024-03-15 23:59:59.999' AND status = 'DONE' AND type = 'BUG'
  ) AS subquery
  GROUP BY time1
) AS cd_bug ON sd.time1 = cd_bug.time1 OR (sd.time1 IS NULL AND cd_bug.time1 IS NULL)
LEFT JOIN (
  SELECT
    time1,
    COALESCE(ROUND(SUM(TIMESTAMPDIFF(HOUR, created_date, updated_date)), 2), 0) as total_hours
  FROM (
    SELECT
      'Sprint 10' as time1,
      created_date,
      updated_date
    FROM issues
    WHERE
      created_date >= '2024-01-08 00:00:00.000' AND
      created_date <= '2024-02-05 23:59:59.999' AND status = 'DONE' AND type = 'REQUIREMENT'

    UNION ALL

    SELECT
      'Sprint 11' as time1,
      created_date,
      updated_date
    FROM issues
    WHERE
      created_date >= '2024-02-29 00:00:00.000' AND
      created_date <= '2024-03-01 23:59:59.999' AND status = 'DONE' AND type = 'REQUIREMENT'

    UNION ALL

    SELECT
      'Sprint 12' as time1,
      created_date,
      updated_date
    FROM issues
    WHERE
      created_date >= '2024-03-04 00:00:00.000' AND
      created_date <= '2024-03-15 23:59:59.999' AND status = 'DONE' AND type = 'REQUIREMENT'
  ) AS subquery
  GROUP BY time1
) AS cd_requirement ON sd.time1 = cd_requirement.time1 OR (sd.time1 IS NULL AND cd_requirement.time1 IS NULL);
