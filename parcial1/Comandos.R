#Con este comando se carga el data set
cpuData <- read.csv("machine.csv")

#Con los siguientes dos comandos, se eliminan las columnas no numericas, y se guardan en una matriz
cpuDataMat <- cpuData[-1]
cpuDataMat <- cpuDataMat[-1]

#Con este comando se hace la correlacion del dataset
cor(cpuDataMat)

#Grafica de scatter `para la correlacion de PRP y MMAX`
plot(cpuDataMat$PRP,cpuDataMat$MMAX)

