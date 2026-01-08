/*
What skills are associated with the highest paying jobs?
- use the top 10 highest paying jobs from query 1_top_paying_jobs.sql
- ADD the skills associated with those jobs
*/



WITH top_paying_jobs AS (
SELECT
    job_title_short as job_title,
    job_postings_fact.job_id,
    job_location as location,
    job_posted_date :: date as posted_date,
    salary_year_avg as average_salary,
    company_dim.name as company_name
FROM
    job_postings_fact
LEFT JOIN
    company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short LIKE '%Data Engineer%'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
    INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id;