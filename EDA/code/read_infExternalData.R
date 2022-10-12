# Definindo o diretório de trabalho!
#setwd("F:\\1_FreeMLVideo_R")
#change to your own working directory
if(Sys.info()["sysname"] == "Darwin") 
  setwd("/Users/jpalbino/Library/Mobile Documents/com~apple~CloudDocs/GitHub/Ciencia-de-Dados-2022/EDA") else 
  setwd("C/:ciencia-de-dados-2022/EDA")

## ler arquivos do tipo csv e texto
resp1=read.csv("./data/Resp1.csv",header=T)
head(resp1)
str(resp1)

resp2=read.table("./data/Resp2.txt",header=T)
head(resp2)

#lendo os dados csv diretamento do site da UCI Machine Learning Repository:
#https://archive.ics.uci.edu/ml/datasets/Wine+Quality
# Obs: neste exemplo o arquivo foi "baixado" no subdiretório "data" do diretório de trabalho EDA

# Lendo arquivo .csv
winer1=read.csv("./data/winequality-red.csv",header=T)
# A opção header= T também lerá os nomes das colunas 
head(winer1)
summary(winer1)

# Lendo arquivo do tipo texto
winer1=read.table("./data/winequality-red-txt.txt",header=T,sep=",",fileEncoding = "UTF-8")
# A opção header= T também lerá os nomes das colunas
head(winer1)
summary(winer1)

#especifique o separador correto
winer=read.table("./data/winequality-red.csv",header=T,sep=",")
# A opção header= T também lerá os nomes das colunas
head(winer)
summary(winer)

## Lendo dados do MS Excel® 
#excel

library(readxl)
dfb <- read_excel("./data/boston1.xls")
head(dfb)
summary(dfb)

#Usando a biblioteca/pacote RCurl para ler dados csv hospedados no github online e em outros #sites
library(RCurl)
data1= read.csv(text=getURL("https://raw.githubusercontent.com/sciruela/Happiness-Salaries/master/data.csv"))
head(data1)
summary(data1)

data2=read.csv(text=getURL("https://raw.githubusercontent.com/opetchey/RREEBES/master/Beninca_etal_2008_Nature/data/nutrients_original.csv"), skip=7, header=T)
head(data2)
summary(data2)



#data3=read.csv(text=getURL("https://www.gov.uk/government/uploads/system/uploads/attachment_data/file/246663/pmgiftsreceivedaprjun13.csv"))
#head(data3)
# Não funcionou !

#workaround = gambiarra!!
library(curl)
# baixando o arquivo localmente...
curl_download("https://www.gov.uk/government/uploads/system/uploads/attachment_data/file/246663/pmgiftsreceivedaprjun13.csv", "./data/local-data3.csv")

data3=read.csv("./data/local-data3.csv",header=F, skip = 1)
names(data3) = c("Minister", "Date received", "From","Gift", "Value (?)", "Outcome")
head(data3)

