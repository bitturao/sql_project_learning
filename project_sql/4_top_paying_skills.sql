/*
What are the top skills based on salary offered for Data Engineer jobs?
-Look at the average salary for each skill for Data Engineer jobs
- Focused on all job postings jobs
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short LIKE '%Data Engineer%'
    AND salary_year_avg IS NOT NULL
GROUP BY 
    skills
ORDER BY
    average_salary DESC
LIMIT 30;


/*Expected Output:
[
  {
    "skills": "arch",
    "average_salary": "249000"
  },
  {
    "skills": "mxnet",
    "average_salary": "176664"
  },
  {
    "skills": "ggplot2",
    "average_salary": "176250"
  },
  {
    "skills": "mongo",
    "average_salary": "176119"
  },
  {
    "skills": "node",
    "average_salary": "175807"
  },
  {
    "skills": "solidity",
    "average_salary": "166250"
  },
  {
    "skills": "cassandra",
    "average_salary": "156724"
  },
  {
    "skills": "vue",
    "average_salary": "155417"
  },
  {
    "skills": "codecommit",
    "average_salary": "155000"
  },
  {
    "skills": "rust",
    "average_salary": "151361"
  },
  {
    "skills": "ubuntu",
    "average_salary": "150071"
  },
  {
    "skills": "shell",
    "average_salary": "149303"
  },
  {
    "skills": "opencv",
    "average_salary": "148125"
  },
  {
    "skills": "drupal",
    "average_salary": "147500"
  },
  {
    "skills": "gatsby",
    "average_salary": "147500"
  },
  {
    "skills": "next.js",
    "average_salary": "147500"
  },
  {
    "skills": "kafka",
    "average_salary": "147097"
  },
  {
    "skills": "scala",
    "average_salary": "146949"
  },
  {
    "skills": "angular",
    "average_salary": "146583"
  },
  {
    "skills": "mysql",
    "average_salary": "145363"
  },
  {
    "skills": "splunk",
    "average_salary": "145300"
  },
  {
    "skills": "redshift",
    "average_salary": "145249"
  },
  {
    "skills": "keras",
    "average_salary": "144968"
  },
  {
    "skills": "zoom",
    "average_salary": "144245"
  },
  {
    "skills": "numpy",
    "average_salary": "144188"
  },
  {
    "skills": "couchdb",
    "average_salary": "144167"
  },
  {
    "skills": "redis",
    "average_salary": "143495"
  },
  {
    "skills": "kubernetes",
    "average_salary": "143413"
  },
  {
    "skills": "openstack",
    "average_salary": "143150"
  },
  {
    "skills": "clojure",
    "average_salary": "143052"
  }
]
*/