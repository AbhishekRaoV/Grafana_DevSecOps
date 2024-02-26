SELECT
    CONCAT(
        IF(
            AVG(TIMESTAMPDIFF(DAY, created_date, updated_date)) > 0,
            CONCAT(ROUND(AVG(TIMESTAMPDIFF(DAY, created_date, updated_date))), 'Days'),
            '0 Days '
        ),
        IF(
            AVG(TIME_FORMAT(TIMEDIFF(updated_date, created_date), '%H')) > 0,
            CONCAT(ROUND(AVG(TIME_FORMAT(TIMEDIFF(updated_date, created_date), '%H'))), 'Hours'),
            '0 Hours '
        ),
        IF(
            AVG(TIME_FORMAT(TIMEDIFF(updated_date, created_date), '%i')) > 0,
            CONCAT(ROUND(AVG(TIME_FORMAT(TIMEDIFF(updated_date, created_date), '%i'))), ' Mins'),
            '0 Mins'
        )
    ) AS 'Sprint 11'
FROM
    issues
WHERE
    created_date >= '2024-02-26 00:00:00.000' AND status = 'DONE';
