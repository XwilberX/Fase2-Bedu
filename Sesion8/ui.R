library(shiny)
library(ggplot2)
datos<-read.csv("D:/BEDU/Fase 2/Clase 8/appRBueno/match.data.csv", header=T)



# Define UI for application that draws a histogram
shinyUI(# Application title
    
    fluidPage( titlePanel("PostWork8"),
               
               # Sidebar with a slider input for number of bins
               sidebarLayout(
                   sidebarPanel(
                       selectInput("x", "Seleccione el equipo de casa",
                                   choices = unique(datos$home.team))
                   ),
                   
                   # Show a plot of the generated distribution
                   mainPanel(
                       tabsetPanel(
                           tabPanel("Goles por equipo",
                                    plotOutput("distPlot")),
                           tabPanel("Probabilidades",
                                    img( src = "CasaPW3.png", 
                                         height = 450, width = 450),
                                    img( src = "VisitantePW3.png", 
                                         height = 450, width = 450),
                                    img( src = "ProbConjunta.png", 
                                         height = 450, width = 450)
                           ),
                           tabPanel("Tabla", dataTableOutput("datatable")),
                           tabPanel("Factores Ganancia",
                                    img( src = "Maximo.png", 
                                         height = 450, width = 450),
                                    img( src = "Promedio.png", 
                                         height = 450, width = 450))
                       )
                   )
               )
    ))

