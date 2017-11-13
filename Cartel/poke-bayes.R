poke_raw <- read.csv("legendarios.csv", stringsAsFactors = F)

#transformar el tipo a factor para que jaaaale
poke_raw$is_legendary <- as.character(factor(poke_raw$is_legendary,c(1,0),c("legendary","non-legendary")))
poke_raw$is_legendary <- factor(poke_raw$is_legendary)

#Estandarizacion de datos y corpus
library("tm")
poke_corpus <- VCorpus(VectorSource(poke_raw$pokedex))


#Convertimos texto a minusculas, se remueven stop words, numeros y puntuaciones
poke_corpus_clean <- tm_map(poke_corpus , content_transformer(tolower))
poke_corpus_clean <- tm_map(poke_corpus_clean , removeNumbers)
poke_corpus_clean <- tm_map(poke_corpus_clean, removeWords, stopwords())
poke_corpus_clean <- tm_map(poke_corpus_clean , removePunctuation)

lapply(poke_corpus_clean[1:2],as.character)

#Sacar raices de las palabras del texto y quitar espacios

poke_corpus_clean <- tm_map(poke_corpus_clean,stemDocument)
poke_corpus_clean <- tm_map(poke_corpus_clean,stripWhitespace)

#Matriz de terminos

poke_dtm <- DocumentTermMatrix(poke_corpus_clean)
poke_dtm

#Separacion de los datos de prueba en dos arreglos, 70/30%
set.seed(32165)
randomizer <- sample(800,640)

poke_dtm_train <- poke_dtm[randomizer,]
poke_dtm_test <- poke_dtm[-randomizer,]

poke_train_labels <- poke_raw[randomizer,]$is_legendary
poke_test_labels <- poke_raw[-randomizer,]$is_legendary

#proporciones de ironic y non ironic, para saber si son aproximadamente proporcionales
prop.table(table(poke_train_labels))

prop.table(table(poke_test_labels))

#nube de palabras
library(wordcloud)
wordcloud(poke_corpus_clean,min.freq = 50, random.order = F)

#Nube de palabras de ironic y non-ironic
legendary <- subset(poke_raw, is_legendary == "legendary")
non.legendary <- subset(poke_raw, is_legendary == "non-legendary")
wordcloud(legendary$pokedex , max.words = 40, scale = c(3,0.5))
wordcloud(non.legendary$pokedex , max.words = 40, scale = c(3,0.5))

#quitar las palabras que se repiten 5 o menos
poke_freq_words <- findFreqTerms(poke_dtm_train,5)

poke_dtm_freq_train <- poke_dtm_train[,poke_freq_words]
poke_dtm_freq_test <- poke_dtm_test[,poke_freq_words]

#Ejecutar Naive Bayes

convert_counts <- function(x){
  x <- ifelse(x > 0, "Yes","No")
  
}

poke_train <- apply(poke_dtm_freq_train, MARGIN = 2, convert_counts)
poke_test <- apply(poke_dtm_freq_test, MARGIN = 2, convert_counts)

library(e1071)

poke_classifier <- naiveBayes(poke_train, poke_train_labels)

poke_test_pred <- predict(poke_classifier, poke_test)


##Tablas

library(gmodels)
CrossTable(poke_test_pred,poke_test_labels)

