###############################################################
#################### EDA ####################
##### (1) Pode explorar a distribuição de 1 variável
##### (2) Pode explorar a relação entre 2 variáveis

data(iris)
names(iris)
summary(iris)

## examina a distribuição de dados de uma variável quantitativa

hist(iris$Sepal.Length) # distribution of a varaibles

boxplot(iris$Sepal.Length,main="Summary of iris",xlab="Sepal Length")

#dataviz de estatísticas descritivas
#relação entre 2 variáveis quantitativas
plot(iris$Sepal.Length,iris$Sepal.Width)

# PLOTAGEM CATEGÓRICA ou ENUMERAGEM (TABELA) DE VARIÁVEIS

data(mtcars)
names(mtcars)
str(mtcars)
counts <- table(mtcars$gear)
counts
barplot(counts, main="Carros", xlab="Número de Marchas")

barplot(counts, main="Carros", xlab="Número de Marchas",horiz=TRUE)

barplot(counts, main="Carros", xlab="Número de Marchas",horiz=TRUE,col="red")


## Visualização de dados aprimorada

library(ggplot2)

# relação entre comprimento e largura da Sépala de 3 espécies diferentes
qplot(Sepal.Length, Petal.Length, data = iris,color = Species)

# Vemos que as flores de Iris setosa têm as pétalas mais estreitas.
qplot(Sepal.Length, Petal.Length, data = iris, color = Species, size = Petal.Width)

### Adicionando rótulos ao gráfico

qplot(Sepal.Length, Petal.Length, data = iris, color = Species,
      xlab = "Comprimento da Sépala", ylab = "Comprimento da pétala",
      main = "Comprimento da sépala x da pétala no conjunto de dados Íris")

qplot(Sepal.Length, Petal.Length, data = iris, geom = "line", color = Species) #line plot

########################GGPLOT#####################

## use ggplot para visualização
# Formato: ggplot(data = , aes(x =, y =, ...)) + geom_xxx()
# aes-> especificamos x,y
# geom-> Tipo de plotagem: se um histograma ou um  boxplot
ggplot(data = iris, aes(Sepal.Length, Sepal.Width)) + geom_point()

# diferenciar as espécies usando esquema de cores
ggplot(data = iris, aes(Sepal.Length, Sepal.Width)) + geom_point(aes(colour = (Species)))
# ou
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, shape = Species)) + geom_point()

## (1) só podemos especificar cores e formas em variáveis do tipo "fator"
## (2) Fatores: números que representam valores categóricos
## (3) A função "fator" transforma qualquer número em uma representação qualitativa

str(mtcars)

#use mtcars como fator de visualização
ggplot(mtcars, aes(x = mpg, y = wt, colour = factor(gear))) + geom_point()

#histograma
ggplot(iris, aes(x = Sepal.Length)) + geom_histogram()

ggplot(iris, aes(x = Sepal.Length, fill = Species)) + geom_histogram()

#boxplot
ggplot(iris, aes(x = Species, y = Sepal.Length)) +geom_boxplot()

#visualizar a relação entre as diferentes variáveis para as 3 espécies
ggplot(data = iris, aes(Sepal.Length, Sepal.Width)) + geom_point() + facet_grid(. ~ Species) + geom_smooth(method = "lm")


