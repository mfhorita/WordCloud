
install.packages("tm")
install.packages("SnowballC")
install.packages("wordcloud")
install.packages("RColorBrewer")
# detach(package:tm) # Descarregar o pacote

library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")

# Lendo o arquivo
dir() # or list.files()
setwd('C:/_RFundamentos/Modulo2_LinguagemR')
getwd()

arquivo <- "Curriculo.txt"
texto <- readLines(arquivo)
head(texto)

# Carregando os dados como Corpus
docs <- Corpus(VectorSource(texto))

# Pre-processamento
inspect(docs)
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))

docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")
docs <- tm_map(docs, toSpace, "<")
docs <- tm_map(docs, toSpace, ">")

# Converte o texto para minúsculo
#docs <- tm_map(docs, content_transformer(tolower))

# Remove numeros
docs <- tm_map(docs, removeNumbers)

# Remove as palavras mais comuns do idioma ingles
docs <- tm_map(docs, removeWords, stopwords("english"))

# Remove pontuacao
docs <- tm_map(docs, removePunctuation)

# Elimina espaços extras
docs <- tm_map(docs, stripWhitespace)

# Text stemming
# docs <- tm_map(docs, stemDocument)

# Voce pode definir um vetor de palavras (stopwords) a serem removidas do texto
#docs <- tm_map(docs, removeWords, c("com", "dado", "at?", "nos", "para", "nas"))

dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
n <- as.double(v[1]+10)
marcelo <- c(marcelo = n)
horita <- c(horita = n - 1)
R <- c(R = n - 3)
python <- c(python = n - 6)
v1 <- unlist(list(marcelo, horita, R, python, v))
d <- data.frame(word = names(v1),freq=v1)
head(d, 10)

nrow(d) # numero de linhas do data frame
ncol(d) # numero de colunas do data frame
dim(d) # numero de linhas e colunas do data frame

# png
set.seed(55555)
png("wordcloud.png", width = 500, height = 500, res = 72)
  wordcloud(words = d$word, freq = d$freq, min.freq = 2,
            max.words=200, random.order=FALSE, rot.per=0.35, 
            colors=brewer.pal(8, "Paired") )
dev.off()

# pdf
pdf("wordcloud.pdf")
  wordcloud(words = d$word, freq = d$freq, min.freq = 2,
            max.words=200, random.order=FALSE, rot.per=0.35, 
            colors=brewer.pal(8, "Paired") )
dev.off()

# --------------------------------------------------------------------
# BAR Plots (Frequencia)
# --------------------------------------------------------------------

  # Tabela de frequencia
  findFreqTerms(dtm, lowfreq = 4)
  findAssocs(dtm, terms = "freedom", corlimit = 0.3)
  head(d, 10)
  
  # Graficos de barras com as palavras mais frequentes
  barplot(d[1:10,]$freq, las = 2, names.arg = d[1:10,]$word,
          col ="lightblue", main ="Most frequent words",
          ylab = "Word frequencies")

# --------------------------------------------------------------------
  