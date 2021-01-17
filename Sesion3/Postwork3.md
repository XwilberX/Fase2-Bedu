# Postwork 3

### Equipo 16 | Integrantes

- JESSICA GUADALUPE TOBAL CUPUL
- IRVIN CISNEROS CASTILLO
- MARÍA ANTONIETA GÓMEZ ORTIZ
- WILBER ALDAIR ALEGRÍA MÉNDEZ

#### 1. Con el último data frame obtenido en el postwork de la sesión 2, elabora tablas de frecuencias relativas para estimar las siguientes probabilidades:
```R
library(dplyr)
library(ggplot2)

##Enviar al directorio de trabajo
setwd("C:/Users/jtoba/Documents/BEDU/R/Sesion2Reto3/Postwork")

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
```
- La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x=0,1,2,)
```R
##Leer los datos de goles anotados por equipos de casa (FTHG) y por equipos visitantes (FTAG)
FTHG <- data2$FTHG
FTAG <- data2$FTAG

Prob_FTHG <- table(FTHG)/length(FTHG)
```

- La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y=0,1,2,)
```R
Prob_FTAG <- table(FTAG)/length(FTAG)
```

- La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)
```R
Prob_Conjunta <- table(as.data.frame(cbind(FTHG,FTAG)))/length(FTAG)
```
#### 2. Realiza lo siguiente:
- Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo de casa
```R
Inciso1 <- as.data.frame(Prob_FTHG)


Inciso1 %>% 
    ggplot(aes(x=FTHG,y=Freq)) +
    geom_bar(stat="identity", fill= "#69b3a2") +
    labs(x="Goles anotados", y= "Probabilidad marginal", title="Goles de casa")
```
- Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo visitante.
```R
Inciso2 <- as.data.frame(Prob_FTAG)

Inciso2 %>% 
    ggplot(aes(x=FTAG,y=Freq)) +
    geom_bar(stat="identity", fill= "#69b3a2") +
    labs(x="Goles anotados", y= "Probabilidad marginal", title="Goles de visitante")
```
- Un HeatMap para las probabilidades conjuntas estimadas de los números de goles que anotan el equipo de casa y el equipo visitante en un partido.
```R
Inciso3 <- as.data.frame(Prob_Conjunta)

Inciso3 %>% 
    ggplot(aes(x=FTHG, y=FTAG, fill=Freq))+
    geom_tile()+
    labs(x="Goles equipo de casa", y="Goles equipo visitante", fill="Probabilidad", 
    title= "Probabilidad Conjunta: Goles de casa vs. Goles visitante")+
    scale_fill_gradient(low="red",  high="green")
```