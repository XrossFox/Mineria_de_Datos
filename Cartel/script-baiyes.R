comments_raw <- read.csv("comment.csv", stringsAsFactors = FALSE)

#Extirpamos las columnas que no queremos

str(comments_raw)

#transformar el tipo a factor para que jaaaale
comments_raw$gid <- as.character(factor(comments_raw$gid,
                                                       c(25160801076,
                                                         117291968282998,
                                                         1443890352589739,
                                                         1239798932720607,
                                                         335787510131917
                                                         ),
                                                       c("Unofficial Cheltenham Township, PA",
                                                         "Elkins Park Happenings!",
                                                         "Cheltenham Schools and Township Open Forum",
                                                         "Cheltenham Lateral Solutions",
                                                         "Cheltenham Township Residents"
                                                         )
                                                       )
                                                )
comments_raw$gid <- factor(comments_raw$gid)

drops <- c("gid","msg")
comments_c_drop <- comments_raw[ , (names(comments_raw) %in% drops)]

comments_c_drop$msg <- gsub('\\{APOST\\}', '', comments_c_drop$msg)
comments_c_drop$msg <- gsub('\\{COMMA\\}', '', comments_c_drop$msg)
lapply(comments_c_drop$msg[1:5],as.character)

#Estandarizacion de datos y corpus
library("tm")
comments_corpus <- VCorpus(VectorSource(comments_c_drop$msg))
as.character(comments_corpus[1])

lapply(comments_corpus[1:5],as.character)



#Convertimos texto a minusculas, se remueven stop words, numeros y puntuaciones
comments_corpus_clean <- tm_map(comments_corpus , content_transformer(tolower))
comments_corpus_clean <- tm_map(comments_corpus_clean , removeNumbers)
comments_corpus_clean <- tm_map(comments_corpus_clean, removeWords, stopwords())
comments_corpus_clean <- tm_map(comments_corpus_clean , removePunctuation)

lapply(comments_corpus_clean[1:5],as.character)

#Sacar raices de las palabras del texto y quitar espacios

comments_corpus_clean <- tm_map(comments_corpus_clean,stemDocument)
comments_corpus_clean <- tm_map(comments_corpus_clean,stripWhitespace)

#Matriz de terminos

comment_dtm <- DocumentTermMatrix(comments_corpus_clean)
comment_dtm

#Separacion de los datos de prueba en dos arreglos, 70/30%
#Ordenarlos al azar
set.seed(32165)
randomizer <- sample(118650,83055)

comment_dtm_train <- comment_dtm[randomizer,]
comment_dtm_test <- comment_dtm[-randomizer,]

comment_train_labels <- comments_c_drop[randomizer,]$gid
comment_test_labels <- comments_c_drop[-randomizer,]$gid

#proporciones de ironic y non ironic, para saber si son aproximadamente proporcionales
prop.table(table(comment_train_labels))

prop.table(table(comment_test_labels))

#--------------------------------------------------------------- Esto no jala
#nube de palabras
#library(wordcloud)
#wordcloud(comments_corpus_clean,min.freq = 50, random.order = F)
#warnings()


#Nube de palabras de ironic y non-ironic
#Lateral_Solutions <- subset(comments_corpus_clean, label == "Cheltenham Lateral Solutions")
#Cheltenham_Schools <- subset(comments_corpus_clean, label == "Cheltenham Schools and Township Open Forum")
#Cheltenham_Township <- subset(comments_corpus_clean, label == "Cheltenham Township Residents")
#Elkins_Park <- subset(comments_corpus_clean, label == "Elkins Park Happenings!")
#Unofficial_Cheltenham <- subset(comments_corpus_clean, label == "Unofficial Cheltenham Township, PA")



#wordcloud(ironic$comment_text , max.words = 40, scale = c(3,0.5))
#wordcloud(non.ironic$comment_text , max.words = 40, scale = c(3,0.5))


#----------------------------------------------------------------



#quitar las palabras que se repiten 5 o menos
comment_freq_words <- findFreqTerms(comment_dtm_train,5)

comment_dtm_freq_train <- comment_dtm_train[,comment_freq_words]
comment_dtm_freq_test <- comment_dtm_test[,comment_freq_words]

#Ejecutar Naive Bayes

convert_counts <- function(x){
  x <- ifelse(x > 0, "Yes","No")
  
}

comment_train <- apply(comment_dtm_freq_train, MARGIN = 2, convert_counts)
comment_test <- apply(comment_dtm_freq_test, MARGIN = 2, convert_counts)

library(e1071)

dtm_classifier <- naiveBayes(comment_train, comment_train_labels)

dtm_test_pred <- predict(comment_classifier, comment_test)


##Tablas

library(gmodels)
table(comment_test_pred,comment_test_labels)

####

####
###

irony_classifier2 <- naiveBayes(irony_train,irony_train_labels,laplace = 1)
irony_test_pred2 <- predict(irony_classifier2, irony_test)
table(irony_test_pred2,irony_test_labels)
