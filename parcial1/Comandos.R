#Con este comando se carga el data set
horseData <- read.csv("horse.csv")

#Con los siguientes dos comandos, se reemplazan las columnas no numericas, y se guardan en una matriz
horseData$surgery <- factor(horseData$surgery,
                         levels=c("yes","no"),
                         labels=c(1,0))

horseData$age <- factor(horseData$age,
                            levels=c("young","adult"),
                            labels=c(1,2))

horseData$temp_of_extremities <- factor(horseData$temp_of_extremities,
                        levels=c("cold","cold","war,","normal"),
                        labels=c(4,3,2,1))

horseData$peripheral_pulse <- factor(horseData$peripheral_pulse,
                                        levels=c("normal", 
                                                 "increased",
                                                 "reduced", 
                                                 "absent" ),
                                        labels=c(1,2,3,4))

horseData$mucous_membrane <- factor(horseData$mucous_membrane,
                                        levels=c("normal_pink" ,
                                                 "bright_pink" ,
                                                 "pale_pink", 
                                                 "pale_cyanotic" ,
                                                 "bright_red", 
                                                 "dark_cyanotic"),
                                        labels=c(1,2,3,4,5,6))

horseData$capillary_refill_time <- factor(horseData$capillary_refill_time,
                                        levels=c("less_3_sec","more_3_sec"),
                                        labels=c(1,2))

horseData$peristalsis <- factor(horseData$peristalsis,
                                        levels=c("hypermotile", 
                                                 "normal", 
                                                 "hypomotile", 
                                                 "absent" ),
                                        labels=c(1,2,3,4))

horseData$peristalsis <- factor(horseData$peristalsis,
                                levels=c("hypermotile", 
                                         "normal", 
                                         "hypomotile", 
                                         "absent" ),
                                labels=c(1,2,3,4))

horseData$abdominal_distention <- factor(horseData$abdominal_distention,
                                levels=c("none", 
                                         "slight", 
                                         "moderate ",
                                         "severe"  ),
                                labels=c(1,2,3,4))

horseData$nasogastric_tube <- factor(horseData$nasogastric_tube,
                                         levels=c("none", 
                                                  "slight ",
                                                  "significant"   ),
                                         labels=c(1,2,3))

horseData$nasogastric_reflux <- factor(horseData$nasogastric_reflux,
                                     levels=c("none", 
                                              "more_1_liter",
                                              "less_1_liter"),
                                     labels=c(1,2,3))

horseData$rectal_exam_feces <- factor(horseData$rectal_exam_feces,
                                       levels=c("normal", 
                                                "increased ",
                                                "decreased ",
                                                "absent" ),
                                       labels=c(1,2,3,4))

horseData$abdomen <- factor(horseData$abdomen,
                                      levels=c("normal", 
                                               "other",
                                               "firm",
                                               "distended_small",
                                               "distended_large"),
                                      labels=c(1,2,3,4,5))

horseData$abdomo_appearance <- factor(horseData$abdomo_appearance,
                            levels=c("clear", 
                                     "cloudy",
                                     "serosanguinous"),
                            labels=c(1,2,3))

horseData$outcome <- factor(horseData$outcome,
                                      levels=c("lived",
                                               "died",
                                               "euthanized"),
                                      labels=c(1,2,3))

horseData$surgical_lesion <- factor(horseData$surgical_lesion,
                            levels=c("yes","no"),
                            labels=c(1,0))

#Matriz de datos con columnas importantes (para correlacion)
horseMatrix <- data.frame(as.numeric(horseData$surgery),
                          as.numeric(horseData$age),
                          as.numeric(horseData$rectal_temp),
                          as.numeric(horseData$pulse),
                          as.numeric(horseData$respiratory_rate),
                          as.numeric(horseData$temp_of_extremities),
                          as.numeric(horseData$peripheral_pulse),
                          as.numeric(horseData$mucous_membrane),
                          as.numeric(horseData$capillary_refill_time),
                          as.numeric(horseData$abdominal_distention),
                          as.numeric(horseData$nasogastric_tube),
                          as.numeric(horseData$nasogastric_reflux),
                          as.numeric(horseData$nasogastric_reflux_ph),
                          as.numeric(horseData$rectal_exam_feces),
                          as.numeric(horseData$abdomen),
                          as.numeric(horseData$packed_cell_volume),
                          as.numeric(horseData$total_protein),
                          as.numeric(horseData$abdomo_appearance),
                          as.numeric(horseData$abdomo_protein),
                          as.numeric(horseData$outcome),
                          as.numeric(horseData$surgical_lesion)
                          )


#Con este comando se hace la correlacion del dataset
cor(horseMatrix,use="pairwise")

#Grafica de scatter `para la correlacion de PRP y MMAX`
plot(cpuDataMat$PRP,cpuDataMat$MMAX)

#Grafica de scatter `para la correlacion de PRP y MMAX`
plot(cpuDataMat$ERP,cpuDataMat$MMAX)

#Grafica de scatter `para la correlacion de PRP y ERP`
plot(cpuDataMat$ERP,cpuDataMat$PRP)
