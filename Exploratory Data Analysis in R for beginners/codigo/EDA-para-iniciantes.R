# A Análise Exploratória de Dados (EDA) é o processo de analisar e visualizar os dados 
# para obter uma melhor compreensão dos dados e obter informações a partir deles. 
# Existem várias etapas envolvidas ao fazer EDA, mas as etapas comuns podem ser resumidas em:
# 1. Importe os dados
# 2.Limpe os dados
# 3.Processe os dados
# 4.Visualize os dados
# Neste script em R o processo de EDA se dará por meio da análise do conjunto de dados 
# de pontuação do PISA disponível em:  <https://www.oecd.org/pisa/data/2015database/>

# Este programa em R trafega por todas as etapas necessárias e pelas ferramentas utilizadas em cada passo.
# 1.Biblioteca Tidyverse para organizar o conjunto de dados
# 2.Biblioteca ggplot2 para visualizações
# 3.Biblioteca corrplot para gráfico de correlação
# 4.Algumas outras funções básicas para manipular dados, tais como: strsplit(), cbind(), matrix() e assim por diante.

# 1. Importando os dados
# ----------------------
# Basicamente, existem três formas de importar dados no R.
# Ao importar esses dados para o R, queremos que a última coluna seja 'numérica' e o restante seja 'fator'.

# Normalmente, a forma mais conveniente de importar os dados seria como no dataframe "df.raw1":
# - sem especificar nenhuma opção (options...)
# - utilizando do pacote (biblioteca) "utils", a função read.csv()
df.raw1 <- read.csv(file ='./dados/Pisa scores 2013 - 2015 Data.csv')
# Observando a estrutura do dataframe:
str(df.raw1)
# Dois (2) problemas podem ser identificados imediatamente: 
# A última coluna deveria ser do tipo 'fator' e não 'numérico'. 
# E a primeira coluna "Nome do país" está codificada de forma diferente dos dados brutos originais
# (deveria ser do tipo fator).

# Uma segunda maneira de importar os dados poderia ser com a opção na.string onde
# os caracteres ".." seja substituído por N.
# Isso será útil e conveniente quando for preciso remover todos os 'NA's.
df.raw2 <- read.csv(file ='./dados/Pisa scores 2013 - 2015 Data.csv',na.strings = '..')
str(df.raw2)
# Observa-se que a última coluna agora é do tipo 'numérico'. 
# No entanto, o nome da primeira coluna ainda não foi importado corretamente.

# Nesta terceira forma de importação, algumas opções para tratamento foram adicionadas:
df.raw <- read.csv(file ='./dados/Pisa scores 2013 - 2015 Data.csv',
                   stringsAsFactors = TRUE,
                   fileEncoding="UTF-8-BOM", 
                   na.strings = '..')
# - A opção fileEncoding="UTF-8-BOM" permite que o R, leia os caracteres da forma como aparecem nos dados brutos.
# - stringsAsFactors = TRUE permite que as colnas (variáveis) do tipo caracteres sejam convertidas em fatores.
# Vamos ver a estrutura dos dados importados:
str(df.raw)

# 2. Limpando e Processando os dados
#-----------------------------------

# Nesta etapa será utilizada a biblioteca tidyverse
if(!("tidyverse") %in% installed.packages()) install.packages("tidyverse")
library(tidyverse)

# Para limpar o conjunto de dados, será necessário:
# 1. Se certificar que cada linha no conjunto de dados corresponda APENAS a um país: 
#   Será utilizada a função spread() do pacote cleantidyverse;
# 2. Se certificar que apenas colunas e linhas úteis sejam mantidas:
#   Serão utilizados os comandos drop_na() e subset() para excluir/selecionar dados;
# 3. Renomear a coluna Series Code para uma interpretação significativa: 
#    Utilizar o comando rename().

