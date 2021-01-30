library(dplyr)
library(ggplot2)

##Enviar al directorio de trabajo
setwd("C:/Users/infrabyte/Documents/Github/Fase2-Bedu/Sesion5")
dir()
##Descargar los archivos a utilizar​
url1 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
url2 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
url3 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"

download.file(url = url1, destfile = "SP1-1011.csv", mode = "wb")
download.file(url = url2, destfile = "SP1-1112.csv", mode = "wb")
download.file(url = url3, destfile = "SP1-1213.csv", mode = "wb")

SmallData <- lapply(dir(pattern = ".csv"), read.csv)
SmallData <- lapply(SmallData, select, Date, HomeTeam, AwayTeam, HS, AS)
SmallData <- lapply(SmallData, mutate,Date=as.Date(Date, "%d/%m/%y"))

str(SmallData)

SmallData <- do.call(rbind, SmallData)

SmallData <- rename(SmallData, home.team= HomeTeam, away.team = AwayTeam, home.score = HS, away.score = AS)

head(SmallData)

write.csv(SmallData, "soccer.csv", row.names = FALSE)
install.packages("fbRanks")

library(fbRanks)

lista2 <-create.fbRanks.dataframes("soccer.csv")

anotaciones <-lista2$scores
equipos <- lista2$teams
head(anotaciones)
head(equipos)


fecha <- unique(anotaciones$date)
head(fecha)

n <-length(fecha)

ranking <-rank.teams(anotaciones, equipos, max.date=fecha[n-1], min.date = fecha[1])

predict(ranking, date = fecha[n])

View(SmallData)