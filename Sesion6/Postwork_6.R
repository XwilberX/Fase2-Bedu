library(dplyr)

setwd("D:/BEDU/Fase 2/Clase 6")

m_data <- read.csv("match.data.csv", header = TRUE)
m_data <- mutate(m_data, date= as.Date(date,"%Y-%m-%d"))

#Dado que se harán promedios de meses, se requieren que estos sean completos.
m_data <- filter(m_data, date >= '2010-09-01')

#Para poder generar la TS, se requiere que cada año tenga la misma cantidad de meses (frequency)
#Se agregan datos nulos para los meses faltantes de cada año (Junio y Julio).
date.null <- as.Date(c("2011-06-01","2011-07-01","2012-06-01","2012-07-01","2013-07-01","2014-06-01","2014-07-01","2015-06-01","2015-07-01","2016-06-01","2016-07-01","2017-06-01","2017-07-01","2018-06-01","2018-07-01","2019-06-01","2019-07-01"))
home.team.null <- rep(NA,17)
home.score.null <- as.integer(rep(0,17))
away.team.null <- rep(NA,17)
away.score.null <- as.integer(rep(0,17))
m_data.null <- data.frame(date = date.null, home.team = home.team.null, home.score= home.score.null, away.team = away.team.null, away.score= away.score.null)
m_data <- rbind(m_data,m_data.null)

#Se agrega la columna sumagoles, que contiene el total de goles por partido,
m_data <- mutate(m_data, sumagoles = home.score + away.score)

#Extraemos Mes, Año y sumagoles de m_data y creamos m_data2 con estas columnas
mo <- as.numeric(strftime(m_data$date, "%m"))
yr <- as.numeric(strftime(m_data$date, "%Y"))
m_data2 <- data.frame(yr, mo, sumagoles = m_data$sumagoles)

#Generamos el promedio de sumagoles por mes
m_data.mean <- aggregate(sumagoles ~ mo + yr, m_data2, FUN = mean)

#Creamos la serie de tiempo por mes
m_data.ts <- ts(m_data.mean[, 3], start = c(2010,9), end = c(2019,12), frequency = 12)

#Se grafica la Serie de Tiempo de los promedios mensuales
plot(m_data.ts, ylab = "Promedio", xlab = "Tiempo", 
     main = "Promedio mensual de la suma de goles")