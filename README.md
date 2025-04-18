- Introduction

# Background
The questions I wanted to answer included: 
- 1) What are the top paying jobs in Data Science 
- 2) What are the skills required 

/*
Question 1: What are the top 10 highest paying Data Science roles? 

Salary- degree of influence of factors such as location, seniority of position

OUTPUTS:
1) created "CTE" (virtual table) joining company name  to the job posting table, discarding any null salary values and filtered to Data science jobs to satifiy investigation.

2) the top 10 highest paying data science jobs.
OUTPUT = Barplot (aveage salary, company, with location in bar)

Analysis of results: Selby J, Glocomms and Netflix appear multiple times, repeated entries from the same companies in the top 10 can suggest either a high volume of lucrative postings from those employers and/or a range of similar high-salary roles in their data science teams. Based on plot Some Senior roles (e.g., MSP Staffing, WhatsApp) offer lower pay than some non-Senior ones (e.g., East River Electric).This suggests that seniority titles alone aren't always tied to pay — employer, location, and job description might weigh more heavily. !! add comment about job location not appearing as a factor as such currently. 
For an inital inspection, there were genreal insights gained, but a deeper investigation of salary was required to observer/measure degree of influence of Senority, Company and Location have towards salary of data scientist. 

- Average salaries compared to the maximum values inidcates the presense of an outlier. 

3) salaries according to senority of data science job postiion. 
OUTPUT: 2 row table, few summary stats to observe influence of senoirty 

4) salaries according to location of job role.

5) salaries according to company (highest average salary) 

-- Identify the top 10 highest paying Data Science job that are avilable remotely 
-- Focuses on job postings with specified salaries (remove nulls) 
-- Why? Highlight the top-paying oportunities for Data Science, offering insight into

NOTES:
-- virtual table was used to allow resuse across all scripts and queries
keeps logic clean and cenralised. 
*/

/* 
Question 2: What are the skills required for top-paying data science roles? 

-- Recall top 10 highest paying job roles for Data Science from query 1 
-- Add skills labels
-- Why? to provide a detailed look at which high-paying jobs demand certain skills,
allowing job seekers to understand which skils to develop to align with top salaries

NOTES:
-- duplicate readings for job ID as more than 1 skill was required. 
-- temp table added as only referencing this table layout in this querry
CT
*/


# Tools I used
- SQL
- PostgreSQL
- Visual Studio Code
- Git & Github: Essential for version control and sharing SQl scripts and analysis 

* ! add justififcation as to why SQL qas prilamilairy used, when in fact vscode wouldve been more optimal for futher manipulation and analysis opposed to SQL. mention size and aim of the project. 
# The Analysis

Rememeber to make comments sych as:
Insight: “Senior roles earn on average 60% more than junior roles; Company X pays 20% above the market average.”

# What I learned
# Conclusions 

Editing:
# Header 1
## Header 2
### Header 3

link to sql queries: [PostgreSQL/Projects folder] (/Projects/1_top_paying_jobs_DataScience_23.sql/) --FIX 

### TL;DR

- experct cvs results
- draw up conclusions and rewrite questions and aims around the querries (need to merge the questions together )