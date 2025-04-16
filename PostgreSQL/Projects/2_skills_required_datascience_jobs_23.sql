-- Top 10 highest paying Data Science roles 
SELECT *
FROM data_science_salaries
limit 10;

-- Joining corresponding skills required for Data Scientists
CREATE TEMP TABLE data_science_skills AS
SELECT 
    data_science_salaries.job_id,
    job_title_short,
    salary_year_avg,
    skills_job_dim.skill_id,
    skills_dim.skills as name_of_skill,
    skills_dim.type 

FROM data_science_salaries

LEFT JOIN skills_job_dim ON
    skills_job_dim.job_id =  data_science_salaries.job_id

LEFT JOIN skills_dim ON
    skills_dim.skill_id =  skills_job_dim.skill_id

ORDER BY salary_year_avg DESC;

-- skills joined into 1 column to observe full list of skills per top job_id 
WITH skills_one_column AS (
    SELECT
        data_science_skills.job_id,
        STRING_AGG(name_of_skill, ', ') AS required_skills,
        COUNT(skill_id) AS number_of_skills,
        COUNT(DISTINCT(type)) AS no_types_of_skills

    FROM data_science_skills

    GROUP BY data_science_skills.job_id
)

-- all skills for top 10 highest paying data science jobs
SELECT 
    data_science_salaries.job_title_short,
    data_science_salaries.salary_year_avg,
    skills_one_column.*

FROM skills_one_column

JOIN data_science_salaries ON
    data_science_salaries.job_id = skills_one_column.job_id

ORDER BY salary_year_avg DESC

LIMIT 10;

-- Skills required by Data Science jobs (hs = high salary) first part is a temporary list of top 100 hs data science job_ids
WITH top_100_hs_jobs AS (
    SELECT 
        job_id
    FROM
        data_science_skills
    WHERE salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 100
)

SELECT 
    name_of_skill,
    COUNT(data_science_skills.job_id) AS no_of_job_requiring_skill,
    COUNT(CASE 
        WHEN top_100_hs_jobs.job_id IS NOT NULL 
        THEN data_science_skills.job_id
        END) AS no_top_100_hs_job_mentions
FROM
    data_science_skills

LEFT JOIN top_100_hs_jobs ON
    top_100_hs_jobs.job_id = data_science_skills.job_id

WHERE name_of_skill IS NOT NULL
GROUP BY(name_of_skill, skill_id)
ORDER BY no_top_100_hs_job_mentions DESC
LIMIT 100;
 
   -- CASE
    --    WHEN job_location = 'Anywhere' THEN 'Remote'
     --   WHEN job_location = 'New York, NY' THEN 'Local'
     --   ELSE 'Onsite'
    --END AS location_category


