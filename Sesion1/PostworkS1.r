Datos<-read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv", header=T)
FTHG<-Datos$FTHG
FTAG<-Datos$FTAG

##Inciso 1
Prob_FTHG<-table(FTHG)/length(FTHG)

##Inciso 2
Prob_FTAG<-table(FTAG)/length(FTAG)

##Inciso 3
#Columnas con los goles del equipo visitante y las filas los goles del equipo local
Prob_Conjunta<-table(as.data.frame(cbind(FTHG,FTAG)))/length(FTAG)