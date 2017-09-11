cpuData <- read.csv("machine.csv")

#Quitando las columnas no numericas
cpuMatrix <- cpuData[-1]
cpuMatrix <- cpuMatrix[-1]
<<<<<<< Updated upstream

#Correlacion de la matriz

cor(cpuMatrix)
=======
cpuMatrix
>>>>>>> Stashed changes
#Grafica de scatter `para la correlacion de PRP y MMAX`
plot(cpuMatrix$PRP,cpuMatrix$MMAX)

#Grafica de scatter `para la correlacion de PRP y MMAX`
<<<<<<< Updated upstream
plot(cpuMatrix$ERP,cpuMatrix$MMAX)

#Grafica de scatter `para la correlacion de PRP y ERP`
plot(cpuMatrix$ERP,cpuMatrix$PRP)
<<<<<<< Updated upstream
=======
plot(cpuMatrix$ERP,cpuDataMat$MMAX)

#Grafica de scatter `para la correlacion de PRP y ERP`
plot(cpuMatrix$ERP,cpuDataMat$PRP)
>>>>>>> Stashed changes
=======

#Boxplot of machine cycle time
boxplot(cpuData$MYCT,
        main = "Boxplot of Machine cycle time",
        ylab = "Nanosenconds (Ns.)") 

#Boxplot of the minimum main memory
boxplot(cpuData$MMIN,
        main = "Boxplot of Minimum main memory",
        ylab = "Kilobytes (Kb.)")

#Boxplot of the maximum main memory
boxplot(cpuData$MMAX,
        main = "Boxplot of Maximum main memory",
        ylab = "Kilobytes (Kb.)") 

#boxplot of the cache memory
boxplot(cpuData$CACH,
        main = "Boxplot of cache memory",
        ylab = "Kilobytes (Kb.)") 

#boxplot of the maximum main memory
boxplot(cpuData$MMAX,
        main = "Boxplot of Maximum main memory",
        ylab = "Kilobytes (Kb.)")

#boxplot of the minimum channels
boxplot(cpuData$CHMIN,
        main = "Boxplot of Minimum channels",
        ylab = "Units (U.)")

#boxplot of the maximum channels
boxplot(cpuData$CHMAX,
        main = "Boxplot of Maximum channels",
        ylab = "Units (U.)")

#boxploot of the relative performance
boxplot(cpuData$PRP,
        main = "Boxplot of published relative performance",
        ylab = "Performance (P.)") 

#boxplot of the estimated relative performance from original article
boxplot(cpuData$MMAX,
        main = "Boxplot of estimated relative performance from original article",
        ylab = "Performance (P.)") 
>>>>>>> Stashed changes
