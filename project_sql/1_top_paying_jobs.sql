/*
-Identifying the top 10 highest paying Data jobs that are available remotely.
- Focus on job postings with specified salaries
*/


SELECT
    job_title_short as job_title,
    job_location as location,
    job_via as job_posted_via,
    job_schedule_type as job_schedule,
    job_posted_date :: date as posted_date,
    salary_year_avg as average_salary,
    company_dim.name as company_name
FROM
    job_postings_fact
LEFT JOIN
    company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short LIKE '%Data%'
    AND job_location LIKE '%Remote%'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;