df <- df.raw[1:1161, c(1, 4, 7)] %>%
  spread(key=Series.Code, value=X2015..YR2015.) %>%
  rename(Maths = LO.PISA.MAT,                        
            Maths.F = LO.PISA.MAT.FE,
            Maths.M = LO.PISA.MAT.MA,
            Reading = LO.PISA.REA,
            Reading.F = LO.PISA.REA.FE,
            Reading.M = LO.PISA.REA.MA,
            Science = LO.PISA.SCI,
            Science.F = LO.PISA.SCI.FE,
            Science.M = LO.PISA.SCI.MA) %>%
  drop_na()

# Observando como os dados limpos ficaram:
view(df)

# 3. Visualizando os dados (data viz)
#-----------------------------------

# 1. Gráfico de barras

library(ggplot2)

# Classificação da pontuação de matemática por países
ggplot(data=df,aes(x=reorder(Country.Name,Maths),y=Maths)) + 
  geom_bar(stat ='identity',aes(fill=Maths))+
  coord_flip() + 
  theme_grey() + 
  scale_fill_gradient(name="Nível de Pontuação de Matemática")+
  labs(title = 'Classificação dos Países por Pontuação em Matemática',
       y='Pontuação',x='Países')+ 
  geom_hline(yintercept = mean(df$Maths),size = 1, color = 'blue')

# Usando a mesma estrutura de código, pode-se classificar por pontuação de ciência e pontuação de leitura 
# basta alterar o nome de adequadamente!

#2. Boxplot (gráfico de caixas)

# Usando o dataset anterior, não se pode desenhar um boxplot. 
# Isso ocorre porque o boxplot precisa de apenas 2 variáveis x e y, 
# mas nos dados limpos, existem muitas variáveis. Então, será necessário combiná-los em 2 variáveis. 
# Isso será feito e definiremos esta nova versão dos dados como df2.

df2 = df[,c(1,3,4,6,7,9,10)] %>%   # seleciona as colunas relevantes 
  pivot_longer(c(2,3,4,5,6,7),names_to = 'Pontuação')
view(df2) 

# Plotando os boxplots:
ggplot(data = df2, aes(x=Pontuação,y=value, color=Pontuação)) + 
  geom_boxplot()+
  scale_color_brewer(palette="Dark2") + 
  geom_jitter(shape=16, position=position_jitter(0.2))+
  labs(title = 'Meninos tiveram desempenho melhor que as meninas?',
       y='Pontuações',x='Tipo de teste')

# O comando geom_jitter() permite plotar os pontos de dados no gráfico.

# Pode-se brincar com o código anterior para obter vários gráficos. 
# Por exemplo, é possível modificar ‘color = Pontuação’ para ‘fill=Pontuação’:

ggplot(data = df2, aes(x=Pontuação,y=value, fill=Pontuação)) + 
  geom_boxplot()+
  scale_fill_brewer(palette="Green") + 
  geom_jitter(shape=16, position=position_jitter(0.2))+
  labs(title = 'Meninos tiveram desempenho melhor que as meninas?',
       y='Pontuações',x='Tipo de teste')

# A plotagem dos gráficos parece um pouco confusa. 
# Uma melhor visualização seria separar Assuntos (subjects) e Gêneros (gender) e plotá-los lado a lado.

# Como fazer isso?
# Como queremos separar Subjects e Genders de uma coluna contendo ‘Subject.Gender’ (por exemplo, Maths.F), 
# precisamos usar strsplit() para fazer esse trabalho

S = numeric(408)     # cria um vetor vazio
for (i in 1:length(df2$Pontuação)) {
  S[i] = strsplit(df2$Pontuação[i],".",fixed = TRUE)
}

# Agora S é uma lista de 408 componentes, cada um com 2 subcomponentes 'Assunto' e 'Gênero'. 
# É Preciso transformar S em um data frame com 1 coluna de Assunto e 1 coluna de Gênero. 
# Vamos nomear este dataframe como df3.
df3 = S%>%unlist() %>% matrix(ncol = 2, byrow = TRUE)%>% as.data.frame()
view(df3)

