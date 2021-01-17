# # Postwork 2

### Equipo 16 | Integrantes

- JESSICA GUADALUPE TOBAL CUPUL
- IRVIN CISNEROS CASTILLO
- MARÍA ANTONIETA GÓMEZ ORTIZ
- WILBER ALDAIR ALEGRÍA MÉNDEZ

#### 1. Importa los datos de soccer de las temporadas 2017/2018, 2018/2019 y 2019/2020 de la primera división de la liga española a R, los datos los puedes encontrar en el siguiente enlace: https://www.football-data.co.uk/spainm.php

```r
url1 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
url2 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
url3 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"

download.file(url = url1, destfile = "SP1-1011.csv", mode = "wb")
download.file(url = url2, destfile = "SP1-1112.csv", mode = "wb")
download.file(url = url3, destfile = "SP1-1213.csv", mode = "wb")


lista2 <- lapply(dir(), read.csv)
```

#### 2. Obten una mejor idea de las características de los data frames al usar las funciones: `str`, `head`, `View` y `summary`

```r
head(data2)
str(data2)
View(data2)
summary(data2)
```

#### 3. Con la función `select` del paquete `dplyr` selecciona únicamente las columnas `Date`, `HomeTeam`, `AwayTeam`, `FTHG`, `FTAG` y `FTR`; esto para cada uno de los data frames. (Hint: también puedes usar `lapply`).

```r
ista2 <- lapply(lista2, select, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
```

#### 4. Asegúrate de que los elementos de las columnas correspondientes de los nuevos data frames sean del mismo tipo (Hint 1: usa `as.Date` y `mutate` para arreglar las fechas). Con ayuda de la función rbind forma un único data frame que contenga las seis columnas mencionadas en el punto 3 (Hint 2: la función `do.call` podría ser utilizada).

```r
data2 <- do.call(rbind, lista2)
```
