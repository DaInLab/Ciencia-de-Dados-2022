##Vamos trabalhar com conjuntos de dados embutidos no R
data(iris)
??iris

str(iris) #estrutura do dataframe

summary(iris)

#lendo nas primeiras 10 linhas

head(iris,10)

## subconjunto/separando as 6 primeiras linhas em diferentes dataframes
df6=iris[1:6,]
str(df6)

##separando as 2 primeiras colunas
df2=iris[,1:2]
head(df2)
str(df2)

##separando todas as linhas e as 2 colunas
x=iris[, c("Sepal.Length", "Sepal.Width")]
str(x)

##subconjunto de uma coluna
## sem retirar x2 será um vetor
x2= iris[, 'Sepal.Length', drop=FALSE]
head(x2)

## selecionando as variáveis Sepal.Length, Petal.Length, Species
vars <- c("Sepal.Length", "Petal.Length", "Species")
nd <- iris[vars]
head(nd)
str(nd)

# excluindo a coluna Species
vars <- names(iris) %in% c("Species") 
nd <- iris[!vars]
str(nd)
head(nd)

### excluindo a 3ª e a 4ª coluna
nd<- iris[c(-3,-4)]
head(nd)

##selecionando um valor de coluna
## separando todas as linhas correspondentes à espécie setosa

df_setosa=subset(iris,iris$Species=="setosa")
str(df_setosa)
summary(df_setosa)

