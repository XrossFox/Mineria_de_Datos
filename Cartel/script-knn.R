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

#Quitamos las Columnas no numericas que no nos importan
poke_raw <- pokemon[-1:-19]
poke_raw <- poke_raw[-6]
poke_raw <- poke_raw[-10:-11]
poke_raw <- poke_raw[-15:-16]


# Funciona que normaliza
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}
# Convertir ints a numeric
poke_raw[-17] <-as.data.frame(lapply(poke_raw[-17],as.numeric))

# Normalizar
poke_norm <- as.data.frame(lapply(poke_raw[-17],normalize))
str(poke_norm$attack)


#Ordenarlos al azar
set.seed(32165)
poke_randomizer <- sample(801,640)

poke_train <- poke_norm[poke_randomizer,]
poke_test <- poke_norm[-poke_randomizer,]

#Labels
poke_train_labels <- as.factor(pokemon$is_legendary[poke_randomizer])
poke_test_labels <- as.factor(pokemon$is_legendary[-poke_randomizer])

round( prop.table(table(poke_train_labels))*100,digits=8)
round( prop.table(table(poke_test_labels))*100,digits=8)

# Aplicar knn
library(class)
pokemon_test_pred <- knn(train = poke_train,
                         test = poke_test,
                         cl = poke_train_labels,
                         k = 5)

# Tabla
library(gmodels)
table(poke_test_labels,pokemon_test_pred)
