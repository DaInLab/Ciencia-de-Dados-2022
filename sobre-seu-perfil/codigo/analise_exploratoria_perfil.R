# Versão 4 em 05 de setembro de 2022
# No R, para utilizar determinadas funções, que não estão no pacote "base" é preciso "carregar" a biblioteca no programa
# O comando que realiza esta função é chamado de "library"
# Neste caso, utilizaremos o "pacote" readxl diretamente do repositório existente no CRAN-R (oficial)
# Caso o mesmo ainda não esteja transferido o comando é instalado pelo comando abaixo:
if(!"readxl" %in% installed.packages()) install.packages("readxl")
library(readxl)
#Lendo a planilha e carregando no R como "data frame". 
#O data frame é usado para armazenar as tabelas de dados em R. 
#É uma tabela ou uma estrutura bidimensional do tipo matriz em que cada coluna contém os valores de uma variável
#e cada linha contém um conjunto de valores de cada coluna.
#É uma lista de vetores de igual comprimento

meu.dataframe <-read_excel("./dados/sobre-seu-perfil-aed.xlsx")

if(!"xlsx" %in% installed.packages()) install.packages("xlsx")
library(xlsx)
meu.dataframe <- read.xlsx("./dados/sobre-seu-perfil-aed.xlsx", 
                           sheetName = "Respostas",
                           stringsAsFactors = FALSE)
head(meu.dataframe, 2)

# Alguns gráficos básicos
# Tipo pizza
pie(table(meu.dataframe$sistema_operacional))

# Para melhorar a visualização, usaremos a função table() para subdividir o gráfico em fatores
# table() usa os fatores de classificação cruzada (classificação de acordo com mais de um atributo ao mesmo tempo)
# para construir uma tabela de contingência (tabela estatística que mostra as freqüências dos dados, 
# classificados de acordo com duas variáveis: as linhas indicam uma variável e as colunas indicam outra variável)
# das contagens em cada combinação de níveis de fatores.
table(meu.dataframe$sistema_operacional)
# Fatores, onde 1 = Não sei, 2 = Windows, 3 = MacOs e 4 = Linux, 5 = Outro)
# 2  3 
# 13  5 

#Incluindo rótulos (label) no gráfico
lbls <- c("Windows","MacOs")
pct <- round(table(meu.dataframe$sistema_operacional)/sum(table(meu.dataframe$sistema_operacional))*100, digits=1)
pct
#      2    3  
#   72.2 27.8 
lbls <- paste(lbls, pct) # adicionar os valores das percentagens nos labels 
lbls <- paste(lbls,"%",sep="") # adicionar o símbolo % aos labels 
pie(table(meu.dataframe$sistema_operacional), labels = lbls, edges = 200, radius = 0.8,
    clockwise = TRUE, density = 60, angle = 45, col = c("purple", "red", "green3","cyan"), border = NULL,
    lty = NULL, main = "Sistemas Operacionais Utilizados pelos Alunos")

# Quanto ao gênero
# Fatores, onde 1 = Feminino, 2 = Masculino e 3 = Não Declarado)
pct <- round(table(meu.dataframe$genero)/sum(table(meu.dataframe$genero))*100, digits=1)
pct
#    1    2    3 
# 33.3 61.1  5.6  
lbls <- c("Feminino", "Masculino", "Não Declarado")
lbls <- paste(lbls, pct) # adicionar os valores das percentagens nos labels 
lbls <- paste(lbls,"%",sep="") # adicionar o símbolo % aos labels 
pie(table(meu.dataframe$genero), labels = lbls, edges = 200, radius = 0.8,
    clockwise = TRUE, density = 60, angle = 45, col = c("purple", "green3","cyan"), border = NULL,
    lty = NULL, main = "Gênero dos Alunos")

# Quanto ao tipo de matrícula do aluno
# Fatores, onde 1 = Regular, 2 = Especial)
pct <- round(table(meu.dataframe$tipo_aluno)/sum(table(meu.dataframe$tipo_aluno))*100, digits=1)
pct
#    1    2 
# 72.2 27.8  
lbls <- c("Regular", "Especial")
lbls <- paste(lbls, pct) # adicionar os valores das percentagens nos labels 
lbls <- paste(lbls,"%",sep="") # adicionar o símbolo % aos labels 
pie(table(meu.dataframe$tipo_aluno), labels = lbls, edges = 200, radius = 0.8,
    clockwise = TRUE, density = 60, angle = 45, col = c("purple", "green3","cyan"), border = NULL,
    lty = NULL, main = "Tipo de Matrícula dos Alunos")

