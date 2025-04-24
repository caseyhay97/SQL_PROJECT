
-- Create View: Filtered Data Scientist Job Postings with Salary and Company Info
CREATE OR REPLACE VIEW data_science_salaries AS
SELECT 
    salary_year_avg,
    job_id,
    job_title_short,
    job_location,
    job_work_from_home,
    name AS company_name

FROM 
    job_postings_fact

LEFT JOIN company_dim ON 
    company_dim.company_id = job_postings_fact.company_id

WHERE salary_year_avg IS NOT NULL
    AND job_title_short LIKE '%Data Scientist%'

ORDER BY salary_year_avg DESC;

-- Top 10 Highest-Paying Data Scientist Roles
SELECT *
FROM data_science_salaries
LIMIT 10;

-- Salary Distribution by Job Title (Seniority Levels)
SELECT
    job_title_short,
    MIN(salary_year_avg) AS min_salary,
    MAX(salary_year_avg) AS max_salary,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary_year_avg) AS median_salary,
    ROUND(AVG(salary_year_avg),1) AS average_salary,
    COUNT(job_id) AS number_positions
    
FROM data_science_salaries
GROUP BY job_title_short;

-- Salary and Job Availability by Geographic Location
SELECT
    job_location,
    ROUND(AVG(salary_year_avg),1) AS average_salary,
    MIN(salary_year_avg) AS min_salary,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary_year_avg) AS median_salary,
    MAX(salary_year_avg) AS max_salary,
    COUNT(job_id) AS number_of_job_postings,
    SUM(CASE
        WHEN job_title_short LIKE '%Senior%' THEN 1
        ELSE 0
    END) AS number_of_senior_positions

FROM data_science_salaries
WHERE job_location IS NOT NULL
GROUP BY job_location;

-- Company-Level Salary Insights and Remote Job Availability
SELECT
    company_name,
    MIN(salary_year_avg) AS min_salary,
    MAX(salary_year_avg) AS max_salary,
    ROUND(AVG(salary_year_avg),1) AS average_salary,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary_year_avg) AS median_salary,
    COUNT(job_id) AS number_of_job_postings,
    COUNT(job_location) AS number_of_different_locations,
    SUM(CASE 
        WHEN job_work_from_home = TRUE THEN 1
        ELSE 0
        END) AS number_of_remote_jobs 
FROM data_science_salaries
GROUP BY company_name
ORDER BY average_salary DESC;