# Agora precisamos combinar df3 com df2 e nomear o resultado como df4.
df4 = cbind(df2,df3) 
# colnames(df4) = c('Country','Score','Value','Test','Gender') # na versão original
colnames(df4) = c('País','Pontuação','Valor','Teste','Gênero')
df4$Pontuação = NULL # já que a coluna 'Pontuação' é redundante
view(df4)

# Ok! Agora os dados parecem limpos e organizados (e traduzidos!).
# Serão gerados vários gráficos com o uso da função facet_wrap() no ggplot2

ggplot(data = df4, aes(x=Teste,y=Valor, fill=Teste)) + 
  geom_boxplot()+
  scale_fill_brewer(palette="Green") + 
  geom_jitter(shape=16, position=position_jitter(0.2))+
  labs(title = 'Meninos tiveram desempenho melhor que as meninas?',
       y='Pontuação',x='Teste')+
  facet_wrap(~Gênero,nrow = 1)

# Ao olhar para esses gráficos, podemos ter alguns insights sobre o desempenho de meninos e meninas 
# Geralmente, os meninos tiveram melhor desempenho em Ciências e Matemática, 
# porém as mulheres tiveram melhor desempenho em Leitura. 
# No entanto, seria ingênuo tirar uma conclusão apenas olhando o boxplot. 
# Vamos nos aprofundar nos dados e verificar outros insights que podemos obter depois de preparar o dataframe.

# Como queremos comparar o desempenho de meninos e meninas em cada disciplina em todos os países participantes, 
# precisamos calcular a % de diferença em termos de pontuação para cada disciplina entre meninos e meninas e, 
# em seguida, plotá-la para visualizar.

# Como se realiza isso no R? Por meio da função mutate()!

#Vejamos o conjunto de dados limpo original que temos, df

# Agora usaremos a função mutate() para calcular, para cada país, a % de diferença entre meninos e meninas 
# para cada sujeito.

df = df %>% mutate(Maths.Diff = ((Maths.M - Maths.F)/Maths.F)*100,
                   Reading.Diff = ((Reading.M - Reading.F)/Reading.F)*100,
                   Science.Diff = ((Science.M - Science.F)/Science.F)*100,
                   Total.Score = Maths + Reading + Science,
                   Avg.Diff = (Maths.Diff+Reading.Diff+Science.Diff)/3
)
view(df)

# Agora plotamos o calculado para visualizar melhor os dados:
##### MATHS SCORE #####
ggplot(data=df, aes(x=reorder(Country.Name, Maths.Diff), y=Maths.Diff)) +
  geom_bar(stat = "identity", aes(fill=Maths.Diff)) +
  coord_flip() +
  theme_light() +
  geom_hline(yintercept = mean(df$Maths.Diff), size=1, color="black") +
  scale_fill_gradient(name="% de Nível de Diferença") +
  labs(title="Meninos são melhores em matemática?", x="", y="% de diferença das meninas")

# Análise:
# Este gráfico representa a % de diferença nas pontuações usando as meninas como referência. 
# Uma diferença positiva significa que os meninos pontuaram mais alto, enquanto uma diferença negativa significa que os meninos pontuaram mais baixo.
# A linha preta representa a diferença média em todos os países.

# Alguns insights interessantes que se pode tirar:
  
# - Em geral, os menino tiveram um desempenho melhor do que as meninas em matemática, especialmente na maioria das CDs, 
#   os menios pontuaram geralmente mais do que as meninas;
# - Curiosamente, em Cingapura e Hong Kong, meninos e meninas tiveram desempenho igual, com a diferença de pontuação 
#   em torno de 0 em cada um desses países. 
#   Este é um bom insight talvez para os formuladores de políticas porque não queremos uma enorme lacuna entre o desempenho de meninos e meninas na educação.

# Pode-se fazer a mesma coisa para verificar a pontuação de Leitura e de Ciências.

