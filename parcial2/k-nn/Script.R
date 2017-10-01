#Cargar el Dataset
alumnos <-read.csv("dataset-alumnos-v2.csv")
alumnos

summary(alumnos)

normalize = function(x){
  return((x-min(x)) / (max(x)-min(x)))
}
alumnos[3:25]
alumnos[alumnos=="NA"] <- 0
alumnos = sapply(alumnos[3:25],normalize)

alumnos

