SELECT (SUM(energy_consumed) * (SELECT carbon_intensity FROM mysql.carbon_intensity WHERE region='us-east-1')) AS amd
FROM (
    SELECT energy_consumed
    FROM mysql.project_data
    WHERE cpu_model = 'AMD EPYC 9R14'
) AS filtered_data;

