SELECT
    CONCAT(
        IF(
            AVG(TIMESTAMPDIFF(DAY, created_date, updated_date)) > 0,
            CONCAT(ROUND(AVG(TIMESTAMPDIFF(DAY, created_date, updated_date))), 'days'),
            '0days'
        ),
        IF(
            AVG(TIME_FORMAT(TIMEDIFF(updated_date, created_date), '%H')) > 0,
            CONCAT(ROUND(AVG(TIME_FORMAT(TIMEDIFF(updated_date, created_date), '%H'))), 'hours'),
            '0hours'
        ),
        IF(
            AVG(TIME_FORMAT(TIMEDIFF(updated_date, created_date), '%i')) > 0,
            CONCAT(ROUND(AVG(TIME_FORMAT(TIMEDIFF(updated_date, created_date), '%i'))), 'mins'),
            '0mins'
        )
    ) AS avg_days_and_hours_difference
FROM
    issues
WHERE
    created_date >= '2024-02-26 00:00:00.000' AND status = 'DONE';
