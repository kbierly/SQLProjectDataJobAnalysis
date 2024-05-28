import pandas as pd
import matplotlib.pyplot as plt

# Data for Top 5 Skills by Average Salary
top_5_skills_avg_salary = [
    {"skills": "pyspark", "avg_salary_per_skill": 208172.25, "number_of_appearances": 2},
    {"skills": "gitlab", "avg_salary_per_skill": 195500, "number_of_appearances": 2},
    {"skills": "jupyter", "avg_salary_per_skill": 190414, "number_of_appearances": 2},
    {"skills": "crystal", "avg_salary_per_skill": 190250, "number_of_appearances": 2},
    {"skills": "jenkins", "avg_salary_per_skill": 189309, "number_of_appearances": 1}
]

df_top_5_avg_salary = pd.DataFrame(top_5_skills_avg_salary)

# Plot Top 5 Skills by Average Salary
plt.figure(figsize=(10, 6))
plt.barh(df_top_5_avg_salary['skills'], df_top_5_avg_salary['avg_salary_per_skill'], color='skyblue')
plt.xlabel('Average Salary (USD)')
plt.title('Top 5 Skills by Average Salary')
plt.savefig('top_5_skills_by_avg_salary.png')
plt.show()

# Data for Top 5 Most Frequent Skills
top_5_most_frequent_skills = [
    {"skills": "sql", "avg_salary_per_skill": 145013.973333333333, "number_of_appearances": 75},
    {"skills": "python", "avg_salary_per_skill": 148181.048076923077, "number_of_appearances": 52},
    {"skills": "tableau", "avg_salary_per_skill": 148810.756097560976, "number_of_appearances": 41},
    {"skills": "r", "avg_salary_per_skill": 148747.424242424242, "number_of_appearances": 33},
    {"skills": "sas", "avg_salary_per_skill": 138207.535714285714, "number_of_appearances": 28}
]

df_top_5_frequent_skills = pd.DataFrame(top_5_most_frequent_skills)
df_top_5_frequent_skills_sorted = df_top_5_frequent_skills.sort_values(by='number_of_appearances', ascending=True)

# Plot Top 5 Most Frequent Skills
plt.figure(figsize=(10, 6))
plt.barh(df_top_5_frequent_skills_sorted['skills'], df_top_5_frequent_skills_sorted['number_of_appearances'], color='lightgreen')
plt.xlabel('Number of Appearances')
plt.title('Top 5 Most Frequent Skills for the Highest Paying 100 Jobs')
plt.savefig('top_5_most_frequent_skills.png')
plt.show()

# Data for Correlation
skills_data = top_5_skills_avg_salary + top_5_most_frequent_skills
df_skills_data = pd.DataFrame(skills_data)
correlation = df_skills_data[['number_of_appearances', 'avg_salary_per_skill']].corr().iloc[0, 1]

# Plot Correlation between Skill Frequency and Average Salary
plt.figure(figsize=(10, 6))
plt.scatter(df_skills_data['number_of_appearances'], df_skills_data['avg_salary_per_skill'], color='purple')
plt.xlabel('Number of Appearances')
plt.ylabel('Average Salary (USD)')
plt.title(f'Correlation between Skill Frequency and Average Salary (Correlation: {correlation:.3f})')
plt.savefig('correlation_skill_frequency_avg_salary.png')
plt.show()
