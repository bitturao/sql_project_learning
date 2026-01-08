# Introduction
📊 Dive into the data job market! Focusing on data engineer roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 SQL queries? Check them out here: [project_sql folder](/project_sql/)

# Background
Driven by a quest to navigate the data engineer job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

It's packed with insights on job titles, salaries, locations, and essential skills.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data engineer jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data engineers?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
For my deep dive into the data engineer job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data engineer job market. Here’s how I approached each question:

### 1. Top Paying Data related Jobs
To identify the highest-paying roles, I filtered data positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
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
```
Here's the breakdown of the top data jobs in 2023:

**Wide Salary Range:** Top paying data roles span from **$75,000 to $202,000**, highlighting strong earning potential across experience levels and organizations.  

**Diverse Employers:** Companies such as **Square, Apixio, Coinbase, Care.com, Thumbtack, Classy, Cisco, and Altruistic Informatics Consulting** are actively hiring, demonstrating demand across fintech, healthcare, e-commerce, SaaS, and enterprise technology sectors.  

**Job Title Variety:** Roles range from **Data Scientist** and **Senior Data Scientist** to **Senior Data Engineer** and **Data Engineer**, reflecting a diverse set of responsibilities across analytics, machine learning, and data infrastructure domains.  

📌 **Insight:** Senior-level roles command higher salaries, while entry and mid-level positions provide accessible entry points into the data industry, making this career path scalable for long-term growth.


### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
```sql
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
```

Here's the breakdown of the most demanded skills for the top-paying Data Engineer roles in 2023:

**Python** is leading with a bold count of **7**, highlighting its dominance in data pipelines and automation.  
**Spark / PySpark** follows closely with a bold count of **6**, reflecting strong demand for distributed data processing.  
**Kafka** and **Hadoop** are equally important, each showing a bold count of **4**, emphasizing real-time streaming and big data infrastructure needs.  
**SQL** appears with a bold count of **2**, reinforcing its importance for data querying and transformation.  

Other skills such as **Pandas**, **NumPy**, **Kubernetes**, **Databricks**, **AWS**, **GCP**, **Azure**, **Scala**, and **Machine Learning frameworks** show varying levels of demand, indicating specialization opportunities for high-growth roles.

📌 **Insight:** Mastering Python, Spark ecosystem, and streaming technologies significantly increases competitiveness for high-paying Data Engineer roles.



### 3. In-Demand Skills for Data Engineers

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
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
```
Here's the breakdown of the most demanded skills for data engineering roles in 2023:

**SQL and Python** remain fundamental, highlighting the importance of strong data querying, transformation, and automation capabilities.  

**Cloud and Big Data Technologies** such as **AWS, Azure, Spark, Kafka, and Snowflake** are essential, reflecting the growing demand for scalable data platforms and real-time data processing systems.

---

### 📋 Top 10 Skills Demand Table

| Skill       | Demand Count |
|--------------|----------------|
| SQL          | 142,062 |
| Python       | 137,245 |
| AWS          | 81,578 |
| Azure        | 77,054 |
| Spark        | 69,905 |
| Java         | 45,814 |
| Kafka        | 38,890 |
| Scala        | 37,453 |
| Hadoop       | 36,762 |
| Snowflake    | 35,821 |

📌 **Table:** Demand for the top 10 skills in data engineering job postings.

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.
```sql
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

```


Here's a breakdown of the results for top paying skills in data roles:

**Advanced Architecture, Big Data & ML Skills:**  
The highest salaries are associated with skills such as **ARCH ($249,000)**, **MXNet ($176,664)**, **OpenCV ($148,125)**, and **Keras ($144,968)**, highlighting the premium placed on system architecture knowledge, machine learning frameworks, and computer vision capabilities.

**Software Development & Deployment Proficiency:**  
Expertise in development and infrastructure tools like **Node.js ($175,807)**, **Rust ($151,361)**, **Shell scripting ($149,303)**, **Kubernetes ($143,413)**, and **CodeCommit ($155,000)** reflects strong demand for professionals who can build, deploy, and maintain scalable data-driven applications.

**Cloud, Streaming & Database Technologies:**  
Skills in **MongoDB ($176,119)**, **Cassandra ($156,724)**, **Kafka ($147,097)**, **Redshift ($145,249)**, **Redis ($143,495)**, and **OpenStack ($143,150)** emphasize the importance of cloud-native data storage, real-time data processing, and distributed systems expertise.

---

### 📋 Average Salary for Top Paying Skills

| Skill        | Average Salary ($) |
|--------------|--------------------|
| ARCH         | 249,000 |
| MXNet        | 176,664 |
| ggplot2     | 176,250 |
| MongoDB     | 176,119 |
| Node.js     | 175,807 |
| Solidity    | 166,250 |
| Cassandra   | 156,724 |
| Vue.js      | 155,417 |
| CodeCommit  | 155,000 |
| Rust        | 151,361 |

📌 **Table:** Average salary for the top 10 paying skills across data engineer roles.


### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
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
```


| Skill ID | Skills   | Demand Count | Average Salary ($) |
|----------|----------|--------------|--------------------|
| 24       | mongo    | 239          | 176,119            |
| 154      | node     | 39           | 175,807            |
| 63       | cassandra| 432          | 156,724            |
| 39       | rust     | 30           | 151,361            |
| 6        | shell    | 569          | 149,303            |
| 98       | kafka    | 1,319        | 147,097            |
| 3        | scala    | 1,222        | 146,949            |
| 136      | angular  | 54           | 146,583            |
| 56       | mysql    | 612          | 145,363            |
| 193      | splunk   | 71           | 145,300            |

### Insights on in-demand and high-paying skills for Data Engineers

- **High-paying backend and database tech:** MongoDB and Node.js offer the highest average salaries (around $176K and $176K), reflecting their strong value in scalable web and data systems.  
- **Distributed systems & streaming:** Kafka and Scala have very high demand counts (1,319 and 1,222), showing the importance of real-time data pipelines and big data processing.  
- **Performance-oriented languages:** Rust shows relatively low demand but high pay, indicating niche, high-impact use cases in performance-critical infrastructure.  
- **Core scripting for automation:** Shell has the highest demand (569) among these skills, underlining its central role in automation, DevOps, and data engineering workflows.  
- **Mature but essential tools:** MySQL and Splunk maintain strong demand and competitive salaries, emphasizing ongoing need for reliable storage, logging, and monitoring in production data environments.

# What I Learned

Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- **🧩 Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
- **📊 Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- **💡 Analytical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# Conclusions

### Insights
From the analysis, several general insights emerged:

1. **Top-Paying Data related Jobs**: The highest-paying jobs for data engineers that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs**: High-paying data engineer jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data engineer job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data engineer to learn to maximize their market value.

### Closing Thoughts

This project enhanced my SQL skills and provided valuable insights into the data engineer job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data engineers can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.