import numpy as np
import matplotlib.pyplot as plt

# Data
data = [
    {"skills": "sql", "demand_count": 7291},
    {"skills": "excel", "demand_count": 4611},
    {"skills": "python", "demand_count": 4330},
    {"skills": "tableau", "demand_count": 3745},
    {"skills": "power bi", "demand_count": 2609}
]

# Extract skill names and demand counts
skills = [d['skills'] for d in data]
demand_counts = [int(d['demand_count']) for d in data]

# Number of variables
num_vars = len(skills)

# Compute angle for each axis
angles = np.linspace(0, 2 * np.pi, num_vars, endpoint=False).tolist()

# The plot is circular, so we need to "complete the loop" and append the start value to the end.
skills += [skills[0]]
demand_counts += [demand_counts[0]]
angles += [angles[0]]

# Compute average angle
avg_angle = np.pi / 2

# Plot
fig, ax = plt.subplots(figsize=(8, 8), subplot_kw=dict(polar=True))
ax.fill(angles, demand_counts, color='lightgreen', alpha=0.5)
ax.plot(angles, demand_counts, color='green', linewidth=2)

# Add demand count as text for each ring
for i in range(7):
    # Set the label values on the SQL axis to 1000, 2000, 3000, 4000, ...
    ax.text(np.pi/2, (i + 1) * 1000, str((i + 1) * 1000), ha='center', va='bottom', fontsize=10, color='gray')

# Add labels
ax.set_yticklabels([])
ax.set_xticks(angles[:-1])  # Set ticks explicitly
ax.set_xticklabels(skills[:-1], fontsize=12, rotation=90 - np.degrees(avg_angle))  # Apply labels with rotation

# Set custom radial position for ticks to move them further from the center
ax.tick_params(axis='x', pad=10)  # Increase the padding to move the labels further out


# Title
plt.title('Skill Frequency in Data Analyst Job Postings (# of Mentions)', size=20, color='green', y=1.05)

# Set radius limit to 7500 to accommodate demand count up to 7000
ax.set_ylim(0, 7500)

# Show plot
plt.show()
