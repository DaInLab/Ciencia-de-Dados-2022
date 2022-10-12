# Versão 1.0 em Português em: 2022-10-07
library(MASS)
data()

##NAs distribuídas aleatoriamente
data(airquality)
??airquality ##mais informações sobre esses dados
str(airquality)

head(airquality)
summary(airquality)

aq=na.omit(airquality) #remove linhas contendo NAs
head(aq)
summary(aq)
str(aq)

aq2=airquality[complete.cases(airquality), ] #somente retém linhas que não tem (são) NA
head(aq2)
summary(aq2)

## substitua NAs por 0
aqty=airquality

aqty[is.na(aqty)]<-0
head(aqty)
summary(aqty)

## substituir valores ausentes por valores médios

meanOzone=mean(airquality$Ozone,na.rm=T)
# remove NAs enquanto calcula a média de ozônio
# com o valor médio de NA sendo NA 

aqty.fix=ifelse(is.na(airquality$Ozone),meanOzone,airquality$Ozone)
summary(aqty.fix)


##visualize os padrões de NAs
library(mice)
aqty2=airquality
md.pattern(aqty2)
#111 observações sem valores

library(VIM) #visualiza o padrão de NAs
mp <- aggr(aqty2, col=c('navyblue','yellow'),
           numbers=TRUE, sortVars=TRUE,
           labels=names(aqty2), cex.axis=.7,
           gap=3, ylab=c("Missing data","Pattern"))

#72,5% observações em todos os dados não têm valores ausentes
#22,9% de valores ausentes no ozônio

#imputar
#500 iterações de mapeamento de média preditiva para imputação
#5 conjuntos de dados
im_aqty<- mice(aqty2, m=5, maxit = 50, method = 'pmm', seed = 500)

#50 iterações de mapeamento de média preditiva para imputação

summary(im_aqty)

im_aqty$imp$Ozone #valores imputados em ozônio

#recupera o conjunto de dados u completo
completedData <- complete(im_aqty,1)
head(completedData)
