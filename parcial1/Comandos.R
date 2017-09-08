cpuData <- read.csv("machine.csv")

#Quitando las columnas no numericas
cpuMatrix <- cpuData[-1]
cpuMatrix <- cpuMatrix[-1]

#Grafica de scatter `para la correlacion de PRP y MMAX`
plot(cpuMatrix$PRP,cpuMatrix$MMAX)

#Grafica de scatter `para la correlacion de PRP y MMAX`
plot(cpuDataMat$ERP,cpuDataMat$MMAX)

#Grafica de scatter `para la correlacion de PRP y ERP`
plot(cpuDataMat$ERP,cpuDataMat$PRP)
