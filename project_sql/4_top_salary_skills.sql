/*Question: What are the highest paying Data Analyst skills?
- Identify the top 25 highest-paying Data Analyst skills that are available remotely.*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary_per_skill
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
ORDER BY
    avg_salary_per_skill DESC
LIMIT 25

/*
High Value of Legacy Technologies
Based on the data provided for the top 25 highest paying skills for data analysts, it's clear that niche and emerging technologies command significant salaries. For instance, svn (Subversion), a version control system, tops the list with an average salary of $400,000, which is notably higher than the others. This suggests that skills in older yet critical technologies might still hold substantial value, potentially due to their specialized usage in legacy systems that require expertise not commonly found in the current job market.

Premium on Emerging Technologies
In addition to legacy systems, several modern and emerging technologies also feature prominently among the top-paying skills. Skills like solidity, used for smart contracts on blockchain platforms, and couchbase, a NoSQL database, highlight the premium placed on knowledge of cutting-edge technologies. This trend extends to other contemporary tools like terraform for infrastructure as code, kafka for real-time data streaming, and kubernetes for container orchestration, indicating that proficiency in these areas is highly valued in the current data analyst job market.

Demand for AI and Machine Learning Expertise
Furthermore, the list reveals a significant demand for skills related to artificial intelligence and machine learning, such as keras, pytorch, tensorflow, and hugging face. These tools are essential for building and deploying machine learning models, underlining the importance of AI competencies in securing high-paying roles. This trend underscores the shifting landscape of data analysis, where traditional data handling and analysis are increasingly augmented by advanced AI and machine learning capabilities, driving up the salaries for professionals skilled in these areas.
*/