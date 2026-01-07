


SELECT
    job_title_short as job_title,
    job_location as location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS posted_date_est
FROM
    job_postings_fact
LIMIT 10;
    
SELECT
    job_title_short as job_title,
    job_location as location,
    job_posted_date :: date as posted_date,
    EXTRACT(DAY FROM job_posted_date) AS posted_day,
    EXTRACT(MONTH FROM job_posted_date) AS posted_month
FROM
    job_postings_fact
LIMIT 10;


CREATE TABLE january_jobs AS
    SELECT *
    FROM
        job_postings_fact
    WHERE
        EXTRACT(MONTH FROM job_posted_date) = 1;

-- February jobs
CREATE TABLE february_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- March jobs
CREATE TABLE march_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

select COUNT(*) AS january_job_count,
        EXTRACT(DAY FROM job_posted_date) AS posted_day
 FROM january_jobs
 GROUP BY posted_day
 ORDER BY posted_day;