# Quanto à formação básica
table(meu.dataframe$formacao_basica)
#       Administração          Computação  Comunicação Social      Design Gráfico             Direito     Educação Física 
#                   1                   1                   3                   3                   2                   1 
#História Licenciatura Letras   Relações Públicas          Tecnologia 
#       1                   1                   1                   4 
pct <- round(table(meu.dataframe$formacao_basica)/sum(table(meu.dataframe$formacao_basica))*100, digits=1)
pct
#Administração          Computação  Comunicação Social      Design Gráfico             Direito     Educação Física 
#          5.6                 5.6                16.7                16.7                11.1                 5.6 
#História Licenciatura Letras   Relações Públicas          Tecnologia 
#     5.6                 5.6                 5.6                22.2 
# Diminuir o número de caracters dos labels
names(pct) <- c("Admin.","Comput.", "Com. Social", "Design", "Direito", "Ed. Física","História", "Licenc.", "Rel. Públ.", "Tecnologia")
pct
lbls <- names(pct)
lbls <- paste(lbls, pct) # adicionar os valores das percentagens nos labels 
lbls <- paste(lbls,"%",sep="") # adicionar o símbolo % aos labels 
pie(table(meu.dataframe$formacao_basica), labels = lbls, edges = 200, radius = 0.8,
    clockwise = TRUE, density = 60, angle = 45, col = c("purple", "green3","cyan"), border = NULL,
    lty = NULL, main = "Formação dos Alunos")

freq_formacao = unname(table(meu.dataframe$formacao_basica))
names(freq_formacao) <- c("Admin.","Comput.", "Com. Social", "Design", "Direito", "Ed. Física","História", "Licenc.", "Rel. Públ.", "Tecnologia")
pct <- paste(unname(round(freq_formacao/sum(freq_formacao)*100, digits=1)), "%")
pct

barplot(freq_formacao,
        main = "Formação dos Alunos",
        xlab = "Formação", ylab = "Quantidade de alunos",
        density = 60, angle = 45, ylim = c(0,6))
text(freq_formacao, pct, cex=1.0, pos = 3, offset = 0.5,  col = "red")

# Quanto ao curso de origem
# Fatores, onde 1 = Mestrado, 2 = Doutorado)
pct <- round(table(meu.dataframe$curso)/sum(table(meu.dataframe$curso))*100, digits=1)
pct
#    1    2 
# 44.4 55.6  
lbls <- c("Mestrado", "Doutorado")
lbls <- paste(lbls, pct) # adicionar os valores das percentagens nos labels 
lbls <- paste(lbls,"%",sep="") # adicionar o símbolo % aos labels 
pie(table(meu.dataframe$curso), labels = lbls, edges = 200, radius = 0.8,
    clockwise = TRUE, density = 60, angle = 45, col = c("purple", "green3","cyan"), border = NULL,
    lty = NULL, main = "Curso dos Alunos")

# Quanto à faixa etária
# Nesta análise, temos nove (9) fatores/faixas etárias, onde:
#1.18 a 21 anos 
#2.22 a 24 anos 
#3.25 a 29 anos 
#4.30 a 34 anos 
#5.35 a 39 anos 
#6.40 a 44 anos 
#7.45 a 49 anos 
#8.50 a 59 anos 
#9.mais de 59 anos
pct <- round(table(meu.dataframe$faixa_etaria)/sum(table(meu.dataframe$faixa_etaria))*100, digits=1)
pct
#   2    3    4    5    6    7    8 
# 5.6 16.7 11.1 11.1 33.3 11.1 11.1  
#lbls <- c("18/21 anos","22/24 anos","25/29 anos",
#          "30/34 anos","35/39 anos","40/49 anos",
#          "45/54 anos","50/59 anos","mais de 59 anos")
lbls <- c("22/24 anos","25/29 anos",
          "30/34 anos","35/39 anos","40/44 anos",
          "45/49 anos","50/59 anos")

lbls <- paste(lbls, pct) # adicionar os valores das percentagens nos labels 
lbls <- paste(lbls,"%",sep="") # adicionar o símbolo % aos labels 
pie(table(meu.dataframe$faixa_etaria), labels = lbls, edges = 200, radius = 0.8,
    clockwise = TRUE, density = 60, angle = 45, col = c("red","purple", "green3","yellow"), border = NULL,
    lty = NULL, main = "Idade dos Alunos")

