sms_raw <- read.csv("sms_spam.csv", stringsAsFactors = FALSE)

str(sms_raw)

#transformar el tipo a factor para que jaaaale
sms_raw$type <- factor(sms_raw$type)

str(sms_raw$type)

table(sms_raw$type)

library("tm")

sms_corpus <- VCorpus (VectorSource(sms_raw$text))

print(sms_corpus)

#del mensaje uno al dos
inspect(sms_corpus[1:2])

as.character(sms_corpus[[1]])

#aplica la funcion del 1 al 10
lapply(sms_corpus[1:10],as.character)

#quitar variaciones de palabras
sms_corpus_clean <- tm_map(sms_corpus, content_transformer(tolower))

as.character(sms_corpus[[1]])
as.character(sms_corpus_clean[[1]])

#remover numeros
sms_corpus_clean <- tm_map(sms_corpus_clean, removeNumbers)

#quitar but, to etc y de el
#stopWords
#removeWords

sms_corpus_clean <- tm_map(sms_corpus_clean, removeWords, stopwords())

#remover puntuacion
sms_corpus_clean <- tm_map(sms_corpus_clean, removePunctuation)

replacePunctuation <- function(x){
  gsub("[[: punct:]] +", " ",x)
}

replacePunctuation

#raiz de las palabras

library(SnowballC)

wordStem(c(" learn"," learned"," learning"," learns"))

sms_corpus_clean <- tm_map( sms_corpus_clean, stemDocument)

#espacios en blanco
sms_corpus_clean <- tm_map( sms_corpus_clean, stripWhitespace)

as.character(sms_corpus_clean[[4]])

#Document term matrix
#dispersa si la mayoria esta en cero

sms_dtm <- DocumentTermMatrix(sms_corpus_clean)
sms_dtm

sms_dtm2 <- DocumentTermMatrix(sms_corpus, control = list(
  tolower = TRUE,
  removeNumbers = TRUE,
  stopwords = TRUE,
  removePunctuation = TRUE,
  stemming = TRUE
))

sms_dtm2

sms_dtm_train <- sms_dtm[1 : 4169,]
sms_dtm_test <- sms_dtm[4170 : 5559,]
sms_train_labels <- sms_raw[1 : 4169,]$type
sms_test_labels <- sms_raw[4170 : 5559,]$type

prop.table(table(sms_train_labels))

prop.table(table(sms_test_labels))

library(wordcloud)

wordcloud(sms_corpus_clean,min.freq = 50,random.order = FALSE)

spam <- subset(sms_raw, type == "spam")
ham <- subset(sms_raw, type == "ham")

wordcloud(spam$text, max.words = 40, scale = c(3,0.5))

sms_freq_words <- findFreqTerms(sms_dtm_train,5)
str(sms_freq_words)

sms_dtm_freq_train <- sms_dtm_train [,sms_freq_words]
sms_dtm_freq_test <- sms_dtm_test [,sms_freq_words]

convert_counts <- function(x) {x = ifelse(x>0,"yes","no")}
sms_train <- apply(sms_dtm_freq_train, MARGIN = 2, convert_counts)
sms_test <- apply(sms_dtm_freq_test, MARGIN = 2, convert_counts)

library(e1071)

sms_classifier <- naiveBayes(sms_train,sms_train_labels)
sms_test_pred <- predict(sms_classifier,sms_test)

library(gmodels)
CrossTable(sms_test_pred, sms_test_labels)
sms_classifier2 <- naiveBayes(sms_train, sms_train_labels, laplace = 1)
sms_test_pred2 <- predict(sms_classifier2,sms_test)
