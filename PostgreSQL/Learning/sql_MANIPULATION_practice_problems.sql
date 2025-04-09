/*
Section includes:
-- Date functions
-- CASE expression (if/else similiar)
-- Subqueries and CTEs


*/


-- Date functions 

-- setting and changing TIMEZONES
-- extract MONTH from data 
-- useful for trend analysis

SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS date_month
FROM 
    job_postings_fact
LIMIT (5);

-- Counting number of job_ids /month AGGREGATION 

SELECT 
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM
    job_postings_fact
GROUP BY
    month
ORDER BY 
    job_posted_count DESC;


-- Practice Problem 6
--      create table of january, feb, march jobs in seperate tables

\-- January
CREATE TABLE public.jan_jobs AS 
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

-- Febuary
CREATE TABLE public.feb_jobs AS 
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- March
CREATE TABLE public.march_jobs AS 
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;   

-- confirming work
SELECT job_posted_date
FROM march_jobs


/* CASE expression 

Similiar to IF/ELSE statements 
Allows user to apply conditional logic to values in your queries 

Label new column as follows:
-- 'Anywhere' jobs as 'Remote'
-- 'New York' as 'Local'
--  Otherwsie 'Onsite' 

*/

-- Adding new column categorising job location
SELECT
    job_title_short,
    job_location,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
LIMIT 10;

-- Number Data Analyst jobs in each loaction category
SELECT
    COUNT(job_id) AS number_of_jobs,
    -- COUNT needs t be used in aggregate function 
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY 
    location_category
LIMIT 10;

-- Subqueries (query inside another query)
/*
Return company names from Company_dim 
ONLY if they require degree using 'Comapny_id' and job_no_degree_mention from Job_posting facts 

*/

-- Company names from job posting requiring a degree
-- MULTIPLE tables used
SELECT
    name AS company_name,
    company_id
FROM company_dim
WHERE company_id IN (
    SELECT
        company_id
    FROM 
        job_postings_fact
    WHERE
        job_no_degree_mention = true
    ORDER BY
        company_id
)
; 

/* 

Using temporary results set:

Find company that have the most job openings 
- Total number of jobs per company_id
- Total number of jobs with the company name
*/

WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) as number_of_jobs
    FROM 
        job_postings_fact
    GROUP BY 
        company_id 
)

SELECT 
    company_dim.name AS company_name,
    company_job_count.number_of_jobs
FROM company_dim
LEFT JOIN company_job_count ON
     company_job_count.company_id = company_dim.company_id
ORDER BY
 number_of_jobs DESC;

/*

Practice Problem 7 
Count the number of remote jobs per skill
    - Display top 5 skills by their demand in remote jobs
    - Include skill ID, name, count of job posting requiring skill

My solution:
 Temporary output table:
    - left joined skills_dim with job_posting_facts to retrive skill_id (via job_id)
    - counted number of job_ids per skil_id 
    - filtered to jobs labelled 'Anywhere'
Left joined skills dm to get the skill role via the skill id in new temporart table created. 

+ then new filter added for data analyst!
*/

WITH skills_per_job_count AS (
    SELECT
        skills_job_dim.skill_id,
         COUNT(job_postings_fact.job_id) AS number_of_jobs 
    FROM 
        job_postings_fact

    LEFT JOIN skills_job_dim 
        ON skills_job_dim.job_id = job_postings_fact.job_id

    WHERE job_location = 'Anywhere' 
    -- (also filter for only data analysts)
    AND job_postings_fact.job_title_short = 'Data Analyst'

    GROUP BY skills_job_dim.skill_id
    )

SELECT 
    skills_per_job_count.skill_id,
    skills_dim.skills,
    skills_per_job_count.number_of_jobs

FROM 
    skills_per_job_count

LEFT JOIN skills_dim 
    ON skills_dim.skill_id = skills_per_job_count.skill_id

ORDER BY number_of_jobs DESC
LIMIT 5;


/*

Practice Problem 8: 

Find job posting tables from the first quarter that have a salary greater than $70K

*/

SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) < 4
    AND salary_year_avg > 70000
