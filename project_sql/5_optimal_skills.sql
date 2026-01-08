/*
The high paying skills and most in demand skills from query 3 and 4 can be combined
 to identify skills that are optimal for Data Engineer roles.
- Identify skills that are both high paying and in demand for Data Engineer roles
- Use the results from query 3_top_demanded_skills.sql and 4_top_paying_skills.sql
- Focus on skills that appear in both the top 10 demanded skills and top 30 high paying skills
*/



-- WITH skills_demand AS (
--     SELECT 
--         skills_dim.skill_id,
--         skills_dim.skills,
--         COUNT(skills_job_dim.skill_id) AS demand_count
--     FROM job_postings_fact
--         INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
--         INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
--     WHERE
--         job_title_short LIKE '%Data Engineer%' AND
--         salary_year_avg IS NOT NULL
--     GROUP BY 
--         skills_dim.skill_id
        
-- ),
-- average_salary AS(
--         SELECT 
--             skills_dim.skill_id as id,
--             skills_dim.skills,
--             ROUND(AVG(salary_year_avg), 0) AS average_salary
--     FROM job_postings_fact
--         INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
--         INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
--     WHERE
--         job_title_short LIKE '%Data Engineer%'
--         AND salary_year_avg IS NOT NULL
--     GROUP BY
--         skills_dim.skill_id
        
-- )


-- SELECT 
--     sd.skills,
--     sd.demand_count,
--     asalary.average_salary
-- FROM skills_demand AS sd
-- INNER JOIN average_salary AS asalary ON sd.skill_id = asalary.id
-- WHERE
--     sd.demand_count > 10
-- ORDER BY
--     asalary.average_salary DESC,
--     sd.demand_count DESC
-- LIMIT 10;


SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.skill_id) AS demand_count,
    ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short LIKE '%Data Engineer%'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.skill_id) > 10
ORDER BY
    average_salary DESC,
    demand_count DESC
LIMIT 10;
    
