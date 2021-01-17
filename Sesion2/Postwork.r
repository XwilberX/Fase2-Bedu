library(dplyr)

setwd("C:/Users/jtoba/Documents/BEDU/R/Sesion2Reto3/Postwork")

url1 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
url2 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
url3 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"

download.file(url = url1, destfile = "SP1-1011.csv", mode = "wb")
download.file(url = url2, destfile = "SP1-1112.csv", mode = "wb")
download.file(url = url3, destfile = "SP1-1213.csv", mode = "wb")


lista2 <- lapply(dir(), read.csv)
lista2 <- lapply(lista2, select, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR) 
lista2<- lapply(lista2, mutate,Date=as.Date(Date, "%d/%m/%y"))

data2 <- do.call(rbind, lista2)

head(data2)
str(data2)
View(data2)
summary(data2)