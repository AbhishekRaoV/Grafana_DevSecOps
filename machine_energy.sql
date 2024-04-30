SELECT 
    SUM(CASE WHEN cpu_model = 'Intel(R) Xeon(R) Platinum 8488C' THEN energy_consumed END) * 1000 / 60 * 25*1500 AS intel,
    SUM(CASE WHEN cpu_model = 'AMD EPYC 9R14' THEN energy_consumed END) * 1000 / 60 * 21*1260 AS amd
FROM mysql.project_data;
