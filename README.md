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

3) salaries according to senority of data science job postiion. 

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
📊 Insight: “Senior roles earn on average 60% more than junior roles; Company X pays 20% above the market average.”
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