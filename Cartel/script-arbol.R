#Leer Dataset de puchamones
pokemon <- read.csv("pokemon.csv")

#Procesando datos
pokemon$capture_rate <- sapply(pokemon$capture_rate,as.integer)

#Eliminar caracteres vacios
pokemon$type2 <- sub("^$", "None", pokemon$type2)

#Porcentaje de macho, y reemplazar na por -1
pokemon$percentage_male <- sapply(pokemon$percentage_male,as.integer)
pokemon$percentage_male[is.na(pokemon$percentage_male)] <- -1

pokemon$is_legendary <- factor(pokemon$is_legendary,
                               levels=c(0,1),
                               labels=c("No","Si"))
#reemplazar altura y peso NA
pokemon$height_m[is.na(pokemon$height_m)] <- -1
pokemon$weight_kg[is.na(pokemon$weight_kg)] <- -1

#Ordenarlos al azar
set.seed(46165)
poke_randomizer <- sample(801,640)

poke_train <- pokemon[poke_randomizer,]
poke_test <- pokemon[-poke_randomizer,]

prop.table(table(poke_train$is_legendary))
prop.table(table(poke_test$is_legendary))

library(C50)
#Modelo
poke_model <- C5.0(poke_train[-41],poke_train$is_legendary)
summary(poke_model)

#Prediccion
poke_pred <- predict(poke_model, poke_test)

summary(poke_pred)
library(gmodels)
CrossTable(poke_pred,poke_test$is_legendary)

