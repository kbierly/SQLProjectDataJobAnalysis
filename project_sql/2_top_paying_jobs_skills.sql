/* 
Question: What are the skills associated with these top-paying data analyst jobs?
- Identify the top 100 highest-paying Data Analyst roles.
- Identify which skills are most in-demand and what the average salary associated with each skill is for each of these high-paying jobs.
*/

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN 
    company_dim 
    ON
    job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND 
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT
        100
)

SELECT 
    AVG(salary_year_avg) AS avg_salary_per_skill,
    COUNT(*) AS number_of_appearances,
    skills
FROM 
    top_paying_jobs
INNER JOIN 
    skills_job_dim
ON
    top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim
ON
    skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY
    skills
ORDER BY
    avg_salary_per_skill DESC;

/* 1. Top 5 Skills by Average Salary
For the top 100 highest paying Data Analyst jobs, these are the top 5 skills with the highest average salaries:

Skill & Average Salary Per Skill
[{
    "avg_salary_per_skill": "208172.25",
    "number_of_appearances": "2",
    "skills": "pyspark"
  },
  {
    "avg_salary_per_skill": "195500",
    "number_of_appearances": "2",
    "skills": "gitlab"
  },
  {
    "avg_salary_per_skill": "190414",
    "number_of_appearances": "2",
    "skills": "jupyter"
  },
  {
    "avg_salary_per_skill": "190250",
    "number_of_appearances": "2",
    "skills": "crystal"
  },
  {
    "avg_salary_per_skill": "189309",
    "number_of_appearances": "1",
    "skills": "jenkins"
  }]
2. Top 5 Most Frequent Skills
These are the top 5 skills that appear most frequently in job descriptions:

Skill & Number of Appearances
[{
    "avg_salary_per_skill": "145013.973333333333",
    "number_of_appearances": "75",
    "skills": "sql"
  },
  {
    "avg_salary_per_skill": "148181.048076923077",
    "number_of_appearances": "52",
    "skills": "python"
  },
  {
    "avg_salary_per_skill": "148810.756097560976",
    "number_of_appearances": "41",
    "skills": "tableau"
  },
  {
    "avg_salary_per_skill": "148747.424242424242",
    "number_of_appearances": "33",
    "skills": "r"
  },
  {
    "avg_salary_per_skill": "138207.535714285714",
    "number_of_appearances": "28",
    "skills": "sas"
  }]
3. Correlation between Skill Frequency and Average Salary
The correlation between the frequency of skills in job descriptions and their average salaries is approximately -0.046. This indicates a very weak negative correlation, suggesting that there is no strong relationship between how frequently a skill appears in job postings and its associated average salary. 

4. Conclusion
These insights reveal that while certain skills like sql, python, and tableau are highly sought after, they do not necessarily command the highest salaries. Conversely, specialized skills like pyspark, gitlab, and jupyter are associated with higher average salaries but appear less frequently in job postings. The weak correlation between skill frequency and salary further highlights that demand does not directly dictate compensation in this field.*/