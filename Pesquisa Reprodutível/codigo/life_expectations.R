#Acessar dados estruturados de fontes on-line e importá-los para R como dataframe
if(!("RCurl") %in% installed.packages()) install.packages("RCurl")
library(RCurl)
dataImport <- function(dataurl) {
  url <- dataurl
  dl <- getURL(dataurl, ssl.verifyhost=FALSE, ssl.verifypeer=FALSE)
  read.csv(textConnection(dl), header=T)
}
life <- dataImport("http://apps.who.int/gho/athena/data/xmart.csv?target=GHO/WHOSIS_000001,WHOSIS_000015&profile=crosstable&filter=COUNTRY:*&x-sideaxis=COUNTRY;YEAR&x-topaxis=GHO;SEX")

# Workaround error
# life = read.csv("./dados/xmart.csv", header=T)

# Selecionando o subconjunto apropriado de colunas e linhas no novo dataset importado
cleaningData <- function(data, startrow, columnyear, year, colsToKeep, columnNames) {
  df <- data[c(startrow:nrow(data)) & data[[columnyear]] == year, ]
  df <- df[ , colsToKeep]
  names(df) <- columnNames
  df
}

life <- cleaningData(life, 2, "X.1", " 2015", c("X", "X.1", "Life.expectancy.at.birth..years."),
                     c("Country", "Year", "LifeExpectancy"))
# Pode-se exportar documentos R Markdown em vários formatos, usando a função knit dentro do pacote knitr. 
# Para isso, utilizamos o arquivo Markdown R como entrada (teste_html.Rmd), especificamos o nome do arquivo
# renderizado e o formato desejado como saída. Aqui, o documento de exemplo estou renderizando como 
# um arquivo regular de markdown (R Markdown example.md):
#setwd("~/Downloads")
if(!("knitr") %in% installed.packages()) install.packages("knitr")
library(knitr)
#knit("~/Downloads/teste_html.Rmd", 
#     output = "~/Downloads/R Markdown example.md")

knit("./teste/teste_html.Rmd", 
     output = "./teste/R Markdown example.md")
