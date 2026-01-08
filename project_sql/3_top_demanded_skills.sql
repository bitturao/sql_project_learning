/*
What are the top demanded skills for  data engineer jobs?
- Join job postings to inner join table similar to query 2
- identify top 10 skills for data engineer jobs
- focus on all job postings jobs
*/


SELECT 
    skills,
    COUNT(skills_job_dim.skill_id) AS demand_count
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short LIKE '%Data Engineer%'
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 10;