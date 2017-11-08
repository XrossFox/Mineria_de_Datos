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

# Funciona que normaliza
normalize <- function(x){
  return (x-min(x))/max(x)-min(x)
}

# Normalizar
poke_norm <- as.data.frame(lapply(poke_raw,normalize))

#Ordenarlos al azar
set.seed(504)
poke_randomizer <- sample(800,640)

poke_train <- poke_norm[poke_randomizer,]
poke_test <- poke_norm[-poke_randomizer,]
