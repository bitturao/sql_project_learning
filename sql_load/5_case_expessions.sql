SELECT
    count(job_id) AS total_jobs,
    CASE
        when job_location LIKE '%Remote%' THEN 'Remote'
        when job_location LIKE '%New York%' THEN 'New York'
        when job_location LIKE '%San Francisco%' THEN 'San Francisco'
        when job_location LIKE '%Los Angeles%' THEN 'Los Angeles'
        ELSE 'Other'
    END AS location_category
FROM
    job_postings_fact
WHERE
    job_title_short LIKE '%Data Engineer%'
GROUP BY
    location_category
LIMIT 10;


-- subqueries
SELECT 
    company_id,
    name as company_name
from company_dim
WHERE company_id IN (
    SELECT DISTINCT company_id
    FROM job_postings_fact
    WHERE job_title_short LIKE '%Data Scientist%'
);



--CTE
/*Find the companies with the highest number of job postings for 'Data Analyst' roles */
WITH data_analyst_jobs AS (
    SELECT 
        company_id,
        COUNT(job_id) AS total_jobs
    FROM 
        job_postings_fact
    WHERE 
        job_title_short LIKE '%Data Analyst%'
    GROUP BY 
        company_id
)



select 
    company_dim.name as company_name,
    data_analyst_jobs.total_jobs
from company_dim
LEFT JOIN data_analyst_jobs ON data_analyst_jobs.company_id = company_dim.company_id
ORDER BY data_analyst_jobs.total_jobs DESC


-- CTE 
-- find the count of number of remote jobs for skills

with remote_job_skills as(
select 
    
    skill_id,
    COUNT(*) as skill_count
from skills_job_dim as skills_to_job
INNER JOIN job_postings_fact as jobs ON jobs.job_id = skills_to_job.job_id
WHERE jobs.job_location LIKE '%Remote%'
GROUP BY skill_id
)

select 
    sd.skill_id,
    sd.skills as skills_name,
    rjs.skill_count
from remote_job_skills as rjs
INNER JOIN skills_dim as sd ON sd.skill_id = rjs.skill_id
ORDER BY rjs.skill_count DESC OFFSET 0
LIMIT 10;

--OFFSET is to skip number of rows