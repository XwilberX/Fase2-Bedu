install.packages('mongolite')
library(mongolite)

match1 <- mongo(
  collection = "match",
  db = "match_games",
  url = "mongodb+srv://dbMariagomez:khQ9--mp6LWq97iA@cluster0.czb3q.mongodb.net/dbMariagomez?retryWrites=true&w=majority",
  verbose = FALSE,
  options = ssl_options()
)

# Se agrego el archivo de SP1 en Mongo que contiene datos del 2015 y 2016 ya que
# el archivo de data solo traia datos hasta el 2017 esto con el fin de poder generar
# la consulta de find. 
match1$count()

match1$find('{"HomeTeam":"Real Madrid","Date":"2015-12-20"}')

# Respuesta: El Real Madrid jugo contra el Vallecano y gano con 10 goles a 2. Fue una goleada.

#Insertar mtcars a la db
m <- mongo(collection = "mtcars",
           db = "match_games",
           url = "mongodb+srv://dbMariagomez:khQ9--mp6LWq97iA@cluster0.czb3q.mongodb.net/dbMariagomez?retryWrites=true&w=majority",
           verbose = FALSE,
           options = ssl_options()
)
m$drop()
m$insert(mtcars)

#Desconectar la conexion
match1$disconnect(gc = TRUE)

