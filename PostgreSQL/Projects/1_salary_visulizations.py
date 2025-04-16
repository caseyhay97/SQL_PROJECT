# Importing libaries
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt


## Top 10 salaries

# Read in CSV from path
df_top_10 = pd.read_csv('C:\\Users\\PCFE\\Documents\\Casey\\Developer\\SQL_PROJECT\\PostgreSQL\\Projects\\data\\1_top_10_salaries.csv')

# Inspect data
print(df_top_10.head(10))         # Shows all 10 rows
print(df_top_10.columns)        # Lists column names

# Sort by salary value desending
df_top_10_sorted = df_top_10.sort_values(by='salary_year_avg', ascending=False).head(10)

print(df_top_10_sorted.shape)

# Barplot
fig, ax = plt.subplots(figsize=(12, 6))
top_10_barplot = sns.barplot(
    data=df_top_10_sorted,
    x='company_name',
    y='salary_year_avg',
    hue='job_title_short',
    ax=ax,
    palette='coolwarm'
)

# Add salary values to top of each bar
for bars in top_10_barplot.containers:
    ax.bar_label(
        bars,
        labels=[f'${int(bar.get_height()):,}' for bar in bars],  # e.g., $990,000
        label_type='edge',
        fontsize=9,
        fontweight='bold'
    )

# Formatting
plt.title('Top 10 Highest Paying Data Science Roles by Company')
plt.xlabel('Company Name')
plt.ylabel('Average Salary (USD)')
plt.xticks(ha='right') #rotation=45, 
plt.legend(title='Job Title')
plt.tight_layout()
plt.show()

"""
NOTE TO SELF:

-need to sort the bars, not group by company name as inccorect number
-y axis in a better format
-different barplot styles in sns barplots with figures ontop of bars!

"""