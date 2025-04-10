/* 
Question 1: What are the top 10 highest paying Data Science roles? 

-- Identify the top 10 highest paying Data Science job that are avilable remotely 
-- Focuses on job postings with specified salaries (remove nulls) 
-- Why? Highlight the top-paying oportunities for Data Science, offering insight into

NOTES:
-- virtual table was used to allow resuse across all scripts and queries
keeps logic clean and cenralised. 
*/

-- Created and the 'view' (virtual table) with job information related to Data Scientist
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

-- Top 10 highest paying jobs
SELECT *
FROM data_science_salaries
LIMIT 10;

-- Minimum & maximum salary according to seniority of position
SELECT
    job_title_short,
    MIN(salary_year_avg) AS min_salary,
    MAX(salary_year_avg) AS max_salary,
    COUNT(job_id) AS number_positions,
    ROUND(AVG(salary_year_avg),1) AS average_salary
FROM data_science_salaries
GROUP BY job_title_short;

-- Minimum & maximum salary according to locations
SELECT
    job_location,
    MIN(salary_year_avg) AS min_salary,
    MAX(salary_year_avg) AS max_salary,
    COUNT(job_id) AS number_of_job_postings,
    ROUND(AVG(salary_year_avg),1) AS average_salary,
    SUM(CASE
        WHEN job_title_short LIKE '%Senior%' THEN 1
        ELSE 0
    END) AS number_of_senior_positions

FROM data_science_salaries
WHERE job_location IS NOT NULL
GROUP BY job_location;


-- Salary & job data according to company
SELECT
    company_name,
    MIN(salary_year_avg) AS min_salary,
    MAX(salary_year_avg) AS max_salary,
    ROUND(AVG(salary_year_avg),1) AS average_salary,
    COUNT(job_id) AS number_of_job_postings,
    COUNT(job_location) AS number_of_different_locations,
    SUM(CASE 
        WHEN job_work_from_home = 'TRUE' THEN 1
        ELSE 0
        END) AS number_of_remote_jobs 
FROM data_science_salaries
GROUP BY company_name
ORDER BY number_of_job_postings DESC;

-- label the 'type of skills column' as too many different categories
-- does not provide enough detail to draw any meaningful insights. 