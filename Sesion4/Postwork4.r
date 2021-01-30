library(dplyr)
library(ggplot2)
​
##Enviar al directorio de trabajo
setwd("C:/Users/jtoba/Documents/BEDU/R/Sesion2Reto3/Postwork")
​
##Descargar los archivos a utilizar
​
url1 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
url2 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
url3 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
​
download.file(url = url1, destfile = "SP1-1011.csv", mode = "wb")
download.file(url = url2, destfile = "SP1-1112.csv", mode = "wb")
download.file(url = url3, destfile = "SP1-1213.csv", mode = "wb")
​
​
lista2 <- lapply(dir(pattern = ".csv"), read.csv)
lista2 <- lapply(lista2, select, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR) 
lista2<- lapply(lista2, mutate,Date=as.Date(Date, "%d/%m/%y"))
​
data2 <- do.call(rbind, lista2)
​
​
##Leer los datos de goles anotados por equipos de casa (FTHG) y por equipos visitantes (FTAG)
FTHG<-data2$FTHG
FTAG<-data2$FTAG
​
##La probabilidad de que un equipo de casa anote x goles
Prob_FTHG<-table(FTHG)/length(FTHG)
​
##La probabilidad de que un equipo visitante anote x goles
Prob_FTAG<-table(FTAG)/length(FTAG)
​
##La probabilidad de que un equpo de casa anote x1 goles y el equipo visitante anote x2 goles
#Columnas con los goles del equipo visitante y las filas los goles del equipo local
Prob_Conjunta<-table(as.data.frame(cbind(FTHG,FTAG)))/length(FTAG)
​
#---- PUNTO 1
​
#Dividimos entre la probabilidad marginal de los goles de casa
a<-function(n){n/Prob_FTHG}
​
Prob_Conjunta<-apply(Prob_Conjunta, 2, a)
​
#Dividimos entre la probabilidad marginal de los goles de visitante
b<-function(n){n/Prob_FTAG}
​
Prob_Conjunta<-apply(Prob_Conjunta, 1, b)
​
#----- PUNTO 2
​
​
library(rsample)
​
Prob_Conjunta2 <- as.data.frame(as.table(Prob_Conjunta))
​
# Aplicación de bootstrap
Prob_Conjunta_boot <- bootstraps(Prob_Conjunta2, times = 100)
Prob_Conjunta2_boot <- Prob_Conjunta_boot$splits[[1]]
​
Prob_Conjunta2_boots <- as.data.frame(Prob_Conjunta2_boot)
​
#Redondeamos a un dígito los cocientes
Prob_Conjunta2_boots$Freq <- round(Prob_Conjunta2_boots$Freq,1)
​
#Comprobación de aplicación correcta de bootstrap
mean(Prob_Conjunta2$Freq)
mean(Prob_Conjunta2_boots$Freq)
​
#Filtramos los cocientes igual a 1. (Independencia en las variables aleatorias).
Prob_Conjunta2_boots[Prob_Conjunta2_boots$Freq==1.0,]
