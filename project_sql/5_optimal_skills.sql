/*
What are the most optimal skills to learn?
- Identify skills that are both in high demand and associated with high average salaries for Data Analyst roles 
*/

WITH skills_demand AS (
    SELECT
        skills_dim.skill_id, 
        skills,
        COUNT(skills_job_dim.job_id) AS demand_count
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
        skills_dim.skill_id
), avg_salary AS (
    SELECT 
        skills_dim.skill_id,
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
        skills_dim.skill_id
), normalized_values AS (
    SELECT  
        skills_demand.skill_id,
        skills_demand.skills,
        demand_count,
        avg_salary_per_skill,
        -- Normalize demand_count
        (CAST(demand_count AS FLOAT) - (SELECT MIN(demand_count) FROM skills_demand)) / 
        ((SELECT MAX(demand_count) FROM skills_demand) - (SELECT MIN(demand_count) FROM skills_demand)) AS normalized_demand,
        -- Normalize avg_salary_per_skill
        (CAST(avg_salary_per_skill AS FLOAT) - (SELECT MIN(avg_salary_per_skill) FROM avg_salary)) / 
        ((SELECT MAX(avg_salary_per_skill) FROM avg_salary) - (SELECT MIN(avg_salary_per_skill) FROM avg_salary)) AS normalized_salary
    FROM
        skills_demand
    INNER JOIN avg_salary
    ON
        skills_demand.skill_id = avg_salary.skill_id
),
weighted_scores AS (
    SELECT
        skill_id,
        skills,
        demand_count,
        avg_salary_per_skill,
        normalized_demand,
        normalized_salary,
        -- Calculate weighted score with demand given slightly more weight
        (0.5 * normalized_demand + 0.5 * normalized_salary) AS weighted_score
    FROM
        normalized_values
)
SELECT
    DISTINCT skills,
    ROUND(CAST(weighted_score AS numeric), 4) AS weighted_score,
    demand_count,
    avg_salary_per_skill
FROM
    weighted_scores
WHERE
    demand_count > 20
ORDER BY
    weighted_score DESC,
    avg_salary_per_skill DESC
LIMIT
    25;

WITH skills_demand AS (
    SELECT
        skills_dim.skill_id, 
        skills,
        COUNT(skills_job_dim.job_id) AS demand_count
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
        skills_dim.skill_id
), avg_salary AS (
    SELECT 
        skills_dim.skill_id,
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
        skills_dim.skill_id
)
SELECT  
        MIN(demand_count),
        MAX(demand_count),
        MAX(avg_salary_per_skill),
        MIN(avg_salary_per_skill)
    FROM
        skills_demand
    INNER JOIN avg_salary
    ON
        skills_demand.skill_id = avg_salary.skill_id
