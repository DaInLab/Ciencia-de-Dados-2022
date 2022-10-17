

# 1.4.1 Statistical Software
# A data matrix can be created manually using commands such as matrix(), data.frame(), and others.
# Any data can be edited using edit(). 
# However, typically analysts have already typed their data into data- bases or spreadsheets, for example in Excel, Access, or MySQL. 
# In most of these applications, it is possible to save the data as an ASCII file (.dat), as a tab-delimited file (.txt), or as a comma-separated values file (.csv).
# All of these formats allow easy switching between different software and database applications.

# Bonus!
# Definindo o diretório de trabalho!
if(Sys.info()["sysname"] == "Darwin")
  setwd("~/Library/Mobile Documents/com~apple~CloudDocs/GitHub/Ciencia-de-Dados-2022/Introduction to Statistics and Data Analysis") else 
    setwd("D:/Github/Ciencia-de-Dados-2022/Introduction to Statistics and Data Analysis")
#setwd('C:/directory')
# setwd() specifies the working directory. 

# Data can easily be read into R by means of the following commands:
read.table('./data/pizza_delivery.dat')
read.table('./data/pizza_delivery.txt')
read.csv('./data/pizza_delivery.csv')

#Once the data is read into R, it can be viewed with fix() or view()
pizza <- read.csv('./data/pizza_delivery.csv')
fix(pizza)
View(pizza)

# We can also can get an overview of the data directly in the R-console by displaying only the top lines of the data with head().
head(pizza)

