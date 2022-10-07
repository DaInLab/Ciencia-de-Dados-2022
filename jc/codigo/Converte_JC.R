# Versâo atualizada em abril de 2022
# Acertando erro de localização de diretório de trabalhp
setwd(paste0(getwd(), "/jc"))
# Atenção:
# Antes de executar o código: 
# - No RStudio, ir até a aba Session -> Set Working Directory -> Choose Directory e ir até o diretório "<drive>:/JC" (Windows)
# Outra forma mais rápida de ir até o diretório é digitar as teclas Crtl + Shift + H
# Verificar se na aba Console aparece o comando "setwd("<drive>:/jc")
#
# Neste programa os "pacotes" pdftools (para extração de Texto, renderização e conversão de documentos em PDF) e xlsx (para Ler, gravar, formatar arquivos Excel) precisam estar instalados

# O comando abaixo verifica se estão instalado no RStudio, caso não estejam, são instalados
if (!"pdftools" %in% installed.packages()) install.packages("pdftools")
if (!"xlsx" %in% installed.packages()) install.packages("xlsx")

# "Carregando" as bibliotecas/pacotes utilizados no programa
library(pdftools)
library(xlsx)

dat<-pdf_text("./dados/JC_Tabela-compactado.pdf")
dat <- paste0(dat, collapse = " ")

#pattern <- "Berufsfeuerwehr\\s+Straße(.)*02366.39258"
pattern <- "Cidades\\s+2016(.)*-0,15%"
extract <- regmatches(dat, regexpr(pattern, dat))
pretable <- gsub("Cidades              2016      2017 crescimento  Cidades               2016      2017 crescimento\n", '', extract)
pretable <- gsub('\n', "", pretable)
#pretable <- gsub("%", "%\n", pretable)
pretable <- gsub("%", "\n", pretable)
pretable <- gsub("\n    ", "\n", pretable)
tabela <- (table(strsplit(pretable, "\n")))
df <- data.frame(tabela, stringsAsFactors = TRUE)
df$Var1 <- as.character(df$Var1)
df$Freq <- NULL
#df
format(df, decimal.mark=",")

words <- strsplit(df$Var1, "  ")

#format(words, decimal.mark=",")

i <- 1
last_one <- length(words)
while (i  <= last_one) {
    
    df$cidade[i]  <- sapply(words[i], function (x) gsub("^\\s+|\\s+$", "", x))[1]
    
    k <- 2
    while ((sapply(words[i], function (x) gsub("^\\s+|\\s+$", "", x))[k]) == "" ) k <- k + 1
    df$pop2016[i] <- as.numeric(sapply(words[i], function (x) gsub("^\\s+|\\s+$", "", x))[k])
   
    k <- k + 1
    while ((sapply(words[i], function (x) gsub("^\\s+|\\s+$", "", x))[k]) == "" ) k <- k + 1
    df$pop2017[i] <- as.numeric(sapply(words[i], function (x) gsub("^\\s+|\\s+$", "", x))[k])
   
    k <- k + 1
    while ((sapply(words[i], function (x) gsub("^\\s+|\\s+$", "", x))[k]) == "" ) k <- k + 1
#    df$indice[i]  <- as.numeric(sapply(words[i], function (x) gsub("^\\s+|\\s+$", "", x))[k])
    df$indice[i]  <- sapply(words[i], function (x) gsub("^\\s+|\\s+$", "", x))[k]
    i <- i + 1
}
df$Var1 <- NULL
df

write.xlsx(df, "./dados/estimativa_regiao.xlsx")

plot(df$pop2017, main="População Regional - Bauru", xlab="Cidades",  
        ylab="Qtde")

barplot(df$pop2017, main="População Regional - Bauru", xlab="Cidades",  
        ylab="Qtde", names.arg=df$cidade,
        border="blue")

