cpuData <- read.csv("machine.csv")

#Quitando las columnas no numericas
cpuMatrix <- cpuData[-1]
cpuMatrix <- cpuMatrix[-1]

#Correlacion de la matriz

cor(cpuMatrix)
#Grafica de scatter `para la correlacion de PRP y MMAX`
plot(cpuMatrix$PRP,cpuMatrix$MMAX)

#Grafica de scatter `para la correlacion de PRP y MMAX`
plot(cpuMatrix$ERP,cpuMatrix$MMAX)

#Grafica de scatter `para la correlacion de PRP y ERP`
plot(cpuMatrix$ERP,cpuMatrix$PRP)
