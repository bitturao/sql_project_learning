/*
find job postings from the first quarter (Jan, Feb, Mar) that have a salary greater than $70,000
- combine jobpostings tables from january_jobs, february_jobs, march_jobs
- get job postings with average_salary > 70000
*/


select 
    first_quarter_jobs.job_title_short as job_title,
    first_quarter_jobs.job_location as location,
    first_quarter_jobs.job_via as job_posted_via,
    first_quarter_jobs.job_posted_date :: date as posted_date,
    first_quarter_jobs.salary_year_avg

from(
    select *    
    from 
        january_jobs
    UNION ALL
    select *
    from
         february_jobs
    UNION ALL
    select *
    from 
    march_jobs
) as first_quarter_jobs
WHERE 
    first_quarter_jobs.salary_year_avg > 70000
ORDER BY 
    first_quarter_jobs.salary_year_avg DESC;