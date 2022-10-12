import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
%matplotlib inline
import seaborn as sns

df = pd.read_csv('D:/Github/Ciencia-de-Dados-2022/python-in-rstudio/dados/StudentsPerformance.csv')
df

# Descriptive Statistics
df.describe(include='all')

# Missing value imputation
df.isnull().sum()

# Graphical representation
plt.subplot(221)

df['gender'].value_counts().plot(kind='bar', title='Gender of students', figsize=(16,9))

plt.xticks(rotation=0)

plt.subplot(222)

df['race/ethnicity'].value_counts().plot(kind='bar', title='Race/ethnicity of students')

plt.xticks(rotation=0)

plt.subplot(223)

df['lunch'].value_counts().plot(kind='bar', title='Lunch status of students')

plt.xticks(rotation=0)

plt.subplot(224)

df['test preparation course'].value_counts().plot(kind='bar', title='Test preparation course')

plt.xticks(rotation=0)

plt.show()


df.boxplot()


sns.distplot(df['math score'])


corr = df.corr()
sns.heatmap(corr, annot=True, square=True)
plt.yticks(rotation=0)
plt.show()


sns.relplot(x='math score', y='writing score', hue='gender', data=df)

df.groupby('parental level of education')[['math score', 'reading score', 'writing score']].mean().T.plot(figsize=(12,8))

df.groupby('test preparation course')[['math score', 'reading score', 'writing score']].mean().T.plot(kind='barh', figsize=(10,10))
