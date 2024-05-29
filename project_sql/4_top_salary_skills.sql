/*Question: What are the highest paying Data Analyst skills?
- Identify the top 15 highest-paying Data Analyst skills.*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary_per_skill,
    COUNT(*) AS number_of_appearances
FROM 
    job_postings_fact
INNER JOIN 
    skills_job_dim
ON
    job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim
ON
    skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND 
    salary_year_avg IS NOT NULL
GROUP BY
    skills
HAVING
    COUNT(*) >5
ORDER BY
    avg_salary_per_skill DESC
LIMIT 15

/*
Analysis
The analysis of the top 15 highest-paying skills for Data Analysts reveals some interesting trends. GitLab, a popular DevOps platform, ranks highest with an average annual salary of $134,126 and 7 job appearances. This indicates that while the demand for GitLab skills might not be widespread, it commands a significant salary premium where it is required. Other high-paying skills like Kafka and PyTorch also highlight the importance of specialized knowledge in modern data engineering and machine learning frameworks. These technologies are critical for handling large-scale data processing and developing advanced machine learning models, which likely explains their high remuneration.

On the other end of the spectrum, skills like MongoDB, PySpark, and Confluence, while still among the top 15 highest-paying, appear more frequently in job postings. This suggests that while these skills are highly valued, they are also more common and thus may offer slightly lower average salaries compared to more niche skills like GitLab and Notion. The scatter plot below visualizes the relationship between average salary and the number of job appearances for each skill, providing a clearer picture of how demand and remuneration interact for Data Analyst positions.
*/