# Postwork 1
### Equipo 16 | Integrantes
- JESSICA GUADALUPE TOBAL CUPUL
- IRVIN CISNEROS CASTILLO
- MARÍA ANTONIETA GÓMEZ ORTIZ
- WILBER ALDAIR ALEGRÍA MÉNDEZ

#### 1. Importa los datos de soccer de la temporada 2019/2020 de la primera división de la liga española a R, los datos los puedes encontrar en el siguiente enlace: https://www.football-data.co.uk/spainm.php

```R
Datos <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv", header=T)
```

#### 2. Del data frame que resulta de importar los datos a R, extrae las columnas que contienen los números de goles anotados por los equipos que jugaron en casa (FTHG) y los goles anotados por los equipos que jugaron como visitante (FTAG)

```R
FTHG <- Datos$FTHG
FTAG <- Datos$FTAG
```

#### 3. Consulta cómo funciona la función table en R al ejecutar en la consola ?table

Posteriormente elabora tablas de frecuencias relativas para estimar las siguientes probabilidades:

- La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x = 0, 1, 2, ...)
```R
Prob_FTHG <- table(FTHG)/length(FTHG)
```

- La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y = 0, 1, 2, ...)
```r
Prob_FTAG <- table(FTAG)/length(FTAG)
```

- La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x = 0, 1, 2, ..., y = 0, 1, 2, ...)
```R
Prob_Conjunta<-table(as.data.frame(cbind(FTHG,FTAG)))/length(FTAG)
```