# Quanto ao fabricante/marca do computador
pct = table(meu.dataframe$fabricante_computador)
pct
#           Apple             Asus             Dell               hp LG e STI Toshiba             Vaio 
#               5                1                8                1                1                1
class(pct) # Os objetos R têm um atributo de classe, um vetor que fornece os nomes das classes nas quais o objeto é herdado.
#[1] "table"
# A variável pct é do tipo "table" (tabela)
# Para obter os "nomes" dos itens da tabela (se houver!) pode-se utilizar a função "names"
names(pct) # Função para obter ou definir os nomes em um objeto.
#[1] "Apple"                    "Asus (Intel 11ª Geração)" "Dell"                     "DELL"                    
#[5] "hp"                       "LG e STI Toshiba"         "Vaio"        
lbls = names(pct)
# Calculando a porcentagem
pct = round(table(meu.dataframe$fabricante_computador)/sum(table(meu.dataframe$fabricante_computador))*100, digits=1)
lbls <- paste(lbls, pct) # adicionar os valores das percentagens nos labels 
lbls <- paste(lbls,"%",sep="") # adicionar o símbolo % aos labels 

#Desenhando o gráfico
pie(table(meu.dataframe$fabricante_computador), labels = lbls, edges = 200, radius = 0.8,
    clockwise = TRUE, density = 60, angle = 45, 
    col = c("red", "yellow",  "purple","green3","cyan"),
    border = NULL,
    lty = NULL, main = "Marca dos Laptops")

# Quanto ao conhecimento de ambiente/programa de ciência de dados
# Fatores, onde 1 = Não, 2 = Sim)
pct <- round(table(meu.dataframe$conhece_linguagem_ciencia_dados)/sum(table(meu.dataframe$conhece_linguagem_ciencia_dados))*100, digits=1)
pct
#    1    2 
# 77.8 22.2   
lbls <- c("Não Conheço", "Conheço")
lbls <- paste(lbls, pct) # adicionar os valores das percentagens nos labels 
lbls <- paste(lbls,"%",sep="") # adicionar o símbolo % aos labels 

#Desenhando o gráfico de conhecimento de ambiente/programa de ciência de dados
pie(table(meu.dataframe$conhece_linguagem_ciencia_dados), labels = lbls, edges = 200, radius = 0.8,
    clockwise = TRUE, density = 60, angle = 45, 
    col = c("red", "yellow",  "purple","green3","cyan"),
    border = NULL,
    lty = NULL, main = "Ambiente/programa de Ciência de Dados")

# Para a variável "expectativa_disciplina" utilizamos o pacote "wordcloud"
# Fonte: How to Generate Word Clouds in R / Céline Van den Rul / Oct 15, 2019
# Published in Towards Data Science
# URL: <https://towardsdatascience.com/create-a-word-cloud-with-r-bde3e7422e8a> 

if(!"wordcloud" %in% installed.packages()) install.packages("wordcloud")
library(wordcloud)
if(!"wordcloud2" %in% installed.packages()) install.packages("wordcloud2")
library(wordcloud2)
if(!"RColorBrewer" %in% installed.packages()) install.packages("RColorBrewer")
library(RColorBrewer)
if(!"tm" %in% installed.packages()) install.packages("tm")
library(tm)

# Passo 1: Recuperando os dados e criando um vetor com a primeira descrição de expectativa 
text <- meu.dataframe$expectativa_disciplina
# Criando um corpus  
docs <- Corpus(VectorSource(text))

# Passo 2: Limpando o texto
# Para utilizar o comando "pipe" (%>%) ou operador "tee pipe" (%T>%) , pode-se "carregar" o pacote magrittr
if(!"magrittr" %in% installed.packages()) install.packages("magrittr")
library(magrittr)

docs <- docs %>%
  tm_map(removeNumbers) %>%
  tm_map(removePunctuation) %>%
  tm_map(stripWhitespace)
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeWords, stopwords("english"))

# Passo 3: criar uma matrix de termos de documento
# Uma matriz de termos de documento é uma matriz matemática que descreve a frequência dos termos que ocorrem em uma coleção de documentos.
dtm <- TermDocumentMatrix(docs) 
matrix <- as.matrix(dtm) 
words <- sort(rowSums(matrix),decreasing=TRUE) 
df <- data.frame(word = names(words),freq=words)

# Passo 4: gerar a núvem de palavras
set.seed(1234) # for reproducibility 
wordcloud(words = df$word, freq = df$freq, min.freq = 1,      
          max.words=200, random.order=FALSE, rot.per=0.35,       
          colors=brewer.pal(8, "Dark2"))


