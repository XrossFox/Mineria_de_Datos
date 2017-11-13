poke <- read.csv("legendarios.csv" stringsAsFactors = F)

head(irony_raw)
#transformar el tipo a factor para que jaaaale
irony_raw$label <- as.character(factor(irony_raw$label,c(1,-1),c("ironic","non-ironic")))
irony_raw$label <- factor(irony_raw$label)

#Estandarizacion de datos y corpus
library("tm")
irony_corpus <- VCorpus(VectorSource(irony_raw$comment_text))
as.character(irony_corpus[1])

lapply(irony_corpus[1:2],as.character)

#Convertimos texto a minusculas, se remueven stop words, numeros y puntuaciones
irony_corpus_clean <- tm_map(irony_corpus , content_transformer(tolower))
irony_corpus_clean <- tm_map(irony_corpus_clean , removeNumbers)
irony_corpus_clean <- tm_map(irony_corpus_clean, removeWords, stopwords())
irony_corpus_clean <- tm_map(irony_corpus_clean , removePunctuation)

lapply(irony_corpus_clean[1:2],as.character)

#Sacar raices de las palabras del texto y quitar espacios

irony_corpus_clean <- tm_map(irony_corpus_clean,stemDocument)
irony_corpus_clean <- tm_map(irony_corpus_clean,stripWhitespace)

#Matriz de terminos

irony_dtm <- DocumentTermMatrix(irony_corpus_clean)
irony_dtm

#Separacion de los datos de prueba en dos arreglos, 70/30%
irony_dtm_train <- irony_dtm[1:1364,]
irony_dtm_test <- irony_dtm[1365 : 1949,]
irony_train_labels <- irony_raw[1:1364,]$label
irony_test_labels <- irony_raw[1365 : 1949,]$label

#proporciones de ironic y non ironic, para saber si son aproximadamente proporcionales
prop.table(table(irony_train_labels))

prop.table(table(irony_test_labels))

#nube de palabras
library(wordcloud)
wordcloud(irony_corpus_clean,min.freq = 50, random.order = F)

#Nube de palabras de ironic y non-ironic
ironic <- subset(irony_raw, label == "ironic")
non.ironic <- subset(irony_raw, label == "non-ironic")
wordcloud(ironic$comment_text , max.words = 40, scale = c(3,0.5))
wordcloud(non.ironic$comment_text , max.words = 40, scale = c(3,0.5))

#quitar las palabras que se repiten 5 o menos
irony_freq_words <- findFreqTerms(irony_dtm_train,5)

irony_dtm_freq_train <- irony_dtm_train[,irony_freq_words]
irony_dtm_freq_test <- irony_dtm_test[,irony_freq_words]

#Ejecutar Naive Bayes

convert_counts <- function(x){
  x <- ifelse(x > 0, "Yes","No")
  
}

irony_train <- apply(irony_dtm_freq_train, MARGIN = 2, convert_counts)
irony_test <- apply(irony_dtm_freq_test, MARGIN = 2, convert_counts)

library(e1071)

irony_classifier <- naiveBayes(irony_train, irony_train_labels)

irony_test_pred <- predict(irony_classifier, irony_test)


##Tablas

library(gmodels)
table(irony_test_pred,irony_test_labels)

irony_classifier2 <- naiveBayes(irony_train,irony_train_labels,laplace = 1)
irony_test_pred2 <- predict(irony_classifier2, irony_test)
table(irony_test_pred2,irony_test_labels)
