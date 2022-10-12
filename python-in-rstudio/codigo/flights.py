import pandas as pd
#flights = pd.read_csv("D:/Github/Ciencia-de-Dados-2022/python-in-rstudio/dados/flights.csv")
flights = pd.read_csv('~/Library/Mobile Documents/com~apple~CloudDocs/GitHub/Ciencia-de-Dados-2022/python-in-rstudio/dados/flights.csv')
flights

flights.describe(include='all')

flights.isnull().sum()

flights['Dest'].describe()

flights = flights[flights['Dest'] == 'LAS']
flights = flights[['CarrierDelay','DepDelay','ArrDelay']]
flights

flights = flights.dropna()
flights
