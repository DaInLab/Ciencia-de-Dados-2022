# Versão 20 de setembro de 2022
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

meu.dataframe <-read_excel("./dados/sobre-seu-perfil-tratado.xlsx")

if(!"xlsx" %in% installed.packages()) install.packages("xlsx")
library(xlsx)
meu.dataframe <- read.xlsx("./dados/sobre-seu-perfil-tratado.xlsx", 
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
# 2.Windows   3.MacOS 
#        12         5 

#Incluindo rótulos (label) no gráfico
lbls <- c("Windows","MacOs")
pct <- round(table(meu.dataframe$sistema_operacional)/sum(table(meu.dataframe$sistema_operacional))*100, digits=1)
pct
# 2.Windows   3.MacOS 
#      70.6      29.4 
lbls <- paste(lbls, pct) # adicionar os valores das percentagens nos labels 
lbls <- paste(lbls,"%",sep="") # adicionar o símbolo % aos labels 
pie(table(meu.dataframe$sistema_operacional), labels = lbls, edges = 200, radius = 0.8,
    clockwise = TRUE, density = 60, angle = 45, col = c("purple", "red", "green3","cyan"), border = NULL,
    lty = NULL, main = "Sistemas Operacionais Utilizados pelos Alunos")

# Quanto ao gênero
pct <- round(table(meu.dataframe$genero)/sum(table(meu.dataframe$genero))*100, digits=1)
pct
#           Feminino           Masculino Outro/Não declarado 
#               35.3                58.8                 5.9 
lbls <- c("Feminino", "Masculino", "Não Declarado")
lbls <- paste(lbls, pct) # adicionar os valores das percentagens nos labels 
lbls <- paste(lbls,"%",sep="") # adicionar o símbolo % aos labels 
pie(table(meu.dataframe$genero), labels = lbls, edges = 200, radius = 0.8,
    clockwise = TRUE, density = 60, angle = 45, col = c("purple", "green3","cyan"), border = NULL,
    lty = NULL, main = "Gênero dos Alunos")

# Quanto à faixa etária
pct <- round(table(meu.dataframe$faixa_etaria)/sum(table(meu.dataframe$faixa_etaria))*100, digits=1)
pct
# Entre 22 e 24 anos Entre 25 e 29 anos Entre 30 e 34 anos Entre 35 e 39 anos Entre 40 e 44 anos Entre 45 e 49 anos 
#                5.9               17.6               11.8               11.8               29.4               11.8 
#Entre 50 e 59 anos 
#              11.8
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
#                    Apple Asus (Intel 11ª Geração)                     Dell                     DELL                       hp 
#                        5                        1                        7                        1                        1 
#LG e STI Toshiba                     Vaio 
#               1                        1 
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

# Quanto ao curso
pct = table(meu.dataframe$curso)
pct
# Design Gráfico na UNESP 
#                       1 
# Direito 
#       1 
# Doutorado no Programa de Mídia e Tecnologia da Faculdade de Arquitetura, Artes, Comunicação e Desing da Unesp de Bauru. 
#                                                                                                                       1 
# Letras/Análise e Desenvolvimento de Sistemas (em andamento) 
#                                                           1 
# Licenciatura Letras Inglês-Português 
#                                    1 
# Mestrado profissional, PPG-MiT da FAAC/UNESP 
#                                            1 
# Mestrando do Programa de Pós-Graduação em Ciências da Informação 
#                                                                1 
# Mídia e Tecnologia 
#                  3 
#PPG em Design - Concentração em Ergonomia - Doutorado 
#                                                    1 
# PPGMIT 
#      1 
# Programa de Pós Graduação em Mídia e Tecnologia 
#                                               1 
# Programa de Pós Graduação em Mídia e Tecnologia (PPGMit - Unesp Bauru) 
#                                                                      1 
# PROGRAMA DE PÓS-GRADUAÇÃO EM MÍDIA E TECNOLOGIA (DOUTORADO ACADÊMICO) 
#                                                                     1 
# Tecnologia em Processamento de Dados 
#                                    1 
# Univem Especializacao em Banco de Dados 
#                                       1
names(pct)
#[1] "Design Gráfico na UNESP"                                                                                                
#[2] "Direito"                                                                                                                
#[3] "Doutorado no Programa de Mídia e Tecnologia da Faculdade de Arquitetura, Artes, Comunicação e Desing da Unesp de Bauru."
#[4] "Letras/Análise e Desenvolvimento de Sistemas (em andamento)"                                                            
#[5] "Licenciatura Letras Inglês-Português"                                                                                   
#[6] "Mestrado profissional, PPG-MiT da FAAC/UNESP"                                                                           
#[7] "Mestrando do Programa de Pós-Graduação em Ciências da Informação"                                                       
#[8] "Mídia e Tecnologia"                                                                                                     
#[9] "PPG em Design - Concentração em Ergonomia - Doutorado"                                                                  
#[10] "PPGMIT"                                                                                                                 
#[11] "Programa de Pós Graduação em Mídia e Tecnologia"                                                                        
#[12] "Programa de Pós Graduação em Mídia e Tecnologia (PPGMit - Unesp Bauru)"                                                 
#[13] "PROGRAMA DE PÓS-GRADUAÇÃO EM MÍDIA E TECNOLOGIA (DOUTORADO ACADÊMICO)"                                                  
#[14] "Tecnologia em Processamento de Dados"                                                                                   
#[15] "Univem Especializacao em Banco de Dados"         

lbls = names(pct)

# Calculando a porcentagem
pct = round(table(meu.dataframe$curso)/sum(table(meu.dataframe$curso))*100, digits=1)
lbls <- paste(lbls, pct) # adicionar os valores das percentagens nos labels 
lbls <- paste(lbls,"%",sep="") # adicionar o símbolo % aos labels 

#Desenhando o gráfico de cursos
pie(table(meu.dataframe$curso), labels = lbls, edges = 200, radius = 0.8,
    clockwise = TRUE, density = 60, angle = 45, 
    col = c("red", "yellow",  "purple","green3","cyan"),
    border = NULL,
    lty = NULL, main = "Cursos dos Alunos")

# Para a variável "expectativa_disciplina" utilizamos o pacote "wordcloud"
# Fonte: How to Generate Word Clouds in R / Céline Van den Rul / Oct 15, 2019
# Published in Towards Data Science
# URL: <https://towardsdatascience.com/create-a-word-cloud-with-r-bde3e7422e8a> 

# Passo 0: Carregando os pacotes
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


