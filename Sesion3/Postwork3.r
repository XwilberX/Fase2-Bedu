library(dplyr)
library(ggplot2)
library(rsample)

##Enviar al directorio de trabajo
setwd("C:/Users/infrabyte/Documents/Github/Fase2-Bedu/Sesion4/files")

##Descargar los archivos a utilizar

url1 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
url2 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
url3 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"

download.file(url = url1, destfile = "SP1-1011.csv", mode = "wb")
download.file(url = url2, destfile = "SP1-1112.csv", mode = "wb")
download.file(url = url3, destfile = "SP1-1213.csv", mode = "wb")


lista2 <- lapply(dir(pattern = ".csv"), read.csv)
lista2 <- lapply(lista2, select, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR) 
lista2<- lapply(lista2, mutate,Date=as.Date(Date, "%d/%m/%y"))

data2 <- do.call(rbind, lista2)


##Leer los datos de goles anotados por equipos de casa (FTHG) y por equipos visitantes (FTAG)
FTHG<-data2$FTHG
FTAG<-data2$FTAG

##La probabilidad de que un equipo de casa anote x goles
#Prob_FTHG<-table(FTHG)/length(FTHG)

##La probabilidad de que un equipo visitante anote x goles
#Prob_FTHG<-table(FTAG)/length(FTAG)

##La probabilidad de que un equpo de casa anote x1 goles y el equipo visitante anote x2 goles
#Columnas con los goles del equipo visitante y las filas los goles del equipo local
Prob_Conjunta<-table(as.data.frame(cbind(FTHG,FTAG)))/length(FTAG)


Prob_FTHG<-table(FTHG)/length(FTHG)

##La probabilidad de que un equipo visitante anote x goles
Prob_FTAG<-table(FTAG)/length(FTAG)

##La probabilidad de que un equpo de casa anote x1 goles y el equipo visitante anote x2 goles
#Columnas con los goles del equipo visitante y las filas los goles del 
a<-function(n){n/Prob_FTHG}

Prob_Conjunta_2<-apply(Prob_Conjunta, 2, a)

b<-function(n){n/Prob_FTAG}

Prob_Conjunta_2<-apply(Prob_Conjunta_2, 1, b)


as.data.frame(as.table(Prob_Conjunta_2))


set.seed(4892)

conjunto_boot = c()

for(i in 1:1000){
    conjunto_boot[i] <- mean(Prob_Conjunta_2[sample(1:length(Prob_Conjunta_2), 100, replace = T)])
}

qplot(Prob_Conjunta_2, geom = "histogram") + geom_vline(xintercept = mean(Prob_Conjunta_2))

qplot(conjunto_boot, geom = "histogram") + geom_vline(xintercept = mean(conjunto_boot))


View(conjunto_boot)

#Gráfico de barras de goles de casa (probablidad marginal)
Inciso1 <- as.data.frame(Prob_FTHG)


Inciso1 %>% 
    ggplot(aes(x=FTHG,y=Freq)) +
    geom_bar(stat="identity", fill= "#69b3a2") +
    labs(x="Goles anotados", y= "Probabilidad marginal", title="Goles de casa")

##Gráfico de barras de goles de visitante (probabilidad marginal)
Inciso2 <- as.data.frame(Prob_FTAG)

Inciso2 %>% 
    ggplot(aes(x=FTAG,y=Freq)) +
    geom_bar(stat="identity", fill= "#69b3a2") +
    labs(x="Goles anotados", y= "Probabilidad marginal", title="Goles de visitante")

##Heatmap
Inciso3 <- as.data.frame(Prob_Conjunta)

Inciso3 %>% 
    ggplot(aes(x=FTHG, y=FTAG, fill=Freq))+
    geom_tile()+
    labs(x="Goles equipo de casa", y="Goles equipo visitante", fill="Probabilidad", 
    title= "Probabilidad Conjunta: Goles de casa vs. Goles visitante")+
    scale_fill_gradient(low="red",  high="green")


