#Leer Dataset de puchamones
pokemon <- read.csv("pokemon.csv",stringsAsFactors = F)

#Quitamos las Columnas no numericas que no nos importan
poke_raw <- pokemon[-1:-19]
poke_raw <- poke_raw[-6]
poke_raw <- poke_raw[-10:-11]
poke_raw <- poke_raw[-15:-16]
poke_raw <- poke_raw[-10]
poke_raw <- poke_raw[-8]
poke_raw <- poke_raw[-13]
poke_raw <- poke_raw[-5]
poke_raw <- poke_raw[-13]

# Funciona que normaliza
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}
# Convertir ints a numeric
poke_raw <-as.data.frame(lapply(poke_raw,as.numeric))

# Normalizar
poke_norm <- as.data.frame(lapply(poke_raw,normalize))
str(poke_norm$attack)


#Ordenarlos al azar
set.seed(32165)
poke_randomizer <- sample(800,640)

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
                         k = 1)

# Tabla
table(poke_test_labels,pokemon_test_pred)
