select 
    job_title_short as job_title,
    company_id,
    job_location as location
from
    january_jobs
UNION
select 
    job_title_short as job_title,
    company_id,
    job_location as location
from
    february_jobs
UNION
select 
    job_title_short as job_title,
    company_id,
    job_location as location
from
    march_jobs



select 
    job_title_short as job_title,
    company_id,
    job_location as location
from
    january_jobs
UNION ALL
select 
    job_title_short as job_title,
    company_id,
    job_location as location
from
    february_jobs
UNION   ALL
select 
    job_title_short as job_title,
    company_id,
    job_location as location
from
    march_jobs