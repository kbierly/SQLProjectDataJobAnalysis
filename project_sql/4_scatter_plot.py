import matplotlib.pyplot as plt
from adjustText import adjust_text
import numpy as np

# Data
data = [
    {"skills": "gitlab", "avg_salary_per_skill": 134126, "number_of_appearances": 7},
    {"skills": "kafka", "avg_salary_per_skill": 129999, "number_of_appearances": 40},
    {"skills": "pytorch", "avg_salary_per_skill": 125226, "number_of_appearances": 20},
    {"skills": "perl", "avg_salary_per_skill": 124686, "number_of_appearances": 20},
    {"skills": "tensorflow", "avg_salary_per_skill": 120647, "number_of_appearances": 24},
    {"skills": "cassandra", "avg_salary_per_skill": 118407, "number_of_appearances": 11},
    {"skills": "notion", "avg_salary_per_skill": 118092, "number_of_appearances": 6},
    {"skills": "atlassian", "avg_salary_per_skill": 117966, "number_of_appearances": 15},
    {"skills": "bitbucket", "avg_salary_per_skill": 116712, "number_of_appearances": 6},
    {"skills": "airflow", "avg_salary_per_skill": 116387, "number_of_appearances": 71},
    {"skills": "scala", "avg_salary_per_skill": 115480, "number_of_appearances": 59},
    {"skills": "linux", "avg_salary_per_skill": 114883, "number_of_appearances": 58},
    {"skills": "confluence", "avg_salary_per_skill": 114153, "number_of_appearances": 62},
    {"skills": "pyspark", "avg_salary_per_skill": 114058, "number_of_appearances": 49},
    {"skills": "mongodb", "avg_salary_per_skill": 113608, "number_of_appearances": 52}
]

# Extract data for plotting
skills = [d['skills'] for d in data]
avg_salaries = [d['avg_salary_per_skill'] for d in data]
num_appearances = [d['number_of_appearances'] for d in data]

# Create scatter plot
plt.figure(figsize=(12, 8))
plt.scatter(avg_salaries, num_appearances, color='mediumpurple', s=100, alpha=0.6, edgecolors='w', linewidth=2)

# Add labels for each point
texts = []
for i, skill in enumerate(skills):
    texts.append(plt.text(avg_salaries[i], num_appearances[i], skill, fontsize=12))

# Adjust text to avoid overlap
adjust_text(texts, only_move={'points': 'y', 'texts': 'y'})

# Line of best fit
m, b = np.polyfit(avg_salaries, num_appearances, 1)
plt.plot(avg_salaries, m * np.array(avg_salaries) + b, color='purple', linestyle='--', linewidth=2)

# Title and labels
plt.title('Salary of Highest Paying Data Analyst Skills vs. # of Mentions in Job Postings', size=16, y=1.1)
plt.xlabel('Average Salary per Skill (USD)', fontsize=14)
plt.ylabel('Number of Appearances', fontsize=14)
plt.grid(True, linestyle='--', alpha=0.7)

# Show plot
plt.tight_layout()
plt.show()

# Extract data for analysis
avg_salaries = [d['avg_salary_per_skill'] for d in data]
num_appearances = [d['number_of_appearances'] for d in data]

# Calculate the correlation coefficient
correlation_matrix = np.corrcoef(avg_salaries, num_appearances)
r_value = correlation_matrix[0, 1]

print(f"The correlation coefficient (r value) is: {r_value:.2f}")